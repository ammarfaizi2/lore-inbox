Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVHVVf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVHVVf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVHVVf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:35:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:5505 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751242AbVHVVf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:35:57 -0400
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: luben_tuikov@adaptec.com, jim.houston@ccur.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050821205214.2a75b3cf.akpm@osdl.org>
References: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
	 <1124680540.5068.37.camel@mulgrave> <20050821205214.2a75b3cf.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 09:28:58 -0500
Message-Id: <1124720938.5211.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-21 at 20:52 -0700, Andrew Morton wrote:
> erp.  posix_timers has its own irq-safe lock, so we're doing extra,
> unneeded locking in that code path.

Possibly, the posix timer code is rather convoluted in this area so I'm
not entirely sure my analysis is correct.

> I think providing locking inside idr.c was always a mistake - generally we
> rely on caller-provided locking for such things.

Well, the reason is because they wanted lockless pre-alloc.  If you do
it locked, you can't use GFP_KERNEL for the memory allocation flag which
rather defeats its purpose.

Perhaps the bug is in the API.  We have pre-allocate, new, find and
remove.  Perhaps what we're missing is a reuse all of which could then
rely on caller provided locking, with pre-alloc and remove requiring
user context but new, find and reuse being happy in irq context.

James


