Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWE3GYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWE3GYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWE3GYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:24:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18840 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932160AbWE3GYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:24:31 -0400
Date: Tue, 30 May 2006 08:24:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc vdso updates
Message-ID: <20060530062447.GD19870@elte.hu>
References: <1148961097.15722.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148961097.15722.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch cleans up some locking & error handling in the ppc vdso and 
> moves the vdso base pointer from the thread struct to the mm context 
> where it more logically belongs. It brings the powerpc implementation 
> closer to Ingo's new x86 one and also adds an arch_vma_name() function 
> allowing to print [vsdo] in /proc/<pid>/maps if Ingo's x86 vdso patch 
> is also applied.

looks good to me.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Ingo Molnar <mingo@elte.hu>

> This is 2.6.18 material, hopefully should go along with Ingo's x86 
> vdso updates. Ingo, if you change something to arch_vma_name(), please 
> let me know.

ok. There's one bit that could potentially be 2.6.17 material:

>  	 * at vdso_base which is the "natural" base for it, but we might fail
>  	 * and end up putting it elsewhere.
>  	 */
> +	down_write(&mm->mmap_sem);
>  	vdso_base = get_unmapped_area(NULL, vdso_base,
>  				      vdso_pages << PAGE_SHIFT, 0, 0);

get_unmapped_area() without holding the mmap semaphore seems dangerous. 
The VDSO setup itself should be 'private' to the process, but i'm not 
totally sure that no other kernel code could get access to this mm. For 
example the swapout code? Am i missing something?

	Ingo
