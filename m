Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUDAKJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUDAKJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:09:35 -0500
Received: from [202.125.86.130] ([202.125.86.130]:27309 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262438AbUDAKJe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:09:34 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Flash Media block driver problem!
Date: Thu, 1 Apr 2004 15:33:12 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A972176F8E@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Flash Media block driver problem!
Thread-Index: AcQX0IsjB17seoCWTWCfgxqXAsw3NA==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are developing a block device driver (2.4.x kernel) for Flash Media devices over one of our storage media controllers. I should admit that this is the first time we are developing a block device driver under Linux.
Sorry if the question becomes too obvious to some.

We are facing a peculiar problem. If the flash media card had been formatted under Linux (either ext2 or FAT) the card was mounted successfully and we could read its contents. However if the card had never been on a Linux box, the file system in the card was not recognized properly (Error: VFAT bogus partition). If we format the card under Linux just once with FAT, then it will continue to work for Windows and Linux.

We have been able to figure out why the problem actually occurs. The reason is that Linux (our driver?) does not recognize several partitions in a single FAT12/FAT16 Flash Media card. According to the FAT12/FAT16 file system, the card should have a valid Master Boot Sector in the first logical sector. This master boot sector indicates how many partitions are in the disk and the start and end addresses along with their respective size. FAT12/FAT16 disks must also have a Partition Boot Sector. The partition boot sector contains the parameters of each partition.

Brand new SM or SD cards come pre-formatted with a FAT12/FAT16 file system, which includes a Master Boot Sector and one Partition Boot Sector for one single partition. Linux does not recognize this partitioned card with just one active partition. Actually, when you format a card with FAT12 or FAT16 under Linux, the OS creates one single partition but without a Master Boot Sector. That is, the first logical sector contains the Partition Boot Sector instead of the Master Boot Sector.

Windows does not have a problem reading cards without a Master Boot Sector as long as they have a valid Partition Boot Sector. That is why once you format a card with 'mkfs -t msdos /dev/ourdev' or similar command under Linux, the card will continue to work under Windows and Linux as well.

However, this behavior is not acceptable for our customers since Digital cameras do not recognize Flashmedia cards after they have been formatted under Linux (with our driver). Besides, end customers do not want to format the cards before they can use them under Linux. For instance, a customer buys a new card and takes some pictures with a digital camera and then inserts it in our reader. This will force the user to format the card in order to be able to use it with Linux, therefore destroying all its data. 

We are *not* doing a "register_disk()" and "struct gendisk" structure in our driver right now. This is a Flash Media device which should not be partitioned. Is a register_disk() call still mandatory? Are we missing out something in the driver?

Thanks,
-Jinu
