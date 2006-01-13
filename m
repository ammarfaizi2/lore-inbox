Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWAMU2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWAMU2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422931AbWAMU2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:28:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422929AbWAMU2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:28:52 -0500
Date: Fri, 13 Jan 2006 12:28:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Takashi Sato" <sho@tnes.nec.co.jp>
Cc: torvalds@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 2/3] Fix problems on multi-TB filesystem and file
Message-Id: <20060113122820.18b751b0.akpm@osdl.org>
In-Reply-To: <000101c61848$4dd3b5b0$4168010a@bsd.tnes.nec.co.jp>
References: <20060112183319.526b877a.akpm@osdl.org>
	<000101c61848$4dd3b5b0$4168010a@bsd.tnes.nec.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Takashi Sato" <sho@tnes.nec.co.jp> wrote:
>
> > >  This is a patch to add blkcnt_t as the type of inode.i_blocks.
>  > >  This enables you to make the size of blkcnt_t either 4 bytes or 8 bytes
>  > >  on 32 bits architecture with CONFIG_LSF.
>  >
>  > What was the rationale behind CONFIG_LSF?  It's a bit of an ugly thing and
>  > I'm wondering if we wouldn't be better off just removing it and simply
>  > fixing >2TB support for all .configs?
> 
>  We should avoid needless growth of heavily-used structure such as
>  inode for a small system like embedded system.
>  So I make it possible to configure the size of i_blocks with CONFIG_LSF.

Variables whose size varies according to Kconfig are surprisingly expensive
with respect to maintenence cost and runtime stability risk.  The main
offended is sector_t.

I am forever fixing people's code which does

	printk("%ld", some_sector_t);

With CONFIG_LBD=n that's fine.  With CONFIG_LBD=y it generates a warning.

The consequences of that warning are:

a) It'll probably print a garbage number

b) If the printk did

	printk("%d %s", some_sector_t, some_string);

   then printk might well oops the kernel, because `some_string' will be
   passed in either the wrong register or in the wrong stack slot.

   And because printks are almost always in rare error paths, such an
   oops will probably sail through everyone's kernel testing and will only
   hit users when rare things like I/O errors or disk corruption occur.

The best fix for the printk(sector_t) problem is

	printk("%llu", (unsigned long long)some_sector_t);

All other solutions have subtle problems.


So now we're proposing to repeat the sector_t problem with a bunch of new
fields.  Fortunately we're less likely to be putting these particular
fields into printk statements but I note that CIFS (at least) has a couple
such statements and with your patch they're now generating warnings (and
potential runtime bugs).


On the other hand, for a fairly fat .config which has 17 filesystems in
.vmlinux:

   text    data     bss     dec     hex filename
4633032 1011304  248288 5892624  59ea10 vmlinux		CONFIG_LSF=y
4633680 1011304  248288 5893272  59ec98 vmlinux		CONFIG_LSF=n

It's probably less 0.5 kbytes for usual embedded .config.


I just don't think the benefit of CONFIG_LSF outweighs its costs.
