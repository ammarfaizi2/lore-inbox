Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWBVSrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWBVSrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBVSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:47:17 -0500
Received: from sccrmhc13.comcast.net ([204.127.200.83]:10734 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751393AbWBVSrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:47:16 -0500
Message-ID: <43FCB1B3.8090101@acm.org>
Date: Wed, 22 Feb 2006 12:47:15 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem with NETIF_F_HIGHDMA
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at a problem with a new system we are trying to get up and
running.  It has a 32-bit only PCI network device, but is a 64-bit
(x86_64) system.  Looking at the code for NETIF_F_HIGHDMA (which, when
not set on a PCI network device, means that it cannot do 64-bit
accesses) in net/core/dev.c, it seems wrong to me.

It is dependent on HIGHMEM, but HIGHMEM has nothing to do with 32/64 bit
accesses.  On 64-bit systems, HIGHMEM is not set, thus the network code
will pass any address (including those >32bits) to the driver.  Plus,
highmem on 32-bit systems may very well be 32-bit accessible, possibly
resulting in unecessary copies.  AFAICT, the current code will only work
with i386 and PAE and is sub-optimal.

If I am right, it is a little messy to fix, but I think doable.  I
propose the following:

    * Create a new zone named ZONE_HIGHMEM32 for 32-bit HIGHMEM addresses.
    * Modify 64-bit architectures (and i386 with HIGHMEM) to put the
      proper pages into the new zone.
    * Add a "PageIn32Bits()" function/macro to check for this, and use
      it in illegal_highdma() in net/core/dev.c
    * Allocate from ZONE_HIGHMEM32 if illegal_highdma() returns true.

I think this will solve the problem.  I haven't looked at other parts of
the kernel (IDE, SCSI, etc.) to see if they have similar problems.

Anyway, does the above change sound reasonable?  Maybe there's an easier
way?  Maybe I've missed something?

Thanks,

-Corey
