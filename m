Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSGWQ2M>; Tue, 23 Jul 2002 12:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSGWQ2L>; Tue, 23 Jul 2002 12:28:11 -0400
Received: from ns.exp-math.uni-essen.de ([132.252.150.18]:7955 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S318139AbSGWQ2K>; Tue, 23 Jul 2002 12:28:10 -0400
Date: Tue, 23 Jul 2002 18:31:13 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with msync system call
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E1149F@ntserver2>
Message-Id: <Pine.A32.3.95.1020723181427.31958B-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Gregory Giguashvili wrote:

> Hello,
> 
> RH 7.2 (kernel 2.4.7-10) and RH 7.3 (kernel 2.4.18-3) (I haven't checked the
> others).
> 
> I attempt to read/write memory mapped file from two Linux machines, which
> resides on NFS mounted drive. The file gets corrupted since the changes made
> on one machine aren't immediately available on the other. The sample program
> is attached to this e-mail. The problematic API set includes (mmap, munmap
> and msync system calls). It seems that MS_INVALIDATE has no effect....
[... rest deleted ...]

I'm no NFS/mmap author or expert, only an experienced admin/user regarding
this issue, still:

I must say I have a very uneasy feeling about such a usage and don't know
how it is covered by standards (although you claim it works for non
linux). Experience shows that such a construct is very fragile. Note also
that NFS file locking is not mandatory, only advisory (read: user level) 
and it is unclear how that will interact with mmap.

That said, I'd expect at least the munmap using variant to work as
expected. I don't know if msync in this context is more than a placebo
function. Again experience shows that linux is very happy in caching
NFS files and contents locally, though. For inter-machine file exchange
(write on one machine, read immediately on the other) synchronized clocks
between server and clients within millisecond range are mandatory.

Forget about clocks set manually, use xntpd or timed or similar.  Without
such synchronized clocks (which synchronize caches), forget about NFS.
Note that this holds in principle even w/o the caching issue (like having
synchronized user databases.. it only seems that due to this caching issue
linux NFS seems to be VERY sensitive to out of sync clocks compared to
other NFS implementations.

So, my guess would be your clocks are out of sync, hence the copies of the
network shared file are. (you know, like: server clock is some
hours/minutes behind the clients so each client thinks IT has the most
actual copy of the file)

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

