Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWATKC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWATKC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWATKC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:02:57 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19835
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750775AbWATKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:02:56 -0500
Message-Id: <43D0C361.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 20 Jan 2006 11:02:57 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andy Whitcroft" <apw@shadowen.org>, "Andi Kleen" <ak@suse.de>
Cc: "Andreas Schwab" <schwab@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: warning: read-write constraint -- 2.6.15-git8 onwards
References: <43CE881A.1060403@shadowen.org> <200601190403.59205.ak@suse.de>
In-Reply-To: <200601190403.59205.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the official 3.4.x, 4.0.x, and the prerelease 4.1 sources I can't see such a warning, nor am I getting it
with 3.3.3 when building on SLES9 (which makes me assume unmodified 3.3.3 doesn't have this either). I thus wonder
whether the compiler used there has an extra, ill patch (after all there's generally nothing wrong for a read-write
constraint to only allow memory on x86). Jan

>>> Andi Kleen <ak@suse.de> 19.01.06 04:03:58 >>>
On Wednesday 18 January 2006 19:25, Andy Whitcroft wrote:
> It seems that the following commit causes a bunch of warnings out of
> most of the files in the kernel tree (see below for examples).  Backing
> this out seems to cure them?




> Compiled with:
> 
>     gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)
> 
> -apw
> 
>   CC      arch/x86_64/kernel/process.o
> include/asm/bitops.h: In function `default_idle':
> include/asm/bitops.h:65: warning: read-write constraint does not allow a
> register
> include/asm/bitops.h:65: warning: read-write constraint does not allow a
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a
> register
> include/asm/bitops.h:30: warning: read-write constraint does not allow a
> register

I only tested with gcc 4.0 and 4.1 prereleases where it worked just fine.

 __asm__ __volatile__( LOCK_PREFIX
                "btrl %1,%0"
                :"+m" (ADDR)
                :"dIr" (nr));

I tried to covert them from +m to explicit input/output
arguments ("=m" (ADDR) : "0" (ADDR)) to fix your compiler 
but with that I get the the same warning as you with 3.4 with 4.0.
Don't know how else it could be written. 

Ok one could just pass the address and do a full memory clobber, but 
that would be a overly large sledgehammer for the problem.

Jan or Andreas - do you have any suggestions how to fix this or should
we revert back to the old (technically wrong) state which was

    __asm__ __volatile__( LOCK_PREFIX
                "btrl %1,%0"
                :"=m" (ADDR)
                :"dIr" (nr));


Thanks,
-Andi


