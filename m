Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVCCGbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVCCGbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVCCGXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:23:13 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:17790 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261542AbVCCGT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:19:56 -0500
Message-ID: <42274727.2070200@yahoo.com.au>
Date: Fri, 04 Mar 2005 04:19:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "David S. Miller" <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>	 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>	 <20050302174507.7991af94.akpm@osdl.org>	 <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>	 <20050302185508.4cd2f618.akpm@osdl.org>	 <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>	 <20050302201425.2b994195.akpm@osdl.org>	 <16934.39386.686708.768378@cargo.ozlabs.ibm.com>	 <20050302213831.7e6449eb.davem@davemloft.net> <1109829248.5679.178.camel@gaston>
In-Reply-To: <1109829248.5679.178.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>However, if this pte_cmpxchg() thing is used for removing access, then
>>sparc64 can't use it.  In such a case a race in the TLB handler would
>>result in using an invalid PTE.  I could "spin" on some lock bit, but
>>there is no way I'm adding instructions to the carefully constructed
>>TLB miss handler assembler on sparc64 just for that :-)
>>
>
>Can't you add a lock bit in the PTE itself like we do on ppc64 hash
>refill ?
>
>

You don't want to do that for all architectures, as I said earlier.
eg. i386 can concurrently set the dirty bit with the MMU (which won't
honour the lock).

So you then need an atomic lock, atomic pte operations, and atomic
unlock where previously you had only the atomic pte operation. This is
disastrous for performance.


