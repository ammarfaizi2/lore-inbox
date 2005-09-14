Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbVINPRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbVINPRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbVINPRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:17:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12302 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965232AbVINPRK (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 11:17:10 -0400
Date: Wed, 14 Sep 2005 16:17:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 1/5] atomic: introduce atomic_cmpxchg
Message-ID: <20050914161700.A30746@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Dipankar Sarma <dipankar@in.ibm.com>
References: <43283825.7070309@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43283825.7070309@yahoo.com.au>; from nickpiggin@yahoo.com.au on Thu, Sep 15, 2005 at 12:48:05AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 12:48:05AM +1000, Nick Piggin wrote:
> This patch still needs work on arm (v6) and m32r. I would
> just be shooting in the dark if I attempted either myself.

ARMv6, something like:

int atomic_cmpxchg(atomic_t *ptr, int old, int new)
{
	u32 oldval, res;

	do {
		asm(
		"ldrex	%1, [%2]\n\t"
		"teq	%1, %3\n\t"
		"strexeq %0, %4, [%2]\n\t"
		    : "=&r" (res), "=&r" (oldval)
		    : "r" (&ptr->counter), "r" (old), "r" (new)
		    : "cc");
	} while (res);

	return oldval;
}

should do what you require.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
