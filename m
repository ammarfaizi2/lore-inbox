Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVIVHhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVIVHhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVIVHhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:37:19 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:16133 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751397AbVIVHhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:37:17 -0400
Date: Thu, 22 Sep 2005 00:35:29 -0700
Message-Id: <200509220735.j8M7ZT6b000921@zach-dev.vmware.com>
Subject: [PATCH 0/3] GDT virtualization performance
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 22 Sep 2005 07:36:22.0620 (UTC) FILETIME=[5480B9C0:01C5BF48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three patches to clean up GDT access in Linux to make it friendly to
virtualization environments.  The basic problem is that the GDT must
be write protected, which causes spurious overhead when the GDT lies
on the same page as other data.  This problem exists both for VMware
and Xen; Xen actually requires page isolation, so we have implemented
the most general and compatible solution.

Patch 1 deprecates a broken GDT reference;
Patch 2 adds a per-cpu GDT accessor;
Patch 3 moves the GDT out of the per-cpu area and makes it page
 padded and page aligned.

The GDTs for secondary processors are allocated dynamically to avoid
bloating kernel static data with GDTs for not-present processors.

This could be adapted to drop and reallocate GDTs for CPU hotplug
if desired, although the space savings (1 page) are dubious, so
I have not implemented that at this time.

Testing: 4 way SMP boot-halts, kernel compiles, stress.

Zachary Amsden <zach@vmware.com>
