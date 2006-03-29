Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWC2F4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWC2F4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 00:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWC2F4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 00:56:22 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:54450 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbWC2F4V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 00:56:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKv6P5jmf/FFYLIz5PL4SKgsFbD7sZz/smMZek6YQHqgKVewVELGaHL+8S4qfCdeiFGZESWRMy2o/ibhMOQHu5f4irWu5MWtmo0LwnOKRHlaIkcBVEcbAnyonfHEAQBf/Eg2cv/Pp75BcRN8sFyLAYsdsAnFawLUUsQFwwmmd+Y=
Message-ID: <2c0942db0603282156x468f4246nae414b2a853668dc@mail.gmail.com>
Date: Tue, 28 Mar 2006 21:56:20 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: interactive task starvation
Cc: "Ingo Molnar" <mingo@elte.hu>, "Willy Tarreau" <willy@w.ods.org>,
       "Con Kolivas" <kernel@kolivas.org>, "Mike Galbraith" <efault@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <1143601277.3330.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142592375.7895.43.camel@homer>
	 <200603220119.50331.kernel@kolivas.org>
	 <1142951339.7807.99.camel@homer>
	 <200603220130.34424.kernel@kolivas.org> <20060321143240.GA310@elte.hu>
	 <20060321144410.GE26171@w.ods.org> <20060321145202.GA3268@elte.hu>
	 <1143601277.3330.2.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Lee Revell <rlrevell@joe-job.com> wrote:
> Can you explain why terminal output ping-pongs back and forth between
> taking a certain amount of time, and approximately 10x longer?
[...]
> Why does it ping-pong between taking ~0.08s and ~0.75s like that?  The
> behavior is completely reproducible.

Does the scheduler have any concept of dependent tasks? (If so, hit
<delete> and move on.) If not, then the producer and consumer will be
scheduled randomly w/r/t each other, right? Sometimes producer then
consumer, sometimes vice versa. If so, the ping pong should be half of
the time slow, half of the time fast (+/- sqrt(N)), and the slow time
should scale directly with the number of tasks running on the system.

Do any of the above WAGs match what you see? If so, then perhaps it's
random just due to the order in which the tasks get initially
scheduled (dmesg vs ssh, or dmesg vs xterm vs X -- er, though I guess
in that latter case there's really <thinks> three separate timings
that you'd get back, as the triple set of tasks could be in one of six
orderings, one fast, one slow, and four equally mixed between the
two).

I wonder if on a pipe write, moving the reader to be right after the
writer in the list would even that out. (But only on cases where the
reader didn't just run -- wouldn't want a back and forth conversation
to starve everyone else...)

But like I said, just a WAG.

Ray
