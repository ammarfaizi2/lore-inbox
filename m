Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSDDOLA>; Thu, 4 Apr 2002 09:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSDDOKt>; Thu, 4 Apr 2002 09:10:49 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:50091 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S313189AbSDDOKh>; Thu, 4 Apr 2002 09:10:37 -0500
Date: Thu, 4 Apr 2002 16:10:25 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rml@tech9.net
Subject: [PATCH 2.5.8-pre1] ppp_deflate.c fix...
Message-ID: <20020404141025.GI9820@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rml@tech9.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.5.8-pre1 without CONFIG_PREEMPT, and ppp all in modules,
I have unresolved symbols in ppp_deflate.o (local_bh_enable and
local_bh_disable). If CONFIG_PREEMPT is on, no problems.

The attached patch fixes it by adding some header files to ppp_deflate.c which
somehow makes it properly compile.

But after a second look, I must say I don't really understand how this is 
supposed to work, for example:
	include/linux/spinlock.h 
		* defines spin_lock_bh dependent on local_bh_disable
		* defines preempt_disable
	include/asm-i386/softirq.h
		* defines local_bh_disable dependent on ... preempt_disable

Do we have here a circular dependency problem or ? 

Stelian.

===== drivers/net/ppp_deflate.c 1.6 vs edited =====
--- 1.6/drivers/net/ppp_deflate.c	Mon Mar  4 14:20:25 2002
+++ edited/drivers/net/ppp_deflate.c	Thu Apr  4 14:31:05 2002
@@ -36,11 +36,13 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/spinlock.h>
 
 #include <linux/ppp_defs.h>
 #include <linux/ppp-comp.h>
 
 #include <linux/zlib.h>
+#include <linux/interrupt.h>
 
 static spinlock_t comp_free_list_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(comp_free_list);
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
