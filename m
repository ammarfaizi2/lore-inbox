Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSKFIXg>; Wed, 6 Nov 2002 03:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265996AbSKFIXf>; Wed, 6 Nov 2002 03:23:35 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:23800 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S265995AbSKFIXe>; Wed, 6 Nov 2002 03:23:34 -0500
Message-Id: <200211060827.gA68RoKb021008@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 6 Nov 2002 03:27:46 -0500
From: Skip Ford <skip.ford@verizon.net>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 13
References: <3DC8B75F.4B425973@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC8B75F.4B425973@mvista.com>; from george@mvista.com on Tue, Nov 05, 2002 at 10:31:59PM -0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Wed, 6 Nov 2002 02:30:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> -	tvec_base_t *old_base, *new_base;
> +	tvec_base_t *new_base;
> +	IF_SMP( tvec_base_t *old_base;)

Your code doesn't compile.  old_base only exists ifdef CONFIG_SMP but
it's referneced for UP compiles @ timer.c:line 332

	if (old_base) {
		list_del(&timer->entry);
		ret = 1;
	}

ifdeffing it out works but I don't know if it's correct.  That's one
ugly function with your patch applied so one more ifdef won't hurt
(unless it's wrong.)


--- linux-sk/kernel/timer.c~fix-high-res	Wed Nov  6 03:14:30 2002
+++ linux-sk-jr/kernel/timer.c	Wed Nov  6 03:14:30 2002
@@ -329,10 +329,12 @@ repeat:
 	 * Delete the previous timeout (if there was any), and install
 	 * the new one:
 	 */
+#ifdef CONFIG_SMP
 	if (old_base) {
 		list_del(&timer->entry);
 		ret = 1;
 	}
+#endif
 	timer->expires = expires;
 	IF_HIGH_RES(timer->sub_expires = sub_expires);
 	internal_add_timer(new_base, timer);


-- 
Skip
