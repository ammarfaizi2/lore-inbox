Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWGMBeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWGMBeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWGMBeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:34:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932487AbWGMBeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:34:17 -0400
Date: Wed, 12 Jul 2006 18:30:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
Message-Id: <20060712183049.bcb6c404.akpm@osdl.org>
In-Reply-To: <adaveq2v9gn.fsf@cisco.com>
References: <44B405C8.4040706@oracle.com>
	<adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com>
	<adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu>
	<adaveq2v9gn.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 13:45:12 -0700
Roland Dreier <rdreier@cisco.com> wrote:

> Currently, the code in lib/idr.c uses a bare spin_lock(&idp->lock) to
> do internal locking.  This is a nasty trap for code that might call
> idr functions from different contexts; for example, it seems perfectly
> reasonable to call idr_get_new() from process context and idr_remove()
> from interrupt context -- but with the current locking this would lead
> to a potential deadlock.
> 
> The simplest fix for this is to just convert the idr locking to use
> spin_lock_irqsave().
> 
> In particular, this fixes a very complicated locking issue detected by
> lockdep, involving the ib_ipoib driver's priv->lock and dev->_xmit_lock,
> which get involved with the ib_sa module's query_idr.lock.

Sigh.  It was always a mistake (of the kernel programming 101 type) to put
any locking at all in the idr code.  At some stage we need to weed it all
out and move it to callers.

Your fix is yet more fallout from that mistake.
