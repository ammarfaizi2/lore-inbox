Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVCDBeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVCDBeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVCDAwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:52:45 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:51974 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262750AbVCDAvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:51:01 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][16/26] IB/mthca: mem-free doorbell record writing
X-Message-Flag: Warning: May contain useful information
References: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>
	<4227A606.50703@pobox.com> <52vf88ntbo.fsf@topspin.com>
	<4227AEA2.8060007@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 16:50:59 -0800
In-Reply-To: <4227AEA2.8060007@pobox.com> (Jeff Garzik's message of "Thu, 03
 Mar 2005 19:41:06 -0500")
Message-ID: <52bra0nsi4.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 00:50:59.0507 (UTC) FILETIME=[3B5AB830:01C52054]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> Well, we don't just add code to "hope and pray" for an event
    Jeff> that nobody is sure can even occur...

The hardware requires that if the record is written in two 32-bit
chunks, then they must be written in order.  Of course the hardware
probably won't be reading just as we're writing, so almost all of the
time we won't notice the problem.

It feels more like "hope and pray" to me to leave the barrier out and
assume that every possible implementation of every architecture will
always write them in order.

    Jeff> Does someone have a concrete case where this could happen? ever?

I don't see how you can rule it out on out-of-order architectures.  If
the second word becomes ready before the first, then the CPU may
execute the second write before the first.

It's not precisely the same situation, but if you look at mthca_eq.c
you'll see an rmb() in mthca_eq_int().  That's there because on ppc64,
I really saw a situation where code like:

	while (foo->x) {
		switch (foo->y) {

was behaving as if foo->y was being read before foo->x.  Even though
both foo->x and foo->y are in the same cache line, and foo->x was
written by the hardware after foo->y.

 - R.
