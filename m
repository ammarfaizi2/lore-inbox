Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966993AbWKYXU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966993AbWKYXU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 18:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935211AbWKYXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 18:20:28 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:19354 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S935201AbWKYXU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 18:20:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm2 (end earlier): WARNING at lib/kobject.c:172 kobject_init() on resume from disk
Date: Sun, 26 Nov 2006 00:15:52 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>
References: <200611222207.07143.rjw@sisk.pl> <20061122134406.f3a30fc4.akpm@osdl.org> <200611252320.12498.rjw@sisk.pl>
In-Reply-To: <200611252320.12498.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611260015.53710.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 25 November 2006 23:20, Rafael J. Wysocki wrote:
> On Wednesday, 22 November 2006 22:44, Andrew Morton wrote:
> > On Wed, 22 Nov 2006 22:07:06 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Hi,
> > > 
> > > I get similar traces on every resume from disk on SMP systems:
> > > 
> > > WARNING at lib/kobject.c:172 kobject_init()
> > > 
> > > Call Trace:
> > >  [<ffffffff80265559>] dump_trace+0xaa/0x3fd
> > >  [<ffffffff802658e8>] show_trace+0x3c/0x52
> > >  [<ffffffff80265913>] dump_stack+0x15/0x17
> > >  [<ffffffff8031c1ad>] kobject_init+0x3f/0x8a
> > >  [<ffffffff8031c298>] kobject_register+0x1a/0x3e
> > >  [<ffffffff8038e5b4>] sysdev_register+0x5f/0xec
> > >  [<ffffffff8026af39>] mce_create_device+0x79/0x103
> > >  [<ffffffff8026afed>] mce_cpu_callback+0x2a/0xbd
> > >  [<ffffffff8026112f>] notifier_call_chain+0x29/0x3e
> > >  [<ffffffff8028e809>] raw_notifier_call_chain+0x9/0xb
> > >  [<ffffffff80299f18>] _cpu_up+0xc2/0xd5
> > >  [<ffffffff80299f56>] cpu_up+0x2b/0x42
> > >  [<ffffffff80299fbb>] enable_nonboot_cpus+0x4e/0x9b
> > >  [<ffffffff802a35da>] snapshot_ioctl+0x1a0/0x5d2
> > >  [<ffffffff8023d9cd>] do_ioctl+0x5e/0x77
> > >  [<ffffffff8022d785>] vfs_ioctl+0x256/0x273
> > >  [<ffffffff8024770b>] sys_ioctl+0x5f/0x82
> > >  [<ffffffff8025811e>] system_call+0x7e/0x83
> > > DWARF2 unwinder stuck at system_call+0x7e/0x83
> > > Leftover inexact backtrace:
> > > 
> > > False positive?
> > > 
> > 
> > Don't know.  The changelog in
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/kobject-warn.patch
> > is pretty pathetic.
> > 
> > Perhaps mce_remove_device() isn't being called.
> 
> I've added some debugging code into mce_remove_device() which shows that it is
> being called when the CPU is removed.
> 
> Investigation continues.

Ah, I think the problem is that the last user of a kobject doesn't decrease
the refcount in kref_put(), so if the same kobject is registered for the
second time, the refcount is still one and the warning triggers.

So, it seems, this is a false positive and I think we can get rid of it in the
following way (tested and works):

---
Make mce_remove_device() clean up the kobject in per_cpu(device_mce, cpu)
after it has been unregistered.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86_64/kernel/mce.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.19-rc6-mm1/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.19-rc6-mm1.orig/arch/x86_64/kernel/mce.c	2006-11-25 23:56:08.000000000 +0100
+++ linux-2.6.19-rc6-mm1/arch/x86_64/kernel/mce.c	2006-11-26 00:15:34.000000000 +0100
@@ -651,6 +651,7 @@ static void mce_remove_device(unsigned i
 	sysdev_remove_file(&per_cpu(device_mce,cpu), &attr_tolerant);
 	sysdev_remove_file(&per_cpu(device_mce,cpu), &attr_check_interval);
 	sysdev_unregister(&per_cpu(device_mce,cpu));
+	per_cpu(device_mce, cpu).kobj = (struct kobject){ 0 };
 }
 
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
