Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSJTUMR>; Sun, 20 Oct 2002 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264640AbSJTUMR>; Sun, 20 Oct 2002 16:12:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9344 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264639AbSJTUMP>;
	Sun, 20 Oct 2002 16:12:15 -0400
Date: Sun, 20 Oct 2002 13:21:29 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org, <andmike@us.ibm.com>
Subject: Re: 2.5.44: problemn when shutting down, drivers/base/power.c and
 the global_device_list
In-Reply-To: <20021019153417.GA567@middle.of.nowhere>
Message-ID: <Pine.LNX.4.44.0210201117080.963-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Oct 2002, Jurriaan wrote:

> When I shut my system down, the last line I saw was
> 
> Shutting down devices.
> 
> I've hacked drivers/base/power.c:device_shutdown() like this:
...

> And I've enabled DEBUG in drivers/base/core.c. It seems the same 2
> devices are being found in my global_device_list alternating, and the
> list_for_each is in effect an endless loop.

Thank you for the debugging output; it's _really_ helpful.

I'm not sure what exactly the problem is, but there are some clues. 

> dmesg | grep "^DEV:" gives:

> DEV: registering device: ID = 'scsi0', name = sym53c8xx
> DEV: registering device: ID = 'scsi0', name = sym53c8xx

> On shutdown, I see these lines alternating:
> 
> found device in global_device_list present 1 ID '0:0:5:0:gen' name ZYAMAHA  CRW2100S        1.0Ngeneric
> found device in global_device_list present 1 ID '0:0:2:0:gen' name = generic
> 
> I can't imagine the global_device_list is corrupt in some way.
> 
> Any hints? Full dmesg below.
> I think I'm going to dump the full global_device_list() any time before
> and after something is added during boot...


> DEV: registering device: ID = 'scsi0', name = sym53c8xx
> scsi0 : sym53c8xx-1.7.3c-20010512
> DEV: registering device: ID = 'scsi0', name = sym53c8xx
> sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
>   Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
>   Type:   CD-ROM                             ANSI SCSI revision: 02

It appears the same device is being added twice. After doing some digging
in the sym53c8xx and the scsi host code, that suspicion grows, though I'm 
not positively sure how the host is being added twice. 

sym53c8xx.c includes scsi_module.c, which contains the init_module() for 
the driver. That calls scsi_register_host() for the host driver, which 
calls ->detect() for the host. No problems there, but that's where the 
weirdness begins.

->detect() calls ncr_attach() at least once for each host adapter, which 
calls scsi_register(), which adds the host to the internal list of host 
adapters. Fine, but once control finally returns to scsi_register_host(), 
it will try to do scsi_register() if the low-level driver "failed to 
register a driver." (Sprinkle with scsi_unregister_host()s in the host 
driver code, and generic code, and you have successfully created a very 
convoluted code path.)

AFAICT, scsi_register() doesn't successfully check for duplicate names, 
and multiple instances of the host aren't detected. And the list 
manipulation itself is fishy at best. 

scsi_register_host() then loops through the hosts, and registers all the 
ones that this driver added. (Q: why is that function constantly looping 
through all the scsi hosts just to operate on the one passed in?).

If there are multiple instances of the same driver on the list, then very
interesting things will happen. The device will be inserted into the 
lists, but directory creation will fail, which will cause the device to be 
removed from the lists its on, which is bad juju. scsi_register_host() is 
not checking the return of device_register() either, and unconditionally 
calling scan_scsis(). 

The thing I still don't understand is why, if the device is inserted twice
on the scsi host list and registered in scsi_register_host(), we don't see
two messages like:

> scsi0 : sym53c8xx-1.7.3c-20010512


To summarize, I think the device is being added twice, which is producing
unpredictable behavior. This might also explain another unexplainable bug
during shutdown, using the same controller. 

device_add() should be checking if the device is already registered before 
adding it to the global list. 

Callers of device_register() and device_add() should check the return of 
it. 

The SCSI code is confusing and likely the culprit. 


The patch below checks if the device is registered, and fixes the
embarrassing double up() bug (Sorry, blackjack on the brain..). Could you
please try it, and let me know if it helps at all?

Thanks,

	-pat - lost in a twisty maze of scsi calls - mochel

===== drivers/base/core.c 1.49 vs edited =====
--- 1.49/drivers/base/core.c	Sun Oct 20 13:10:00 2002
+++ edited/drivers/base/core.c	Sun Oct 20 13:15:06 2002
@@ -33,6 +33,8 @@
 	if (!dev || !strlen(dev->bus_id))
 		return -EINVAL;
 
+	WARN_ON(dev->state == DEVICE_REGISTERED);
+
 	if (dev->parent) {
 		parent = get_device(dev->parent);
 		if (!parent)
@@ -67,9 +69,10 @@
 	devclass_add_device(dev);
  register_done:
 	if (error) {
-		up(&device_sem);
+		down(&device_sem);
 		list_del_init(&dev->g_list);
-		list_del_init(&dev->node);
+		if (!list_empty(&dev->node))
+			list_del_init(&dev->node);
 		up(&device_sem);
 		if (parent)
 			put_device(parent);

