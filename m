Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVGNXYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVGNXYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVGNXWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:22:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262758AbVGNXU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:20:57 -0400
Date: Thu, 14 Jul 2005 16:19:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: john stultz <johnstul@us.ibm.com>, Arjan van de Ven <arjan@infradead.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121381026.3747.14.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507141614170.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>  <1121360561.3967.55.camel@laptopd505.fenrus.org>
  <1121370122.7673.161.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org> <1121381026.3747.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Alan Cox wrote:
> 
> I suspect the problem for some of this is that people think of jiffies
> as incrementing by 1. If HZ is right then jiffies can be in nS, it just
> won't increment by 1.

No, jiffies _cannot_ be in nS, because of the fact that then it doesn't 
fit in a word any more. A lot of things want timeouts in the tens of 
minutes, and a jiffy clock that tries to ne in nS just screws that up 
entirely, and forces people to use u64.

Which is much more expensive to compare on 32-bit architectures due to 
nasty atomicity issues. 

So you want to keep the "normal" timeout 32-bit. In ten years we may not 
care any more. For the forseeable future we definitely do.

> Its also why jiffies() is better on some platforms
> because many machines can answer "what time is it" far more accurately
> than they can set interrupts.

That's not what "jiffies" are about. If you want accurate time, use
something else, like gettimeofday. The timeouts are _only_ relevant on the
scale of a timer interrupt, since by definition that's what we're waiting
for.

So accuracy is a total non-issue. The only kind of accuracy we care about 
is "how often can the timer ticks happen".

		Linus
