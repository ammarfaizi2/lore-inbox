Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVISSWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVISSWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVISSWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:22:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23942 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932553AbVISSWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:22:23 -0400
Date: Mon, 19 Sep 2005 11:22:04 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Rusty Lynch <rusty@linux.intel.com>, Andi Kleen <ak@suse.de>,
       Rusty Lynch <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if
 KPROBES is configured.
In-Reply-To: <20050830111830.GI26314@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0509191119020.25963@schroedinger.engr.sgi.com>
References: <200508262246.j7QMkEoT013490@linux.jf.intel.com>
 <Pine.LNX.4.62.0508261559450.17433@schroedinger.engr.sgi.com>
 <200508270224.26423.ak@suse.de> <20050830001905.GA18279@linux.jf.intel.com>
 <20050830111830.GI26314@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Matthew Wilcox wrote:

> On Mon, Aug 29, 2005 at 05:19:05PM -0700, Rusty Lynch wrote:
> > So, assuming inlining the notifier_call_chain would address Christoph's
> > conserns, is the following patch something like what you are sugesting?  
> > This would make all the kdebug.h::notify_die() calls use the inline version. 
> 
> I think we need something more like this ...
> 
> include/linux/notifier.h:
> +static inline int notifier_call_chain(struct notifier_block **n,
> +					unsigned long val, void *v)
> +{
> +	if (n)
> +		return __notifier_call_chain(n, val, v);
> +	return NOTIFY_DONE;
> +}
> kernel/sys.c:
> -int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
> +int __notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
> -EXPORT_SYMBOL(notifier_call_chain);
> +EXPORT_SYMBOL(__notifier_call_chain);
> 
> That way everyone gets both the quick test and the global size reduction.

And then do

#ifndef CONFIG_KPROBES

#define ia64die_chain 0

#endif

in include/asm-ia64/kdebug.h?

Otherwise we still check a notifier chain that cannot ever be 
activated.

But then the patch is essentially the same as the last one I proposed.

