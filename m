Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWGNBeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWGNBeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 21:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWGNBeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 21:34:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161168AbWGNBeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 21:34:06 -0400
Date: Thu, 13 Jul 2006 18:30:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: rdreier@cisco.com, arjan@infradead.org, mingo@elte.hu,
       zach.brown@oracle.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
Message-Id: <20060713183047.642bd9e6.akpm@osdl.org>
In-Reply-To: <20060713181835.ad5eeff6.akpm@osdl.org>
References: <44B405C8.4040706@oracle.com>
	<adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com>
	<adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu>
	<adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org>
	<adau05ltsso.fsf@cisco.com>
	<20060713135446.5e2c6dd5.akpm@osdl.org>
	<adau05lrzdy.fsf@cisco.com>
	<20060713144341.97d4f771.akpm@osdl.org>
	<adazmfdq9ha.fsf@cisco.com>
	<20060713181835.ad5eeff6.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 18:18:35 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > Having the caller hold a chunk of memory in a stack variable was the
> > trick I came up with to get around that.
> 
> Yes, that certainly works.


Problem is, I think, you'll need to preallocate IDR_FREE_MAX items.  And
then free them all again when none of them were consumed (usual).

Yes, storing the preallocated nodes in the idr itself requires locking. 
But that locking is 100% private to the IDR implementation.  It locks only
the preload list and not the user's stuff.

radix_tree_preload() effectively does this.  Except the preload list is
kernel-wide.  It's split across CPUs and uses
local_irq_disable/preempt_disable locking tricks as a performance
optimisation.  But conceptually it's the same.

Simply copying that would give something which is known to work...  It
seems like a large amount of fuss, but when you think about it the problem
isn't simple.
