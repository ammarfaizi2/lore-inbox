Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbULBObl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbULBObl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbULBObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:31:41 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:33189 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261639AbULBOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:30:46 -0500
Date: Thu, 2 Dec 2004 08:30:30 -0600
From: Andy Warner <andyw@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041202083030.A30927@florence.linkmargin.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <41AEBD95.7030804@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41AEBD95.7030804@pobox.com>; from jgarzik@pobox.com on Thu, Dec 02, 2004 at 02:00:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jeff Garzik wrote:
> [...]
> I am currently chasing a 2.6.8->2.6.9 SATA regression, which causes 
> ata_piix (Intel ICH5/6/7) to not-find some SATA devices on x86-64 SMP, 
> but works on UP.  Potentially related to >=4GB of RAM.
> 
> 
> 
> Details, in case anyone is interested:
> Unless my code is screwed up (certainly possible), PIO data-in [using 
> the insw() call] seems to return all zeroes on a true-blue SMP machine, 
> for the identify-device command.  When this happens, libata (correctly) 
> detects a bad id page and bails.  (problem doesn't show up on single CPU 
> w/ HT)

Ah, I might have been here recently, with the pass-thru stuff.

What I saw was that in an SMP machine:

1. queue_work() can result in the work running (on another
   CPU) instantly.

2. Having one CPU beat on PIO registers reading data from one port
   would significantly alter the timing of the CMD->BSY->DRQ sequence
   used in PIO. This behaviour was far worse for competing ports
   within one chip, which I put down to arbitration problems.

3. CPU utilisation would go through the roof. Effectively the
   entire pio_task state machine reduced to a busy spin loop.

4. The state machine needed some tweaks, especially in error
   handling cases.

I made some changes, which effectively solved the problem for promise
TX4-150 cards, and was going to test the results on other chipsets
next week before speaking up. Specifically, I have seen some
issues with SiI 3114 cards.

I was trying to explore using interrupts instead of polling state
but for some reason, I was not getting them for PIO data operations,
or I misunderstand the spec, after removing ata_qc_set_polling() - again
I saw a difference in behaviour between the Promise & SiI cards
here.

I'm about to go offline for 3 days, and hadn't prepared for this
yet. The best I can do is provide a patch (attached) that applies
against 2.6.9. It also seems to apply against libata-2.6, but
barfs a bit against libata-dev-2.6.

The changes boil down to these:

1. Minor changes in how status/error regs are read.
   Including attempts to use altstatus, while I was
   exploring interrupts.

2. State machine logic changes.

3. Replace calls to queue_work() with queue_delayed_work()
   to stop SMP machines going crazy.

With these changes, on a platform consisting of 2.6.9 and
Promise TX4-150 cards, I can move terabytes of parallel
PIO data, without error.

My gut says that the PIO mechanism should be overhauled, I
composed a "how much should we pay for this muffler" email
to linux-ide at least twice while working on this, but never
sent it - wanting to send a solution in rather than just
making more comments from the peanut gallery.

I'll pick up the thread on this next week, when I'm back online.
I hope this helps.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.9-pio-smp.patch"

diff -r -u -X dontdiff linux-2.6.9-vanilla/drivers/scsi/libata-core.c linux-2.6.9/drivers/scsi/libata-core.c
--- linux-2.6.9-vanilla/drivers/scsi/libata-core.c	2004-10-18 16:53:06.000000000 -0500
+++ linux-2.6.9/drivers/scsi/libata-core.c	2004-11-24 11:01:40.000000000 -0600
@@ -2099,7 +2099,7 @@
 	}
 
 	drv_stat = ata_wait_idle(ap);
-	if (!ata_ok(drv_stat)) {
+	if (drv_stat & (ATA_ERR | ATA_DF)) {
 		ap->pio_task_state = PIO_ST_ERR;
 		return;
 	}
@@ -2254,23 +2254,17 @@
 	 * chk-status again.  If still busy, fall back to
 	 * PIO_ST_POLL state.
 	 */
-	status = ata_busy_wait(ap, ATA_BUSY, 5);
-	if (status & ATA_BUSY) {
+	status = ata_altstatus(ap) ;
+	if (!(status & ATA_DRQ)) {
 		msleep(2);
-		status = ata_busy_wait(ap, ATA_BUSY, 10);
-		if (status & ATA_BUSY) {
+		status = ata_altstatus(ap) ;
+		if (!(status & ATA_DRQ)) {
 			ap->pio_task_state = PIO_ST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return;
 		}
 	}
 
-	/* handle BSY=0, DRQ=0 as error */
-	if ((status & ATA_DRQ) == 0) {
-		ap->pio_task_state = PIO_ST_ERR;
-		return;
-	}
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
@@ -2321,17 +2315,15 @@
 	case PIO_ST_TMOUT:
 	case PIO_ST_ERR:
 		ata_pio_error(ap);
-		break;
+		return ;
 	}
 
-	if ((ap->pio_task_state != PIO_ST_IDLE) &&
-	    (ap->pio_task_state != PIO_ST_TMOUT) &&
-	    (ap->pio_task_state != PIO_ST_ERR)) {
+	if (ap->pio_task_state != PIO_ST_IDLE) {
 		if (timeout)
 			queue_delayed_work(ata_wq, &ap->pio_task,
 					   timeout);
 		else
-			queue_work(ata_wq, &ap->pio_task);
+			queue_delayed_work(ata_wq, &ap->pio_task, 2);
 	}
 }
 
@@ -2624,7 +2616,7 @@
 		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		queue_delayed_work(ata_wq, &ap->pio_task, 2);
 		break;
 
 	case ATA_PROT_ATAPI:

--k+w/mQv8wyuph6w0--
