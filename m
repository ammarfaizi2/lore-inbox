Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVHAMZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVHAMZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVHAMZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:25:14 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:25754 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261633AbVHAMZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:25:06 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
References: <20050729161343.A18249@flint.arm.linux.org.uk>
	<20050730.124052.104057695.davem@davemloft.net>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 01 Aug 2005 13:24:04 +0100
Message-ID: <tnxzms1c0bf.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Aug 2005 12:24:39.0784 (UTC) FILETIME=[FCEF7E80:01C59693]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Fri, 29 Jul 2005 16:13:43 +0100
>
>> My current patch to get this working is below.  The only thing which
>> really seems to fix the issue is the __flush_dcache_page call in
>> read_pages() - if I remove this, I get spurious segfaults and illegal
>> instruction faults.
>
> If one cpu stores, does it get picked up in the other cpu's I-cache?

It only gets picked up by the other CPU's D-cache (which is fully
coherent between cores). The I-cache needs to be invalidated on each
CPU.

> If not, you cannot use the lazy dcache flushing method, and in fact
> you must broadcast the flush on all processors.

Why wouldn't the lazy dcache flushing method work? My understanding is
that if there is no user mapping for a given page, there's no reason
to flush the dcache and just postpone it until the page is faulted
in. When the page fault occurs the dcache should be flushed (on one
CPU is enough) and the icache invalidated on all the CPUs.

-- 
Catalin

