Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVCYHuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVCYHuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVCYHuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:50:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261524AbVCYHuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:50:37 -0500
Date: Fri, 25 Mar 2005 07:50:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: miles.lane@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-ID: <20050325075032.B18596@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, miles.lane@gmail.com,
	linux-kernel@vger.kernel.org
References: <20050324044114.5aa5b166.akpm@osdl.org> <a44ae5cd05032420122cd610bd@mail.gmail.com> <20050324202215.663bd8a9.akpm@osdl.org> <20050325073846.A18596@flint.arm.linux.org.uk> <20050324234544.135a1eb2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050324234544.135a1eb2.akpm@osdl.org>; from akpm@osdl.org on Thu, Mar 24, 2005 at 11:45:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 11:45:44PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Thu, Mar 24, 2005 at 08:22:15PM -0800, Andrew Morton wrote:
> > > Miles Lane <miles.lane@gmail.com> wrote:
> > > >  Unable to handle kernel paging request at virtual address 24fc1024
> > > >  c0198448
> > > >  *pde = 00000000
> > > >  Oops: 0000 [#1]
> > > >  CPU:    0
> > > >  EIP:    0060:[<c0198448>]    Not tainted VLI
> > > 
> > > I wonder why the EIP sometimes doesn't get decoded.
> > > 
> > > >  Using defaults from ksymoops -t elf32-i386 -a i386
> > > >  EFLAGS: 00210206   (2.6.12-rc1-mm2)
> > 
> > ksymoops seems to remove lines from the kernel output that it doesn't
> > like.
> 
> but.  but.  There used to be a symbol+0xN/0xM in the EIP: line.  Are you
> saying that ksymoops rubbed that out and stuck a hex number in there?

The kernel's x86 format is:

        printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
        print_symbol("EIP is at %s\n", regs->eip);

so what you have there is the first EIP: line.  The "EIP is at
symbol+0xN/0xM" is produced by the print_symbol statement, which
ksymoops decided to omit from the output.

It can be clearly seen from the rest of the oops (the call trace)
that print_symbol definitely does produce output, so kallsyms hasn't
been disabled.

> I wonder if there's something clever we could do to the kallsymsised oops
> output so that ksymoops would simply cease to recognise it.

I have been wondering why we still mark the addresses with [< >]
even though we've decoded them ourselves.  Maybe omitting these
would be sufficient in the kallsyms-decoded case?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
