Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVDQLeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVDQLeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 07:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDQLeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 07:34:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55304 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261302AbVDQLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 07:34:07 -0400
Date: Sun, 17 Apr 2005 13:30:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More performance for the TCP stack by using additional hardware chip on NIC
Message-ID: <20050417113046.GA777@alpha.home.local>
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de> <1113728880.17394.16.camel@laptopd505.fenrus.org> <1113733753.15803.26.camel@avik.scalemp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113733753.15803.26.camel@avik.scalemp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Sun, Apr 17, 2005 at 01:29:14PM +0300, Avi Kivity wrote:
> On Sun, 2005-04-17 at 12:07, Arjan van de Ven wrote:
> > On Sun, 2005-04-17 at 10:17 +0200, Andreas Hartmann wrote:
> > > Hello!
> > > 
> > > Alacritech developed a new chip for NIC's
> > > (http://www.alacritech.com/html/tech_review.html), which makes it possible
> > > to take away the TCP stack from the host CPU. Therefore, the host CPU has
> > > more performance for the applications according Alacritech.
> > 
> > there are very many good reasons why this for linux is not the right
> > solution, including the fact that the linux tcp/ip stack already is
> > quite fast so the "gains" achieved aren't that stellar as the gains you
> > get when comparing to windows.
> > 
> 
> TOEs can remove the data copy on receive. In some applications (notably
> storage), where the application does not touch most of the data, this is
> a significant advantage that cannot be achieved in a software-only
> solution.

Well, if the application does not touch most of the data, either it
is playing as a relay, and the data will at least have to be copied,
or it will play as a client or server which reads from/writes to disk,
and in this case, I wonder how the NIC will send its writes directly
to the disk controller without some help.

What worries me with those NICs is that you have no control on the
TCP stack. You often have to disable the acceleration when you
want to insert even 1 firewall rule, use policy routing or even
do a simple anti-spoofing check. It is exactly like the routers
which do many things in hardware at wire speed, but jump to snail
speed when you enable any advanced feature.

> > Also these types of solution always add quite a bit of overhead to
> > connection setup/teardown making it actually a *loss* for the "many
> > short connections" types of workloads. Now guess which things certain
> > benchmarks use, and guess what real world servers do :)
> > 
> 
> again, this depends on the application.

The speed itself depends on the application. An application which
goal is to achieve 10 Gbps needs to be written with this goal in
mind from start, and needs fine usage of the kernel internals, and
even sometimes good knowledge of the hardware itself. At the moment,
a non-blocking application needs one copy because the final data
position in memory is unknown. Probably soon we'll see new prefetch
syscalls (like in CPUs) which will allow the application to tell
the system that it expects to fetch some data to a particular place.
Then a very simple TOE card would be able to wake the system up to
send only TCP headers first, and the system will say "send the
data there", then wake the application once the data has been copied
and checksummed. This keeps compatible with firewalls and other
mechanisms.

> a copyless solution is probably necessary to achieve 10Gb/s speeds.

That was said for 100 Mbps then Gbps years ago, and the fact is that
software has improved a lot (zero-copy, epoll, etc...) and at the
moment, it's relatively easy to drain multi-gigabit from cheap
hardware. For example, I could fetch 3.2 Gbps of HTTP traffic on
a $3000 opteron 2GHz with a 4-port intel gigabit NIC, and a non-
optimized HTTP client which still uses select().

Memory and I/O busses are becoming very large, eg: 8 Gbps for the
PCI-X 133, multi-gigabytes/s between memory and the CPU, so the
hardware bottleneck for the 10 Gbps is already at the NIC side
and not between the CPU and the memory. When you leverage this
limit, you'll notice that the application needs very large buffers
(eg: 12.5 MB to support a 10ms scheduling latency on 10 Gbps) and
good general design (10 Gbps is 125000 open/read/send/close of
10 kB files every second).

Regards,
Willy

