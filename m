Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTJXEo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 00:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTJXEo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 00:44:59 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6104 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261982AbTJXEo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 00:44:56 -0400
Date: Thu, 23 Oct 2003 21:42:06 -0700
From: "Kurtis D. Rader" <kdrader@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       pberger@brimson.com, borchers@steinerpoint.com
Subject: Re: [PATCH][2.6.0-test7] digi_acceleport.c has bogus "address of" operator
Message-ID: <20031024044206.GA8582@us.ibm.com>
References: <20031016054821.GA22005@us.ibm.com> <20031024000750.GE21734@kroah.com> <20031023174433.77770988.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023174433.77770988.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 17:44:33, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Wed, Oct 15, 2003 at 10:48:21PM -0700, Kurtis D. Rader wrote:
> > > 
> > > === diff -rup drivers/usb/serial/digi_acceleport.c.orig drivers/usb/serial/digi_acceleport.c
> > > --- drivers/usb/serial/digi_acceleport.c.orig   2003-10-15 22:03:26.000000000 -0700
> > > +++ drivers/usb/serial/digi_acceleport.c        2003-10-15 21:10:21.000000000 -0700
> > 
> > This patch does not apply.  It looks like the tabs are converted to
> > spaces.  Can you send it to me again, so that I can apply it?
> 
> It was applied.  But it added a compile-time warning, which this
> fixes:

My apologies. Even though I knew, in the back of my mind, it was the
wrong thing to do I still "cut-and-pasted" the output of the diff :-(
I won't make that mistake again.

Also, note that even with the aforementioned change applied the driver
is still broken and results in oopses. It's now failing (see the oops
included below) a random interval after the device is opened. As soon as
I resolve my current customer crit-sit involving the O(1) scheduler I'll
get to the root cause of that problem, as well as any others that rear
their ugly heads, and submit a proper patch against the digi_acceleport
driver that makes it work in a v2.6 kernel.

The following trace is included for the benefit of the documented driver
maintainers in the hope they have an idea as to the proper fix. The
tainting is due to use of VMware, the use of which is unlikely to have
anything to do with the digi_accelport driver problems (probability =~ 0.0).

Unable to handle kernel NULL pointer dereference at virtual address 00000050
 printing eip:
f88ee3f0
*pde = 31ce8067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f88ee3f0>]    Tainted: PF 
EFLAGS: 00010002
EIP is at digi_read_oob_callback+0x2a4/0x339 [digi_acceleport]
eax: 00000001   ebx: f544adf8   ecx: 00000000   edx: 00000000
esi: f5444df8   edi: 00000004   ebp: c047fe70   esp: c047fe38
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c047e000 task=c03f4ea0)
Stack: 00000000 00000046 3ccba773 f2077dc4 f56c23c0 f621fbf8 c047e000 c047e000 
       00000040 00000008 f545821c f5447df8 f5458b68 f5441df8 c047fe98 f88edda1 
       f5458b68 f5f2f860 f7f0aef8 00000082 f5458b68 f5f2f864 f5458b68 c047ff8c 
Call Trace:
 [<f88edda1>] digi_read_bulk_callback+0xdd/0x158 [digi_acceleport]
 [<f8a86965>] usb_hcd_giveback_urb+0x27/0x3c [usbcore]
 [<f88cdf35>] dl_done_list+0x1cf/0x22e [ohci_hcd]
 [<f88cef4f>] ohci_irq+0x1d3/0x2da [ohci_hcd]
 [<f8a869af>] usb_hcd_irq+0x35/0x5c [usbcore]
 [<c010bd7d>] handle_IRQ_event+0x39/0x62
 [<c010c207>] do_IRQ+0xf7/0x23e
 [<c010717a>] default_idle+0x0/0x32
 [<c010a3d4>] common_interrupt+0x18/0x20
 [<c010717a>] default_idle+0x0/0x32
 [<c01071a7>] default_idle+0x2d/0x32
 [<c0107226>] cpu_idle+0x3a/0x44
 [<c0105000>] rest_init+0x0/0x94
 [<c0480870>] start_kernel+0x1a4/0x1e6
 [<c0480428>] unknown_bootoption+0x0/0xf6

-- 
Kurtis D. Rader, Level 3 Linux Support and Customer Service Tool Developer
Beaverton Service Center/Linux Change Team
T/L 775-3714, DID +1 503-578-3714
