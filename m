Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUBTMDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbUBTMDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:03:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5553 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261170AbUBTMDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:03:48 -0500
Date: Fri, 20 Feb 2004 13:04:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220120417.GA4010@elte.hu>
References: <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Basic approach: add two bits to the VFS dentry flags. That's all that
> is needed. Then you have two new system calls:
> 
>  - set_bit_one(dirfd)
>  - set_bit_two_if_one_is_set(dirfd);
>  - check_or_create_name(dirfd, name, case_table_pointer, newfd);

i believe Samba's problems can be solved in an even simpler way, by 
using only a single bit associated with the directory dentry, and by not 
putting any case-insensitivity code into the kernel. (not even as a 
separate module.)

One 'user-space cache is valid/clean' bit should be enough - where all
non-Samba accesses clear the 'valid bit', and Samba sets the bit
manually.

What Samba needs is a way to tell between two points in time whether the
directory contents have changed in any way - nothing more. Only one new
syscall is used to maintain the Samba dcache:

	long sys_mark_dir_clean(dirfd);

the syscall returns whether the directory was valid/clean already.

this is how Samba name lookup would work:

repeat:
	if (sys_mark_dir_clean(dirfd)) {
		... pure user-space fast path, use Samba dcache ...
		return;
	}
	... fill Samba dcache ...
	readdir() loop

	goto repeat;

i.e. there will be two calls to sys_mark_dir_clean() in the slowpath
(the first one to set it, the second one to make sure it's still set). 
Races are handled automatically by the loop.

this is how Samba could create a file atomically:

	sys_create(name, mode | O_CLEAN);

ie. the create only succeeds if the directory has not been touched since
the Samba dcache has processed it last time. O_CLEAN would be a very
simple check in the open_namei() code, it returns -ENOTCLEAN if the
parent directory has not been marked clean.

i dont think there's any need to have a case-insensitive lookup module
in the kernel - Samba has all the information through the readdir() loop
already - all it needs to know is whether that info is valid or not via
the mark_dir_clean() syscall!

the impact of sys_mark_dir_clean() and O_CLEAN is quite minimal on the
generic VFS i believe. Also, it can be used as a caching method for just
about everything that wants to have a coherent user-space cache of the
VFS namespace. Note that there's nothing about case sensitivity or
insensitivity in this approach, it still gets rid of all of the
excessive readdir()s done in the Samba fastpath.

[ To get rid of all Samba overhead in this area we might need other
  syscall variants too, like rename_if_clean() and unlink_if_clean().
  Under this scheme Samba would never have to do a stat() call of the
  target file, because it always has a coherent copy of the kernel
  dcache, for directories it choses to cache. ]

this approach differs from dnotify in a couple of key areas:

 - it's a synchronous solution that avoids signals, and is thus
   usable/robust in libraries too.

 - dnotify _forces_ action. mark_dir_clean() you can use if there's use 
   and there's no overhead if the Samba workload is completely silent
   and there are only POSIX users. I.e. it should scale better than 
   dnotify.

 - cache teardown can be done in userspace purely: the 'clean bit' has
   no state associated with it (unlike dnotify), so no kernel call is
   necessary to tear down state. User-space just forgets that it cached
   anything about that directory and it's done. No leaking state, and
   good scalability again.

 - but most importantly, it's fundamentally atomic for local filesystems
   and thus meets the needs of Samba in mixed POSIX/Samba workloads.

just in case anyone has followed me down to this point :-), there's yet
another, more advanced way to do the Samba-dcache fastpath 100% in
user-space:

We can export the 'directory clean bit' to userspace, via the same page
pinning and mapping techniques used by futexes. User-space could
register a 'clean bit' address via a new syscall, which the dcache then
uses from that point on. Thus there would be only a single syscall when
Samba sets up a directory cache in user-space [which needs those
readdir() calls so performance is down the drain anyway], which syscall
lets userspace register a machine-word address to serve as the
'directory is clean' flag. Userspace and kernelspace will set this flag
possibly in parallel which is not a problem as long as userspace uses
atomic ops. This approach introduces some page pinning allocation
overhead but that's easy to solve.  User-space would of course condense
the pinned range. Kernel-space would see very minimal overhead from
having the bit in an indirect pointer - at least on 64-bit systems where
all kernel RAM is mapped.

	Ingo
