Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVHROI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVHROI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHROI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:08:29 -0400
Received: from iona.labri.fr ([147.210.8.143]:59329 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932234AbVHROI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:08:28 -0400
Date: Thu, 18 Aug 2005 16:08:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: idle task's task_t allocation on NUMA machines
Message-ID: <20050818140829.GB8123@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, the task_t structure of the idle task is always allocated
on CPU0, hence on node 0: while booting, for each CPU, CPU 0 calls
fork_idle(), hence copy_process(), hence dup_task_struct(), hence
alloc_task_struct(), hence kmem_cache_alloc(), which picks up memory
from the allocation cache of the current CPU, i.e. on node 0.

This is a bad idea: every write needs be written back to node 0 at some
time, so that node 0 can get a small bit busy especially when other
nodes are idle.

A solution would be to add to copy_process(), dup_task_struct(),
alloc_task_struct() and kmem_cache_alloc() the node number on which
allocation should be performed. This might also be useful if performing
node load balancing at fork(): one could then allocate task_t directly
on the new node. It might also be useful when allocating data for
another node.

Regards,
Samuel
