Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUIWWbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUIWWbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUIWW3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:29:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:34495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267478AbUIWW0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:26:41 -0400
Date: Thu, 23 Sep 2004 15:30:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: janitor@sternwelten.at
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
Subject: Re: [patch 12/26]  char/istallion: replace 	schedule_timeout() with
 msleep_interruptible()
Message-Id: <20040923153027.36a2eedd.akpm@osdl.org>
In-Reply-To: <E1CAa9g-0008HI-0z@sputnik>
References: <E1CAa9g-0008HI-0z@sputnik>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

janitor@sternwelten.at wrote:
>
> @@ -2504,7 +2484,8 @@ static void stli_waituntilsent(struct tt
>  	while (test_bit(ST_TXBUSY, &portp->state)) {
>  		if (signal_pending(current))
>  			break;
> -		stli_delay(2);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(2);
>  		if (time_after_eq(jiffies, tend))
>  			break;
>  	}

I'll replace this with msleep_interruptible(20), which is presumably what
the driver was trying to do originally.

Again, all of these delays become accidental busyloops if the calling task
has a signal pending.  Sigh.  Probably they should all be using
TASK_UNINTERRUPTIBLE.  
