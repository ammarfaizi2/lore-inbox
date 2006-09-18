Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965331AbWIRFYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbWIRFYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbWIRFYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:24:03 -0400
Received: from exprod6og53.obsmtp.com ([64.18.1.187]:38632 "HELO
	exprod6og53.obsmtp.com") by vger.kernel.org with SMTP
	id S965331AbWIRFYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:24:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols from
    /boot/System.map
Date: Mon, 18 Sep 2006 07:23:58 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols 
    from /boot/System.map
Thread-Index: Acba4qRumahXl3MASd6sI+n2FrxOCg==
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>
Cc: "Willy Tarreau" <w@1wt.eu>
X-OriginalArrivalTime: 18 Sep 2006 05:23:58.0614 (UTC) 
    FILETIME=[A4A15B60:01C6DAE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
The 2.4 kernel series uses sys32_get_kernel_syms(struct kernel_sym32 *table) for reading the kernel symbols (on sparc64). The size of struct kernel_sym is 64 byte on "normal" arches, but 72 byte on sparc64.
The memory for the table holding all the structs is currently kmalloc'd, giving a limitation of 2048*sizeof(struct kernel_sym) for "normal" and 1820*sizeof(struct kernel_sym) for "sparc64" arches, the latter being caused by different sizes of unsigned longs and the need for alingnment bytes. This causes an "error reading System.map" message for no reason.

Solution (significantly helped by Dave Miller):
replace kmalloc() by vmalloc() to circumvent the size limit of 2^17 for kmalloc.

Other arches:
ppc64 defines value in struct kernel_sym as u32 in contrast to sparc, so we have the 2048 units limit here, but this would profit from using vmalloc(), too, since the limitation to 2048 is neither helpful nor neccessary. I lack sufficient understanding of the details to predict the impact on other arches. This patch refers to sparc64 but someone with deeper insight might want to look into this for other arches, too.

Signed off by: Dieter Jurzitza <DJurzitza@HarmanBecker.com>

--- linux/arch/sparc64/kernel/sys_sparc32.c     2006-08-11 06:18:20.000000000 +
+++ linux/arch/sparc64/kernel/sys_sparc32.c     2006-08-25 12:37:42.000000000 +
@@ -3730,7 +3730,7 @@
        
        len = sys_get_kernel_syms(NULL);
        if (!table) return len;
-       tbl = kmalloc (len * sizeof (struct kernel_sym), GFP_KERNEL);
+       tbl = vmalloc (len * sizeof (struct kernel_sym));
        if (!tbl) return -ENOMEM;
        old_fs = get_fs(); 
        set_fs (KERNEL_DS);
@@ -3741,7 +3741,7 @@
                    copy_to_user (table->name, tbl[i].name, 60))
                        break;
        }
-       kfree (tbl);
+       vfree (tbl);
        return i;
 }

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

