Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUBUTaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 14:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUBUTaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 14:30:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:27318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261603AbUBUTaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 14:30:17 -0500
Date: Sat, 21 Feb 2004 11:30:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, anton@megashop.ru
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040221113044.7deb60b9.akpm@osdl.org>
In-Reply-To: <200402211945.21837.rathamahata@php4.ru>
References: <200401311940.28078.rathamahata@php4.ru>
	<20040131161729.04000e92.akpm@osdl.org>
	<200402211945.21837.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> Hello Andrew,
> 
> On Sunday 01 February 2004 03:17, Andrew Morton wrote:
> > "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> > >
> > > I had experienced a lockups on three of my servers with 2.6.1. It doesn't
> > >  look like a deadlock, the box is still pingable and all tcp ports which were
> > >   in listen state before a lockup are remains in listen state, but I can't get
> > >  any data from this ports. According to sar(1) systems had not been overloaded
> > >  right before a lockup. And there is no log entries in all user services logs
> > >  for almost 10 hours after lockup.
> > 
> > Please ensure that CONFIG_KALLSYMS is enabled, then generate an all-tasks
> > backtrace or a locked machine with sysrq-T or `echo t >
> > /proc/sysrq-trigger'.  Then send us the resulting trace.
> 
> I've just reproduced this lockup with 2.6.3.
> 
> > 
> > You may need a serial console to be able to capture all the output.
> > 
> > Also, it would be useful to know what sort of load the machines are under,
> > and what filesystems are in use.
> 
> The machine is a http server. The main applications are:
> 1) apache 1.3 which serves php pages (mod_php):
> 	 15.3 requests/sec - 111.9 kB/second - 7.3 kB/request
> 	 54 requests currently being processed, 19 idle servers
> 2) mysql:
> 	Threads: 19  Questions: 26922012  Slow queries: 9799  Opens: 64980
> 	Flush tables: 1  Open tables: 630  Queries per second avg: 143.547
> 
> This is an IO bound machine in general. All filesystems are reiserfs.
> 
> Here is a sysrq-T output obtained from a locked box via serail console:

OK, so everything is stuck trying to allocate memory.  Perhaps you ran out
of swapspace, or some process has gone berzerk allocating memory.

How much memory does the machine have, and how much swap space?

I suggest that you run a `vmstat 30' trace on a terminal somewhere, see what
it says prior to the hangs.  Also capture the sysrq-M output after it has
hung.

It would be useful to monitor the contents of /proc/vmstat also.

And perhaps keep top running in `sort by memory usage' mode.
