Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVEIVIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVEIVIC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVEIVIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:08:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29592 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261526AbVEIVHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:07:50 -0400
Date: Mon, 9 May 2005 22:07:53 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050509210753.GA1150@parcelfarce.linux.theplanet.co.uk>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org> <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk> <20050508061044.GB32143@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050508061044.GB32143@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 07:10:44AM +0100, Al Viro wrote:
> 	r) when built static, kernel dies ugly death with
> #0  0x00000000601e4178 in ptmalloc_init () at swab.h:134
> #1  0x00000000601e4034 in malloc_hook_ini () at swab.h:134
> #2  0x00000000601e1698 in malloc () at swab.h:134
> #3  0x00000000602068ee in _dl_init_paths () at swab.h:134
> #4  0x00000000601eba45 in _dl_non_dynamic_init () at swab.h:134
> #5  0x00000000601ebc60 in __libc_init_first () at swab.h:134
> #6  0x00000000601cfa4f in __libc_start_main () at swab.h:134
> #7  0x000000006001202a in _start () at proc_fs.h:183
> as stack trace.  Buggered offsets in uml.lds, perhaps?

Apparently solved by adding .tdata and .tbss to uml.lds.S.  That change does
not give any visible regression on i386.

	s) i386 TT-only won't compile, due to mispaced include in
sysdep/ptrace.h (under ifdef for skas).  Trivial fix apparently gets it
to work correctly.  Which is surprising - when running that sucker on
amd64 we get zero from
        *host_size_out = ROUND_4M((unsigned long) &arg);
Of course, the real size rounded up to 4M is 4Gb there - 32bit tasks do not
have to share the lower 4Gb of address space with the kernel.  Looks like
we survive, though - it boots and apparently works both on i386 and (as
32bit process) on amd64.
	t) amd64 TT-only builds just fine, but gets buggered due to
mismatch between CONFIG_TOP_ADDR and start address - we get *both* set
to 0x60000000, which is obviously b0rken and doesn't match the old
code, while we are at it.  We want TOP_ADDR at 0x80000000 to match start
address.
	u) amd64 TT is _still_ buggered due to unmap_fin.o attempts at
magic.  errno sits in TLS for amd64, so unmap_fin.o gets very interesting
stuff leaking from libc and messing the link.  IMO that should be dealt
with by brute force; namely, unmap-$(SUBARCH).S instead of trying to
play games with pulling stuff from libc.a.  For fsck sake, we are just
making 3 syscalls there and switcheroo() is as low-level as it gets...
Will post once that's done...
