Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSLKK7A>; Wed, 11 Dec 2002 05:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSLKK7A>; Wed, 11 Dec 2002 05:59:00 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:12944 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267115AbSLKK66>;
	Wed, 11 Dec 2002 05:58:58 -0500
Date: Wed, 11 Dec 2002 16:51:53 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, ak@suse.de, cminyard@mvista.com,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021211165153.A17546@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Mon, Dec 09, 2002 at 10:08:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:08:11PM +0000, Stephen Hemminger wrote:
> This is a successor to the previous patch for notifier callback when NMI
> watchdog occurs.  It is a port of x86_64 code (thanks for the suggestion
> Andi Kleen <ak@suse.de>) with extensions for watchdog, and integration
> of panic handling.  
> 
> To get notified for panic, oops, NMI and other events the caller needs
> to insert itself in the notify_die chain.  The callback can then filter
> out which events are of interest. 
> 
> This started out as a way to hook in LKCD, but it is general enough that
> kprobe, kdb, and other utilities can use it as well. 
> 
I support this, it makes all kernel-space debug tools less intrusive. 
It may be out of scope for this work but there are a couple of
other issues to consider here:

- turn trap1/trap3 to interrupt gates: kprobes does this, kgdb turns
  off interrupts in its own handler, I suppose other tools too need
  this.
- notifier lists are racy on SMP, IFAICT, read_lock(&notifier_lock)
  needs to be taken in notifier_call_chain(), but that too is 
  deadlock prone.

Andi,

Isn't this a problem on x86_64 too? What is there to prevent a
handler from being removed from the notifier list while it
is being used to call the handler on another CPU?

I am considering using a RCU-based list for notifier chains.
Corey has done some work on these lines to add NMI notifier
chain, I think it should be generalised on for all notifiers.

Thoughts? Comments?
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
