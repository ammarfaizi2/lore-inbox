Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUETMUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUETMUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 08:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUETMUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 08:20:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37338 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265094AbUETMUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 08:20:37 -0400
Date: Thu, 20 May 2004 09:21:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, Carson Gaspar <carson@taltos.org>,
       Marco Fais <marco.fais@abbeynet.it>
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040520122131.GB18718@logos.cnet>
References: <406D3E8F.20902@abbeynet.it> <20040505183558.GB1350@logos.cnet> <20040519115950.GE12419@logos.cnet> <200405191750.10090@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405191750.10090@WOLK>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 05:50:10PM +0200, Marc-Christian Petersen wrote:
> On Wednesday 19 May 2004 13:59, Marcelo Tosatti wrote:
> 
> Hi Marcelo, Carson ...
> 
> > > > >>[1.] Kernel panic while using distcc
> > > > >>[2.] I have 5-6 development linux systems that we use without problem
> > > > >>under a normal development workload. Trying distcc for speeding up
> > > > >>compilation, we have a fully reproducible kernel panic in a very
> > > > >> short time (seconds after compilation start). The kernel panic
> > > > >> happens *only* when the systems are "remotely controlled" (the
> > > > >> distcc daemon is receiving source files from remote systems, compile
> > > > >> and send back compiled objects). When compiling with distcc the
> > > > >> local system doesn't show any kernel panic, while the same system
> > > > >> used as a "remote compiler system" dies very quickly.
> > > > >>[3.] Keywords: distcc BUG page_alloc.c
> 
> > So did Andrea's fix work for you? :)
> 
> sorry if I did not follow this thread from the beginning, but why is distcc 
> causing a BUG() in page_alloc.c? I use distcc since I don't know when and 
> never had any BUG() in page_alloc with distcc, nor the specific bug at :98.
> 
> I have 7 machines in my distcc farm, and all are "remote controlled".
> 
> Could someone please clarify me? Thank you.

We try to free a page which has been sent over the network 
in IRQ context, because with sendfile() its possible that such IRQ context 
reference is the last one on the page.

Quoting David Miller:

When vmscan.c shrinks a cache, it never tosses a page which is LRU if
the page count is not 1 (after trying to toss attached buffers if any).
                                                                                                                                                                                   
I think LRU used to contribute a page count, which prevented this problem,
or something like that.
                                                                                                                                                                                   
In fact it seems trivial to trigger the bug in question:
                                                                                                                                                                                   
1) open file
2) sendfile() it over a socket
3) quickly close the file, no existing user references, only the
   sendfile() packet references remain to the page
                                                                                                                                                                                   
When the TCP packet gets ACK'd, we explode in __free_pages_ok() as per
the report.

