Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUHaVPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUHaVPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbUHaVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:13:12 -0400
Received: from holomorphy.com ([207.189.100.168]:64703 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269221AbUHaVMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:12:42 -0400
Date: Tue, 31 Aug 2004 14:12:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Valette <eric.valette@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [3/2] document wake_up_bit()'s requirement for preceding memory barriers
Message-ID: <20040831211234.GV5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Eric Valette <eric.valette@free.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41343136.6080208@free.fr> <20040831080916.GK5492@holomorphy.com> <20040831081456.GL5492@holomorphy.com> <20040831084458.GM5492@holomorphy.com> <20040831210346.GT5492@holomorphy.com> <20040831210542.GU5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831210542.GU5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 02:05:42PM -0700, William Lee Irwin III wrote:
> Some of the parameters to __wait_on_bit() and __wait_on_bit_lock() are
> redundant, as the wait_bit_queue parameter holds the flags word and the
> bit number. This patch updates __wait_on_bit() and __wait_on_bit_lock()
> to fetch that information from the wait_bit_queue passed to them and so
> reduce the number of parameters so that -mregparm may be more effective.
> Incremental atop the complete out-of-lining of the contention cases and
> the fastcall and wait_on_bit_lock()/test_and_set_bit() fixes.
> Successfully tested on x86-64.

Document the requirement to use a memory barrier prior to wake_up_bit().


Index: mm2-2.6.9-rc1/kernel/wait.c
===================================================================
--- mm2-2.6.9-rc1.orig/kernel/wait.c	2004-08-31 02:00:10.000000000 -0700
+++ mm2-2.6.9-rc1/kernel/wait.c	2004-08-31 14:07:13.688481360 -0700
@@ -219,6 +219,13 @@
  * is the part of the hashtable's accessor API that wakes up waiters
  * on a bit. For instance, if one were to have waiters on a bitflag,
  * one would call wake_up_bit() after clearing the bit.
+ *
+ * In order for this to function properly, as it uses waitqueue_active()
+ * internally, some kind of memory barrier must be done prior to calling
+ * this. Typically, this will be smp_mb__after_clear_bit(), but in some
+ * cases where bitflags are manipulated non-atomically under a lock, one
+ * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
+ * because spin_unlock() does not guarantee a memory barrier.
  */
 void fastcall wake_up_bit(void *word, int bit)
 {
