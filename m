Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUIQMM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUIQMM2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268718AbUIQMM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:12:27 -0400
Received: from holomorphy.com ([207.189.100.168]:62379 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268717AbUIQMLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:11:25 -0400
Date: Fri, 17 Sep 2004 05:10:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040917121040.GN9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua> <20040916121747.GQ9106@holomorphy.com> <200409171421.15470.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171421.15470.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
>> Did the kallsyms patches reduce the cpu overhead from get_wchan()? I take
>> this to mean reducing HZ to 100 did not alleviate the syscall problems?
>> How do microbenchmarks fare, e.g. lmbench?

On Fri, Sep 17, 2004 at 02:21:15PM +0300, Denis Vlasenko wrote:
> 2x3 lmbench runs. HZ=100, configs attached.
> Context switching - times in microseconds - smaller is better
> -------------------------------------------------------------------------
> Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
>                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> --------- ------------- ------ ------ ------ ------ ------ ------- -------
> hunter    Linux 2.6.9-r   31.9   64.0  120.8  115.7  322.2   136.0   356.4
> hunter    Linux 2.6.9-r   29.1   47.2   76.7  102.3  321.5   136.0   354.2
> hunter    Linux 2.6.9-r   29.3   56.0  144.5  101.9  305.5   145.3   351.0
> hunter    Linux 2.4.27-   19.8   39.4  190.3   77.8  368.0   104.1   401.5
> hunter    Linux 2.4.27-   19.7   30.9  105.0   87.2  316.9   107.2   359.9
> hunter    Linux 2.4.27-   19.5   34.6   95.5   74.3  279.1   109.5   325.0

Bizarre; context switching latency is actually one of the 2.6
scheduler's strong points AFAIK. This generally needs NMI's to
instrument as the critical sections here have interrupts disabled.
Someone more knowledgable regarding the i8259A PIC may have ideas about
how to go about arranging for NMI-based profiling on a system such as
yours. I presume this is a Pentium "Classic", not Pentium Pro.

Alan, any ideas?


On Fri, Sep 17, 2004 at 02:21:15PM +0300, Denis Vlasenko wrote:
> *Local* Communication latencies in microseconds - smaller is better
> ---------------------------------------------------------------------
> Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
>                         ctxsw       UNIX         UDP         TCP conn
> --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> hunter    Linux 2.6.9-r  31.9 129.8 230.                             
> hunter    Linux 2.6.9-r  29.1 130.1 244.                             
> hunter    Linux 2.6.9-r  29.3 136.9 233.                             
> hunter    Linux 2.4.27-  19.8  74.0 146.                             
> hunter    Linux 2.4.27-  19.7  74.4 134.                             
> hunter    Linux 2.4.27-  19.5  77.8 137.                             

Degradation #2: pipe and AF_UNIX latencies. This can likely be profiled
without NMI's.


On Fri, Sep 17, 2004 at 02:21:15PM +0300, Denis Vlasenko wrote:
> File & VM system latencies in microseconds - smaller is better
[...]

2.6 looks clean here, which directly contradicts your prior results.
Hmm.


On Fri, Sep 17, 2004 at 02:21:15PM +0300, Denis Vlasenko wrote:
> *Local* Communication bandwidths in MB/s - bigger is better
> -----------------------------------------------------------------------------
> Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
>                              UNIX      reread reread (libc) (hand) read write
> --------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
> hunter    Linux 2.6.9-r 13.1 11.1        16.8   54.3   18.4   18.5 54.2  26.1
> hunter    Linux 2.6.9-r 12.7 12.1        16.4   54.3   18.5   18.5 54.3  26.2
> hunter    Linux 2.6.9-r 13.0 11.2        18.3   54.3   18.5   18.5 54.3  26.1
> hunter    Linux 2.4.27- 15.7 11.9        17.6   54.2   18.6   18.6 54.4  26.0
> hunter    Linux 2.4.27- 15.7 10.7        18.3   54.2   18.4   18.5 54.4  26.1
> hunter    Linux 2.4.27- 15.5 10.9        17.8   54.3   18.6   18.5 54.4  26.1

So pipes also degraded slightly wrt. bandwidth, and AF_UNIX bandwidth is
slightly superior. This can likely also be profiled without NMI's.

One thing we're going to have to do to instrument your specific
regressions is to run the tests for whatever you see degradations for
in isolation. None of this should require building new kernels, except
for whatever we (later) devise to instrument your context switching
latencies.

There is also a question of how the context switching benchmark was
implemented. If it was via pipes, then degradations in pipe performance
will affect it. So we should likely ask Larry to comment on how that
part of his benchmark was implemented; if it is indeed via pipes, then
we should ignore the scheduler until fs/pipe.c has been addressed.
There are likely other ways to measure context switching latency (well,
sched_yield() probably won't DTRT on 2.6.x unless they're RT tasks with
a policy of SCHED_RR, but that's one alternative).


-- wli
