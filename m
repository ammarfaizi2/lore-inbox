Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbULOQ36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbULOQ36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbULOQ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:29:58 -0500
Received: from linux.us.dell.com ([143.166.224.162]:34242 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262381AbULOQ3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:29:52 -0500
Date: Wed, 15 Dec 2004 10:29:43 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Ray Van Dolson <rayvd@digitalpath.net>, linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Message-ID: <20041215162943.GB31494@lists.us.dell.com>
References: <20041215013228.GA3390@digitalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215013228.GA3390@digitalpath.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 05:32:28PM -0800, Ray Van Dolson wrote:
> Hoping someone can shed some light on this, or help me out in narrowing the
> problem down.
> 
> Our servers exhibit these error messages (at bottom) off and on and
> eventually appears to lead to system instability.  I guess the three
> possibilities are that this is either a) a hardware problem, b) a problem
> with poptop, pppd or the mppe modules, or c) a problem with the kernel
> 
> This happens on every single one of our DL140's, so if it's a hardware
> problem, then it is widespread on this platform.
> 
> If it's a problem with poptop, pppd or mppe modules I'd at least like to be
> able to give some evidence to that effect...
> 
> If it's c, I'm hoping someone here can give some suggestions on how to
> resolve this. :-)  Please let me know if I can provide further information.
> I have a box on which this happens fairly regularly, so I can reproduce it
> pretty easily.
> 
> Thanks in advance!
> 
> System Specs:
> HP DL140
> Dual 2.4GHz P4 Xeon w/ Hyperthreading
> Fedora Core 2
> 2.6.9 kernel (static compile, downloaded from ftp.kernel.org with the
>               following patches):
>  - http://marc.theaimsgroup.com/?l=linux-kernel&m=109926628920398
>    This fixes an oops I was getting in mm/prio_tree.c
>  - http://mdomsch.bkbits.net:8080/linux-2.6-mppe
>    This provides MPPE support for clients connecting via PoPToP 1.2.1.
> 
> Intel E100 Pro Dual Port NIC (Using built-in e100 driver).
> Onboard Broadcom BCM5700 Gigabit NIC's are *not* in use (no driver support
>  compiled in)
> 
> Software:
> Poptop 1.2.1
> PPP 2.4.3
> 
> Kernel config:
[snip]
> lspci output:
[snip] 

> <7>divert: not allocating divert_blk for non-ethernet device ppp440

These messages I have gotten for years.  They're debugging messages,
as a result of:
register_netdevice()
  alloc_divert_blk()
     (sees it's not an ethernet device, printk's the message)

So I believe they're harmless.


> ksymoops output of problem:
> Unable to handle kernel NULL pointer dereference
> 00000000
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    2
> EIP:    0060:[<00000000>]    Not tainted VLI
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286   (2.6.9) 
> eax: ed13b000   ebx: d1d0a000   ecx: c029e9de   edx: f795ef40
> esi: d1d0a000   edi: 00000000   ebp: e2f30080   esp: d2b0dea0
> ds: 007b   es: 007b   ss: 0068
> Stack: c02a205a ed13b000 00000000 c02a122c d1d0a000 13208a2e c040956f d1d0a000 
>        d1d0a00c e2f30080 00000000 c029cda9 d1d0a000 e2f30080 00000000 c01552cd 
>        e2f30080 00000010 00000004 00000004 c0166aa0 e2f30080 00000000 00000000 
> Call Trace:
>  [<c02a205a>] pty_chars_in_buffer+0x2c/0x49
>  [<c02a122c>] normal_poll+0xed/0x150
>  [<c040956f>] schedule_timeout+0x75/0xbf
>  [<c029cda9>] tty_poll+0xa0/0xb0
>  [<c01552cd>] fget+0x49/0x5e
>  [<c0166aa0>] do_select+0x269/0x2c6
>  [<c0166691>] __pollwait+0x0/0xc7
>  [<c0166dd5>] sys_select+0x2b3/0x4c6
>  [<c0105971>] sysenter_past_esp+0x52/0x71
> Code:  Bad EIP value.

It looks like pty_chars_in_buffer() dereferenced a NULL function
pointer, but I don't see how that can be, the one deference is tested
for NULL before doing so.

I can't rule out the ppp_mppe code, but I haven't seen this crash
before myself.  Does this happen on simlar systems that aren't running poptop?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
