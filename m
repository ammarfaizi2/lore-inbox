Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754768AbWKMO36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbWKMO36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbWKMO36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:29:58 -0500
Received: from cantor.suse.de ([195.135.220.2]:24291 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754768AbWKMO35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:29:57 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Date: Mon, 13 Nov 2006 15:29:46 +0100
User-Agent: KMail/1.9.5
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
References: <20061111151414.GA32507@elte.hu> <200611131008.37810.ak@suse.de> <20061113140520.GA8111@elte.hu>
In-Reply-To: <20061113140520.GA8111@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131529.46464.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Secondly, in the physical case, /all/ IPI sending goes through this 
> code:
> 
>         for_each_cpu_mask(query_cpu, mask) {
> 
> yes, even the single-IPI calls which give the overwhelming majority of 
> the use of IPIs. Even on systems that have only 2 CPUs to begin with. 
> This should be measurable.

I thought so too originally, but it wasn't. My original thinking
was that logical must be faster because it can in theory send less messages
on large systems.

On the two CPU case it is basically always the same anyways because
the loop is very cheap compared to the IPIs (IPIs tend to be thousands
of cycles). for_each_cpu_mask is essentially just BSF with some glue.

For the > 2 CPU case it is not that obvious -- in theory the hardware
could optimize it to be more efficient, but it doesn't seem to. Or at least
not in a good enough way to show significant differences.

> you are still not getting it i think. The IO-APIC is still in logical 
> delivery mode on small systems, 

The IO-APIC delivery mode that is configured comes from genapic, and should be 
physical for physflat unless I'm totally confused about the code.

> the right solution is to use pure physical mode (both local APIC and 
> IO-APIC) only on large systems, and to use pure logical mode on small 
> systems - maybe with the combination of clustered mode as well.

I disagree.  I think we should just use physical mode everywhere,
except on the old i386 systems.
 
> as i said it before, what you are suggesting is not a 'fix', it's a 
> workaround for a design flaw in the hotplug code which flaw is hitting 
> us in other places and architectures anyway, and which workaround makes 
> us use an inferior IRQ delivery method on small systems ...

It isn't inferior as far as I know.

-Andi
