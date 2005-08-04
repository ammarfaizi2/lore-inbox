Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVHDTLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVHDTLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVHDTLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:11:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:12424 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262613AbVHDTLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:11:36 -0400
Date: Thu, 4 Aug 2005 12:11:23 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050804191123.GA6614@us.ibm.com>
References: <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <Pine.LNX.4.61.0508041123220.3728@scrub.home> <20050804143339.GE4520@us.ibm.com> <Pine.LNX.4.61.0508042049450.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508042049450.3728@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2005 [20:59:50 +0200], Roman Zippel wrote:
> Hi,
> 
> On Thu, 4 Aug 2005, Nishanth Aravamudan wrote:
> 
> > The comment for schedule_timeout() claims:
> > 
> >  * Make the current task sleep until @timeout jiffies have
> >  * elapsed.
> > 
> > Currently, it does not do so. I was simply trying to make the function
> > do what it claims it does.
> 
> What makes you think the comment is correct? This comment was added at 
> 2.4.3, while schedule_timeout() has this behaviour since it was added at 
> 2.1.127.

Fair enough. Should we change the comment? What are the expectations of
programmers wrt. to this interface?

> > My point was that the +1 issues (potential
> > infinite timeouts) are a problem with *jiffies* not milliseconds. And
> > thus need to be pushed down to the jiffies layer. I think my explanation
> > was pretty clear.
> 
> Not really, could you go into more details why it's "a problem with 
> *jiffies* not milliseconds"?

Well, I may have phrased that wrong. It's not that milliseconds in the
kernel wouldn't have the same problem -- they would/do, because they
convert to jiffies eventually.

This is all the same issue, as George pointed out, that itimers face.

If a user requests schedule_timeout(HZ/100); which, if HZ is 1000, is 10
jiffies, yes? But, since we are between ticks, we want to actually add
that request to the next interval, not to the current one. Otherwise, we
do have the possibility of returning early. Currently, we require
callers to add the +1 to their request, and thus they only add it to the
first one. The problem with my patch which pushed it to
schedule_timeout(), is that we will do +1 to every request. I'm not
sure, without some sort of "persistent" timeout control structure, how
we get around that, though, in the schedule_timeout() case. Does that
make any more sense?

Thanks
Nish
