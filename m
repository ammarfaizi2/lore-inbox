Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWJNMU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWJNMU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWJNMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:20:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161123AbWJNMU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:20:27 -0400
Subject: Re: [PATCH]: disassociate tty locking fixups
From: Arjan van de Ven <arjan@infradead.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com>
References: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 14 Oct 2006 14:20:24 +0200
Message-Id: <1160828425.15683.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -1364,14 +1366,16 @@ static void do_tty_hangup(void *data)
>  				p->signal->tty = NULL;
>  			if (!p->signal->leader)
>  				continue;
> +			mutex_unlock(&tty_mutex);
>  			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
>  			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
> +			mutex_lock(&tty_mutex);
>  			if (tty->pgrp > 0)
>  				p->signal->tty_old_pgrp = tty->pgrp;
>  		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
>  	}
>  	read_unlock(&tasklist_lock);
> -
> +	mutex_unlock(&tty_mutex);

Hi,

what is the lock ordering rules between tasklist_lock and tty_mutex?
In the code above you first take tty_mutex then tasklist_lock, and later
on you drop tty_mutex, with the result that you then have a
tasklist_lock -> tty_mutex order.

This can deadlock if someone gets in the middle with a
mutex_lock(&tty_mutex);
write_lock(&tasklist_lock);
....

in addition, are you sure you don't need to revalidate anything after
retaking the lock?

Greetings,
   Arjan van de Ven

