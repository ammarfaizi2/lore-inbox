Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWILLYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWILLYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWILLYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:24:00 -0400
Received: from exprod6og55.obsmtp.com ([64.18.1.191]:36570 "HELO
	exprod6og55.obsmtp.com") by vger.kernel.org with SMTP
	id S965155AbWILLX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:23:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: fix 2.4.33.3 / sun partition size
Date: Tue, 12 Sep 2006 13:23:56 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fix 2.4.33.3 / sun partition size
Thread-Index: AcbWXe+Ye4evdLd8RtKHunpD/RMQJw==
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jeff Mahoney" <jeffm@suse.com>, <sparclinux@vger.kernel.org>
X-OriginalArrivalTime: 12 Sep 2006 11:23:56.0721 (UTC) 
    FILETIME=[EFA07210:01C6D65D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.33

Issue: really fix size display for sun partitions larger than 1TByte

Signed off by: Dieter Jurzitza DJurzitza@HarmanBecker.com

Problem: the last fix introduced by Jeff Mahoney for kernel 2.6 was not complete for kernel 2.4 (as applied)
I found out that add_gd_partition is called by any type of partition (2.4). add_gd_partition is defined as add_gd_partition (int, int), what makes no sense to me as negative numbers should never occur here. As long as add_gd_partition is not changed to add_gd_partition (unsigned, unsigned), /proc/partitions will keep showing negative numbers.

If ever someone could look into this, within the different partition type files in linux/fs/partitions the parameters to add_gd_partitions seem to be chosen arbitrarily between int, unsigned and unsigned long, whatever seemed to be appropriate, I think it would make sense to get consistent parameters to add_gd_partition from all partition types here.
Especially if one takes into account that sizeof (long) and sizeof (int) may differ significantly i. e. on sparc.


Take care


Dieter Jurzitza



--- linux/fs/partitions/sun.c   2002-11-29 00:53:15.000000000 +0100
+++ linux/fs/partitions/sun.c   2006-08-29 07:04:56.000000000 +0200
@@ -86,7 +86,7 @@
        spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
        for (i = 0; i < 8; i++, p++) {
                unsigned long st_sector;
-               int num_sectors;
+               unsigned int num_sectors;
 
                st_sector = first_sector + be32_to_cpu(p->start_cylinder) * spc;
                num_sectors = be32_to_cpu(p->num_sectors);
--- linux/fs/partitions/check.c 2006-08-31 19:03:20.000000000 +0200
+++ linux/fs/partitions/check.c 2006-09-03 12:47:55.000000000 +0200
@@ -204,7 +204,7 @@
 /*
  * Add a partitions details to the devices partition description.
  */
-void add_gd_partition(struct gendisk *hd, int minor, int start, int size)
+void add_gd_partition(struct gendisk *hd, int minor, unsigned int start, unsign
ed int size)
 {
 #ifndef CONFIG_DEVFS_FS
        char buf[40];
--- linux/fs/partitions/check.h 2006-08-31 19:03:20.000000000 +0200
+++ linux/fs/partitions/check.h 2006-09-03 12:48:54.000000000 +0200
@@ -2,7 +2,7 @@
  * add_partition adds a partitions details to the devices partition
  * description.
  */
-void add_gd_partition(struct gendisk *hd, int minor, int start, int size);
+void add_gd_partition(struct gendisk *hd, int minor, unsigned int start, unsign
ed int size);
 
 typedef struct {struct page *v;} Sector;
 


-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
   System Development

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de
 


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

