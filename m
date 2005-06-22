Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVFVIMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVFVIMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVFVIID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:08:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9431 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262842AbVFVIET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:04:19 -0400
Date: Wed, 22 Jun 2005 10:03:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050622080324.GA18083@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

>                  _------=> CPU#            
>                 / _-----=> irqs-off        
>                | / _----=> need-resched    
>                || / _---=> hardirq/softirq 
>                ||| / _--=> preempt-depth   
>                |||| /                      
>                |||||     delay             
>    cmd     pid ||||| time  |   caller      
>       \   /    |||||   \   |   /           
[...]
>   wmResh-3189  1....    1us : up_mutex (sock_def_readable)
>   wmResh-3189  1....    2us : __up_mutex (up_mutex)
>   <idle>-0     0Dnh2    2us : _raw_spin_unlock (__schedule)
>   <idle>-0     0Dnh1    2us!: preempt_schedule (__schedule)
>   wmResh-3189  1Dnh.  204us : _raw_spin_lock (__up_mutex)
>   wmResh-3189  1Dnh1  205us : _raw_spin_unlock (__up_mutex)
>   <idle>-0     0Dnh1  205us : _raw_spin_lock (__schedule)
>   wmResh-3189  1....  205us : _read_unlock (unix_stream_sendmsg)

look at the CPU# column, we have trace entries from both CPU#0 and CPU#1 
- and both of them are delayed by 200 usecs! The CPU#0 delay happened in 
the idle thread, between preempt_schedule() in __schedule() and 
_raw_spin_lock in __schedule(). It's a codepath where there's no 
spinning done. The CPU#1 delay happened in the wmResh process, between 
__up_mutex()'s entry and the first _raw_spin_lock() it did. This too is 
a codepath where no spinning is done. (and even if there was spinning, 
the two locks are not the same.)

in other words, since there is no OS-level explanation for the delay, 
this can only be an effect of the hardware/system. (Or it could be a bug 
in the measurement, but the likelyhood of seeing a 200 usec bump in the 
measurement is quite small.)

	Ingo
