Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVK3KJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVK3KJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 05:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVK3KJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 05:09:03 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:10712 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750701AbVK3KJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 05:09:01 -0500
Message-ID: <438D8BC0.1993824F@tv-sign.ru>
Date: Wed, 30 Nov 2005 14:23:44 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
References: <438C5057.A54AFA83@tv-sign.ru> <Pine.LNX.4.61.0511300330130.1609@scrub.home>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
>  int __mod_timer(struct timer_list *timer, unsigned long expires)
> @@ -210,6 +203,7 @@ int __mod_timer(struct timer_list *timer
> 
>         BUG_ON(!timer->function);
> 
> +restart:
>         base = lock_timer_base(timer, &flags);
> 
>         if (timer_pending(timer)) {

Another problem. __mode_timer() does:

	if (timer_pending(timer)) {
		detach_timer(timer, 0);

Note that 'clear_pending' parameter == 0. This means that detach_timer()
will remove the timer from list, but won't clear 'pending' status. So
this will crash after 'goto restart' (or in case of concurrent del_timer()).

Oleg.
