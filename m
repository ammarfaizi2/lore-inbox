Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbVIAWTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbVIAWTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbVIAWTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:19:01 -0400
Received: from fmr24.intel.com ([143.183.121.16]:38574 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030452AbVIAWTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:19:00 -0400
Date: Thu, 1 Sep 2005 15:18:49 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       ananth@in.ibm.com, prasanna@in.ibm.com
Subject: Re: [PATCH]kprobes fix bug when probed on task and isr functions
Message-ID: <20050901151848.A29863@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050901134937.A29041@unix-os.sc.intel.com> <20050901140938.69909683.akpm@osdl.org> <20050901142734.A29448@unix-os.sc.intel.com> <20050901144211.5bf5ded6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050901144211.5bf5ded6.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 01, 2005 at 02:42:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 02:42:11PM -0700, Andrew Morton wrote:
> Are you sure that other CPUs can safely read kprobe_cpu without taking the
> lock?  I don't see any memory barriers in there...

I see your point, in the current code we read kprobe_cpu and compare it with
ones own smp_processor_id() and if it *does* not match, then this cpu is allowed to
take the kprobe_lock(). So in this context, if one CPU is trying to read(kprobe_cpu)
the value while other is updating its own smp_processor_id() value,
then this cpu can either get NR_CPU(stale data) or the correct CPU_ID 
of the other processor, which in any case does not match with its 
own smp_processor_id() and we are allowed to take the lock(where in we might have to
wait spinning since we are any way serializing handling of probes).

So to answer your question, for our current desing, we are safe to read
kprobe_cpu outside of the lock.

Here is the link which gives the status of testing this patch on
various platforms.
http://sourceware.org/bugzilla/show_bug.cgi?id=1229

