Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUEJBfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUEJBfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 21:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUEJBfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 21:35:25 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26513 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261426AbUEJBfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 21:35:15 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Un-inline spinlocks on ppc64 
In-reply-to: Your message of "Mon, 10 May 2004 10:11:33 +1000."
             <16542.51381.215308.485006@cargo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 May 2004 11:34:42 +1000
Message-ID: <2515.1084152882@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 10:11:33 +1000, 
Paul Mackerras <paulus@samba.org> wrote:
>The one problem with out-of-line spinlock routines is that lock
>contention will show up in profiles in the spin_lock etc. routines
>rather than in the callers, as it does with inline spinlocks.  I have
>added a CONFIG_INLINE_SPINLOCKS config option for people that want to
>do profiling.  In the longer term, Anton is talking about teaching the
>profiling code to attribute samples in the spin lock routines to the
>routine's caller.

If it is any help, SGI patched the ia64 perfmon code to cope with a 2.4
version of the out of line spinlock patch.  The ia64 code uses a
non-standard calling sequence to work around a bug in gcc prior to 3.4,
r28 is the return address for the out of line code.

pfm_record_sample()
{
	...
#ifdef CONFIG_SMP
        extern char ia64_spinlock_contention[], ia64_spinlock_contention_end[];
#endif
	...
        h->ip   = regs ? regs->cr_iip | ((regs->cr_ipsr >> 41) & 0x3): 0x0UL;
#ifdef CONFIG_SMP
        if (h->ip >= (unsigned long)ia64_spinlock_contention &&
                        h->ip < (unsigned long)ia64_spinlock_contention_end)
                h->ip = regs->r28;
#endif
	...
}

