Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWEJXoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWEJXoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWEJXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:44:39 -0400
Received: from ozlabs.org ([203.10.76.45]:47768 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965084AbWEJXoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:44:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.31456.68099.57515@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 09:44:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Richard Henderson <rth@twiddle.net>, t@twiddle.net,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org, amodra@bigpond.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <17506.29128.591758.502430@cargo.ozlabs.ibm.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<17506.29128.591758.502430@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> Hmmm...  Would it be sufficient to use a RELOC_HIDE in __get_cpu_var,
> like this?
> 
> #define __get_cpu_var(x)	(*(RELOC_HIDE(&per_cpu__##x, 0)))

But that won't work because the compiler can still cache &per_cpu__x.
I guess I have to do this:

#define __get_cpu_var(var, cpu)					\
	(*(__typeof__(&per_cpu__##var))({			\
		void *__ptr;					\
		asm("addi %0,13,per_cpu__"#var"@tprel"		\
		    : "=r" (__ptr));				\
		__ptr;						\
	}))

That means we lose the possible optimization of combining the addi
into a following load or store.  Bah.  However, I guess it's still
better than what we do at the moment.

Paul.
