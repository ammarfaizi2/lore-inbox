Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUIJKws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUIJKws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUIJKws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:52:48 -0400
Received: from [213.85.13.118] ([213.85.13.118]:52608 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S267352AbUIJKwr (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 10 Sep 2004 06:52:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16705.34633.433179.600565@gargle.gargle.HOWL>
Date: Fri, 10 Sep 2004 14:51:53 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Hugh Dickins <hugh@veritas.com>
Subject: 2.6.9-rc1: page_referenced_one() CPU consumption
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in 2.6.9-rc1 page_referenced_one() is among top CPU consumers (which
wasn't a case for 2.6.8-rc2) in the host kernel when running heavily
loaded UML. readprofile -b shows that time is spent in
spin_lock(&mm->page_table_lock), so, I reckon, recent "rmaplock: kill
page_map_lock" changes are probably not completely unrelated.

Without any deep investigation, one possible scenario is that multiple
threads are doing (as part of direct reclaim),

   refill_inactive_zone()
       page_referenced()
           page_referenced_file() /* (1) mapping->i_mmap_lock doesn't
                                     serialize them */
               page_referenced_one()
                   spin_lock(&mm->page_table_lock) /* (2) everybody is
                                                     serialized here */

(1) and (2) will be true if we have one huge address space with a lot of
VMAs, which seems to be exactly what UML does:

$ wc /proc/<UML-host-pid>/maps
4134 28931 561916

This didn't happen before, because page_referenced_one() used to
try-lock.

Nikita.


