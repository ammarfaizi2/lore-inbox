Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVGHVQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVGHVQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVGHVOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:14:18 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:12770 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262906AbVGHVMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:12:18 -0400
Date: Fri, 8 Jul 2005 14:12:09 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, abhay_salunke@dell.com,
       greg@kroah.com
Subject: Re: [patch 2.6.12-rc3] modified firmware_class.c to add a new
 function request_firmware_nowait_nohotplug
Message-Id: <20050708141209.56395d5d.rdunlap@xenotime.net>
In-Reply-To: <20050709001657.GA29556@abhays.us.dell.com>
References: <20050709001657.GA29556@abhays.us.dell.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005 19:16:57 -0500 Abhay Salunke wrote:

| This is the patch to add dell_rbu driver. This patch requires the 
| firmware_class.c patch sent earlier which adds request_firmware_nowait_nohotplug 
| function. 
| Andrew , 
| Could you add this patch to the -mm tree. This patch was submitted about a
| week ago for review.
| 
| Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>
| 
| Thanks
| Abhay
| diff -uprN linux-2.6.11.11.orig/Documentation/dell_rbu.txt linux-2.6.11.11.new/Documentation/dell_rbu.txt
| --- linux-2.6.11.11.orig/Documentation/dell_rbu.txt	1969-12-31 18:00:00.000000000 -0600
| +++ linux-2.6.11.11.new/Documentation/dell_rbu.txt	2005-06-30 15:41:28.000000000 -0500
| @@ -0,0 +1,72 @@
| +Purpose:
| +Demonstrate the usage of the new open sourced rbu (Remote BIOS Update) driver
| +for updating BIOS images on Dell servers and desktops.
| +
| +Scope:
| +This document discusses the functionality of the rbu driver only.
| +It does not cover the support needed from aplications to enable the BIOS to
| +update itself with the image downloaded in to the memory.
| +
| +Overview:
| +This driver enables userspace applications to update the BIOS on Dell servers
| +(starting from servers sold since 1999), desktops and notebooks (starting
   (beginning with servers sold in 1999)                          (beginning
| +from those sold in 2005).
   with those sold in 2005)
| +
| +The driver supports BIOS update using the monilothic image and packetized
                                             monolithic
| +image methods. In case of moniolithic the driver allocates a contiguous chunk
                  In the monolithic case,
| +of physical pages having the BIOS image. In case of packetized the app
                                            In the packetized case,
| +using the driver breaks the image in to packets of fixed sizes and the driver
| +would place each packet in contiguous physical memory. The driver also
     places               into
| +maintains a link list of packets for reading them back.
               linked
| +If the dell_rbu driver is unloaded all the allocated memory is freed.
| +
| +The rbu driver needs to have an application which will inform the BIOS to
| +enable the update in the next system reboot.
| +
| +The user should not unload the rbu driver after downloading the BIOS image
| +or updating.
| +
| +The driver load creates the following directories under the /sys file system.
| +/sys/class/firmware/dell_rbu/loading 
| +/sys/class/firmware/dell_rbu/data
| +/sys/devices/platform/dell_rbu/image_type
| +/sys/devices/platform/dell_rbu/data
| +
| +The driver supports two types of update mechanism; monolithic and packetized.
                                           mechanisms;
| +These update mechanism depends upon the BIOS currently running on the system.
| +Most of the Dell systems support a monolithic update where the BIOS image is 
| +copied to a single contiguous block of physical memory. 
| +In case of packet mechanism the single memory can be broken in smaller chuks
   In the packetized mode,                                     into smaller chunks
| +of contiguous memory and the BIOS image is scattered in these packets.
| +
| +By default the driver uses monolithic memory for the update type. This can be
| +changed to contiguous during the driver load time by specifying the load
             packetized mode
| +parameter image_type=packet.  This can also be changed later as below
                                                                by using:
| +echo "packet" > /sys/devices/platform/dell_rbu/image_type 
| +
| +Do the steps below to download the BIOS image.
| +1) echo 1 > /sys/class/firmware/dell_rbu/loading
| +2) cp bios_image.hdr /sys/class/firmware/dell_rbu/data
| +3) echo 0 > /sys/class/firmware/dell_rbu/loading
| +
| +The /sys/class/firmware/dell_rbu/ entries will remain till the following is
                                                        until
| +done. 
   done:
| +echo -1 > /sys/class/firmware/dell_rbu/loading
| +
| +Until this step is completed the drivr cannot be unloaded.
                                    driver
| +
| +Also the driver provides /sys/devices/platform/dell_rbu/data readonly file to
| +read back the image downloaded. This is useful in case of packet update 
                                   This is useful in the packetized update
| +mechanism where the above steps 1,2,3 will repeated for every packet. 
| +By reading the /sys/devices/platform/dell_rbu/data file all packet data 
| +downloaded can be verified in a single file. 
| +The packets are arranged in this file one after the other in a FIFO order.
| +
| +NOTE:
| +This driver requires a patch for firmware_class.c which has the addition
| +of request_firmware_nowait_nohotplug function to wortk
     ^insert "the"                                  work.
| +Also after updating the BIOS image an user mdoe application neeeds to execute
                                      a user mode
| +code which message the BIOS update request to the BIOS. So on the next reboot
              sends                         to the BIOS, so that on the next reboot
| +the BIOS knows about the new image downloaded and it updates it self.
                                                                itself.
| +Also don't unload the rbu drive if the image has to be updated.
                             driver

So do you recommend never unloading the rbu driver -- just reboot?


Code review comments will follow separately.

---
~Randy
