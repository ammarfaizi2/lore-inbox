Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVHKMGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVHKMGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVHKMG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:06:29 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:26266 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932376AbVHKMG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:06:29 -0400
Message-ID: <42FB41B5.98314BA5@tv-sign.ru>
Date: Thu, 11 Aug 2005 16:16:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
> --- linux-2.6.13-rc6/kernel/signal.c	2005-08-08 19:59:24.000000000 -0700
> +++ linux-2.6.13-rc6-tasklistRCU/kernel/signal.c	2005-08-10 08:20:25.000000000 -0700
> @@ -1151,9 +1151,13 @@ int group_send_sig_info(int sig, struct 
>
>  	ret = check_kill_permission(sig, info, p);
>  	if (!ret && sig && p->sighand) {
> +		if (!get_task_struct_rcu(p)) {
> +			return -ESRCH;
> +		}
>  		spin_lock_irqsave(&p->sighand->siglock, flags);
                                      ^^^^^^^
Is it correct?

The caller (kill_proc_info) does not take tasklist_lock anymore.
If p does exec() at this time it can change/free its ->sighand.

fs/exec.c:de_thread()
   773                  write_lock_irq(&tasklist_lock);
   774                  spin_lock(&oldsighand->siglock);
   775                  spin_lock(&newsighand->siglock);
   776
   777                  current->sighand = newsighand;
   778                  recalc_sigpending();
   779
   780                  spin_unlock(&newsighand->siglock);
   781                  spin_unlock(&oldsighand->siglock);
   782                  write_unlock_irq(&tasklist_lock);
   783
   784                  if (atomic_dec_and_test(&oldsighand->count))
   785                          kmem_cache_free(sighand_cachep, oldsighand);

Oleg.
