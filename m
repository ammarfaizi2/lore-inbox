Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWHGGC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWHGGC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHGGC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:02:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33175 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751097AbWHGGC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:02:56 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 08:02:40 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de> <44D6D315.2030907@goop.org>
In-Reply-To: <44D6D315.2030907@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070802.40614.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 07:43, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> +/* Stop speculative execution */
> >> +static inline void sync_core(void)
> >> +{
> >> +	unsigned int eax = 1, ebx, ecx, edx;
> >> +	__cpuid(&eax, &ebx, &ecx, &edx);
> >> +}
> >>     
> >
> > Actually I don't think this one should be para virtualized at all.
> > I don't see any reason at all why a hypervisor should trap it and it
> > is very time critical. I would recommend you move it back into the 
> > normal files without hooks.
> >   
> 
> When VT/AMDV is enabled, cpuid could cause a vm exit,

They will learn to add a filter at some point I guess (at least on SVM
because it's not patched out on AMD)


> so it would be  
> nice to use one of the other serializing instructions in this case.

You would first need to find one that works in ring 3. On x86-64 it is 
used in the gettimeoday vsyscall in ring 3 to synchronize the TSC and 
afaik John was about to implement that for i386 too.

BTW another issue that I haven't checked but we will need to make
this also an alternative() for another case - it is faily important
to patch it out on Intel systems with a synchronized TSC where it is
fairly expensive. That is also not done yet on i386, but will be 
likely once vsyscall gettimeofday is implemented.

So basically you would need double patching. Ugly.

I would recommend to keep it out of para ops.

-Andi
