Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbTLFW4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTLFW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:56:12 -0500
Received: from turing.informatik.Uni-Halle.DE ([141.48.14.250]:14235 "EHLO
	turing.informatik.uni-halle.de") by vger.kernel.org with ESMTP
	id S265267AbTLFW4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:56:07 -0500
Message-ID: <3FD25E84.5050702@abeckmann.de>
Date: Sat, 06 Dec 2003 23:56:04 +0100
From: Andreas Beckmann <andreas@abeckmann.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ralf@linux-mips.org
Subject: [PATCH] inclusion of <asm/system.h> into spinlock.h breaks sparc
Content-Type: multipart/mixed;
 boundary="------------040602090804010104050500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040602090804010104050500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the recent inclusion of <asm/system.h> into spinlock.h causes a cyclic 
inclusion under the sparc architecture. This breaks the build (at the 
beginning of make dep) in oplib.h because spinlock_t is not yet defined.

linux/spinlock.h
   asm/system.h
     asm/oplib.h
       linux/spinlock.h
     ERROR! (asm/oplib.h)

I was working with 2.4.23-bk3 and -bk4.

The change was introduced in the following changeset:
--------------------
ChangeSet 1.1192.4.2 2003/12/02 11:25:25 ralf@linux-mips.org
   [PATCH] Include <asm/system.h> into spinlock.h

   <linux/spinlock.h> uses local_irq_save() etc. from <asm/spinlock.h> but
   relies on this header file having been dragged in on some other way.
   So if things are just right the build may blow up ...
include/linux/spinlock.h 1.9 2003/11/28 10:38:30 ralf@linux-mips.org
   Include <asm/system.h> into spinlock.h
--------------------

Not including asm/oplib.h from asm/system.h seems to fix this.
The patch drops this include.


Andreas

Please CC: me in your replies.

--------------040602090804010104050500
Content-Type: text/plain;
 name="asm_system_h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asm_system_h.diff"

--- linux-2.4.23/include/asm-sparc/system.h.orig	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.23/include/asm-sparc/system.h	2003-12-06 05:49:05.000000000 +0100
@@ -10,7 +10,6 @@
 
 #ifdef __KERNEL__
 #include <asm/page.h>
-#include <asm/oplib.h>
 #include <asm/psr.h>
 #include <asm/ptrace.h>
 #include <asm/btfixup.h>

--------------040602090804010104050500--

