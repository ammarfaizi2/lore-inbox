Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272263AbUKAPhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272263AbUKAPhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272430AbUKAPhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:37:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47510 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262859AbUKAOgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:36:09 -0500
Date: Mon, 1 Nov 2004 15:36:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101143633.GA22981@elte.hu>
References: <OF7D48BC89.318047B1-ON86256F3F.004FE424-86256F3F.004FE4A1@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7D48BC89.318047B1-ON86256F3F.004FE424-86256F3F.004FE4A1@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Hmm. I was in the middle of a V0.6.4 build when I saw this message.
> I let it run but the build stopped with the following error:
> 
>   CC [M]  drivers/scsi/qla2xxx/qla_os.o
>   CC [M]  drivers/usb/media/stv680.o
> drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_do_dpc':
> drivers/scsi/qla2xxx/qla_os.c:3193: warning: implicit declaration of
> function `DECLARE_MUTEX_LOCKED'

the patch below should fix it, will be in the next release.

	Ingo

--- linux/drivers/scsi/qla2xxx/qla_os.c.orig
+++ linux/drivers/scsi/qla2xxx/qla_os.c
@@ -3190,7 +3190,7 @@ qla2x00_free_sp_pool( scsi_qla_host_t *h
 static int
 qla2x00_do_dpc(void *data)
 {
-	DECLARE_MUTEX_LOCKED(sem);
+	DECLARE_MUTEX(sem);
 	scsi_qla_host_t *ha;
 	fc_port_t	*fcport;
 	os_lun_t        *q;
@@ -3204,6 +3204,8 @@ qla2x00_do_dpc(void *data)
 	int t;
 	os_tgt_t *tq;
 
+	down(&sem);
+
 	ha = (scsi_qla_host_t *)data;
 
 	lock_kernel();
