Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUCDOhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCDOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:37:11 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:53397 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261848AbUCDOhI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:37:08 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Fixed broken x86_64
Date: Thu, 4 Mar 2004 20:06:55 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403042006.55161.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am attempting to fix broken x86_64: kgdb_connected is zero when kgdb 
connects to gdb. This comes through a debug exception.

I am checking in this patch to fix it for uniprocessor systems. I still have 
to think about smp system.
-Amit

@@ -556,13 +566,15 @@
 +{
 +        struct die_args *d = ptr;
 +
-+        if (!kgdb_connected || (cmd == DIE_DEBUG && user_mode(d->regs)))
++        if (cmd == DIE_DEBUG && user_mode(d->regs))
 +                return NOTIFY_DONE;
 +        if (cmd == DIE_NMI_IPI) {
-+                if (atomic_read(debugger_active))
++                if (atomic_read(&debugger_active))
 +                        return NOTIFY_BAD;
-+        } else if ((*linux_debug_hook)(d->trapnr, d->signr, d->err, 
d->regs))
-+                return NOTIFY_BAD; /* skip */
++        } else {
++              CHK_DEBUGGER(d->trapnr, d->signr, d->err, d->regs,);
++              return NOTIFY_BAD;
++      }
 +
 +        return NOTIFY_DONE;
 +}


