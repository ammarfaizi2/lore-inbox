Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUDMQl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUDMQl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:41:27 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:49156 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S263544AbUDMQlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:41:15 -0400
Date: Tue, 13 Apr 2004 11:40:02 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: PAT support
Message-ID: <20040413164002.GB453@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <407B7BDE.5030002@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407B7BDE.5030002@colorfullife.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23 
X-OriginalArrivalTime: 13 Apr 2004 16:41:04.0065 (UTC) FILETIME=[1C773B10:01C42176]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oh, good catch. we added comments detailing this to an internal evaluation stand-alone pat module for pci express testing (the same pat.c/pat.h files as a standalone module), and I forgot to propogate those comments to this patch.

here's a snippet of our comments:

/* Here is the PAT's default layout on ia32 cpus at boot/reset.
 * This is table 10-12 in the IA-32 Intel Architecture Software Developer's
 * Manual Volume 3: System Programming Guide.
 * PAT0: Write Back
 * PAT1: Write Through
 * PAT2: Uncached (/ Uncacheable on Athlon cpus)
 * PAT3: Uncacheable
 * PAT4: Write Back
 * PAT5: Write Through
 * PAT6: Uncached (/ Uncacheable on Athlon cpus)
 * PAT7: Uncacheable
 * 
 * Rather than mucking with the PAT entries too much, we'll only replace one
 * entry with Write Combining. Ideally, we'd do that to one of the latter 4
 * entries, but due to errata in the P3/P4 cpus, we can only use the first
 * four entries reliably.
 *
 * For that reason, we'll replace PAT1: Write Through with Write Combine.
 * 
 * For more details about these errata, see Intel Pentium III Processor
 * Specification Update, errata E.27 (Upper Four PAT Entries Not Usable With
 * Mode B or Mode C Paging) and Intel Pentium IV Processor Specification
 * Update, errata N46 (PAT Index MSB May Be Calculated Incorrectly)
 */

rather than reprogramming all of the pats (compare the above table to the below table), we only replaced one entry with write-combining. I could just update cachemap with the corrected comments, or go ahead and only update the one pat entry, whichever everyone prefers.

Thanks,
Terence

On Mon, Apr 12, 2004 at 10:34:22PM -0700, manfred@colorfullife.com wrote:
> Hi Terence,
> 
> in your patch, you write
> +/* Here is the PAT's default layout on ia32 cpus when we are done.
> + * PAT0: Write Back
> + * PAT1: Write Combine
> + * PAT2: Uncached
> + * PAT3: Uncacheable
> + * PAT4: Write Through
> + * PAT5: Write Protect
> + * PAT6: Uncached
> + * PAT7: Uncacheable
> 
> Is that layout possible?
> There is an errata in the B2 and C1 stepping of the Pentium 4 cpus that 
> results in incorrect PAT numbers: the highest bit is ignored by the CPU 
> under some circumstances. There's a similar errata (E27) that affects 
> all Pentium 3 cpus: The highest bit is always ignored.
> I think we need a fallback to 4 PAT entries.
> 
> --
>     Manfred
> 
