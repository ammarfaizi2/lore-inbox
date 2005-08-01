Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVHASkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVHASkD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVHASj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:39:59 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47615 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261185AbVHASif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:38:35 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
References: <20050729161343.A18249@flint.arm.linux.org.uk>
	<20050730.124052.104057695.davem@davemloft.net>
	<tnxzms1c0bf.fsf@arm.com>
	<20050801174030.C14401@flint.arm.linux.org.uk>
	<tnxzms1a986.fsf@arm.com>
	<20050801180119.E14401@flint.arm.linux.org.uk>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 01 Aug 2005 19:37:29 +0100
In-Reply-To: <20050801180119.E14401@flint.arm.linux.org.uk> (Russell King's
 message of "Mon, 1 Aug 2005 18:01:20 +0100")
Message-ID: <tnxmzo1ld06.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Aug 2005 18:38:00.0534 (UTC) FILETIME=[24D2AF60:01C596C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Aug 01, 2005 at 05:54:33PM +0100, Catalin Marinas wrote:
>> I haven't checked the original patch but it might work (by luck)
>> without the I-cache invalidation (and without stressing it too
>> much). This is because you might do a full mm flush when a process
>> exits and the I-cache would be clean for newly allocated pages (only
>> the D-cache needs flushing). If you don't overload memory, you don't
>> get pages swapped-out/removed and the code in a page for a given
>> process might remain unchanged until the process exits.
>
> Given that it's sometimes going wrong as early as the first process, I
> doubt this is what's happening.  The i-cache will be clean at this point
> for the userspace programs.

The I-cache might not be completely clean when executing the first
process since the kernel already ran code from the .init.text section
which is freed.

Anyway, the problem you are seeing, apart from the I-cache flushing,
looks to me like being caused by not flushing the D-cache on the CPU
that actually wrote the page (not the one handling the page
fault). That's why flushing immediately (not lazily) seems to work.

-- 
Catalin

