Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269357AbUIIG0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbUIIG0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbUIIG0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:26:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61827 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269357AbUIIG0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:26:36 -0400
Date: Thu, 9 Sep 2004 08:27:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040909062738.GI1362@elte.hu>
References: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
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

> Not quite sure where to add touch_preempt_timing() calls - somewhere in the
> loop in ide_outsl and ide_insl? [so we keep resetting the start /end
> times?]

> 00000001 0.002ms (+0.000ms): ata_output_data (taskfile_output_data)
> 00000001 0.003ms (+0.542ms): ide_outsl (ata_output_data)
> 00000001 0.545ms (+0.000ms): kunmap_atomic (ide_multwrite)

yeah, i'd add it to ide_outsl. Something like the patch below. (it
compiles but is untested otherwise.)

another possibility besides DMA starvation is starvation between CPUs. 
The only way to exclude DMA as a source of CPU starvation would be to
try a maxcpus=1 test using the SMP kernel. You dont even have to run the
RT-latency tester for this - just the disk read/write workload should
trigger the latency traces!

	Ingo

--- linux/drivers/ide/ide-iops.c.orig	
+++ linux/drivers/ide/ide-iops.c	
@@ -56,7 +56,15 @@ static u32 ide_inl (unsigned long port)
 
 static void ide_insl (unsigned long port, void *addr, u32 count)
 {
-	insl(port, addr, count);
+	unsigned int chunk, offset = 0;
+
+	while (count) {
+		chunk = min(128U, count);
+		insl(port, addr + offset, chunk);
+		count -= chunk;
+		offset += chunk;
+		touch_preempt_timing();
+	}
 }
 
 static void ide_outb (u8 val, unsigned long port)
@@ -86,7 +94,15 @@ static void ide_outl (u32 val, unsigned 
 
 static void ide_outsl (unsigned long port, void *addr, u32 count)
 {
-	outsl(port, addr, count);
+	unsigned int chunk, offset = 0;
+
+	while (count) {
+		chunk = min(128U, count);
+		outsl(port, addr + offset, chunk);
+		count -= chunk;
+		offset += chunk;
+		touch_preempt_timing();
+	}
 }
 
 void default_hwif_iops (ide_hwif_t *hwif)
