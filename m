Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTJRSJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJRSJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:09:51 -0400
Received: from web40912.mail.yahoo.com ([66.218.78.209]:23370 "HELO
	web40912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261796AbTJRSHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:07:42 -0400
Message-ID: <20031018180741.69117.qmail@web40912.mail.yahoo.com>
Date: Sat, 18 Oct 2003 11:07:41 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: This bug appears under 2.6.0-test8 as well (was: 2.6.0-test7-mm1)
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <20031018132741.GV866@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Collins,

--- Ben Collins <bcollins@debian.org> wrote:
> > 
> > I was looking briefly at this too, and as you say, the problem is that 
> > some things have to happen in interrupt, others happen in process 
> > context.  I've attached a patch that implements one way to fix it: 
> > double book-keeping - we maintain two lists of the highlevel drivers, 
> > one protected by a semaphore another protected by the rw spinlock. The 
> > lists are identical, except between the two list_add_tail()'s (and the 
> > two list_del()'s), but that doesn't allow any harmful race conditions.
> > 
> > A more radical approach would be to split the highlevel interface into 
> > two interfaces add_host() + remove_host() in a hpsb_host_notification 
> > interface and the rest in another interface.  The driver would have to 
> > register both interfaces if it needs them. Some drivers only use 
> > add_host() and remove_host(), so they could register only the 
> > hpsb_host_notification interface.
> 
> Actually I'm leaning toward getting rid of our internal locking and
> reference counting and relying heavily on the device model's reference
> counting and such. Take some of the work load off of our code.
> 
> Each host already has a device associated with it, so it just requires a
> revamp of some internals.

JFYI, this bug also appears under 2.6.0-test8:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
Packet=[2048]
Debug: sleeping function called from invalid context at mm/slab.c:1857
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c012186b>] __might_sleep+0xa0/0xc1
 [<c01531f4>] __kmalloc+0x204/0x216
 [<e08a9e2c>] hpsb_create_hostinfo+0x6b/0xe8 [ieee1394]
 [<e08aef8a>] nodemgr_add_host+0x23/0x1d2 [ieee1394]
 [<c0210abc>] sprintf+0x1f/0x23
 [<e08aa62d>] highlevel_add_host+0x6b/0x6f [ieee1394]
 [<e08a9c42>] hpsb_add_host+0x6d/0x95 [ieee1394]
 [<e08c0b4e>] ohci1394_pci_probe+0x512/0x620 [ohci1394]
 [<e08bdb18>] ohci_irq_handler+0x0/0x1129 [ohci1394]
 [<c0216d33>] pci_device_probe_static+0x52/0x63
 [<c0216d7f>] __pci_device_probe+0x3b/0x4e
 [<c0216dbe>] pci_device_probe+0x2c/0x4a
 [<c0279e72>] bus_match+0x3f/0x6a
 [<c0279f84>] driver_attach+0x56/0x80
 [<c027a256>] bus_add_driver+0x9f/0xb1
 [<c027a6ba>] driver_register+0x8c/0x90
 [<c0216faa>] pci_register_driver+0x8c/0xab
 [<e0886013>] ohci1394_init+0x13/0x3d [ohci1394]
 [<c0145a37>] sys_init_module+0x213/0x3e6
 [<c017228b>] sys_read+0x42/0x63
 [<c010a179>] sysenter_past_esp+0x52/0x71

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0b8060000db10]

Since I don't use the OHCI1394 drivers yet, I can't really offer any assistance,
except to test patches that make the debug message go away.

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
