Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbTCJNET>; Mon, 10 Mar 2003 08:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbTCJNET>; Mon, 10 Mar 2003 08:04:19 -0500
Received: from pD95193BE.dip.t-dialin.net ([217.81.147.190]:4480 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S261308AbTCJNER>;
	Mon, 10 Mar 2003 08:04:17 -0500
Date: Mon, 10 Mar 2003 14:14:58 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.5.64 ACPI suspend/resume locking fix
Message-ID: <20030310131458.GA1063@note.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

doing an
echo 1 >/proc/acpi/sleep
caused quite some trouble on resume, such as
bad: scheduling while atomic!
Call Trace:
 [<c011d4c0>] schedule+0x220/0x230
 [<c0140608>] __pdflush+0x98/0x1e0
 [<c0140750>] pdflush+0x0/0x20
 [<c0140761>] pdflush+0x11/0x20
 [<c010826d>] kernel_thread_helper+0x5/0x18

(see BugZilla #455).

Turned out that the suspend handling in __pdflush() was abusing
pdflush_lock, by not relocking before going back up the loop (which then
unlocked again --> refcount -1 --> haywire!).

With the locking fix below,
doing
echo 1 >/proc/acpi/sleep
now suspends/resumes beautifully without giving further errors.

Note that my machine still gets killed completely if I do
echo 3 >/proc/acpi/sleep
, however. Any ideas? How to debug this?

Thanks,

Andreas Mohr

--- mm/pdflush.c.org	2003-03-10 14:04:00.000000000 +0100
+++ mm/pdflush.c	2003-03-10 13:14:57.000000000 +0100
@@ -106,6 +106,7 @@
 		schedule();
 		if (current->flags & PF_FREEZE) {
 			refrigerator(PF_IOTHREAD);
+			spin_lock_irq(&pdflush_lock);
 			continue;
 		}
 

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
