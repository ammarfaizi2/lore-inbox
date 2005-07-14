Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVGNUiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGNUiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVGNUiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:38:05 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:50821 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261692AbVGNUhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:37:35 -0400
Date: Thu, 14 Jul 2005 22:38:55 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Message-ID: <20050714203855.GA6022@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
	"Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
	david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
	linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
	azarah@nosferatu.za.org, christoph@lameter.com
References: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> <20050714005106.GA16085@taniwha.stupidest.org> <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org> <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121360561.3967.55.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.232.111
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 Linus Torvalds wrote:
> In other words, the _right_ way to do this is literally
> 
> 	unsigned long timeout = jiffies + HZ/2;
> 	for (;;) {
> 		if (ready())
> 			return 0;
> 		if (time_after(timeout, jiffies))
> 			break;
> 		msleep(10);
> 	}
> 
> which is unquestionably more complex, yes, but it's more complex because 
> it is CORRECT!

Since you emphasised on correctness, your code is actually buggy
for the preemptible kernel. It could get preempted after the ready() test,
but before the time_after(), for quite a whie if a high priority process
keeps the system busy. This code is better:

 	unsigned long timeout = jiffies + HZ/2;
	int err;
 	for (;;) {
 		err = time_after(timeout, jiffies);
 		if (ready())
 			return 0;
 		if (err)
 			break;
 		msleep(10);
 	}

This way the condition is always re-tested before reporting timeout.

Johannes
