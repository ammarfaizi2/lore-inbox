Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWDSLLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWDSLLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWDSLLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:11:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60884 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750844AbWDSLLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:11:24 -0400
Date: Wed, 19 Apr 2006 06:11:13 -0500
From: Robin Holt <holt@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Robin Holt <holt@sgi.com>, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ia64_do_page_fault shows 19.4% slowdown from notify_die.
Message-ID: <20060419111113.GA2718@lnx-holt.americas.sgi.com>
References: <20060417112552.GB4929@lnx-holt.americas.sgi.com> <9758.1145319832@ocs3.ocs.com.au> <20060418221623.GB22514@lnx-holt.americas.sgi.com> <p73r73u2yqc.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r73u2yqc.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 02:30:35AM +0200, Andi Kleen wrote:
> Robin Holt <holt@sgi.com> writes:
>  
> > 499 nSec/fault ia64_do_page_fault notify_die commented out.
> > 501 nSec/fault ia64_do_page_fault with nobody registered.
> > 533 nSec/fault notify_die in and just kprobes.
> > 596 nSec/fault notify_die in and kdb, kprobes, mca, and xpc loaded.
> > 
> 
> With kdb some slowdown is expected.

kdb does not register a die notifier.  It only does the notify_die
callouts.  Sorry for the confusion.  mca handler and xpc both register
notifiers and both have very early exits.

> 
> But just going through kprobes shouldn't be that slow. I guess
> there would be optimization potential there.
> 
> Do you have finer grained profiling what is actually slow?
> 
>  
> > Having the notify_page_fault() without anybody registered was only a
> > 0.4% slowdown.  I am not sure that justifies the optimize away, but I
> > would certainly not object.
> 
> Still sounds far too much for what is essentially a call + load + test + return
> Where is that overhead comming from?  I know IA64 doesn't like indirect
> calls, but there shouldn't any be there for this case.

I think each registered notifier is adding approx 32 nSec.  Actually,
the noise on these samples was about +-9nSec which I assumed was processor
stalls on cacheline load.

I think it looks like a lot of time when viewed as nSec, but when viewed
as a percentage of process run time, it is probably not that great of
an issue which is why it has been allowed to creep by for so long.

I can not think of an easy way to diagnose this slowdown any further.
I could run through this code on the simulator so you can see which
instructions actually got executed.  Would that be helpful?

Thanks,
Robin
