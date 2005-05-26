Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVEZVuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVEZVuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEZVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:50:33 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:31752 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261804AbVEZVuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:50:21 -0400
Message-ID: <42964498.9080909@rtr.ca>
Date: Thu, 26 May 2005 17:50:16 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>
In-Reply-To: <20050526140058.GR1419@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also saw a good boost from NCQ on the qstor driver (full version,
not the libata subset) last year.  Very good for busy servers
and RAID arrays.

Jens Axboe wrote:
+	do {
+		/*
+		 * we rely on the FIFO order of the exclusive waitqueues
+		 */
+		prepare_to_wait_exclusive(&ap->cmd_wait_queue, &wait,
+					  TASK_UNINTERRUPTIBLE);
+
+		if (!ata_qc_issue_ok(ap, qc, 1)) {
+			spin_unlock_irq(&ap->host_set->lock);
+			schedule();
+			spin_lock_irq(&ap->host_set->lock);
+		}
+
+		finish_wait(&ap->cmd_wait_queue, &wait);
+
+	} while (!ata_qc_issue_ok(ap, qc, 1));

In this bit (above), is it possible for this code to ever
be invoked from a SCHED_RR or SCHED_FIFO context?

If so, it will lock out all lower-priority processes
for the duration of the polling interval.

Cheers
