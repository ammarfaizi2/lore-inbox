Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVLFNeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVLFNeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLFNeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:34:08 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:32982 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932561AbVLFNeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:34:07 -0500
Message-Id: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:08 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/13] Balancing the scan rate of major caches V2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1:
- better broken up of patches
- replace pages_more_aged with age_ge/age_gt
- expanded shrink_slab interface
- rewrite kswapd rebalance logic to be simple and robust


This patch balances the aging rates of active_list/inactive_list/slab.

It started out as an effort to enable the adaptive read-ahead to handle large
number of concurrent readers. Then I found it envolves much more stuffs, and
deserves a standalone patchset to address the balancing problem as a whole.


The whole picture of balancing:

- In each node, inactive_list scan rates are synced with each other
  It is done in the direct/kswapd reclaim path.

- In each zone, active_list scan rate always follows that of inactive_list

- Slab cache scan rates always follow that of the current node.
  Since shrink_slab() can be called from different CPUs, that effectly sync
  slab cache scan rates with that of the most scanned node.


The patches can be grouped as follows:

- balancing stuffs
mm-revert-vmscan-balancing-fix.patch
mm-simplify-kswapd-reclaim-code.patch
mm-balance-zone-aging-supporting-facilities.patch
mm-balance-zone-aging-in-direct-reclaim.patch
mm-balance-zone-aging-in-kswapd-reclaim.patch
mm-balance-slab-aging.patch
mm-balance-active-inactive-list-aging.patch


- pure code cleanups
mm-remove-unnecessary-variable-and-loop.patch
mm-remove-swap-cluster-max-from-scan-control.patch
mm-accumulate-nr-scanned-reclaimed-in-scan-control.patch
mm-turn-bool-variables-into-flags-in-scan-control.patch

- debug code
mm-page-reclaim-debug-traces.patch

- a minor fix
mm-scan-accounting-fix.patch

Thanks,
Wu Fengguang

--
Dept. Automation                University of Science and Technology of China
