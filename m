Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282176AbRLEDCT>; Tue, 4 Dec 2001 22:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283708AbRLEDCJ>; Tue, 4 Dec 2001 22:02:09 -0500
Received: from t2.redhat.com ([199.183.24.243]:27630 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S282176AbRLEDB4>;
	Tue, 4 Dec 2001 22:01:56 -0500
Date: Tue, 4 Dec 2001 19:00:48 -0800
From: Richard Henderson <rth@redhat.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: alpha bug in signal handling
Message-ID: <20011204190048.B8179@redhat.com>
In-Reply-To: <jepu5xqnva.fsf@sykes.suse.de> <15372.13000.922405.379605@napali.hpl.hp.com> <20011204171426.B7982@redhat.com> <15373.33622.236872.92057@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15373.33622.236872.92057@napali.hpl.hp.com>; from davidm@hpl.hp.com on Tue, Dec 04, 2001 at 06:15:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:15:50PM -0800, David Mosberger wrote:
> Oh, sorry, I was referring to teh *other* problem... ;-)
> 
> What I meant is that the check for re-scheduling
> (current->need_resched) and signal deliverify (current->sigpending)
> needs to be done with interrupts turned off, and the interrupts need
> to be left off until user space is reached.  Otherwise, you could get
> an interrupt which would wake up a higher priority task or post a
> signal between the check and the return to user space.
> 
> I didn't see this interrupt disabling in the Alpha version of entry.S,
> but I have to admit my Alpha assembly is getting quite rusty.

Oh, yes, I see.  This should fix it.


r~



--- arch/alpha/kernel/entry.S.orig	Tue Dec  4 18:40:53 2001
+++ arch/alpha/kernel/entry.S	Tue Dec  4 18:46:33 2001
@@ -580,6 +580,10 @@
 	and	$0,8,$0
 	beq	$0,restore_all
 ret_from_reschedule:
+	/* Turn off interrupts so that resched and signal delivery
+	   checks are done atomically.  */
+	addq	$31,7,$16
+	call_pal PAL_swpipl
 	ldq	$2,TASK_NEED_RESCHED($8)
 	lda	$4,init_task_union
 	bne	$2,reschedule
