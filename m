Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUIAH0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUIAH0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUIAHZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:25:56 -0400
Received: from holomorphy.com ([207.189.100.168]:24771 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268803AbUIAHZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:25:33 -0400
Date: Wed, 1 Sep 2004 00:25:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andre Eisenbach <int2str@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2
Message-ID: <20040901072525.GX5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andre Eisenbach <int2str@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040830235426.441f5b51.akpm@osdl.org> <7f800d9f040901001551f92762@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f800d9f040901001551f92762@mail.gmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 12:15:50AM -0700, Andre Eisenbach wrote:
> Does not compile for me:
>   CC      kernel/wait.o
> kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
> include/linux/wait.h:143: error: previous declaration of
> '__wait_on_bit' was here
[...]
> Let me know if you need the .config or any other info.
> Thanks for your continued hard work guys!

Please apply the following fixes:


Index: mm2-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm2-2.6.9-rc1.orig/include/linux/wait.h	2004-08-31 16:01:44.000000000 -0700
+++ mm2-2.6.9-rc1/include/linux/wait.h	2004-08-31 16:02:00.000000000 -0700
@@ -388,7 +388,7 @@
 	DEFINE_WAIT_BIT(q, word, bit);
 	wait_queue_head_t *wqh;
 
-	if (!test_bit(bit, word))
+	if (!test_and_set_bit(bit, word))
 		return 0;
 
 	wqh = bit_waitqueue(word, bit);
Index: mm2-2.6.9-rc1/kernel/wait.c
===================================================================
--- mm2-2.6.9-rc1.orig/kernel/wait.c	2004-08-31 16:01:44.000000000 -0700
+++ mm2-2.6.9-rc1/kernel/wait.c	2004-08-31 16:02:00.000000000 -0700
@@ -150,8 +150,8 @@
  * waiting, the actions of __wait_on_bit() and __wait_on_bit_lock() are
  * permitted return codes. Nonzero return codes halt waiting and return.
  */
-int __sched __wait_on_bit(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			void *word,
+int __sched fastcall __wait_on_bit(wait_queue_head_t *wq,
+			struct wait_bit_queue *q, void *word,
 			int bit, int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
@@ -164,8 +164,8 @@
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
-			void *word, int bit,
+int __sched fastcall __wait_on_bit_lock(wait_queue_head_t *wq,
+			struct wait_bit_queue *q, void *word, int bit,
 			int (*action)(void *), unsigned mode)
 {
 	int ret = 0;
More recent patches modify files in wait-on-bit-lock-fix.patch.
