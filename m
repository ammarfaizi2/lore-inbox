Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTADUD1>; Sat, 4 Jan 2003 15:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTADUD1>; Sat, 4 Jan 2003 15:03:27 -0500
Received: from smtp2.us.dell.com ([143.166.85.133]:59584 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S261375AbTADUDY>; Sat, 4 Jan 2003 15:03:24 -0500
Date: Sat, 4 Jan 2003 14:11:52 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_init() sets kobj->subsys wrong?
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D680211A947@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0301041400570.17248-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your recent patch creating find_bus("scsi") always returns NULL.  I see
> that's because bus_subsys.list is empty.

In kobject_add(), with kobj->subsys = NULL, this kobject (embedded inside 
struct subsystem embedded inside struct bus_type) never gets added to 
either it's parent's list, nor to the (NULL) subsystem's list.  It appears 
that the object can be on either a parent's list or a subsystem's list, 
but not both, by virtue of there being only one struct list_head entry in 
struct kobject.

You're far more versed in how this should work than I.  Some ideas...

1) in bus_register(), don't set bus->subsys.parent = &bus_subsys, instead 
set bus->subsys.kobj.subsys = &bus_subsys.  I did this, and now find_bus() 
works as expected, but now the busses created don't have parents unless 
they're specified prior to calling bus_register(), so this doesn't seem 
quite right.

===== linux-2.5-edd-work/drivers/base/bus.c 1.26 vs edited =====
--- 1.26/drivers/base/bus.c     Sun Dec  1 23:22:04 2002
+++ edited/linux-2.5-edd-work/drivers/base/bus.c        Sat Jan  4 13:58:31 2003
@@ -495,7 +520,7 @@
 
        down(&bus_sem);
        strncpy(bus->subsys.kobj.name,bus->name,KOBJ_NAME_LEN);
-       bus->subsys.parent = &bus_subsys;
+       bus->subsys.kobj.subsys = &bus_subsys;
        subsystem_register(&bus->subsys);
 
        snprintf(bus->devsubsys.kobj.name,KOBJ_NAME_LEN,"devices");


2) set both bus->subsys.parent and bus->subsys.kobj.subsys, but then fix 
the test in kobject_add() to put the object on the subsystem's list if 
possible, then fall back to the parent list otherwise.  Again, doesn't 
seem quite right.

3) Add another struct list_head to kobject to let it reside on both a 
parent list and a subsystem list if either exist.

There are probably other options.  Please advise.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


