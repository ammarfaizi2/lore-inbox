Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUISUU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUISUU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUISUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:20:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18909 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263626AbUISUUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:20:42 -0400
To: vatsa@in.ibm.com
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       suparna@in.ibm.com, ebiederm@xmission.com, mbligh@aracnet.com,
       fastboot@osdl.org, litke@us.ibm.com,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH][4/6]Register snapshotting before kexec boot
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<20040915125422.GD15450@in.ibm.com>
	<20040915125525.GE15450@in.ibm.com>
	<20040915142722.46088ad5.akpm@osdl.org>
	<20040916081138.GB4594@in.ibm.com> <20040917145350.GA4750@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2004 14:17:58 -0600
In-Reply-To: <20040917145350.GA4750@in.ibm.com>
Message-ID: <m1hdpu813d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:

> On Thu, Sep 16, 2004 at 08:41:13AM +0000, Dipankar Sarma wrote:
> > On Wed, Sep 15, 2004 at 02:27:22PM -0700, Andrew Morton wrote:
> > > Is dodgy wrt CPU hotplug, but there's not a lot we can do about that
> > > in this context, I expect.  Which is a shame, given that CPU hotplug
> > > is a likely time at which to be taking a crashdump ;)
> > 
> > If Hari disables preemption during this entire section of code,
> > he should be safe from CPU hotplug, AFAICS. The stop machine
> > threads will never get to run on that CPU.
> 
> This will work for CPU remove, not CPU add, since the later
> is not atomic (yet). 
> 
> Rusty, do you think it would be worthwhile making CPU add atomic?
> I can give it a shot :)

The whole section should be run with interrupts disabled,
so disabling preemption should be trivial.

Beyond this the code needs a bogomips based timeout, (we can't use external
time sources just the delay loop).  Any of the other cpu's could have
crashed at this point, or our accounting data structures could be
currupt.

Putting the initial call inside of machine_kexec is also bogus.
crash_machine_kexec needs to call crash_stop_cpus and then
machine_kexec.  machine_kexec is currently factored as a perfectly
reusable piece of code let's not mess that up.

Eric
