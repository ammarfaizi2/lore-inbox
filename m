Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTAPBCD>; Wed, 15 Jan 2003 20:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTAPBCC>; Wed, 15 Jan 2003 20:02:02 -0500
Received: from fmr05.intel.com ([134.134.136.6]:58587 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266796AbTAPBCC>; Wed, 15 Jan 2003 20:02:02 -0500
Date: Wed, 15 Jan 2003 17:11:06 -0800
Message-Id: <200301160111.h0G1B6ZE020954@penguin.co.intel.com>
From: Rusty Lynch <rusty@penguin.co.intel.com>
To: scottm@somanetworks.com
CC: linux-kernel@vger.kernel.org
CC: pcihpd-discuss@lists.sourceforge.net
Subject: [BUG][2.5]deadlock on cpci hot insert
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I hot insert a cpci peripheral board into a ZT5084 chassis
with a ZT5550 system master board, my ZT5550 locks up.  I managed
to isolate the problem to a deadlock with list_lock

* hot insert * 
      ||
      \/
cpci_hotplug_core.c:check_slots() which does a spin_lock(&list_lock)
      ||
      \/
* inserted card is found *
      ||
      \/
cpci_hotplug_pci.c:cpci_configure_slot()
      ||
      \/
pci_hotplug_util.c:pci_visit_dev()
      ||
      || (fn->visit_pci_dev)
      \/
cpci_hotplug_pci.c:configure_visit_pci_dev()
      ||
      \/
cpci_hotplug_core.c:cpci_find_slot() which also does a spin_lock(&list_lock)
      ||
      \/
* deadlock *


I'm not sure which is the correct way to fix this.  Maybe a
cpci_unlocked_find_slot()? hmm... pci_visit_dev is exported,
so anybody could call it.

    --rustyl
