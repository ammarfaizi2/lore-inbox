Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbULBQCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbULBQCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbULBQB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:01:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:36845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261677AbULBQA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:00:59 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 17:03:15 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org, jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption,
 -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202170315.067d7853@mango.fruits.de>
In-Reply-To: <200412021546.iB2FkK5a005502@cichlid.com>
References: <200412021546.iB2FkK5a005502@cichlid.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 07:46:20 -0800
Andrew Burgess <aab@cichlid.com> wrote:

> Ingo Molnar said:
> 
> >Florian Schmidt <mista.tapas@gmx.net> wrote:
> >>
> >> Hmm, i wonder if there's a way to detect non RT behaviour in jackd
> >> clients. I mean AFAIK the only thing allowed for the process callback
> >> of on is the FIFO it waits on to be woken, right? Every other sleeping
> >> is to be considered a bug. 
> 
> >there's such a feature in -RT kernels. If a user process calls:
> >	gettimeofday(1,1);
> >then the kernel turns 'atomic mode' on. To turn it off, call:
> >	gettimeofday(1,0);
> 
> >while in atomic-mode, any non-atomic activity (scheduling) will produce
> >a kernel message and a SIGUSR2 sent to the offending process (once,
> >atomic mode has to be re-enabled again for the next message). Preemption
> >by a higher-prio task does not trigger a message/signal.
> 
> >If you run the client under gdb you should be able to catch the SIGUSR2
> >signal and then you can see the offending code's backtrace via 'bt'.
> 
> Might be handy to have the option to send a SIGABRT, then you don't need
> to guess which app to run under gdb and the offending code is there in
> the core file.
> 
> Also, I'm cc-ing jack-devel. This could fit into libjack so no client
> mods would be needed I think. After the thread_init_callback is run libjack
> could run 'gettimeofday(1,1);' for each client thread. Then if any client
> breaks the rules you get a core showing where. 
> 
> On further thought, I suppose libjack could install a SIGUSR2 handler and
> have that call abort for all the rt client threads. Still no client mods
> needed, only an RT-aware libjack.

right. Or instead of aborting jackd might print a debug output (like
"client foo violated RT constraints"). 

But the calls to gettimeofday would need to be done right before and
after every process callback as each client's RT thread does wait on the
FIFO to get woken by jackd. This waiting would appear as RT constraints
violation if the gettimeofday would be done only once per thread
lifetime at thread startup.

> 
> A big thank you to Ingo and everyone else involved on behalf of all the
> linux audio users!

BTW: i suppose pretty much every jack client except for very simple ones
do break the RT constraints.

Flo
