Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWIMSvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWIMSvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWIMSvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:51:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751093AbWIMSvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:51:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45084833.4040602@yahoo.com.au> 
References: <45084833.4040602@yahoo.com.au>  <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 13 Sep 2006 19:50:55 +0100
Message-ID: <22461.1158173455@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> +	while ((tmp = atomic_read(&sem->count)) >= 0) {
> +		if (tmp == atomic_cmpxchg(&sem->count, tmp,
> +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {

NAK for FRV.  Do not use atomic_cmpxchg() there as it isn't strictly atomic
(FRV only has one strictly atomic operation: SWAP).  Please leave FRV as using
the spinlock version which is more efficient on UP.

Please also show benchmarks to show the performance difference between your
version and the old version before Ingo messed it up and made everything
unconditionally out of line without cleaning the inline asm up.

If you are going to generalise, you should get rid of everything barring the
spinlock-based version and stick with that.  It will cost you performance
under some circumstances, but it's better under others than attempting to use
atomic_cmpxchg() which may not really exist on all archs.

You've also caused another problem: the spinlock based version permits up to
2^31 - 1 readers at one time, the inline optimised version, on a 32-bit arch,
will only permit up to 2^16 - 1 at most.  By doing this to x86_64, you've
reduced the number of processes it can support.

David
