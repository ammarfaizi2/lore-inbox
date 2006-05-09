Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWEIU5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWEIU5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWEIU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12765 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750724AbWEIU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:13 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:35 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 0/8] [RFC PATCH] nmi watchdog: x86 32/64 cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A major cleanup of the nmi watchdog on the i386 and x86_64 archs.

This little project started out as a way to get unknown_nmi_panic working on
an x86_64 SMP machine. But after Andi rejected my dirty little hack ;), it
grew into a spring cleaning of the nmi watchdog.

The fix Andi wanted led to a conflict with how oprofile worked.  This led to
a reservation layer around the performance counters and a bunch of changes
in oprofile startup.  All the reservation layer consists of is reserving a
bit that corresponds to a performance counter.  The intent here is to
prevent subsystems like oprofile and nmi watchdog from stomping on each
other when trying to manipulate these counters. Currently, oprofile must
stop the nmi watchdog before using the counters.  This approach does not
encourage any sharing. :) 

During the testing of this reservation layer, I ran into more and more bugs
from old hacks (notably in the SMP cases).  As a result I found myself
rewriting a lot of this code.  I think I straightened everything out, except
for enabling/disabling the nmi watchdog on an ioapic.  The
enable_irq/disable_irq macros don't seem to work for me and I don't know
enough about the subsystem to figure it out either. 

Of course the oprofile code is shared with the i386 arch, so all the changes
I did in x86_64 had to be duplicated over there too.

I tested these changes on a Xeon (UP/SMP), P4 (32/64, UP/SMP) and under
various boot-up defaults (nmi-watchdog=0,1,2).  I also worked on some of
these changes with Andi Kleen and the oprofile folks, so these ideas
shouldn't be too surprising, just perhaps the implementation. :o

Any thoughts/feedback/criticism to clean this up more and probably fix some of my
coding style would be appreciated.

Cheers,
Don

--
