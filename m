Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318048AbSFSWpY>; Wed, 19 Jun 2002 18:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSFSWpX>; Wed, 19 Jun 2002 18:45:23 -0400
Received: from holomorphy.com ([66.224.33.161]:59835 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318049AbSFSWpH>;
	Wed, 19 Jun 2002 18:45:07 -0400
Date: Wed, 19 Jun 2002 15:44:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <20020619224441.GP22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 04:18:00AM -0700, Craig Kulesa wrote:
> Where:  http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/
> This patch implements Rik van Riel's patches for a reverse mapping VM 
> atop the 2.5.23 kernel infrastructure.  The principal sticky bits in 

There is a small bit of trouble here: pte_chain_lock() needs to
preempt_disable() and pte_chain_unlock() needs to preempt_enable(),
as they are meant to protect critical sections.


Cheers,
Bill


On Wed, Jun 19, 2002 at 04:18:00AM -0700, Craig Kulesa wrote:
+static inline void pte_chain_lock(struct page *page)
+{
+   /*
+    * Assuming the lock is uncontended, this never enters
+    * the body of the outer loop. If it is contended, then
+    * within the inner loop a non-atomic test is used to
+    * busywait with less bus contention for a good time to
+    * attempt to acquire the lock bit.
+    */
+   while (test_and_set_bit(PG_chainlock, &page->flags)) {
+       while (test_bit(PG_chainlock, &page->flags))
+           cpu_relax();
+   }
+}
+
+static inline void pte_chain_unlock(struct page *page)
+{
+   clear_bit(PG_chainlock, &page->flags);
+}

