Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264713AbTFLDxC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 23:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbTFLDxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 23:53:02 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:50948 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264713AbTFLDw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 23:52:59 -0400
Message-ID: <3EE7FC24.40103@cyberone.com.au>
Date: Thu, 12 Jun 2003 14:05:56 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Stoffel <stoffel@lucent.com>
CC: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       bos@serpentine.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] as-iosched divide by zero fix
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>	<20030611154122.55570de0.akpm@digeo.com>	<1055374476.673.1.camel@localhost>	<1055377120.665.6.camel@localhost>	<20030611172444.76556d5d.akpm@digeo.com>	<1055380257.662.8.camel@localhost>	<20030611182249.0f1168e4.akpm@digeo.com>	<3EE7D7F5.3070803@cyberone.com.au> <16103.59032.405790.988082@gargle.gargle.HOWL>
In-Reply-To: <16103.59032.405790.988082@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Stoffel wrote:

>Nick> Yeah, thats the way to do it, of course. It was too jumpy at
>Nick> that setting though, so make it batch*3 (or <<1+batch if you
>Nick> don't want the multiply).
>
>Aren't we trying to get away from magic constants like this?  Or at
>least a better idea of why batch*3 is better than batch*2?  I will
>admit I haven't had the chance to peer into the code, so I'm probably
>just being stupid (and lazy) here to speak up.
>
>I guess the real question I have is what happens if we make it
>batch*100, how does the affect the algorithm?  And if going from 2 to
>3 makes such a difference, doesn't that point to a scaling issue,
>i.e. we should have 200 and 300 here, so we can try out 250 as an
>intermediate value.
>
>*shrug* Just trying to understand...
>

Its not very critical. It is used to estimate how many
requests will take t ms to complete, based on how many
requests we sent last time around, and how long that
took.

As long as it increment when we were below estimate and
decrement when above it should be OK. The mul/div were
put there in order to adapt more quickly to changes in
the request pattern.

You would think that if a batch of 10 requests took
twice as long as we wanted, we might as well submit 5
requests, but in testing I found that this makes the
numbers jump around too much, while a 3* threshold
smoothed it over while still adapting to changes nicely.



