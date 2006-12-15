Return-Path: <linux-kernel-owner+w=401wt.eu-S1751700AbWLOAYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWLOAYv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWLOAXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:23:51 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34802 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbWLOAXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:23:42 -0500
Message-Id: <20061215000754.764718000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:07:54 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
Subject: [PATCH 00/10] Introduction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of my Task Watchers patches with performance enhancements.

Task watchers calls functions whenever a task forks, execs, changes its
[re][ug]id, or exits.

Task watchers is primarily useful to existing kernel code as a means of making
the code in fork and exit more readable. Kernel code uses these paths by
marking a function as a task watcher much like modules mark their init
functions with module_init(). This improves the readability of copy_process().

The first patch adds the basic infrastructure of task watchers: notification
function calls in the various paths and a table of function pointers to be
called. It uses an ELF section because parts of the table must be gathered
from all over the kernel code and using the linker is easier than resolving
and maintaining complex header interdependencies. Furthermore, using a list
proved to have much higher impact on the size of the patches and was deemed
unacceptable overhead. An ELF table is also ideal because its "readonly" nature means that no locking nor list traversal are required.

Subsequent patches adapt existing parts of the kernel to use a task watcher
 -- typically in the fork, clone, and exit paths:

        FEATURE (notes)                               RELEVANT CONFIG VARIABLE
	-----------------------------------------------------------------------
	audit                                         [ CONFIG_AUDIT ...      ]
	semundo                                       [ CONFIG_SYSVIPC        ]
	cpusets                                       [ CONFIG_CPUSETS        ]
	mempolicy                                     [ CONFIG_NUMA           ]
	trace irqflags                                [ CONFIG_TRACE_IRQFLAGS ]
	lockdep                                       [ CONFIG_LOCKDEP        ]
	keys (for processes -- not for thread groups) [ CONFIG_KEYS           ]
	process events connector                      [ CONFIG_PROC_EVENTS    ]

TODO:
	Mark the task watcher table ELF section read-only. I've tried to "fix"
	the .lds files to do this with no success. I'd really appreciate help
	from folks familiar with writing linker scripts.

	I'm working on three more patches that add support for creating a task
	watcher from within a module using an ELF section. They haven't recieved
	as much attention since I've been focusing on measuring the performance
	impact of these patches.

Changes:
since v2 ():
	Added ELF section annotations to the functions handling the events
	Added section annotation to the lookup table in kernel/task_watchers.c
	Added prefetch hints to the function pointer array walk
	Renamed the macros (better?)
	Retested the patches
	Reduced noise in test results (0.6 - 1%, 2+% previously)

With the last prefetch patch I was able to measure a performance increase in
the range of 0.4 to 2.8%. I sampled 100 times and took the mean for each patch.
Since the numbers seemed to be a source of confusion last time I've tried to
simplify them here:

Patch    Mean (forks/second)
0        6925.16 (baseline)
1        7170.81  task watchers
2        7100.34  audit
3        7114.47  semundo
4        7185.7   cpusets
5        7121.41  numa-mempolicy
6        7070.82  irqflags
7        7012.61  lockdep
8        7116.54  keys
9        7116.35  procevents
12       7109.52  prefetch
----------------------------------------------------
7109.52 - 6925.16 = +184 forks/second (+2.6%)

So the patch series now actually improves performance a little.

All the numbers from the tests are available if anyone wishes to analyze them
independently.

Please consider for inclusion in -mm.

Cheers,
	-Matt Helsley
