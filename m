Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVC3D47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVC3D47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVC3D47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:56:59 -0500
Received: from ozlabs.org ([203.10.76.45]:29614 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261372AbVC3DxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:53:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16970.9005.721117.942549@cargo.ozlabs.ibm.com>
Date: Wed, 30 Mar 2005 13:55:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: prefetch on ppc64
In-Reply-To: <20050330034034.GA1752@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050330034034.GA1752@IBM-BWN8ZTBWA01.austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn writes:

> While investigating the inordinate performance impact one of my patches
> seemed to be having, we tracked it down to two hlist_for_each_entry
> loops, and finally to the prefetch instruction in the loop.

I would be interested to know what results you get if you leave the
loops using hlist_for_each_entry but change prefetch() and prefetchw()
to do the dcbt or dcbtst instruction only if the address is non-zero,
like this:

static inline void prefetch(const void *x)
{
	if (x)
	        __asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
}

static inline void prefetchw(const void *x)
{
	if (x)
	        __asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
}

It seems that doing a prefetch on a NULL pointer, while it doesn't
cause a fault, does waste time looking for a translation of the zero
address.

Paul.
