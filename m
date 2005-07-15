Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVGOAnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVGOAnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVGOAnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:43:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262942AbVGOAni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:43:38 -0400
Date: Thu, 14 Jul 2005 17:42:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <9a874849050714171767b85ced@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0507141735390.19183@g5.osdl.org>
References: <42D3E852.5060704@mvista.com> <20050713184227.GB2072@ucw.cz> 
 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>  <1121282025.4435.70.camel@mindpipe>
  <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
  <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <9a874849050714170465c979c3@mail.gmail.com>  <1121386505.4535.98.camel@mindpipe>
 <9a874849050714171767b85ced@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Jesper Juhl wrote:
>
> Even if we only have to do it once at boot?  The thought was to detect
> what type of machine we are booting on, figure out what a good HZ
> would be for that type of box, then set that HZ value and treat it as
> a constant from that point forward.

No, it really should be a compile-time constant, or a lot of things get a 
lot more expensive. There's a HZ embedded in a lot of places, and some of 
them are divides, for example. Others do optimized special cases based on 
static knowledge of what HZ is.

So this is why I so strongly argue that we should have a constant HZ, but 
a dynamic _increment_ of "jiffies". Nobody (obviously) depends on jiffies 
being constant, so it's ok to increment jiffies by pretty much any value.

Yeah, yeah, there might be some _very_ few code-paths (bogomips, I think)  
that may look at when "jiffies" changes, and actually measure one tick 
that way. They would need to be taught that they don't measure "one" tick 
any more, they measure "jiffies_increment" ticks or something.

But I really wouldn't be surprised if the bogomips calibration loop was 
really the only thing that needed some small tweaking for increments of 
other than one.

(Oh, we'll find other things we want to fix up, and such a change would
result in other changes down the line, no question about that.  But I
don't think it would be very much at all, and I don't think it would 
turn out at all traumatic).

		Linus
