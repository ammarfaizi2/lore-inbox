Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUI0PMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUI0PMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUI0PMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:12:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266304AbUI0PKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:10:13 -0400
Date: Mon, 27 Sep 2004 10:25:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjanv@redhat.com, ak@suse.de,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Message-ID: <20040927132527.GC30956@logos.cnet>
References: <7F740D512C7C1046AB53446D3720017302495C07@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017302495C07@scsmsx402.amr.corp.intel.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 05:48:18PM -0700, Nakajima, Jun wrote:
> >From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> >Sent: Thursday, September 23, 2004 3:32 PM
> >To: Nakajima, Jun
> >Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; arjanv@redhat.com;
> >ak@suse.de; Saxena, Sunil; Mallick, Asit K
> >Subject: Re: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to
> fit
> >32byte cacheline]
> >
> 
> <snip>
> 
> >> >***********
> >> >
> >> >Jun,
> >> >
> >> >We need some assistance here - you can probably help us.
> >> >
> >> >Within the Linux kernel we can benefit from changing some fields
> >> >of commonly accessed data structures to 16 bit instead of 32 bits,
> >> >given that the values for these fields never reach 2 ^ 16.
> >> >
> >> >Arjan warned me, however, that the prefix (in this case "data16")
> will
> >> >cause an additional extra cycle in instruction decoding, per message
> >> above.
> >>
> >> On the Pentium4 core, this is not a big deal because it runs out of
> the
> >> trace cache (i.e. decoded in advance). However, on the Pentium III/M
> >> (aka P6) core (i.e. Penitum III, Banias, Dothan, Yonah, etc.),
> >> especially when an operand size prefix (0x66) changes the # of bytes
> in
> >> an instruction (usually by impacting the size of an immediate in the
> >> instruction), the P6 core pays unnegligible penalty, slowing down
> >> decoding.
> >
> >Jun,
> >
> >What you mean by "unnegligible penalty" ?
> >
> >You mean its very small penalty (unconsiderable), or its considerable
> >penalty?
> 
> I mean it's considerable. Did you look at what kinds of instructions are
> used for accessing such data structures? Does the operand size prefix
> change the # of bytes in those instructions (as described above) for
> most cases? If it does, we don't recommend such codes.

Yep, it does change the size the operand size. 

Its mostly moving from the memory position into register for
comparison, and moving back to the memory position.

The hottest path (free_hot_cold_page) changes from 


    105d:       8b 42 08                mov    0x8(%edx),%eax
    1086:       ff 83 dc 00 00 00       incl   0xdc(%ebx)

    10a6:       8b 42 0c                mov    0xc(%edx),%eax


to

    1087:       0f b7 83 dc 00 00 00    movzwl 0xdc(%ebx),%eax
    108e:       40                      inc    %eax
    108f:       66 89 83 dc 00 00 00    mov    %ax,0xdc(%ebx)

    10c4:       0f b7 93 dc 00 00 00    movzwl 0xdc(%ebx),%edx



