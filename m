Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUHaIpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUHaIpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHaIpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:45:52 -0400
Received: from holomorphy.com ([207.189.100.168]:20155 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267491AbUHaIpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:45:50 -0400
Date: Tue, 31 Aug 2004 01:44:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric Valette <eric.valette@free.fr>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: wait_on_bit_lock() must test_and_set_bit(), not test_bit()
Message-ID: <20040831084458.GM5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eric Valette <eric.valette@free.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41343136.6080208@free.fr> <20040831080916.GK5492@holomorphy.com> <20040831081456.GL5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831081456.GL5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:09:16AM -0700, William Lee Irwin III wrote:
>> I very distinctly recall compiling and booting these...

On Tue, Aug 31, 2004 at 01:14:56AM -0700, William Lee Irwin III wrote:
> Index: mm2-2.6.9-rc1/kernel/wait.c

Incremental atop the fastcall fix:

wait_on_bit_lock() needs to test_and_set_bit() in the fastpath, not
test_bit().


-- wli

Index: mm2-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm2-2.6.9-rc1.orig/include/linux/wait.h	2004-08-31 01:37:55.507900064 -0700
+++ mm2-2.6.9-rc1/include/linux/wait.h	2004-08-31 01:38:34.670946376 -0700
@@ -388,7 +388,7 @@
 	DEFINE_WAIT_BIT(q, word, bit);
 	wait_queue_head_t *wqh;
 
-	if (!test_bit(bit, word))
+	if (!test_and_set_bit(bit, word))
 		return 0;
 
 	wqh = bit_waitqueue(word, bit);
