Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWARQ3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWARQ3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWARQ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:14232 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030380AbWARQ3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:29:49 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: Why is wmb() a no-op on x86_64?
Date: Wed, 18 Jan 2006 17:29:36 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <1137601417.4757.38.camel@serpentine.pathscale.com>
In-Reply-To: <1137601417.4757.38.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181729.36423.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 17:23, Bryan O'Sullivan wrote:
> Hi, Andi -
> 
> I notice that wmb() is a no-op 

Actually it is a compiler optimizer barrier, not a no-op.

> on x86_64 kernels unless 
> CONFIG_UNORDERED_IO is set. 

Because x86 is architecturally defined as having ordered writes (unless you use 
write combining or non temporal stores which normal kernel code doesn't). So it's 
not needed.

> Is there any particular reason for this? 
> It's not similarly conditional on other platforms, and as a consequence,
> in our driver (which requires a write barrier in some situations for
> correctness), I have to add the following piece of ugliness:
> 
> #if defined(CONFIG_X86_64) && !defined(CONFIG_UNORDERED_IO)
> #define ipath_wmb() asm volatile("sfence" ::: "memory")
> #else
> #define ipath_wmb() wmb()
> #endif

Hmm, I suppose one could add a wc_wmb() or somesuch, but WC 
is currently deeply architecture specific so I'm not sure
how you can even use it portably.

Why do you need the barrier?

-Andi
