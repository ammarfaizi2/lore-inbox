Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSJQIx3>; Thu, 17 Oct 2002 04:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJQIx3>; Thu, 17 Oct 2002 04:53:29 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:7416 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id <S261307AbSJQIxZ>; Thu, 17 Oct 2002 04:53:25 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB9D4264@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'andre@linux-ide.org'" <andre@linux-ide.org>
Subject: [PATCH]:  Sanity checking for drives that claim to be LBA-48, but
	 aren't!
Date: Thu, 17 Oct 2002 10:02:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I had previously posted about a relatively new Seagate drive that had worked
prior to 2.4.19, but in 2.4.19 failed to identify it's geometry properly. 

http://marc.theaimsgroup.com/?l=linux-kernel&m=103253071519548&w=2

Upon investigation of this with Seagate, it turns out that the firmware
version in question is for CE (consumer electronics) use.  They have used
bit 10 of word 86 (0x56) of the IDENTIFY DEVICE information to indicate some
feature in their "AV streaming data transfer set".  This breaks ATA-7, which
says this bit indicates that the drive understands LBA-48 commands.  

The kernel sees this bit set, tries to use LBA-48 commands, and the drive
errors, complaining that it doesn't understand!  Meaning this drive is
unusable with the >=2.4.19 kernels.  I think at least one other person has
reported something very similar, IIRC with a very old Maxtor IDE drive.

Here is a patch that does some basic sanity checking.  If the drive has an
lba_capacity_2==0, and has the bit set claiming to be LBA-48, it ignores
this claim.

I think this should go into the kernel, but I don't have any LBA-48 kit to
check that I'm not breaking things for other people.  Hope this helps anyone
else scratching their heads with drives that used to work.  


James Finnie


Standard disclaimer: it works for me, use at your own risk.

--BEGIN PATCH

diff -Naur linux-2.4.19/drivers/ide/ide-disk.c
linux-2.4.19-lba48sanity/drivers/ide/ide-disk.c
--- linux-2.4.19/drivers/ide/ide-disk.c Sat Aug  3 01:39:44 2002
+++ linux-2.4.19-lba48sanity/drivers/ide/ide-disk.c     Thu Oct 17 09:51:10
2002
@@ -924,6 +924,15 @@
        unsigned long long capacity_2 = capacity;
        unsigned long long set_max_ext;

+       // if the disk claims to be LBA-48, and yet has a capacity of 0,
+       // it's fairly safe to say that the firmware doesn't comply with
ATA-7
+       if ((id->cfs_enable_2 & 0x0400) && (id->lba_capacity_2==0)) {
+               printk ("%s: Broken firmware - this is NOT an LBA-48
drive!\n",drive->name);
+               printk ("%s: Disabling LBA-48 addressing for this
drive\n",drive->name);
+               //reset bit 10 so that we can use the disk in a non LBA-48
fashion
+               id->cfs_enable_2 &= ~ 0x0400;
+       }
+
        drive->capacity48 = 0;
        drive->select.b.lba = 0;

--END PATCH





~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


