Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWCVIhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWCVIhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCVIhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:37:12 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:60681 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751100AbWCVIhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:37:03 -0500
Message-ID: <44210C4B.7050307@vmware.com>
Date: Wed, 22 Mar 2006 00:35:23 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [Xen-devel] [RFC PATCH 14/35] subarch modify CPU capabilities
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063751.151430000@sorel.sous-sol.org>
In-Reply-To: <20060322063751.151430000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
>  
> +void __devinit machine_specific_modify_cpu_capabilities(struct cpuinfo_x86 *c)
> +{
> +	clear_bit(X86_FEATURE_VME, c->x86_capability);
> +	clear_bit(X86_FEATURE_DE, c->x86_capability);
> +	clear_bit(X86_FEATURE_PSE, c->x86_capability);
> +	clear_bit(X86_FEATURE_PGE, c->x86_capability);
> +	clear_bit(X86_FEATURE_SEP, c->x86_capability);
> +	clear_bit(X86_FEATURE_MWAIT, c->x86_capability);
> +	if (!(xen_start_info->flags & SIF_PRIVILEGED))
> +		clear_bit(X86_FEATURE_MTRR, c->x86_capability);
> +	c->hlt_works_ok = 0;
>   

That's pretty heinous.  Suppose Xen decides to start supporting any of 
these features.  Now, you need to change all of the Xen modified kernels 
to remove pieces of this.

You've effectively introduced completely arbitrary, but most 
importantly, static constraints into Linux based on what features Xen 
currently supports.  This is not productive on either end.

This is the entire point of the VMI interface.  You can arbitrarily 
enable and disable these features in a hidden layer, call it VMI, call 
it Xen-bridge, call it hypercall page, whatever.   Using this layer, you 
can automatically abstract away exactly this type of nasty, deliberately 
deprecating extraneous code.  We use this feature exactly to strip away 
these bits, completely hidden from the guest, by "trapping" the CPUID 
instruction in the VMI layer.  The VMI interface as it stands today is 
unimportant - it has and will continue to change to accommodate Xen.  
But the principles of it are important for maintainability, flexibility, 
and future compatibility.  One of these principles is to avoid 
unbalanced changes like this to the guest kernel.

And we certainly support VME, DE, PSE, PGE, and SEP features, and really 
would not like them disabled unconditionally in a virtual environment.

Zach
