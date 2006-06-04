Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932230AbWFDJSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWFDJSp (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWFDJSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:18:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932230AbWFDJSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:18:44 -0400
Subject: Re: [patch 05/61] lock validator: introduce WARN_ON_ONCE(cond)
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1149358157.13993.94.camel@localhost.localdomain>
References: <20060529212109.GA2058@elte.hu> <20060529212328.GE3155@elte.hu>
	 <20060529183321.6c1a3cba.akpm@osdl.org>
	 <1149010697.8104.11.camel@localhost.localdomain>
	 <1149358157.13993.94.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 11:18:38 +0200
Message-Id: <1149412718.3109.88.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 14:09 -0400, Steven Rostedt wrote:

> 
> As you can see, because the whole thing is unlikely, the first condition
> is expected to fail.  With the current WARN_ON logic, that means that
> the __warn_once is expected to fail, but that's not the case.  So on a
> normal system where the WARN_ON_ONCE condition would never happen, you
> are always branching. 

which is no cost since it's consistent for the branch predictor

>   So simply reversing the order to test the
> condition before testing the __warn_once variable should improve cache
> performance.
> -	if (unlikely(__warn_once && (condition))) {	\
> +	if (unlikely((condition) && __warn_once)) {	\
>  		__warn_once = 0;			\

I disagree with this; "condition" can be a relatively complex thing,
such as a function call. doing the cheaper (and consistent!) test first
will be better. __warn_once will be branch predicted correctly ALWAYS,
except the exact ONE time you turn hit the backtrace. So it's really
really cheap to test, and if the WARN_ON_ONCE is triggering a lot after
the first time, you now would have a flapping first condition (which
means lots of branch mispredicts) while the original code has a perfect
one-check-predicted-exit scenario.



