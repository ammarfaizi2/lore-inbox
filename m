Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWGADw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWGADw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGADw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:52:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbWGADw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:52:27 -0400
Date: Fri, 30 Jun 2006 20:51:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060630205148.4f66b125.akpm@osdl.org>
In-Reply-To: <44A5EDE6.3010605@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<44A57310.3010208@watson.ibm.com>
	<44A5770F.3080206@watson.ibm.com>
	<20060630155030.5ea1faba.akpm@osdl.org>
	<44A5DBE7.2020704@watson.ibm.com>
	<20060630194353.1cc96ce4.akpm@osdl.or!
 g>
	<44A5EDE6.3010605@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 23:37:10 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> >Set aside the implementation details and ask "what is a good design"?
> >
> >A kernel-wide constant, whether determined at build-time or by a /proc poke
> >isn't a nice design.
> >
> >Can we permit userspace to send in a netlink message describing a cpumask? 
> >That's back-compatible.
> >  
> >
> Yes, that should be doable. And passing in a cpumask is much better 
> since we no longer
> have to maintain mappings.
> 
> So the strawman is:
> Listener bind()s to genetlink using its real pid.
> Sends a separate "registration" message with cpumask to listen to. 
> Kernel stores (real) pid and cpumask.
> During task exit, kernel goes through each registered listener (small 
> list) and decides which
> one needs to get this exit data and calls a genetlink_unicast to each 
> one that does need it.
> 
> If number of listeners is small, the lookups should be swift enough. If 
> it grows large, we
> can consider a fancier lookup (but there I go again, delving into 
> implementation too early :-)

We'll need a map.

1024 CPUs, 1024 listeners, 1000 exits/sec/CPU and we're up to a million
operations per second per CPU.  Meltdown.

But it's a pretty simple map.  A per-cpu array of pointers to the head of a
linked list.  One lock for each CPU's list.
