Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVDLJfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVDLJfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVDLJfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:35:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1010 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262080AbVDLJeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:34:44 -0400
Date: Tue, 12 Apr 2005 15:05:25 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: Hien Nguyen <hien@us.ibm.com>, SystemTAP <systemtap@sources.redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm3] [1/2]  kprobes += function-return
Message-ID: <20050412093525.GC19538@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050404081538.GF1715@in.ibm.com> <1112721545.2293.36.camel@dyn9047018078.beaverton.ibm.com> <1113242482.2298.128.camel@dyn9047018078.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113242482.2298.128.camel@dyn9047018078.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > int register_returnprobe(struct rprobe *rp) {
> > ...
> > 
> > > independent of kprobe and jprobe.
> > ...
> > > 
> > > make unregister exitprobes independent of kprobe/jprobe.
> > > 
> > ...
> > 
> > 1. When you call register_j/kprobe(), if kprobe->rp is non-null, it is
> > assumed to point to a retprobe that will be registered and unregistered
> > along with the kprobe.  (But this may make trouble for existing kprobes
> > applications that didn't need to initialize the (nonexistent) rp
> > pointer.  Probably not a huge deal.)
> 
> I suppose if pairing of entry and return probes is important for a user,
> he/she can always do the following:
> 
> static int ready;	// 1 = everybody registered
> 			// 2 = everybody knows we're registered
> ...
> 	ready = 0;
> 	... register_kprobe(&kp)...
> 	... register_retprobe(&rp) ...
> 	/* instant XXX -- see below*/
> 	ready = 1;
> 
> and in kp.pre_handler do
> 	if (!ready) {
> 		// return probe not registered yet
> 		return 0;
> 	}
> 	ready = 2;
> 	<body of handler>
> 
> and in rp.handler do
> 	if (ready != 2) {
> 		// Probed function entered during instant XXX,
> 		// so kp.pre_handler didn't act on it.
> 		return 0;
> 	}
> 	<body of handler>
> 
> Keeping a whole group of kprobes, jprobes, and retprobes in the starting
> gate pending a "ready" signal (e.g., for SystemTap) could probably be
> handled similarly.
> 
> Unregistration shouldn't be an issue.  At any time you can have N active
> instances of the probed function, and have therefore recorded E entries
> and E-N returns.  Hien's code handles all that on retprobe
> deregistration, but the user's instrumentation should never count on #
> probed entries == # probed returns.
> 

Jim,

You can do something like you explained above to handle the pairing issues.
You need to provide simple and compact interfaces for return probe feature.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
