Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268212AbTCFRMH>; Thu, 6 Mar 2003 12:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268209AbTCFRMH>; Thu, 6 Mar 2003 12:12:07 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:36358 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S268201AbTCFRMC>; Thu, 6 Mar 2003 12:12:02 -0500
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
From: James Bottomley <James.Bottomley@steeleye.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Mike Anderson <andmike@us.ibm.com>, Andries.Brouwer@cwi.nl,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0303061213400.25282-100000@montezuma.mastecende.com>
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
	<20030306064921.GA1425@beaverton.ibm.com>
	<Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
	<20030306083054.GB1503@beaverton.ibm.com>
	<Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
	<20030306085506.GB2222@beaverton.ibm.com>
	<Pine.LNX.4.50.0303060354550.25282-100000@montezuma.mastecende.com>
	<20030306091824.GA2577@beaverton.ibm.com> 
	<Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com>
	<1046968304.1746.20.camel@mulgrave> 
	<Pine.LNX.4.50.0303061213400.25282-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Mar 2003 11:21:40 -0600
Message-Id: <1046971303.1998.23.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 11:15, Zwane Mwaikambo wrote:
> On Thu, 6 Mar 2003, James Bottomley wrote:
> 
> > This log implies the error handling finished after the BDR.  That looks
> > like the system doesn't have Mike's latest patch for the logic reversal
> > problem in scsi_eh_ready_devs, could you check this?
> 
> static void scsi_eh_ready_devs(struct Scsi_Host *shost,
>                               struct list_head *work_q,
>                               struct list_head *done_q)
> {
>        if (scsi_eh_bus_device_reset(shost, work_q, done_q))
>                if (scsi_eh_bus_reset(shost, work_q, done_q))
>                        if (scsi_eh_host_reset(work_q, done_q))
>                                scsi_eh_offline_sdevs(work_q, done_q);
> }
> 
> That is what i currently have, i'll try a boot with;
> 
> -               if (scsi_eh_bus_reset(shost, work_q, done_q))
> +               if (!scsi_eh_bus_reset(shost, work_q, done_q))
> 
> Thanks,
> 	Zwane


Actually, all three if's need nots in front:

diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Thu Mar  6 11:21:22 2003
+++ b/drivers/scsi/scsi_error.c	Thu Mar  6 11:21:22 2003
@@ -1490,9 +1490,9 @@
 			       struct list_head *work_q,
 			       struct list_head *done_q)
 {
-	if (scsi_eh_bus_device_reset(shost, work_q, done_q))
-		if (scsi_eh_bus_reset(shost, work_q, done_q))
-			if (scsi_eh_host_reset(work_q, done_q))
+	if (!scsi_eh_bus_device_reset(shost, work_q, done_q))
+		if (!scsi_eh_bus_reset(shost, work_q, done_q))
+			if (!scsi_eh_host_reset(work_q, done_q))
 				scsi_eh_offline_sdevs(work_q, done_q);
 }
 

