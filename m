Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136371AbRD2VQE>; Sun, 29 Apr 2001 17:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136374AbRD2VPp>; Sun, 29 Apr 2001 17:15:45 -0400
Received: from chromium11.wia.com ([207.66.214.139]:51208 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136371AbRD2VPl>; Sun, 29 Apr 2001 17:15:41 -0400
Message-ID: <3AEC8562.887CFA72@chromium.com>
Date: Sun, 29 Apr 2001 14:19:30 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0104280923520.12895-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4 is surely one of the most advanced OSs ever happened, especially
from the optimization point of view and for the admirable economy of concepts
on which it lies. I definitively hope that X15 helps reinforcing the success
to this amazing system.

TUX has definitively been my performance yardstick for the development of
X15, but I had many sources of inspiration for the X15 architecture. Maybe
the most relevant are the Flash Web Server (Pai, Druschel, Zwaenepoel),
several Linus observations on this list about (web) server architecture and
kernnel services, and the reading of the Hennessy & Patterson architecture
books. Last but not least, aside from some heated discussions, research in
microkernel architecture has taught us many lessons on how to achieve an
efficient model of interaction across separate addressing spaces.

If i have to make some sort of educated guess and point at where the current
bottleneck lies for web server performance, I would say that it is somewhere
between the memory subsystem and the PCI bus.

With zero-copy sendfile data movement is not an issue anymore, asynchronous
network IO allows for really inexpensive thread scheduling, and system call
invocation adds a very negligible overhead in Linux. What we are left with
now is purely wait cycles, the CPUs and the NICs are contending for memory
and bus bandwidth. It would be really interesting to see where the network
shifts now that faster machines are becoming available.

On my whish list for future kernel developments I would definitively put disk
asynchronous IO and a more decent file descriptor passing implementation.
I'll detail this in subsequent messages.

I'll surely check out the impact of Ingo's patches on TUX performance
sometime this week.

I'd also like to reiterate my request for help for testing X15 on higher end
server architectures.

X15 is still very young alpha code and I can surely improve its performance
in many ways.

 - Fabio

Ingo Molnar wrote:

> On Fri, 27 Apr 2001, Fabio Riccardi wrote:
>
> > I'd like to announce the first release of X15 Alpha 1, a _user space_
> > web server that is as fast as TUX.
>
> great, the first TUX clone! ;-)
>
> This should put the accusations to rest that Linux got the outstandingly
> high SPECweb99 scores only because the webserver was in kernel-space. It's
> the 2.4 kernel's high performance that enabled those results, having the
> web-server in kernel-space didnt have much effect. TUX was and remains a
> testbed to test high-performance webserving (and FTP serving), without the
> API-exporting overhead of userspace.
>
> [i suspect the small performance advantage of X15 is due to subtle
> differences in the SPECweb99 user-space module: eg. while the TUX code was
> written, tested and ready to use mmap()-enabled
> TUXAPI_alloc_read_objectbuf(), it wasnt enabled actually. I sent Fabio a
> mail how to enable it, perhaps he can do some tests to confirm this
> suspicion?]
>
> doing a TUX 2.0 SPECweb99 benchmark on the latest -ac kernels, 86% of time
> is spent in generic parts of the kernel, 12% of time is spent in the
> user-space SPECweb99 module, and only 2% of time is spent in TUX-specific
> kernel code.
>
> doing the same test with the original TUX 1.0 code shows that more than
> 50% of CPU time was spent in TUX-specific code.
>
> what does this mean? In the roughly 6 months since TUX 1.0 was released,
> we moved much of the TUX 1.0 -only improvements into the generic kernel
> (most of which was made available to user-space as well), and TUX itself
> became smaller and smaller (and used more and more generic parts of the
> kernel). So in effect X15 is executing 50% TUX code :-)
>
> (there are still a number of performance improvement patches pending that
> are not integrated yet: the pagecache extreme-scalability patch and the
> smptimers patch. These patches speed both X15 and TUX up.)
>
> (there is one thing though that can never be 'exported to user-space': to
> isolate possibly untrusted binary application code from the server itself,
> without performance degradation. So we always have to be mentally open to
> the validity of kernel-space services.)
>
>         Ingo

