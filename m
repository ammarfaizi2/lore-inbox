Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTFQWiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFQWiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:38:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264987AbTFQWiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:38:02 -0400
Date: Tue, 17 Jun 2003 15:54:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: borked sysfs system devices in 2.5.72
In-Reply-To: <1055889108.24196.11.camel@nighthawk>
Message-ID: <Pine.LNX.4.44.0306171551261.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look in subsys_attr_show().  It is being passed a kobject, which is a
> member of a "struct sys_device".  We can tell this because I printed out
> the address of the sys device in sys_device_register().  A to_subsys()
> is being performed on that object, which is wrong, because the kobject
> is not a member of a "struct subsystem".

My question was how the hell it was getting there in the first place, and 
I see that the type of the object isn't getting set properly, so it 
defaults to treat it as a struct subsystem. 

Could you please try the following patch, and let me know if it works? 

Thanks,


	-pat

===== drivers/base/sys.c 1.25 vs edited =====
--- 1.25/drivers/base/sys.c	Mon Jun 16 10:07:04 2003
+++ edited/drivers/base/sys.c	Tue Jun 17 15:50:48 2003
@@ -170,6 +172,9 @@
 
 	/* Make sure the kset is set */
 	sysdev->kobj.kset = &cls->kset;
+
+	/* But make sure we point to the right type for sysfs translation */
+	sysdev->kobj.ktype = &ktype_sysdev;
 
 	/* set the kobject name */
 	snprintf(sysdev->kobj.name,KOBJ_NAME_LEN,"%s%d",

