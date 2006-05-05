Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWEENlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWEENlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWEENlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:41:45 -0400
Received: from mail.tmr.com ([64.65.253.246]:23017 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751579AbWEENlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:41:44 -0400
Message-ID: <445B5941.3020606@tmr.com>
Date: Fri, 05 May 2006 09:55:13 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au,
       linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -mm: i386 apm.c optimization
References: <20060416220552.GA22998@rhlx01.fht-esslingen.de>
In-Reply-To: <20060416220552.GA22998@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:

>Hello all,
>
>- avoid expensive modulo (integer division) which happened
>  since APM_MAX_EVENTS is 20 (non-power-of-2)
>- kill compiler warnings by initializing two variables
>- add __read_mostly to some important static variables that are read often
>  (by idle loop etc.)
>- constify several structures
>
>Patch tested on 2.6.16-ck5, rediffed against 2.6.17-rc1-mm2. 
>@@ -1104,7 +1105,8 @@
> 
> static apm_event_t get_queued_event(struct apm_user *as)
> {
>-	as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
>+	if (++as->event_tail >= APM_MAX_EVENTS)
>+		as->event_tail = 0;
> 	return as->events[as->event_tail];
> }
> 
>  
>
Either event_tail can never be > APM_MAX_EVENTS (I believe that's true) 
and you should use ==, or you should do a proper mod function:
  ++as->event_tail;
  while (as->event_tail >= APM_MAX_EVENTS) as->event_tail -= APM_MAX_EVENTS;

In the unlikely even that the event_tail is already too large you want a 
proper mod, not to set it to zero.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

