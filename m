Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269503AbUICJH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269503AbUICJH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUICJFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:05:50 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:29081 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S269452AbUICI7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:59:08 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 2.6.9-rc1-mm2 compilation fixes
Date: Fri, 3 Sep 2004 08:57:24 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VXBOBrH14NCOOf5"
Message-Id: <200409030857.25295.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_VXBOBrH14NCOOf5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

make modules_install doesn't work if the ALSA korg1212 sound module is built - 
"grep -h .ko" will find /korg1212.o (. is a regexp character...), and 
therefore try to install the nonexistant korg1212.ko.
It should be grep -h '\.ko'

kernel/wait.c fails to compile with gcc 3.4 due to discrepancies between the 
prototype and implementations of __wait_on_bit() and __wait_on_bit_lock()

Fixes to both are attached.

LLaP
bero

--Boundary-00=_VXBOBrH14NCOOf5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.9-rc1-mm2-modules_install.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.9-rc1-mm2-modules_install.patch"

--- linux-2.6.8/scripts/Makefile.modinst.ark	2004-09-03 08:46:43.000000000 +0200
+++ linux-2.6.8/scripts/Makefile.modinst	2004-09-03 08:47:15.000000000 +0200
@@ -9,7 +9,7 @@
 
 #
 
-__modules := $(sort $(shell grep -h .ko /dev/null $(wildcard $(MODVERDIR)/*.mod)))
+__modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 .PHONY: $(modules)

--Boundary-00=_VXBOBrH14NCOOf5
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.9-rc1-mm2-gcc34.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.9-rc1-mm2-gcc34.patch"

--- linux-2.6.8/kernel/wait.c.ark	2004-09-03 06:08:23.000000000 +0200
+++ linux-2.6.8/kernel/wait.c	2004-09-03 06:09:01.000000000 +0200
@@ -150,7 +150,7 @@
  * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
-int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
+int __sched fastcall __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
 			void *word,
 			int bit, int (*action)(void *), unsigned mode)
 {
@@ -164,7 +164,7 @@
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
+int __sched fastcall __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
 			void *word, int bit,
 			int (*action)(void *), unsigned mode)
 {

--Boundary-00=_VXBOBrH14NCOOf5--
