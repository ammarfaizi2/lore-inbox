Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUIUHbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUIUHbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 03:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUIUHbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 03:31:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48289 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267505AbUIUHbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 03:31:07 -0400
Date: Tue, 21 Sep 2004 09:32:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Shane Shrybman <shrybman@aei.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040921073219.GA10095@elte.hu>
References: <1095714967.3646.14.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <1095714967.3646.14.camel@mars>
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


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Shane Shrybman <shrybman@aei.ca> wrote:

> I am having what appears to be IDE DMA problems with 2.6.9-rc2-mm1-S1.
> 2.6.9-rc2-mm1 does not show this problem and runs fine. Before this I
> was happily using 2.6.8-rc3-O5.
> 
> I tried booting with acpi=off but was unable to enter my user name at
> the login prompt, it just hung with no response to sysreq. I also
> tried turning off irq threading for that irq but it made no
> difference.

does undoing (patch -R) the attached patch fix this IDE problem?

	Ingo

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=1

--- linux/drivers/ide/ide-io.c.orig	
+++ linux/drivers/ide/ide-io.c	
@@ -114,6 +114,9 @@ static int __ide_end_request(ide_drive_t
 	int ret = 1;
 
 	BUG_ON(!(rq->flags & REQ_STARTED));
+	spin_unlock(&ide_lock);
+	if (drive->unmask)
+		local_irq_enable();
 
 	/*
 	 * if failfast is set on a request, override number of sectors and
@@ -135,6 +138,7 @@ static int __ide_end_request(ide_drive_t
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
+		spin_lock_irq(&ide_lock);
 		add_disk_randomness(rq->rq_disk);
 
 		if (blk_rq_tagged(rq))
@@ -144,7 +148,8 @@ static int __ide_end_request(ide_drive_t
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
 		ret = 0;
-	}
+	} else
+		spin_lock_irq(&ide_lock);
 	return ret;
 }
 

--uQr8t48UFsdbeI+V--
