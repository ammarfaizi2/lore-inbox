Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWHYOko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWHYOko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWHYOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:40:44 -0400
Received: from exprod6og54.obsmtp.com ([64.18.1.189]:15046 "HELO
	exprod6og54.obsmtp.com") by vger.kernel.org with SMTP
	id S1751486AbWHYOkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:40:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: two bugletts on sparc - Dave Miller is always right, isn't he? :-)))
Date: Fri, 25 Aug 2006 16:40:41 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C060156929E@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: two bugletts on sparc - Dave Miller is always right, isn't he? 
    :- ) ) )
Thread-Index: AcbIVHCMM7TcQO6sTFCMZ8K1NSxFdA==
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>
X-OriginalArrivalTime: 25 Aug 2006 14:40:41.0745 (UTC) 
    FILETIME=[7088A810:01C6C854]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear listmembers,
thanks to the inputs to David Miller there is a fix for the kmalloc issue with sys32_get_kernel_syms() in linux/arch/sparc64/kernel/sys_sparc32.c, preventing the kernel from reading the entire symbol table due to a memory limitation.

Rather than my initial suggestion to change the unsigned long to an unsigned int in struct kernel_syms, the kmalloc() should be changed into a vmalloc() giving significant improvement with regard to the max amount of symbols that can be read. So, I would suggest (tested on my U60) to integrate the following patch into the kernel 2.4-tree (cannot tell about 2.6). I would expect similar issues on other 32/64 arches, but cannot test. x86_64 contains the very same function with the very same call in linux/arc/x86_64/kernel/ia32/sys_ia32.c.

The number of symbols that can be read by sys32_get_kernel_syms is limited to 2048 at max, what is not enough IMHO. Dave Miller suggested to replace the kmalloc() by a vmalloc(), this should be uncritical here as I do not think the delay is of significance. This increases the memsize-limit from 2^17 i. e. 128k to several MByte, what should be sufficient.

Successfully tested here (kernel 2.4.33):

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


Thanks to Dave Miller once again,
take care



Dieter Jurzitza


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

