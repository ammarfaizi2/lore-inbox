Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVAQIBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVAQIBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVAQIBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:01:01 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:21917 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261445AbVAQIAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:00:30 -0500
Date: Mon, 17 Jan 2005 00:00:22 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, mingo@elte.hu,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050117080022.GA4282@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org> <20050117073345.GA3616@taniwha.stupidest.org> <16875.28257.239324.486966@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16875.28257.239324.486966@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 06:50:57PM +1100, Paul Mackerras wrote:

> AFAICS on i386 the lock word, although it goes to 0 when write-locked,
> can then go negative temporarily when another cpu tries to get a read
> or write lock.  So I think this should be
> 
> ((signed int)(x)->lock <= 0)

I think you're right, objdump -d shows[1] _write_lock looks
something like:

      lock subl $0x1000000,(%ebx)
      sete   %al
      test   %al,%al
      jne    out;
      lock addl $0x1000000,(%ebx)
  out:

so I guess it 2+ CPUs grab a write-lock at once it would indeed be
less than zero (the initial value is RW_LOCK_BIAS which is 0x1000000
in this case).

> (or the equivalent using atomic_read).

on x86 aligned-reads will be always be atomic AFAIK?


[1] Yes, I'm stupid, trying to grok the twisty-turny-maze of headers
    and what not made my head hurt and objdump -d seemed easier.

