Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVGZOib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVGZOib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVGZOib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:38:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28921 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261809AbVGZOi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:38:29 -0400
Message-ID: <42E64A76.50504@mvista.com>
Date: Tue, 26 Jul 2005 07:36:38 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tmarshall@real.com, pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: itimer oddness in 2.6.12
References: <20050722171657.GG4311@real.com>	<42E14735.1090205@grupopie.com>	<20050722205825.GB6476@real.com>	<42E1A208.8060408@mvista.com> <20050725231720.507d4b38.akpm@osdl.org>
In-Reply-To: <20050725231720.507d4b38.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>+	while (time_before_eq(p->signal->real_timer.expires, jiffies))
>>+		p->signal->real_timer.expires += inc;
> 
> 
> It gives me the creeps when I see timer code doing this, and it seems to be
> done relatively frequently.
> 
> Surely it can be calculated arithmetically?  If not, are you really sure
> that it is not exploitable by malicious code?

Hm.. the system only falls into a loop here if the system is loaded to 
the point where we are a jiffie or more late.  The prior code just did 
the "+=" and called add_timer, possibly with a time in the past.  I 
suspect that way of doing this would never catch up if the user asked 
for a one jiffie repeat time.  Also, this is faster than the div, mpy if 
you are not late (or even if you are several jiffies late).

A possible alternative might be:
	p->signal->real_timer.expires += inc;	
	if (time_before_eq(p->signal->real_timer.expires, jiffies))
		p->signal->real_timer.expires += ((jiffies - 
p->signal->real_timer.expires + inc -1) / inc) * inc;

Both a div and a mpy in there.  I really think the "while" is ok, but if 
you prefer...	

The last time you questioned this sort of thing was in the code to 
correct an absolute timer.  In that case we were adjusting after a clock 
set and, yes, it was possibly exploitable (assuming you could set the 
clock).  Here we don't have that possibility, i.e. we only get into the 
loop if the system is late.
> -
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
