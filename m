Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbULIOTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbULIOTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULIOTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:19:25 -0500
Received: from mail0.lsil.com ([147.145.40.20]:21943 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261412AbULIOTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:19:09 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57057A1AEA@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'Matt Domsch'" <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Thu, 9 Dec 2004 09:11:15 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > >The real way I'd like to handle this is via hotplug.  The hotplug 
> > >event would transmit the HCTL in the environment.
> > >Whether the drive actually gets incorporated into the system and 
> > >where is user policy, so it's appropriate that it should be in 
> > >userland.
> > 
> > James, it is the application that is adding the drive. So 
> it is not a 
> > hotplug event for the driver.
> 
> Then perhaps I don't understand what the issue is.  If the 
> application is adding the drive, then surely it would know 
> the numbers.  If not, then the driver must communicate this 
> back, and that's what the hotplug would be about.
> 
> James
> 
> 
Let me elaborate it.

1. The management applications decide to created new logical drives or
remove some of the existing ones.

2. How applications would do this, is by sending commands to the megaraid
firmware via driver. Driver does not intercept these commands for a simple
reason that the driver code would become unnecessarily bulky to understanad
all the possible ways applications can change the number of logical devices.

3. Once the change in configuration has happened, someone must notify kernel
about new or removed devices.

4. Since megaraid driver does not know about these changes, it cannot notify
kernel.

5. So this becomes the responsibility of the application which caused the
change in configuration. Application dilemma is, all it know is it created a
few devices and removed some. But there is no way for it to relate the
affected devices with the way how kernel was or would be seeing them, that
is, the affected device's scsi address. Remember, the affected devices are
only logical, there is no physical bus, target, lun associated with them.
Driver creates this mapping on the fly.

6. That's where application seeks help from driver and requests for the scsi
address driver would be using for the affected devices.

7. Once it has the scsi address for the devices in question, depending on
the application and system administrator's preference, application would
either use sysfs to add/remove affected devices or cause a hotplug event
resulting in the configured behavior.

8. So, all driver has to do to assist applications is to provide the logical
drive number to scsi address mapping. Application would say, hey! I
added/removed logical drive number 5, driver reverts, here is the scsi
address for it "host:2, channel:5, target:5 lun:0" :-)

-Atul Mukker
