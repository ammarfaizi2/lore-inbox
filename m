Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUFPMcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUFPMcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUFPMcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:32:21 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:37494 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S266262AbUFPMcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:32:16 -0400
Date: Wed, 16 Jun 2004 12:32:13 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Alex Williamson <alex.williamson@hp.com>
cc: Corey Minyard <minyard@acm.org>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: IPMI hangup in 2.6.6-rc3
In-Reply-To: <1086887543.4182.46.camel@tdi>
Message-Id: <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de> 
 <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org>
 <1086887543.4182.46.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch fixes the hangup for me too using 2.6.7. However I cannot verify
if it runs properly since ipmitool crashes, I think that is because the
kernel interface has changed. Using the ipmi driver from 2.6.5 ipmitool
works fine.

Holger

On Thu, 10 Jun 2004, Alex Williamson wrote:

> 
>    I was seeing a hang on an hp rx8620 ia64 system as well.  I'd get up
> to here:
> 
> ipmi message handler version v31
> ipmi device interface version v31
> IPMI System Interface driver version v31, KCS version v31, SMIC version
> v31, BT version v31
> ipmi_si: ACPI/SPMI specifies "bt" memory SI @ 0xffc30040000
> ipmi_si: ipmi_si unable to claim interrupt 17, running polled
> 
> Then hang forever.  The hang appears to be because the timer for polling
> is setup after the call to ipmi_register_smi().  If I add the following
> chunk of code just before the call to ipmi_register_smi(), I get past
> the hang:
> 
>         new_smi->timer_stopped = 0;
>         init_timer(&(new_smi->si_timer));
>         new_smi->si_timer.data = (long) new_smi;
>         new_smi->si_timer.function = smi_timeout;
>         new_smi->last_timeout_jiffies = jiffies;
>         new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
>         add_timer(&(new_smi->si_timer));
> 
> (I commented out the corresponding lines towards the end of
> init_one_smi())  I'm not sure the IPMI interface actually works (it does
> using the v30 patch on a 2.4 kernel), but at least the driver doesn't
> hangup the box.  Anyway, looks like the polling handler needs to get
> setup earlier or we'll wait forever.  Thanks,
> 
> 	Alex
> 
> On Fri, 2004-06-04 at 14:59, Corey Minyard wrote:
> > Strange.  I don't know what changed to cause this.
> > 
> > The best bet is to use printks to trace this back to see where the 
> > message is being lost (handle_bmc_rsp, handle_new_recv_msg, and so forth).
> > 
> > -Corey
> > 
> > Philipp Matthias Hahn wrote:
> > 
> > >Hi Holger, Corey, LKML!
> > >
> > >On Tue, May 04, 2004 at 07:05:12AM +0200, Holger Kiehl wrote:
> > >  
> > >
> > >>When compiling in IPMI (not as modules) my system hangs just after
> > >>it prints out detection of IPMI. 2.6.5 did work fine. Compiling
> > >>it as a module and inserting it with modprobe causes modprobe
> > >>to hang in D state, there is nothing unusual in /var/log/messages:
> > >>
> > >>May  4 08:46:34 apollo kernel: ipmi message handler version v31
> > >>May  4 08:46:34 apollo kernel: IPMI System Interface driver version v31, KCS version v31, SMIC version v31, BT version v31
> > >>May  4 08:46:34 apollo kernel: ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca2
> > >>May  4 08:54:14 apollo kernel: ipmi device interface version v31
> > >>    
> > >>
> > >
> > >Same for me on one of our single Xeon with 2.6.7-rc1. Using SysRq-T I
> > >was able to track it somehow down to the following situation:
> > >
> > >modprobe      D C201AD20     0  3735   2415                     (NOTLB)
> > >f6b51f0c 00000082 00000000 c201ad20 c201a0a0 00008124 00000002 00000000
> > >       f7c03000 f6b51ee4 f8bda434 c04b5dc0 c201ad20 00000000 00000000 8ce9c0c0
> > >       000f431a c03b8d80 f75fccd0 f75fce80 00000246 00000003 f6b50000 f7c03000
> > >Call Trace:
> > > [<f8bdb46d>] ipmi_register_smi+0x22a/0x386 [ipmi_msghandler]
> > > [<f8b570a6>] init_one_smi+0x1e6/0x4c2 [ipmi_si]
> > > [<f8b270c2>] init_ipmi_si+0xc2/0x203 [ipmi_si]
> > > [<c0137910>] sys_init_module+0x116/0x24d
> > > [<c0106053>] syscall_call+0x7/0xb
> > >
> > >modprobe hangs at linux-2.6.7-rc1/drivers/char/ipmi/ipmi_msghandler.c:1727
> > >	wait_event((*intf)->waitq, ((*intf)->curr_channel>=IPMI_MAX_CHANNELS));
> > >
> > >This event should be fired by channel_handler(), but isn't for some
> > >unknown reason. I verified this by adding some printk() there, which
> > >wheren't shown.
> > >
> > >When I tried a 2.4 kernel with the patches from openipmi.sf.net, I
> > >was somehow able to use IPMI, but got into problems later.
> > >
> > >Any idea, what I can do to track the problem further down?
> > >
> > >BYtE
> > >Philipp
> > >  
> > >
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
