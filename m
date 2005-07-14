Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVGNXe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVGNXe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVGNXe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:34:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262709AbVGNXeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:34:10 -0400
Date: Thu, 14 Jul 2005 16:32:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <Pine.LNX.4.58.0507141600540.19183@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0507141627400.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121380637.3747.10.camel@localhost.localdomain>
 <Pine.LNX.4.58.0507141600540.19183@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Linus Torvalds wrote:
> 
> But what you can do is to have HZ at some reasonably high value (ie in the 
> kHz range), and then slow down the system clock to conserve energy, and 
> increment jiffies by 16 or 32 when in "slow clock mode".

Btw, it doesn't have to even be a slow-down due to the kernels decision.

In a VM environment, the timer interrupt might be erratic, and the timer 
interrupt might read some hardware register (TSC or something) and use 
_that_ to increment jiffies by the "proper" amount.

See? The point is that "jiffies" is useful exactly because it's very cheap 
to read portably (there are no portable high-performance alternatives) and 
because it has the right resolution to be useful in 32 bits.

That doesn't mean that the code that updates it can't be clever. We
already have code that updates it that is a lot more intelligent than 99%
of the code that reads it:  we update it in 64 bits under xtime_lock, even
though most readers use a lock-less 32-bit read and only get a partial
value - the part they care about.

And this is a wonderful property that everybody seems to be ignoring, even 
though we have absolutely tons of code that just takes all of this 
goodness for granted.

		Linus
