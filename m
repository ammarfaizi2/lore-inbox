Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268218AbTCFRMl>; Thu, 6 Mar 2003 12:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268215AbTCFRMl>; Thu, 6 Mar 2003 12:12:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:18333 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268209AbTCFRMf>; Thu, 6 Mar 2003 12:12:35 -0500
Date: Thu, 6 Mar 2003 09:24:49 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Andries.Brouwer@cwi.nl,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Message-ID: <20030306172449.GA1109@beaverton.ibm.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20030306064921.GA1425@beaverton.ibm.com> <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com> <20030306083054.GB1503@beaverton.ibm.com> <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com> <20030306085506.GB2222@beaverton.ibm.com> <Pine.LNX.4.50.0303060354550.25282-100000@montezuma.mastecende.com> <20030306091824.GA2577@beaverton.ibm.com> <Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com> <1046968304.1746.20.camel@mulgrave> <Pine.LNX.4.50.0303061213400.25282-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303061213400.25282-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo [zwane@linuxpower.ca] wrote:
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

This should not fix your problem you should apply the whole patch as the
reversed check on scsi_eh_bus_device_reset is what you should be
hitting.

The patch below should apply to your kernel version.

-andmike
--
Michael Anderson
andmike@us.ibm.com


=====
name:		00_scsi_error_ready_devs-1.diff
version:	2003-03-05.10:39:28-0800
against:	2.5.63

 scsi_error.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

=====
===== drivers/scsi/scsi_error.c 1.38 vs edited =====
--- 1.38/drivers/scsi/scsi_error.c	Sat Feb 22 08:17:01 2003
+++ edited/drivers/scsi/scsi_error.c	Wed Mar  5 10:14:22 2003
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
 
