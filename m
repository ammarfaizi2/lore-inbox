Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275838AbRI1FVj>; Fri, 28 Sep 2001 01:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275839AbRI1FVV>; Fri, 28 Sep 2001 01:21:21 -0400
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:30960 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S275838AbRI1FVI>; Fri, 28 Sep 2001 01:21:08 -0400
From: junio@siamese.dhis.twinsun.com
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] link failur in Linux 2.4.9-ac16 around apm.o and sysrq.o
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Date: 27 Sep 2001 22:21:24 -0700
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Message-ID: <7v8zezki0b.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.9-ac16 fails to link with CONFIG_APM=y and
CONFIG_MAGIC_SYSRQ=n.  This is because apm.c unconditionally
makes calls to functions (__sysrq_lock_table and friends)
defined in sysrq.c.

I can think of a couple of different approaches to work this
around, but is there an established proper way to resolve this
kind of dependency in the kernel code?

I've attached a fix based on (3) below at the end of this message.

 (1) In include/linux/sysrq.h, define stubs for
     __sysrq_lock_table that does not do anything when
     CONFIG_MAGIC_SYSRQ is not set;

 (2) Change ''make config'' procedure so that CONFIG_MAGIC_SYSRQ
     is always set if CONFIG_APM is defined;

 (3) Change drivers/char/Makefile to make sysrq.o to be linked
     in if CONFIG_APM is defined (even if CONFIG_MAGIC_SYSRQ is).

--- 2.4.9-ac16.sffix/drivers/char/Makefile	Thu Sep 27 12:46:56 2001
+++ 2.4.9-ac16.sffix/drivers/char/Makefile	Thu Sep 27 22:08:19 2001
@@ -143,6 +143,7 @@
 endif
 
 obj-$(CONFIG_MAGIC_SYSRQ) += sysrq.o
+obj-$(CONFIG_APM) += sysrq.o
 obj-$(CONFIG_ATARI_DSP56K) += dsp56k.o
 obj-$(CONFIG_ROCKETPORT) += rocket.o
 obj-$(CONFIG_MOXA_SMARTIO) += mxser.o
