Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWFMS2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWFMS2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFMS2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:28:13 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:8407 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S932222AbWFMS2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:28:12 -0400
Message-ID: <448F03B3.5040501@psc.edu>
Date: Tue, 13 Jun 2006 14:28:03 -0400
From: John Heffner <jheffner@psc.edu>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca> <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca> <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu> <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 13 Jun 2006, John Heffner wrote:
>> The best thing you can do is try to find this broken box and inform its owner
>> that it needs to be fixed.  (If you can find out what it is, I'd be interested
>> to know.)  In the meantime, disabling window scaling will work around the
>> problem for you.
> 
> Well, arguably, we shouldn't necessarily have defaults that use window 
> scaling, or we should have ways to recognize automatically when it 
> doesn't work (which may not be possible).
> 
> It's not like there aren't broken boxes out there, and it might be better 
> to make the default buffer sizes just be low enough that window scaling 
> simply isn't an issue.
> 
> I suspect that the people who really want/need window scaling know about 
> it, and could be assumed to know enough to raise their limits, no?
> 
> 		Linus

Unfortunately, there's really no way to detect this, at least not until 
it's too late.  You can't un-negotiate window scale after the connection 
is initiated.

64k buffers, the largest you can use without window scaling, are 
adequate for most home users on DSL or cable modems (good to about 10 
Mbps across the US, not quite that over trans-oceanic links). 
Unfortunately, that's about a factor of ten too small for that average 
university user, and a factor of 100-1000 too small for high end use. 
Check out the figure at 
<http://people.internet2.edu/~ghb/pmwiki/pmwiki.php/BridgingTheGap/BtGWizGap>, 
which has some data points.  (The bottom line is the best "normal" users 
can get with system default buffers, the top line is what high-end users 
have gotten with tuned systems over the wide area.  Note that this gap 
is increasing at an exponential rate.)

In the last couple years, we've added code that can automatically size 
the buffers as appropriate for each connection, but it's completely 
crippled unless you use a window scale.  Personally, I think it's not a 
question of *whether* we have to start using a window scale by default, 
but *when*.  I don't know that we want to let a small number of 
unambiguously broken middleboxes kill our forward progress.

Though I haven't gotten my hands on it, I believe Windows will soon have 
this capability, too.  I'm sure Windows is big enough that whenever they 
turn this on, it will flush out all these boxes pretty quickly.  We 
could wait for them to do it first, that that's not my favored approach.

BTW, as one data point, I've been personally running with a large window 
scale for about 5 years, and only seen a small handful of problems, most 
of which were corrected fairly quickly after I sent email to the admin 
of the box in question.  No "big" sites have been an issue.

Thanks,
   -John
