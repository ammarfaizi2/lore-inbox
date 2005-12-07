Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVLGKWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVLGKWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVLGKWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:22:38 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:21426 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750783AbVLGKWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:22:38 -0500
Message-Id: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:47:55 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/16] Balancing the scan rate of major caches V3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V2:
- fix divide error in shrink_slab()
- more debug/accounting code
- fine grained priority/scan quantity
- reluctant to reclaim lowest zone if it is out of sync with highest zone

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


The patches is grouped as follows:

- balancing stuffs
mm-revert-vmscan-balancing-fix.patch
mm-simplify-kswapd-reclaim-code.patch
mm-balance-zone-aging-supporting-facilities.patch
mm-balance-zone-aging-in-direct-reclaim.patch
mm-balance-zone-aging-in-kswapd-reclaim.patch
mm-balance-slab-aging.patch
mm-balance-active-inactive-list-aging.patch
mm-fine-grained-scan-priority.patch

- pure code cleanups
mm-remove-unnecessary-variable-and-loop.patch
mm-remove-swap-cluster-max-from-scan-control.patch
mm-accumulate-nr-scanned-reclaimed-in-scan-control.patch
mm-fold-bool-variables-into-flags-in-scan-control.patch

- minor fix
mm-scan-accounting-fix.patch

- debug code
mm-account-zone-aging-rounds.patch
mm-page-reclaim-debug-traces.patch
mm-kswapd-reclaim-debug-trace.patch

Thanks,
Wu Fengguang

--
Dept. Automation                University of Science and Technology of China
