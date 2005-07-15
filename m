Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVGOFFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVGOFFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVGOFFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:05:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261833AbVGOFFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:05:46 -0400
Date: Thu, 14 Jul 2005 22:04:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <42D731A4.40504@gmail.com>
Message-ID: <Pine.LNX.4.58.0507142158010.19183@g5.osdl.org>
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com> 
 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>  <20050713184227.GB2072@ucw.cz>
  <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>  <1121282025.4435.70.camel@mindpipe>
  <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe>
 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org> <42D731A4.40504@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Jesper Juhl wrote:
>
> It's buggy, that I know. setting kernel_hz (the new boot parameter) to 
> 250 causes my system clock to run at something like 4-5 times normal 
> speed

4 times normal. You don't actually make the timer interrupt happen at 
250Hz, so the timer will be programmed to run at the full 1kHz.

You also need to actually change the LATCH define (in 
include/linux/jiffies.h) to take this into account (there might be 
something else too).

So 

	/* LATCH is used in the interval timer and ftape setup. */
	#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)  /* For divider */

should become something like

	/* LATCH is used in the interval timer and ftape setup. */
	#define LATCH  ((CLOCK_TICK_RATE*jiffies_increment + HZ/2) / HZ)  /* For divider */

and you might be getting closer.

Of course, you need to make sure that LATCH is used only after 
jiffies_increment is set up. See "setup_pit_timer(void)" in
arch/i386/kernel/timers/timer_pit.c for more details.

		Linus
