Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUKKJfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUKKJfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUKKJfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:35:00 -0500
Received: from aun.it.uu.se ([130.238.12.36]:62370 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262132AbUKKJe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:34:58 -0500
Date: Thu, 11 Nov 2004 10:34:50 +0100 (MET)
Message-Id: <200411110934.iAB9Yo1D028739@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm4][0/4] perfctr interrupt fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches fixes a problem where a perfctr
overflow interrupt can be delayed and be "handled"
in the context of the wrong task, which doesn't work.

Bug 1 is that the perfctr core patches on x86 and
x86-64 perform the suspend action too late, when the
task owning the perfctr state no longer is current.
This creates a time window where interrupts can be
delivered even though 'current' isn't the owner.
Fixed by moving the suspend action to an earlier
point in switch_to(), when the owner still is current.

Bug 2 is a hardware quirk, confirmed to exist at least
on P3s. There appears to be a time window where a
pending counter overflow can be delivered as a local
APIC interrupt _after_ the counters have been disabled.
Disabling the counters is a serializing operation
so this shouldn't happen, but it does.
Fixed by masking interrupts before stopping the counters,
and checking in software for pending overflows.

/Mikael
