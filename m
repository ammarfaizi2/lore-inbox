Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVBVDH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVBVDH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 22:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVBVDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 22:07:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36334 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262195AbVBVDHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 22:07:21 -0500
Message-ID: <421AA1BD.7020706@mvista.com>
Date: Mon, 21 Feb 2005 19:06:37 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: puneet_kaushik@persistent.co.in, linux-kernel@vger.kernel.org
Subject: Re: Needed faster implementation of do_gettimeofday()
References: <34373.203.199.147.2.1108897097.squirrel@webmail.persistent.co.in> <200502201048.01424.kernel-stuff@comcast.net>
In-Reply-To: <200502201048.01424.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> On Sunday 20 February 2005 05:58 am, puneet_kaushik@persistent.co.in wrote:
> 
>>985913    8.6083  vmlinux                  mark_offset_tsc
>>584473    5.1032  libc-2.3.2.so            getc
> 
> 
> What makes you think mark_offset_tsc is slow? Do you have any comparative 
> numbers?  It might just be that the workload you are throwing at it justifies 
> it. (For e.g. if your workload does a zillion system calls, system_call will 
> show up as a hot spot in oprofile - doesn't necessarily mean it is slow - 
> it's just overused.) Can you post the relevant code?

He really is right.  Mark offset is reading the PIT counter and that is not only 
rather dumb but dog slow.

A suggestion, try the high res timers patch.  Even if you don't use the timers 
the mark offset there is MUCH faster.  It does not read the PIT.

The difference is where we assume the jiffie bump is in time.  If we assume it 
is at the point that the PIT interrupts, well then the only way to get to that 
is to read the PIT.  If, on the other hand, we assume it is at the time after 
the interrrupt where we mark offset, we can observe the "best" time for this 
event based on the TSC and avoid reading the PIT.

Try the HRT patch (see signature below) and see if if doesn't do better.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

