Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVHVVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVHVVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVHVVyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:54:08 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38580 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751278AbVHVVyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:54:07 -0400
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: luben_tuikov@adaptec.com, jim.houston@ccur.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1124720938.5211.13.camel@mulgrave>
References: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
	 <1124680540.5068.37.camel@mulgrave> <20050821205214.2a75b3cf.akpm@osdl.org>
	 <1124720938.5211.13.camel@mulgrave>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 16:53:35 -0500
Message-Id: <1124747615.5211.34.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 09:28 -0500, James Bottomley wrote:
> > I think providing locking inside idr.c was always a mistake - generally we
> > rely on caller-provided locking for such things.
> 
> Well, the reason is because they wanted lockless pre-alloc.  If you do
> it locked, you can't use GFP_KERNEL for the memory allocation flag which
> rather defeats its purpose.

It looks to be feasible to implement this locklessly the same way as the
radix-tree does (with a per_cpu list), except that you still need a
start/end API for the pre allocation to do the initial disable of pre-
emption.

Then the remove should simply then free the entry (again like radix-
tree) and let the slab take care of necessary locking.

Of course, if we're going to go to all this trouble, the next question
that arises naturally is why not just reuse the radix-tree code to
implement idr anyway ... ?

James


