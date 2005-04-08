Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVDHSiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVDHSiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVDHSiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:38:22 -0400
Received: from fmr15.intel.com ([192.55.52.69]:11215 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262916AbVDHSiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:38:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch] sched: unlocked context-switches
Date: Fri, 8 Apr 2005 11:38:09 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] sched: unlocked context-switches
Thread-Index: AcU8NMnGT13uUbhkS7C6cAuU9VdN9gANDPHw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <nickpiggin@yahoo.com.au>,
       <linux-arch@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2005 18:38:07.0332 (UTC) FILETIME=[1B5EBA40:01C53C6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>tested on x86, and all other arches should work as well, but if an 
>architecture has irqs-off assumptions in its switch_to() logic 
>it might break. (I havent found any but there may such assumptions.)

The ia64_switch_to() code includes a section that can change a pinned
MMU mapping (when the stack for the new process is in a different
granule from the stack for the old process).  The code beyond the ".map"
label in arch/ia64/kernel/entry.S includes the comment:

.map:
        rsm psr.ic                      // interrupts (psr.i) are already disabled here

I don't think that it would be sufficient to merely add psr.i to this rsm
(and to the ssm 15 lines above).  That would leave a window where we could
take an interrupt, but not be sure that the current stack is pinned.

-Tony
