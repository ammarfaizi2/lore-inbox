Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTKDWIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTKDWIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:08:24 -0500
Received: from cmailm5.svr.pol.co.uk ([195.92.193.21]:56589 "EHLO
	cmailm5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261151AbTKDWIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:08:22 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: Con Kolivas <kernel@kolivas.org>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Tue, 4 Nov 2003 22:08:05 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org>
In-Reply-To: <200311041355.08731.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311042208.05748.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 November 2003 2:55 am, Con Kolivas wrote:
> That's pretty much what I expected. Overall I'm happier with this later
> version as it doesn't impact on the noticable improvement on systems that
> are not overloaded, yet keeps performance at least that of the untuned
> version. I can tune it to be better for this work load but it would be to
> the detriment of the rest.
>
> Ultimately this is the problem I see with 2.6 ; there is no way for the vm
> to know that "all the pages belonging to the currently running tasks should
> try their best to fit into the available space by getting an equal share".
> It seems the 2.6 vm gives nice emphasis to the most current task, but at
> the detriment of other tasks that are on the runqueue and still need ram.
> The original design of the 2.6 vm didn't even include this last ditch
> effort at taming swappiness with the "knob", and behaved as though the
> swapppiness was always set at 100. Trying to tune this further with just
> the swappiness value will prove futile as can be seen by the "best" setting
> of 20 in your test case still taking 4 times longer to compile the kernel.
>
> This is now a balance tradeoff of trying to set a value that works for your
> combination of the required ram of the applications you run concurrently,
> the physical ram and the swap ram. As you can see from your example, in
> your workload it seems there would be no point having more swap than your
> physical ram since even if it tries to use say 40Mb it just drowns in a
> swapstorm. Clearly this is not the case in a machine with more ram in
> different circumstances, as swapping out say openoffice and mozilla while
> it's not being used will not cause any harm to a kernel compile that takes
> up all the available physical ram (it would actually be beneficial).
> Fortunately most modern machines' ram vs application sizes are of the
> latter balance.

Your diagnosis looks right, but two points -

1.  The test compile was not of the kernel but of a file in a C++ program 
using quite a lot of templates and therefore which is quite memory intensive 
(for the sake of choosing something, it was a compile of src/main.o in 
http://www.cvine.freeserve.co.uk/efax-gtk/efax-gtk-2.2.2.src.tgz).  It would 
be a sad day if the kernel could not be compiled under 2.6 in 32MB of memory, 
and I am glad to say that it does compile - my 2.6.0-test9 kernel compiles on 
the 32MB machine in on average 45 minutes 13 seconds under kernel 2.4.22, and 
in 54 minutes 11 seconds under 2.6.0-test9 with your latest patch, which is 
not an enormous difference.  (As a digression, in the 2.0 days the kernel 
would compile in 6 minutes on the machine in question, and at the time I was 
very impressed.)

2.  Being able to choose a manual setting for swappiness is not "futile".  As 
I mentioned in an earlier post, a swappiness of 10 will enable 2.6.0-test9 to 
compile the things I threw at it on a low end machine, albeit slowly, whereas 
with dynamic swappiness it would not compile at all.  So the difference is 
between being able to do something and not being able to do it.

Chris.

