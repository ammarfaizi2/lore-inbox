Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262985AbSJBHeJ>; Wed, 2 Oct 2002 03:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbSJBHeJ>; Wed, 2 Oct 2002 03:34:09 -0400
Received: from laibach.mweb.co.za ([196.2.53.177]:3216 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S262985AbSJBHeI>; Wed, 2 Oct 2002 03:34:08 -0400
To: Corporal_Pisang@Counter-Strike.com.my, linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: 2.5.40 compile error (missing imm.o)
Date: Wed, 2 Oct 2002 07:39:18 GMT
X-Posting-IP: 196.34.86.10 via 172.24.158.16
X-Mailer: Endymion MailMan  
Message-Id: <E17wdvf-0005YV-00@laibach.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi,
> 
> 2.5.40 gives me a compile error doesnt exists before.
> 
> gcc -Wp,-MD,./.imm.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=athlon  -I/usr/src/linux/arch/i386/mach-generic -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=imm   -c -o imm.o imm.c
> drivers/scsi/imm.c: In function `imm_interrupt':
> drivers/scsi/imm.c:901: warning: implicit declaration of function
> `queue_task'
> drivers/scsi/imm.c:901: `tq_timer' undeclared (first use in this function)
> drivers/scsi/imm.c:901: (Each undeclared identifier is reported only once
> drivers/scsi/imm.c:901: for each function it appears in.)
> drivers/scsi/imm.c: In function `imm_queuecommand':
> drivers/scsi/imm.c:1108: `tq_immediate' undeclared (first use in this
> function)
> drivers/scsi/imm.c:1109: warning: implicit declaration of function `mark_bh'
> drivers/scsi/imm.c:1109: `IMMEDIATE_BH' undeclared (first use in this
> function)

<snip>

Try this patch I think it should fix it (not tested though)


diff -uNr linux-2.5/drivers/scsi/imm.c.old linux-2.5/drivers/scsi/imm.c    
--- linux-2.5/drivers/scsi/imm.c.old	2002-10-02 09:30:41.000000000 +0200
+++ linux-2.5/drivers/scsi/imm.c	2002-10-02 09:31:53.000000000 +0200
@@ -898,7 +898,7 @@
     if (imm_engine(tmp, cmd)) {
 	tmp->imm_tq.data = (void *) tmp;
 	tmp->imm_tq.sync = 0;
-	queue_task(&tmp->imm_tq, &tq_timer);
+	schedule_task(&tmp->imm_tq);
 	return;
     }
     /* Command must of completed hence it is safe to let go... */
@@ -1105,8 +1105,7 @@
 
     imm_hosts[host_no].imm_tq.data = imm_hosts + host_no;
     imm_hosts[host_no].imm_tq.sync = 0;
-    queue_task(&imm_hosts[host_no].imm_tq, &tq_immediate);
-    mark_bh(IMMEDIATE_BH);
+    schedule_task(&imm_hosts[host_no].imm_tq);
 
     return 0;
 }

Cheers

> 
> Regards
> 
> -Ubaida-


---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


