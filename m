Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVDERpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVDERpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDERnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:43:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:20115 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261833AbVDERTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:19:07 -0400
Subject: Re: [PATCH 2.6.12-rc1-mm3] [1/2]  kprobes += function-return
From: Jim Keniston <jkenisto@us.ibm.com>
To: prasanna@in.ibm.com
Cc: Hien Nguyen <hien@us.ibm.com>, SystemTAP <systemtap@sources.redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050404081538.GF1715@in.ibm.com>
References: <20050404081538.GF1715@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1112721545.2293.36.camel@dyn9047018078.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Apr 2005 10:19:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 01:15, Prasanna S Panchamukhi wrote:
> Hi Hien,
> 
> This patch looks good to me, but I have some comments on this patch.
> 
> >int register_kretprobe(struct kprobe *kp, struct rprobe *rp);
...
> >int register_jretprobe(struct jprobe *jp, struct rprobe *rp);
...
> 
> Why two interfaces for the same feature?
> You can provide a simple interface like
...
> int register_returnprobe(struct rprobe *rp) {
...

> independent of kprobe and jprobe.
> This routine should take care to register entry handler internally if not 
> present. This routine can check if there are already entry point kprobe/jprobe
> and use some flags internally to say if the entry jprobe/kprobe already exists.
> 
...
> 
> make unregister exitprobes independent of kprobe/jprobe.
> 
...
> 
> Please let me know if you need more information.
> 
> Thanks
> Prasanna

We thought about that.  It is a nicer interface.  But I'm concerned that
if the user has to do
	register_kprobe(&foo_entry_probe);
	register_retprobe(&foo_return_probe);
then he/she has to be prepared to handle calls to foo that happen
between register_kprobe and register_retprobe -- i.e., calls where the
entry probe fires but the return probe doesn't.  Similarly on
unregistration.

Here are a couple of things we could do to support registration and
unregistration of retprobes that can be either dependent on or
independent of the corresponding j/kprobes, as the user wants:

1. When you call register_j/kprobe(), if kprobe->rp is non-null, it is
assumed to point to a retprobe that will be registered and unregistered
along with the kprobe.  (But this may make trouble for existing kprobes
applications that didn't need to initialize the (nonexistent) rp
pointer.  Probably not a huge deal.)

OR

2. Create the ability to (a) register kprobes, jprobes, and/or retprobes
in a disabled state; and (b) enable a group of probes in an atomic
operation.  Then you could register the entry and return probes
independently, but enable them together.  We may need to do something
like that for SystemTap anyway.

Jim Keniston
IBM Linux Technology Center

