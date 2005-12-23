Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030598AbVLWTTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbVLWTTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 14:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbVLWTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 14:19:38 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51931
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030598AbVLWTTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 14:19:37 -0500
Date: Fri, 23 Dec 2005 11:19:40 -0800 (PST)
Message-Id: <20051223.111940.17674086.davem@davemloft.net>
To: michael.bishop@APPIQ.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
References: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Bishop" <michael.bishop@APPIQ.com>
Date: Fri, 23 Dec 2005 11:23:36 -0500

> Bad pte = 1fa00600a88, process = X, vm_flags = 184473, vaddr = 7001e000
> Call Trace:

Strange, I thought we'd fixed this.

Aww crap....

Linus, X.org is doing a MAP_PRIVATE mmap() of these discontiguous
I/O mappings of the sparc frame buffer device it seems.  So the
MAP_SHARED check in is_cow_mapping() doesn't pass.

Michael, does X.org work properly with your FFB card with 2.6.14 by
chance?

I really haven't used X.org on anything other than an ATI Radeon on
Sparc boxes, so it's highly possible that SunFFB support in X.org has
deteriorated into a non-working state due to not being looked after by
anyone.

Back to the MAP_SHARED issue, the culprit code in X.org can be fixed
but I know that this thing has been coded this way for years.  It
goes like this (hw/xfree86/os-support/bus/Sbus.c:xf86MapSbusMem()):

    ret = (pointer) mmap (NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE,
                          psdp->fd, off);
    if (ret == (pointer) -1) {
        ret = (pointer) mmap (NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED,
                              psdp->fd, off);
    }
    if (ret == (pointer) -1)
        return NULL;

and that should be fixed to just be:

    ret = (pointer) mmap (NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED,
                          psdp->fd, off);
    if (ret == (pointer) -1)
        return NULL;

Ie. use MAP_SHARED unconditionally.
