Return-Path: <linux-kernel-owner+w=401wt.eu-S1422796AbWLUHNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWLUHNK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422790AbWLUHNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:13:10 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49456 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422777AbWLUHNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:13:08 -0500
Date: Thu, 21 Dec 2006 16:16:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, npiggin@suse.de,
       Andrew Morton <akpm@osdl.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: [BUG ?] oom with empty nodes.
Message-Id: <20061221161608.27f81383.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some system, there are memory-less-nodes. (IOW, cpu-only-node)
Then,there are online nodes which has no memory.

Now, below code is used to detect the context where oom happens.

===
static inline int constrained_alloc(struct zonelist *zonelist, gfp_t gfp_mask)
{
#ifdef CONFIG_NUMA
        struct zone **z;
        nodemask_t nodes = node_online_map;

        for (z = zonelist->zones; *z; z++)
                if (cpuset_zone_allowed_softwall(*z, gfp_mask))
                        node_clear(zone_to_nid(*z), nodes);
                else
                        return CONSTRAINT_CPUSET;

        if (!nodes_empty(nodes))
                return CONSTRAINT_MEMORY_POLICY;
#endif

        return CONSTRAINT_NONE;
}
==
Because the zonelist never incldues memory-less-zone, above nodemask cannot be
empty if there is a memoly-less-node, never returns CONSTRAINT_NONE.

It looks select_bad_process() and panic_on_oom is checked only when
above function returns CONSTRAINT_NONE. This means current dies every time.

Does anyone have good idea for fix this ?

-Kame


 

