Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWGDNGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWGDNGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGDNGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:06:02 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:34491 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S932148AbWGDNF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:05:59 -0400
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, csturtiv@sgi.com,
       balbir@in.ibm.com, jlan@engr.sgi.com, Valdis.Kletnieks@vt.edu,
       pj@sgi.com, Shailabh Nagar <nagar@watson.ibm.com>
In-Reply-To: <20060703180151.56f61b31.akpm@osdl.org>
References: <44892610.6040001@watson.ibm.com>
	 <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com>
	 <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com>
	 <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
	 <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
	 <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
	 <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org>
	 <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com>
	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	 <20060629094408.360ac157.pj@sgi.com>
	 <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com>
	 <44A5770F.3080206@watson.ibm.com> <20060630155030.5ea1faba.akpm@osdl.org>
	 <44A5DBE7.2020704@watson.ibm.com> <44A5EDE6.3010605@watson.ibm.com>
	 <20060630205148.4f66b125.akpm@osdl.org> <44A9881F.7030103@watson.ibm.com>
	 <44A9BC4D.7030803@watson.ibm.com>  <20060703180151.56f61b31.akpm@osdl.org>
Content-Type: text/plain
Organization: unknown
Date: Tue, 04 Jul 2006 09:05:53 -0400
Message-Id: <1152018353.5214.14.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-07 at 18:01 -0700, Andrew Morton wrote:
> On Mon, 03 Jul 2006 20:54:37 -0400
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
> > > What happens when a listener exits without doing deregistration
> > > (or if the listener attempts to register another cpumask while a current
> > > registration is still active).
> > >
> > ( Jamal, your thoughts on this problem would be appreciated)
> > 
> > Problem is that we have a listener task which has "registered" with 
> > taskstats and caused
> > its pid to be stored in various per-cpu lists of listeners. Later, when 
> > some other task exits on a given cpu, its exit data is sent using 
> > genlmsg_unicast on each pid present on that cpu's list.
> > 
> > If the listener exits without doing a "deregister", its pid continues to 
> > be kept around, obviously not a good thing. So we need some way of 
> > detecting the situation (task is no longer listening on
> > these cpus events) that is efficient.
> 
> Also need to address the case where the listener has closed off his file
> descriptor but continues to run.
> 
> So hooking into listener's exit() isn't appropriate - the teardown is
> associated with the lifetime of the fd, not of the process.  If we do that,
> exit() gets handled for free.  

If you are always going to send unicast messages, then  -ECONNREFUSED
will tell you the listener has closed their fd - this doesnt meant it
has exited. Besides that one process could open several sockets. I know
that would not be the app you would write - but it doesnt stop other
people from doing it.
I think i may not follow what you are doing - for some reason i thought
you may have many listeners in user space and these messages get
multicast to them?
Does the user space program somehow communicate its pid to the kernel?

cheers,
jamal

