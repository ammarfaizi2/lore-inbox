Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273496AbRIUM4U>; Fri, 21 Sep 2001 08:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273497AbRIUM4K>; Fri, 21 Sep 2001 08:56:10 -0400
Received: from ns.ithnet.com ([217.64.64.10]:4106 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273496AbRIUM4D>;
	Fri, 21 Sep 2001 08:56:03 -0400
Date: Fri, 21 Sep 2001 14:55:56 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010921145556.1f0af431.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0109210912310.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <20010921124338.4e31a635.skraw@ithnet.com>
	<Pine.LNX.4.33L.0109210912310.19147-100000@imladris.rielhome.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001 09:13:07 -0300 (BRST) Rik van Riel <riel@conectiva.com.br>
wrote:

> On Fri, 21 Sep 2001, Stephan von Krawczynski wrote:
> 
> > Shit, if I only were able to implement that. Can anybody help me to
> > proove my point?
> 
> Trying to implement your idea would probably pose a nice
> counter-argument. Without measuring which pages are in
> heavy use, how are you going to evict the right pages ?

Hi Rik,

The really beautiful thing about it is that you can divide it completely in two
parts:
1) basic list handling, you obviously need the list itself and some atomic
functions to queue/dequeue/requeue entries, possibly as well as
get_next_freeable() for simplicity. The rest vm only uses this to work.
2) the management "plugins" where you can virtually do any check of heavy use
or aging or buddy-finding or whatever comes to your mind and requeue
accordingly. You may do that on every alloc (surely not nice), or on page hits,
or on low-mem condition (like page_launder), or in a independant process
(somehow like kswapd), whatever you tend to believe is the best performing way
- feel free to find the killer-plugin :-). 

BUT (and thats the real good point): (2) is completely independant in structure
and processing from the basic mem-handling, because the only interaction is
requeuing, which means as a first step (only experimental of course) you could
just fill the list with addtail and shorten it on demand of free pages with
remhead (hope my short-terms are understandable). This implements a _very_
simple aging based on only the age of the allocation and nothing else (FIFO).
You can spend any time and brain in refining the strategy without ever touching
the vm basics _and_ (because of the simple and clean interface between (1) and
(2), you got no chance to screw things up (unless you do not drop entries in a
bug-implementation)). No obvious need for patches or weird workarounds.

Your opinion?

Regards,
Stephan


