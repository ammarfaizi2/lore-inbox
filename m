Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUFUXNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUFUXNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266523AbUFUXNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:13:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:17864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266522AbUFUXNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:13:08 -0400
Date: Mon, 21 Jun 2004 16:13:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Message-Id: <20040621161306.1d6bff5c@dell_ss3.pdx.osdl.net>
In-Reply-To: <40C7BE29.9010600@am.sony.com>
References: <40C7BE29.9010600@am.sony.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of comments on posix-hrt-core-04.06.09.patch

1. Comment in hrtime.h is out of date, you are using seq_lock to do the read
   stuff now, an example is...

+ * Global locking issues: 
+ *
+ *      Time is locked with the xtime_lock using read/write locks.
+ *      Note: It is assumed that the do_timer() call is  protected by
+ *      write_lock(&xtime_lock).
+ *
+ *      Using code must not change, but only read, the protected
+ *      variables (xtime, jiffies, any temps tha need protection in the
+ *      arch_get_cycles() code).  Usage is as follows:
+ *
+ *      read_lock_irq(&xtime_lock);
+ *          do the reads
+ *      read_unlock_irq(&xtime)


2. Don't like new definition of running_timer; use explicit memory barriers
   not volatile please.

struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	struct timer_list *running_timer;
-	tvec_root_t tv1;
-	tvec_t tv2;
-	tvec_t tv3;
-	tvec_t tv4;
-	tvec_t tv5;
+ 	volatile struct timer_list * volatile running_timer;
+ 	struct list_head tv[NEW_TVEC_SIZE]line_aligned_in_smp;

3. The IF_HIGH_RES() macro looks cute, but get confusing, and makes the code
   less readable.
