Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTEZWdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTEZW0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:26:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17683 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262273AbTEZWGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:06:32 -0400
Date: Mon, 26 May 2003 23:19:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Lothar Wassmann <LW@KARO-electronics.de>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030526231938.A29288@flint.arm.linux.org.uk>
Mail-Followup-To: Lothar Wassmann <LW@KARO-electronics.de>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <20030523175413.A4584@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain> <20030523112926.7c864263.akpm@digeo.com> <20030523193458.B4584@flint.arm.linux.org.uk> <1053919171.14018.2.camel@rth.ninka.net> <20030526095551.C4417@flint.arm.linux.org.uk> <16082.4540.943674.698305@ipc1.karo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16082.4540.943674.698305@ipc1.karo>; from LW@KARO-electronics.de on Mon, May 26, 2003 at 03:08:12PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 03:08:12PM +0200, Lothar Wassmann wrote:
> No, its still there. But I seem to be unable to turn writealloc ON
> anyway. I get:

Ok, this gets worrying since I haven't heard of the problem occuring
with our write back caches before, neither can I reproduce it here.
It also completely knocks out my reasoning for it occuring.

> |CPU: XScale-PXA250 [69052904] revision 4 (ARMv5TE)
> |CPU: D undefined 5 cache
> |CPU: I cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
> |CPU: D cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
> |Machine: KARO electronics PXA25x module
> |Memory policy: ECC disabled, Data cache write back
> no matter whether I specify 'cachepolicy=writeback', '...writealloc'
> or no cachepolicy at all.
> (This is because ARMv5TE is not recognized as an ARMv5 architecture and
>  PMD_SECT_WBWA is turned into PMD_SECT_WB in build_mem_type_table()
>  ('arch/arm/mm/mm-armv.c' line 304).
>  Another bug?)
> Shouldn't it be:
> @@ -295,12 +295,13 @@
>  	/*
>  	 * ARMv5 can use ECC memory.
>  	 */
> -	if (cpu_arch == CPU_ARCH_ARMv5) {
> +	if (cpu_arch == CPU_ARCH_ARMv5 || cpu_arch == CPU_ARCH_ARMv5T ||
> +		cpu_arch == CPU_ARCH_ARMv5TE) {

No - it should be cpu_arch >= CPU_ARCH_ARMv5.  I seem to have been over-
zealous about removing some currently unreleasable stuff here.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

