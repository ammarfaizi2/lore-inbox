Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbUJaOYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUJaOYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUJaOYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:24:38 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21438 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261630AbUJaOYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:24:14 -0500
Date: Sun, 31 Oct 2004 14:24:10 +0000
From: Willem Riede <osst@riede.org>
Subject: rmmod osst hangs whenever osst gets loaded by hotplug at boot
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.2.4
Message-Id: <1099232650l.6300l.5l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I need some help here. I've been wrecking my brain to understand why
"rmmod osst" works just fine whenever I perfom the "modprobe osst"
manually from a terminal but always hangs when I coax hotplug (by a
modified /etc/hotplug/scsi.agent) to do the loading at boot time...

[root@fallguy osst]# ps alx
F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
4     0  3509  3472  17   0  3124  380 -      D+   pts/1      0:00 rmmod osst

It is the call to "scsi_unregister_driver(&osst_template.gendrv)" that
doesn't return. AFAICT, this can only be due to "down(&drv->unload_sem)"
in driver_unregister() at line 111 of linux-2.6.9/drivers/base/driver.c.

For that semaphore to be free a call to "up(&drv->unload_sem)" in  
driver_release() at line 68 of linux-2.6.9/drivers/base/bus.c is needed.

That would happen if osst_template.gendrv.bus->subsys.kset.kobj.kref.refcount  
reached zero in put_bus() called from bus_remove_driver() [put_bus translates  
into a kobject_put which does kref_put(&kobj->kref, kobject_release), which
is documented to "Decrement the refcount, and if 0, call kobject_cleanup()",
with kobject_cleanup doing "get_ktype(kobj)->release(kobj)"].

Having traced all that, and created some debug output fromm osst, I'm now even  
more baffled -- the refcount is 14 regardless of when/how osst was loaded at  
the time of the call to scsi_unregister_driver (the only difference is that it  
already reached 14 when osst initialized, if osst gets loaded at boot time  
register_driver makes it 10, with 4 references counted later).

The other counts must be from the other drivers on the "scsi" bus:
[root@fallguy ~]# ls /sys/bus/scsi/drivers
osst  sd  sr  st

There should be no way that refcount can make it back to zero, which would  
imply that rmmod osst should always hang. But it doesn't. Which must mean that  
I don't realy understand what's going on :-(

So I'm lost, which is why I'm asking for help :-) . Can somebody explain it?

(by the way, I can get rmmod st to hang in the same way)

For the record - I'm doing this testing on a scsi based dual PIII machine  
running Fedora Core release 2.92 (FC3 Test 3) kernel 2.6.9-1.643smp.

Thanks, Willem Riede.

