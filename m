Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVDKSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVDKSED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVDKSED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:04:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31637 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261866AbVDKSB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:01:28 -0400
Subject: Re: [PATCH 2.6.12-rc1-mm3] [1/2]  kprobes += function-return
From: Jim Keniston <jkenisto@us.ibm.com>
To: prasanna@in.ibm.com
Cc: Hien Nguyen <hien@us.ibm.com>, SystemTAP <systemtap@sources.redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1112721545.2293.36.camel@dyn9047018078.beaverton.ibm.com>
References: <20050404081538.GF1715@in.ibm.com>
	 <1112721545.2293.36.camel@dyn9047018078.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1113242482.2298.128.camel@dyn9047018078.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Apr 2005 11:01:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 10:19, Jim Keniston wrote:
> On Mon, 2005-04-04 at 01:15, Prasanna S Panchamukhi wrote:
> ...
> > int register_returnprobe(struct rprobe *rp) {
> ...
> 
> > independent of kprobe and jprobe.
> ...
> > 
> > make unregister exitprobes independent of kprobe/jprobe.
> > 
> ...
> > 
> > Please let me know if you need more information.
> > 
> > Thanks
> > Prasanna
> 
> We thought about that.  It is a nicer interface.  But I'm concerned that
> if the user has to do
> 	register_kprobe(&foo_entry_probe);
> 	register_retprobe(&foo_return_probe);
> then he/she has to be prepared to handle calls to foo that happen
> between register_kprobe and register_retprobe -- i.e., calls where the
> entry probe fires but the return probe doesn't.  Similarly on
> unregistration.
> 
> Here are a couple of things we could do to support registration and
> unregistration of retprobes that can be either dependent on or
> independent of the corresponding j/kprobes, as the user wants:
> 
> 1. When you call register_j/kprobe(), if kprobe->rp is non-null, it is
> assumed to point to a retprobe that will be registered and unregistered
> along with the kprobe.  (But this may make trouble for existing kprobes
> applications that didn't need to initialize the (nonexistent) rp
> pointer.  Probably not a huge deal.)
> 
> OR
> 
> 2. Create the ability to (a) register kprobes, jprobes, and/or retprobes
> in a disabled state; and (b) enable a group of probes in an atomic
> operation.  Then you could register the entry and return probes
> independently, but enable them together.  We may need to do something
> like that for SystemTap anyway.
> 
> Jim Keniston
> IBM Linux Technology Center

I suppose if pairing of entry and return probes is important for a user,
he/she can always do the following:

static int ready;	// 1 = everybody registered
			// 2 = everybody knows we're registered
...
	ready = 0;
	... register_kprobe(&kp)...
	... register_retprobe(&rp) ...
	/* instant XXX -- see below*/
	ready = 1;

and in kp.pre_handler do
	if (!ready) {
		// return probe not registered yet
		return 0;
	}
	ready = 2;
	<body of handler>

and in rp.handler do
	if (ready != 2) {
		// Probed function entered during instant XXX,
		// so kp.pre_handler didn't act on it.
		return 0;
	}
	<body of handler>

Keeping a whole group of kprobes, jprobes, and retprobes in the starting
gate pending a "ready" signal (e.g., for SystemTap) could probably be
handled similarly.

Unregistration shouldn't be an issue.  At any time you can have N active
instances of the probed function, and have therefore recorded E entries
and E-N returns.  Hien's code handles all that on retprobe
deregistration, but the user's instrumentation should never count on #
probed entries == # probed returns.

Jim

