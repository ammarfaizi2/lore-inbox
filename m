Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTKDC4Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTKDC4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 21:56:25 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:15786
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263611AbTKDC4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 21:56:22 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Chris Vine <chris@cvine.freeserve.co.uk>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Tue, 4 Nov 2003 13:55:08 +1100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk>
In-Reply-To: <200311032113.14462.chris@cvine.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041355.08731.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 08:13, Chris Vine wrote:
> On Monday 03 November 2003 12:48 am, Con Kolivas wrote:
> > Well I was considering adding the swap pressure to this algorithm but I
> > had hoped 2.6 behaved better than this under swap overload which is what
> > appears to happen to yours. Can you try this patch? It takes into account
> > swap pressure as well. It wont be as aggressive as setting the swappiness
> > manually to 10, but unlike a swappiness of 10 it will be more useful over
> > a wide range of hardware and circumstances.

>
> The test compile started in a similar way to the compile when using your
> first patch.  swappiness under no load was 37.  At the beginning of the
> compile it went up to 67, but when thrashing was well established it
> started to come down slowly.  After 40 minutes of thrashing it came down to
> 53.  At that point I stopped the compile attempt (which did not complete).
>
> So, there is a slight move in the right direction, but given that a
> swappiness of 20 generates thrashing with 32 MB of RAM when more than about
> 20MB of memory is swapped out, it is a drop in the ocean.
>
> The conclusion appears to be that for low end systems, once memory swapped
> out reaches about 60% of installed RAM the swap ceases to work effectively
> unless swappiness is much more aggressively low than your patch achieves. 
> The ability manually to tune it therefore seems to be required (and even
> then, 2.4.22 is considerably better, compiling the test file in about 1
> minute 35 seconds).
>
> I suppose one question is whether I would get the same thrashiness with my
> other machine (which has 512MB of RAM) once more than about 300MB is
> swapped out.  However, I cannot answer that question as I do not have
> anything here which makes memory demands of that kind.

That's pretty much what I expected. Overall I'm happier with this later 
version as it doesn't impact on the noticable improvement on systems that are 
not overloaded, yet keeps performance at least that of the untuned version. I 
can tune it to be better for this work load but it would be to the detriment 
of the rest. 

Ultimately this is the problem I see with 2.6 ; there is no way for the vm to 
know that "all the pages belonging to the currently running tasks should try 
their best to fit into the available space by getting an equal share". It 
seems the 2.6 vm gives nice emphasis to the most current task, but at the 
detriment of other tasks that are on the runqueue and still need ram. The 
original design of the 2.6 vm didn't even include this last ditch effort at 
taming swappiness with the "knob", and behaved as though the swapppiness was 
always set at 100. Trying to tune this further with just the swappiness value 
will prove futile as can be seen by the "best" setting of 20 in your test 
case still taking 4 times longer to compile the kernel. 

This is now a balance tradeoff of trying to set a value that works for your 
combination of the required ram of the applications you run concurrently, the 
physical ram and the swap ram. As you can see from your example, in your 
workload it seems there would be no point having more swap than your physical 
ram since even if it tries to use say 40Mb it just drowns in a swapstorm. 
Clearly this is not the case in a machine with more ram in different 
circumstances, as swapping out say openoffice and mozilla while it's not 
being used will not cause any harm to a kernel compile that takes up all the 
available physical ram (it would actually be beneficial). Fortunately most 
modern machines' ram vs application sizes are of the latter balance.

There's always so much more you can do...

wli, riel care to comment?

Cheers,
Con

