Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbSKCPlp>; Sun, 3 Nov 2002 10:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbSKCPlp>; Sun, 3 Nov 2002 10:41:45 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:53769 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S262055AbSKCPln>; Sun, 3 Nov 2002 10:41:43 -0500
Date: Sun, 3 Nov 2002 10:49:50 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <1036327515.29646.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211031021260.16432-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2002, Alan Cox wrote:

> On Sun, 2002-11-03 at 02:03, Linus Torvalds wrote:
> > So I'd suggest _not_ attaching that capability to the sendmail binary
> > itself, or to any inode number of that binary. A binary is a binary is a
> > binary - it's just the data. Instead, I'd attach the information to the
> > directory entry, either directly (ie the directory entry really has an
> > extra field that lists the capabilities) or indirectly (ie the directory
> > entry is really just an "extended symlink" that contains not just the path
> > to the binary, but also the capabilities associated with it).
>
> So what are the semantics for writing to the file. If I modify a setuid
> (or setpartlysetuid) type file then I wan't the setuidness revoked as
> happens now. That is done for very good reason. Your system appears to
> need a scan of the entire file system to find directory references to
> this object, done atomically.
>
> > The reason I like directory entries as opposed to inodes is that if you
> > work this way, you can actually give different people _different_
> > capabilities for the same program.  You don't need to have two different
> > installs, you can have one install and two different links to it.
>
> I'll trade 500K of disk space for a working security model especially as
> the case in question is not that common.

Here's a random idea, it has problems, but seems workable to me:

1) Add a standardized exported data structure to your ELF executable
   called "KERNEL_PROCESS_CAPABILITIES_v1" or another name you like, and
   have it as a fixed-length bit-array (null terminated) of capabilities,
   maybe 128 bits for version one.  If extensions are needed later, we can
   fairly easily extend the length by aliasing it with another name, say
   "KERNEL_PROCESS_CAPABILITIES_v2" and sticking the extra bits at the end
   of the structure (or create a second structure...).

2) SUID root the binary like normal

This is what the kernel does:

1) Checks if the binary is SUID root (uid 0), if not go on like normal.

2) If SUID root, and it's an ELF execuable, look for the ELF symbol(s)
   above; if not present, set uid to 0 and execute.

3) If caps are present, read them in, don't change UID/GID, set the caps,
   and execute.

4) If that process executes another process, drop all capabilities

This could (probably be) extended to a.out format.  To deal with scripts
and 'binfmt_misc' stuff, you can create a capability called "CAP_WRAPPER"
which allows capabilities to be transferred to the next process.  When you
execute that process, the kernel drops only that one flag, denying the
wrapped executable from transferring capabilities.

Here's some advantages:
 - No huge and wierd /etc/fstab[.d], and no mounting of files to gain
   capabilites, or other 'strange things'.
 - If the kernel doesn't recognize capabilites, it'll just SUID root the
   binary like normal
 - If the binary doesn't have capabilities listed, it'll just get SUID
   root like normal
 - Changing the binary still drops SUID root, and thus drops the
   capabilites
 - User can create wrapper 'binaries' fairly simply
 - Since the size of the bitfield for the capabilities is fixed, the user
   can modify capabilites inside a binary with that structure.

Problems:
 - It's binary, not text, so possibly harder to read without tools.
 - Stripped binaries.  This could be fixed by a small change:

  Instead of using a symbol to look up capabilites, use text in the
  executable eg:

struct caps_t {
	int magic;
	char name[28];
	char caps[8];
} kern_proc_caps =
	{0x1234AA55, "KERNEL_PROCESS_CAPSTRING_v1", ... };

Comments?

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif


