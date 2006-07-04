Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWGDBCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWGDBCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGDBCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:02:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751270AbWGDBCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:02:30 -0400
Date: Mon, 3 Jul 2006 18:01:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: hadi@cyberus.ca, pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060703180151.56f61b31.akpm@osdl.org>
In-Reply-To: <44A9BC4D.7030803@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
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
	<44A5EDE6.3010605@watson.ibm.com>
	<20060630205148.4f66b125.akpm@osdl.org>
	<44A9881F.7030103@watson.ibm.com>
	<44A9BC4D.7030803@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 20:54:37 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> > What happens when a listener exits without doing deregistration
> > (or if the listener attempts to register another cpumask while a current
> > registration is still active).
> >
> ( Jamal, your thoughts on this problem would be appreciated)
> 
> Problem is that we have a listener task which has "registered" with 
> taskstats and caused
> its pid to be stored in various per-cpu lists of listeners. Later, when 
> some other task exits on a given cpu, its exit data is sent using 
> genlmsg_unicast on each pid present on that cpu's list.
> 
> If the listener exits without doing a "deregister", its pid continues to 
> be kept around, obviously not a good thing. So we need some way of 
> detecting the situation (task is no longer listening on
> these cpus events) that is efficient.

Also need to address the case where the listener has closed off his file
descriptor but continues to run.

So hooking into listener's exit() isn't appropriate - the teardown is
associated with the lifetime of the fd, not of the process.  If we do that,
exit() gets handled for free.  
