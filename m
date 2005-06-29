Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVF2QKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVF2QKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVF2QHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:07:30 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:16215 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261575AbVF2QG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:06:27 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 14/16] IB uverbs: add mthca user CQ support
X-Message-Flag: Warning: May contain useful information
References: <2005628163.XfYnZThlsTGb61Td@cisco.com>
	<2005628163.jWivrrVepuPgy40z@cisco.com>
	<20050628171046.6fa7de0d.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 29 Jun 2005 09:06:25 -0700
Message-ID: <52mzp9f8qm.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >> + int is_kernel;

    Andrew> I assume we have one body of code which is capable of
    Andrew> handling data structures in either kenrel memory of user
    Andrew> memory?  (guess).

    Andrew> If so, that's a fairly sensitive thing to be doing.  Tell
    Andrew> us more, please.

It's actually not that bad.  A completion queue (CQ) is a basically a
chunk of memory where completion information is written when a work
request completes.  The hardware can handle many CQs (64K is not an
unreasonable number), and we always do things like allocation of CQ
numbers, programming HW for CQ context, etc. in the kernel.

Both the kernel and userspace can do data path operations like looking
for a new CQ entry.  This means that for userspace CQs, the actual
memory where entries are written should be in userspace.  However the
struct mthca_cq will always be in the kernel.

If you look at how the is_kernel flag is used, you can see that all it
does is control whether we allocate/free the actual buffer and a few
other things in the kernel, or just use the stuff that userspace has
already allocated.

 - R.
