Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVHDWDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVHDWDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVHDWBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:01:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8599 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbVHDWBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:01:14 -0400
Date: Thu, 4 Aug 2005 15:02:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: george@mvista.com, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve()
 any more
Message-Id: <20050804150251.5f4acb0a.akpm@osdl.org>
In-Reply-To: <20050804213416.1EA56180980@magilla.sf.frob.com>
References: <42F28707.7060806@mvista.com>
	<20050804213416.1EA56180980@magilla.sf.frob.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> That's wrong.  It has to be done only by the last thread in the group to go.
> Just revert Ingo's change.
> 

OK..

--- 25/kernel/exit.c~revert-timer-exit-cleanup	Thu Aug  4 15:00:55 2005
+++ 25-akpm/kernel/exit.c	Thu Aug  4 15:01:06 2005
@@ -829,8 +829,10 @@ fastcall NORET_TYPE void do_exit(long co
 	acct_update_integrals(tsk);
 	update_mem_hiwater(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
-	if (group_dead)
+	if (group_dead) {
+ 		del_timer_sync(&tsk->signal->real_timer);
 		acct_process(code);
+	}
 	exit_mm(tsk);
 
 	exit_sem(tsk);
diff -puN kernel/posix-timers.c~revert-timer-exit-cleanup kernel/posix-timers.c
--- 25/kernel/posix-timers.c~revert-timer-exit-cleanup	Thu Aug  4 15:00:55 2005
+++ 25-akpm/kernel/posix-timers.c	Thu Aug  4 15:01:06 2005
@@ -1166,7 +1166,6 @@ void exit_itimers(struct signal_struct *
 		tmr = list_entry(sig->posix_timers.next, struct k_itimer, list);
 		itimer_delete(tmr);
 	}
-	del_timer_sync(&sig->real_timer);
 }
 
 /*
_

