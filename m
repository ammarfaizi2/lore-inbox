Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHOXh2>; Thu, 15 Aug 2002 19:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSHOXh2>; Thu, 15 Aug 2002 19:37:28 -0400
Received: from fmr03.intel.com ([143.183.121.5]:13033 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S317772AbSHOXh1>; Thu, 15 Aug 2002 19:37:27 -0400
Message-Id: <200208152341.g7FNf6P06241@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] exit_free(), 2.5.31-A0
Date: Thu, 15 Aug 2002 16:51:35 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208131112270.7411-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208131112270.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 August 2002 02:17 pm, Linus Torvalds wrote:
> On Tue, 13 Aug 2002, Ingo Molnar wrote:
> > > That still doesn't make it any les crap: because any thread that exits
> > > without calling the "magic exit-flag interface" will then silently be
> > > lost, with no information left around anywhere.
> >
> > that should be a pretty rare occurance: with the upcoming signals patch
> > any segmentation fault zaps all threads and does a proper (and
> > deadlock-free) multithreaded coredump.
>
> That still doesn't change the fact that the interface is broken
> _by_design_.
>
> If the parent wants to get notified on child death, it should damn well
> get notified on child death. Not "in case the child exists politely".
>
> We don't depend on processes calling "exit()" to clean up all the stuff
> they left behind. The VM gets cleaned up even for bad processes.
>

What's been missing is the there is no option for synchronization as part of 
the parent notification or exit processing.

What's needed, for TCore, is something like "when a process dies, signal 
parents to do X and then wait on optional semaphore" before losing all the 
process data to do_exit.

The big problem I've been had with TCore is that that there is no polite way 
of synchronization for the dumping process with the parent and sibling 
processes while they are getting a signal storm as they all go down.  

I've come up with a few brutish ways to suspend these processes (with some 
risk taken with semaphore locks from a maintenance point of view ;).  
However; these approaches still sometimes don't get to run before some of the 
siblings exit.

There is no good way, especially on SMP setups with a large multi-threaded 
applications, to guarantee the signals don't get where they are going before 
the core dump data is gathered.


--mgross

