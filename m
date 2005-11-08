Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVKHES1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVKHES1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKHES1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:18:27 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:3346 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750804AbVKHES0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:18:26 -0500
Date: Mon, 7 Nov 2005 20:17:44 -0800
Message-Id: <200511080417.jA84HiH2009833@zach-dev.vmware.com>
Subject: [PATCH 0/21] Descriptor table fixes / cleanup for i386
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:17:50.0157 (UTC) FILETIME=[61895FD0:01C5E41B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches to clean up descriptor access in Linux to make it friendly to
virtualization environments.  The basic problem is that the GDT must
be write protected, which causes spurious overhead when the GDT lies
on the same page as other data.  This problem exists both for VMware
and Xen; Xen actually requires page isolation, so we have implemented
the most general and compatible solution.  While VMware suffers only
from false sharing, Xen suffers from the false-validation problem,
which requires the extra space for the GDT page to be zeroed.

The GDTs for secondary processors are allocated dynamically to avoid
bloating kernel static data with GDTs for not-present processors.

Along the way, I discovered two serious but subtle problems; there
was no consistent mechanism for converting an EIP to a linear address,
which presented a serious challenge for the kprobes code, since the
LDT is protected by a semaphore which must be acquired in user
context, with interrupts enabled.  The second problem was that %fs,
and %gs could end up loaded with bad cached values after a PnP or APM
BIOS call.

Many other small enhancements to readability, compactness, correctness,
and overall goodness were discovered along the way.

The core piece of these patches is getting the GDT page aligned;
I wil rework or deprecate any other pieces of this that are not
wanted / unnecessary / (hopefully not) buggy.

Testing: 4 way SMP boot-halts, kernel compiles, stress, UML, LDT
 test suites, insane cross-modifying code for breakpoint testing.

Zachary Amsden <zach@vmware.com>
