Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUFNU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUFNU27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUFNU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:28:59 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:34106 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263875AbUFNU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:28:57 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, anton@au.ibm.com,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ppc64 out_be64
References: <521xkk77xh.fsf@topspin.com> <1087141822.8210.176.camel@gaston>
	<52llir5rr2.fsf@topspin.com> <1087146682.8697.184.camel@gaston>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 14 Jun 2004 13:26:28 -0700
In-Reply-To: <1087146682.8697.184.camel@gaston>
Message-ID: <52wu2928ej.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Jun 2004 20:26:29.0115 (UTC) FILETIME=[DFA294B0:01C4524D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> Well, I may know ppc asm, but gcc inline asm still
    Benjamin> drives me nuts :)

Speaking of gcc asm, is there a reason why out_le64 (specifically the
constraints) isn't written in this (simpler) way?  It seems to me we
can just let val be an input, as long as the "&" constraint for tmp
makes sure it doesn't share the same register.  This seems to generate
the same code for me as the current kernel version, at least with gcc
3.4.0/binutils 2.15.

	static inline void out_le64(volatile unsigned long *addr, unsigned long val)
	{
		unsigned long tmp;
	
		__asm__ __volatile__(
				     "rldimi %0,%2,5*8,1*8\n"
				     "rldimi %0,%2,3*8,2*8\n"
				     "rldimi %0,%2,1*8,3*8\n"
				     "rldimi %0,%2,7*8,4*8\n"
				     "rldicl %2,%2,32,0\n"
				     "rlwimi %0,%2,8,8,31\n"
				     "rlwimi %0,%2,24,16,23\n"
				     "std %0,%1\n"
				     "sync"
				     : "=&r" (tmp), "=m" (*addr) : "r" (val));
	}
