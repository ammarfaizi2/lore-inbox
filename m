Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVBILLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVBILLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 06:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBILLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 06:11:36 -0500
Received: from gprs215-22.eurotel.cz ([160.218.215.22]:60878 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261805AbVBILLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 06:11:32 -0500
Date: Wed, 9 Feb 2005 12:11:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Daniel Jacobowitz <dan@debian.org>
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050209111111.GA1554@elf.ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org> <20050208175106.GA1091@elf.ucw.cz> <20050208111625.0bb1896d@dxpl.pdx.osdl.net> <20050208181018.5592beab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208181018.5592beab.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I wonder if reverting the patch will restore the old behaviour?
> > > 
> > > This seems to be minimal fix to get Kylix application back to the
> > > working state... Maybe it is good idea for 2.6.11?
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > > 								Pavel
> > > 
> > > --- clean/fs/binfmt_elf.c	2005-02-03 22:27:19.000000000 +0100
> > > +++ linux/fs/binfmt_elf.c	2005-02-08 18:46:38.000000000 +0100
> > > @@ -803,11 +803,8 @@
> > >  				nbyte = ELF_MIN_ALIGN - nbyte;
> > >  				if (nbyte > elf_brk - elf_bss)
> > >  					nbyte = elf_brk - elf_bss;
> > > -				if (clear_user((void __user *) elf_bss + load_bias, nbyte)) {
> > > -					retval = -EFAULT;
> > > -					send_sig(SIGKILL, current, 0);
> > > -					goto out_free_dentry;
> > > -				}
> > > +				if (clear_user((void __user *) elf_bss + load_bias, nbyte))
> > > +					printk(KERN_ERR "Error clearing BSS, wrong ELF executable? (Kylix?!)\n");
> > 
> > do once or rate limit rather than log spamming.
> 
> We could just remove the printk and stick a comment over it.  If the
> application later tries to access the not-there pages then it'll just
> fault.
> 
> However I worry if there is some way in which we can leave unzeroed memory
> accessible to the application, although it's hard to see how that could
> happen.
> 
> Daniel, Pavel cruelly chopped you off the Cc when replying.  What's your
> diagnosis on the below?

Not me, my mailer did it :-). No, don't know what went wrong, and I
forwarded the message to Daniel; his reaction was:

>
> Elf file type is EXEC (Executable file)
> Entry point 0x80614b4
> There are 5 program headers, starting at offset 52
>
> Program Headers:
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg
>Align
>   PHDR           0x000034 0x08048034 0x08048034 0x000a0 0x000a0 R E
>0x4
>   INTERP         0x0000d4 0x080480d4 0x080480d4 0x00013 0x00013 R
>0x1
>       [Requesting program interpreter: /lib/ld-linux.so.2]
>   LOAD           0x000000 0x08048000 0x08048000 0xb7354 0x1b7354 R E
>0x1000
>   LOAD           0x0b7354 0x08200354 0x08200354 0x1e3e4 0x1f648 RW
>0x1000
>   DYNAMIC        0x0d56a0 0x0821e6a0 0x0821e6a0 0x00098 0x00098 RW
>0x4

Looks fine but it's probably the first load segment: that's a megabyte
of blank space at the end...

that's all I can see.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
