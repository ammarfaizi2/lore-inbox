Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTH1P4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTH1P4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:56:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:21225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264082AbTH1P4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:56:10 -0400
Date: Thu, 28 Aug 2003 08:59:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy driver cleanup
Message-Id: <20030828085916.035632ce.akpm@osdl.org>
In-Reply-To: <16205.58701.762150.49446@gargle.gargle.HOWL>
References: <20030827224135.75f344dd.rddunlap@osdl.org>
	<16205.58701.762150.49446@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Randy.Dunlap writes:
>  > -static void schedule_bh( void (*handler)(void*) )
>  > +static void schedule_bh(void (*handler) (void *))
> ...
>  > -		schedule_bh( (void *)(void *) handler);
>  > +		schedule_bh((void *) handler);
> ...
>  > -	schedule_bh((void *)(void *)handler);
>  > +	schedule_bh((void *) handler);
> ...
>  > -		schedule_bh( (void *)(void *) floppy_start);
>  > +		schedule_bh((void *) floppy_start);
> ...
>  > -	schedule_bh( (void *)(void *) redo_fd_request);
>  > +	schedule_bh((void *) redo_fd_request);
> 
> Am I the only one having problems with code like this?
> (Not Randy's, the original.)

No, you're not - I also instapuked over that.



diff -puN drivers/block/floppy.c~floppy-more-cleanup drivers/block/floppy.c
--- 25/drivers/block/floppy.c~floppy-more-cleanup	2003-08-27 22:51:16.000000000 -0700
+++ 25-akpm/drivers/block/floppy.c	2003-08-27 22:56:54.000000000 -0700
@@ -1007,9 +1007,9 @@ static void empty(void)
 
 static DECLARE_WORK(floppy_work, NULL, NULL);
 
-static void schedule_bh(void (*handler) (void *))
+static void schedule_bh(void (*handler) (void))
 {
-	PREPARE_WORK(&floppy_work, handler, NULL);
+	PREPARE_WORK(&floppy_work, (void (*)(void *))handler, NULL);
 	schedule_work(&floppy_work);
 }
 
@@ -1799,9 +1799,9 @@ irqreturn_t floppy_interrupt(int irq, vo
 			max_sensei--;
 		} while ((ST0 & 0x83) != UNIT(current_drive) && inr == 2 && max_sensei);
 	}
-	if (handler) {
-		schedule_bh((void *) handler);
-	} else
+	if (handler)
+		schedule_bh(handler);
+	else
 		FDCS->reset = 1;
 	is_alive("normal interrupt end");
 
@@ -2063,7 +2063,7 @@ static int wait_til_done(void (*handler)
 {
 	int ret;
 
-	schedule_bh((void *) handler);
+	schedule_bh(handler);
 
 	if (command_status < 2 && NO_SIGNAL) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -2974,7 +2974,7 @@ static void redo_fd_request(void)
 
 		if (TESTF(FD_NEED_TWADDLE))
 			twaddle();
-		schedule_bh((void *) floppy_start);
+		schedule_bh(floppy_start);
 #ifdef DEBUGT
 		debugt("queue fd request");
 #endif
@@ -2993,7 +2993,7 @@ static struct cont_t rw_cont = {
 static void process_fd_request(void)
 {
 	cont = &rw_cont;
-	schedule_bh((void *) redo_fd_request);
+	schedule_bh(redo_fd_request);
 }
 
 static void do_fd_request(request_queue_t * q)
@@ -3057,9 +3057,9 @@ static void reset_intr(void)
 
 static struct cont_t reset_cont = {
 	.interrupt = reset_intr,
-	. redo = success_and_wakeup,
-	. error = generic_failure,
-	. done = generic_done
+	.redo = success_and_wakeup,
+	.error = generic_failure,
+	.done = generic_done
 };
 
 static int user_reset_fdc(int drive, int arg, int interruptible)

_

