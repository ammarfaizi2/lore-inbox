Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUBVMQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 07:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUBVMQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 07:16:24 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:53916 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261231AbUBVMQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 07:16:22 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
References: <16435.60448.70856.791580@samba.org>
	<Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
	<16435.61622.732939.135127@samba.org>
	<Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
	<20040219081027.GB4113@mail.shareable.org>
	<Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	<20040219163838.GC2308@mail.shareable.org>
	<Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	<20040219182948.GA3414@mail.shareable.org>
	<Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
	<20040220120417.GA4010@elte.hu>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 20 Feb 2004 21:38:51 +0100
In-Reply-To: <20040220120417.GA4010@elte.hu>
Message-ID: <m3vfm1trj8.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> i believe Samba's problems can be solved in an even simpler way, by 
> using only a single bit associated with the directory dentry, and by not 
> putting any case-insensitivity code into the kernel. (not even as a 
> separate module.)
> 
> One 'user-space cache is valid/clean' bit should be enough - where all
> non-Samba accesses clear the 'valid bit', and Samba sets the bit
> manually.
> 
> What Samba needs is a way to tell between two points in time whether the
> directory contents have changed in any way - nothing more. Only one new
> syscall is used to maintain the Samba dcache:
> 
> 	long sys_mark_dir_clean(dirfd);
> 
> the syscall returns whether the directory was valid/clean already.

Isn't this rather bad, it's only possible to have one process that
does this magic clean bit thing.  Other applications such as Wine or a
DOS emulator might want to get the same speedups.  

Instead of a bit, why don't just use the generation number idea that
have been tossed around?  Let each directory have a generation number
which can be read with a function:

    long sys_get_generation(dirfd);

Then the name lookup would work with multiple processes and with some
code like this:

repeat:
        new_generation = sys_get_generation(dirfd);
        if (new_generation == old_generation) {
		... pure user-space fast path, use Samba dcache ...
		return;
	}
        old_generation = generation;
	... fill Samba dcache ...
	readdir() loop

	goto repeat;

Add a new create syscall with the same idea as your one bit syscall,
which checks that the generation number matches.  If the generation
number doesn't match the create call fails.

    int create_synchronized(name, mode, generation);

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
