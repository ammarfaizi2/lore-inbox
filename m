Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWASDEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWASDEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWASDEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:04:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:44195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161183AbWASDEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:04:20 -0500
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: warning: read-write constraint -- 2.6.15-git8 onwards
Date: Thu, 19 Jan 2006 04:03:58 +0100
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jbeulich@novell.com, schwab@suse.de
References: <43CE881A.1060403@shadowen.org>
In-Reply-To: <43CE881A.1060403@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190403.59205.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


