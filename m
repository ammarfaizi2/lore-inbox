Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTDCUyX 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263512AbTDCUyW 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:54:22 -0500
Received: from [12.47.58.55] ([12.47.58.55]:27525 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263510AbTDCUyV 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 15:54:21 -0500
Date: Thu, 3 Apr 2003 13:05:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jjs <jjs@tmsusa.com>, "Grover, Andrew" <andrew.grover@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] acpi compile fix
Message-Id: <20030403130505.199294c7.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 21:05:45.0165 (UTC) FILETIME=[CB04C7D0:01C2FA24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ACPI is performing a spin_lock() on a `void *'.  That's OK when spin_lock is
implemented via an inline function.  But when it is implemented via macros
(eg, with spinlock debugging enabled) we get:

drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `owner' in something not a structure or union

So cast it to the right type.


diff -puN drivers/acpi/osl.c~acpi-spinlock-casts drivers/acpi/osl.c
--- 25/drivers/acpi/osl.c~acpi-spinlock-casts	Thu Apr  3 13:00:54 2003
+++ 25-akpm/drivers/acpi/osl.c	Thu Apr  3 13:01:25 2003
@@ -736,7 +736,7 @@ acpi_os_acquire_lock (
 	if (flags & ACPI_NOT_ISR)
 		ACPI_DISABLE_IRQS();
 
-	spin_lock(handle);
+	spin_lock((spinlock_t *)handle);
 
 	return_VOID;
 }
@@ -755,7 +755,7 @@ acpi_os_release_lock (
 	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Releasing spinlock[%p] from %s level\n", handle,
 		((flags & ACPI_NOT_ISR) ? "non-interrupt" : "interrupt")));
 
-	spin_unlock(handle);
+	spin_unlock((spinlock_t *)handle);
 
 	if (flags & ACPI_NOT_ISR)
 		ACPI_ENABLE_IRQS();

_

