Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbRLTXJA>; Thu, 20 Dec 2001 18:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286463AbRLTXIl>; Thu, 20 Dec 2001 18:08:41 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:6568 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S286462AbRLTXIb>; Thu, 20 Dec 2001 18:08:31 -0500
Message-Id: <4.3.2.7.2.20011220145246.02b62350@171.69.24.15>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 20 Dec 2001 15:02:10 -0800
To: Linus Torvalds <torvalds@transmeta.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: aio
Cc: Dan Kegel <dank@kegel.com>, <mingo@elte.hu>,
        "David S. Miller" <davem@redhat.com>, bcrl <bcrl@redhat.com>,
        billh <billh@tierra.ucsd.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
In-Reply-To: <Pine.LNX.4.33.0112201354420.1545-100000@penguin.transmeta.
 com>
In-Reply-To: <4.3.2.7.2.20011220133542.02c03ef0@171.69.24.15>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:59 PM 20/12/2001 -0800, Linus Torvalds wrote:

>On Thu, 20 Dec 2001, Lincoln Dale wrote:
> >
> > SIGIO sucks in the real-world for a few reasons right now, most of them
> > unrelated to 'sigio' itself:
>
>Well, there _is_ one big one, which definitely is fundamentally related to
>sigio itself:
>
>sigio is an asynchronous event programming model.
>
>And let's face it, asynchronous programming models suck. They inherently
>require that you handle various race conditions etc, and have extra
>locking.

actually, i disagree with your assertion that "asyncronous programming 
models suck".

for MANY applications, it doesn't matter.  the equivalent to async is to do 
either:
  - thread-per-connection or process-per-connection (ala apache, sendmail, 
inetd-type services, ...)
  - a system that blocks -- handles one-connection-at-a-time

the only time async actually starts to matter is if you start to stress the 
precipitous performance characteristics associated with thousands of 
concurrent tasks in a thread/process-per-connection model.  (limited 
processor L2 cache size, multiple tasks sharing the same cache-lines 
(suboptimal cache colouring), scheduler overhead, wasted 
stack-space-per-thread/process, ..).

if you care about that level of performance, then you generally move to an 
async model.
moving to an async model doesn't have to be hard -- people generally start 
with their own pseudo scheduler and go from there.
"harder" than non-async: yes.  but "hard": no.

>SIGIO just isn't very nice. It's useful for some event notification (ie if
>you don't actually _do_ anything in the signal handler), but let's be
>honest: it's an extremely heavy notifier. Something synchronous like
>"poll" or "select" will beat it just about every time (yes, they don't
>scale well, but neither does SIGIO).

actually, my experience (circa 12 months ago) was that they were roughly equal.
poll()'s performance dropped off significantly at a few thousand FDs 
whereas sigio's latency just went up.
but it was somewhat trivial to _make_ poll() go faster by being intelligent 
about what fd's to poll.  simple logic of "if a FD didn't have anything 
active, don't poll for it on the next poll() loop" didn't increase the 
latency in servicing that FD by any noticable amount but basically triples 
the # of FDs one could handle.


cheers,

lincoln.
NB. sounds like you're making a case for the current trend in Java Virtual 
Machines insistance on "lots of processes" being a good thing. <grin, duck, 
run>

