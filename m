Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTEVE3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 00:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEVE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 00:29:19 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:30981 "EHLO smtp.uc3m.es")
	by vger.kernel.org with ESMTP id S262108AbTEVE3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 00:29:18 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305220442.h4M4gFM12023@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <3ECC4C3A.9000903@cyberone.com.au> from Nick Piggin at "May 22,
 2003 02:04:10 pm"
To: Nick Piggin <piggin@cyberone.com.au>
Date: Thu, 22 May 2003 06:42:15 +0200 (MET DST)
Cc: Robert White <rwhite@casabyte.com>,
       Rik van Riel <riel@imladris.surriel.com>,
       David Woodhouse <dwmw2@infradead.org>, ptb@it.uc3m.es,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nick Piggin wrote:"
> Locking is an implementation issue, and as such I think you'll have
> to come up with a real problem or some real code. You must have some
> target problem in mind?

I'll butt back in here.

I found a problem when I made two drivers talk to each other.
Concretely a modified raid MD driver and a block device driver.

Each driver had ioctls that walked or modified a linear list, and locked
the list against other threads while running their subroutine in the
ioctl. To be concrete again, the lists were respectively the set of
raid arrays in which the block device found itself currently, and
the md drivers internal lists of arrays, component devices, etc.

The ioctls worked fine when used from user space.

Then I had the bright idea of getting the block driver to call the md
driver's ioctl automatically when a certain condition arose.  Concretely
again, I had the block device driver tell the md driver "setfaulty" when
the block device noticed an internal problem, and "hotadd" when it felt
cured.

Unfortunately, I had already gotten the md driver to tell the block
driver when it was booted out from or newly included in an array
(so that it could know if it should tell md when it felt ill or well).

The result was a call from the block driver to the md driver with a
lock held, and a rather unexpected call back from the md driver that
impotently tried to take the same lock.

Same thread.

Peter
