Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVAIQpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVAIQpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVAIQpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:45:09 -0500
Received: from one.firstfloor.org ([213.235.205.2]:46270 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261663AbVAIQo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:44:56 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Notify user of MCE events.
References: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 09 Jan 2005 17:44:54 +0100
In-Reply-To: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Sat, 8 Jan 2005 21:29:41 -0700 (MST)")
Message-ID: <m1sm5av9fd.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> +
> +	if (!test_and_set_bit(0, &console_logged))
> +		notify_user = 1;
>  }
>  
>  static void print_mce(struct mce *m)
> @@ -252,6 +258,12 @@ static void mcheck_timer(void *data)
>  {
>  	on_each_cpu(mcheck_check_cpu, NULL, 1, 1);
>  	schedule_delayed_work(&mcheck_work, check_interval * HZ);
> +
> +	if (notify_user && console_logged) {

Perhaps a comment here that the race is harmless? 

> +		notify_user = 0;
> +		clear_bit(0, &console_logged);
> +		printk(KERN_EMERG "Machine check exception logged, run mcelog\n");

I would drop the "run mcelog". It's misleading if mcelog is already
running in cron as it should. 

-Andi
