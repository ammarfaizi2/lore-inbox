Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTJAQSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbTJAQSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:18:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:61574 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262347AbTJAQS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:18:29 -0400
Date: Wed, 1 Oct 2003 17:18:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001161805.GA4990@mail.shareable.org>
References: <20031001073132.GK1131@mail.shareable.org> <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain> <20031001093329.GA2649@mail.shareable.org> <20031001075151.4e595f99.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001075151.4e595f99.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I'm a bit confused as to what significance the faulting address has btw:
> kernel code can raise prefetch faults against addresses which are less
> than, and presumably greater than TASK_SIZE.

The address itself is not important.

What's important is that if a prefetch erratum fault happens while
mmap_sem or any spinlock are held, then do_page_fault must not try to
acquire mmap_sem.  That can deadlock or schedule; both are bad.

Checking the address is an easy way to ensure that: addr >= TASK_SIZE
implies that no vma lookup is needed, hence mmap_sem is not needed.

There is already an addr >= TASK_SIZE test, so this can be hooked in
without any penalty, in fact it will streamline the existing code a bit.

-- Jamie

