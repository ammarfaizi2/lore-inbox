Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267733AbTACX6d>; Fri, 3 Jan 2003 18:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267734AbTACX6c>; Fri, 3 Jan 2003 18:58:32 -0500
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:44049 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S267733AbTACX6b>; Fri, 3 Jan 2003 18:58:31 -0500
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <20BF5713E14D5B48AA289F72BD372D680211A947@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: kobject_init() sets kobj->subsys wrong?
Date: Fri, 3 Jan 2003 18:06:57 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1208FA29165781-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat, I need your help tracking this one down... :-)

Your recent patch creating find_bus("scsi") always returns NULL.  I see
that's because bus_subsys.list is empty.  Now, why is it empty, when the
SCSI driver did a bus_register()?  It comes down to the code in
kobject_add(), where struct subsystem *s = kobj->subsys == NULL, thus the
list_add_tail code never gets called in there.  

The calls go something like this:

scsi_sysfs_register()
  bus_register(&scsi_bus_type)
    subsystem_register(scsi_bus_type->subsys)
      subsystem_init()
         kobject_init()  sets kobj->subsys = subsys_get(kobj->subsys)  which
seems wrong
	kobject_register()
	  kobject_add() where kobject->subsys is NULL

Strange, but true, and it may be kobject_init() that's borked setting
kobj->subsys.

Please advise.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

