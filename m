Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWJXJrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWJXJrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWJXJrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:47:36 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:64737 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030257AbWJXJrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:47:35 -0400
Subject: Re: [PATCH] do_acct_process: don't take tty_mutex
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061023135644.GA1501@oleg>
References: <20061023135644.GA1501@oleg>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:48:15 +0200
Message-Id: <1161683295.24143.12.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 17:56 +0400, Oleg Nesterov wrote:
> Depends on
> 	tty-signal-tty-locking.patch
> 
> No need to take the global tty_mutex, signal->tty->driver can't go away
> while we are holding ->siglock.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl

> --- rc2-mm2/kernel/acct.c~	2006-10-22 19:28:17.000000000 +0400
> +++ rc2-mm2/kernel/acct.c	2006-10-23 17:09:12.000000000 +0400
> @@ -484,12 +484,9 @@ static void do_acct_process(struct file 
>  	ac.ac_ppid = current->parent->tgid;
>  #endif
>  
> -	mutex_lock(&tty_mutex);
> -	tty = get_current_tty();
> -	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
> -	mutex_unlock(&tty_mutex);
> -
>  	spin_lock_irq(&current->sighand->siglock);
> +	tty = current->signal->tty;
> +	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
>  	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));
>  	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_stime)));
>  	ac.ac_flag = pacct->ac_flag;
> 

