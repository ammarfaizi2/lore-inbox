Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753087AbWKCE22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbWKCE22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbWKCE2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:28:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3000 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753090AbWKCE1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:27:54 -0500
Message-Id: <20061103042257.274316000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 02 Nov 2006 20:22:57 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/9] Task Watchers v2: Introduction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of my Task Watchers patches.

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
and maintaining complex header interdependencies. An ELF table is also ideal
because its "readonly" nature means that no locking nor list traversal are
required.

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
since v2 RFC:
	Updated to 2.6.19-rc2-mm2
	Compiled, booted, tested, and benchmarked
	Testing
		Booted with audit=1 profile=2
		Enabled profiling tools
		Enabled auditing
		Ran random syscall test
		IRQ trace and lockdep CONFIG=y not tested
	Benchmarks
		A clone benchmark (try to clone as fast as possible)
			Unrealistic. Shows incremental cost of one task watcher
		A fork benchmark (try to fork as fast as possible)
			Unrealistic. Shows incremental cost of one task watcher
		Kernbench
			Closer to realistic.
		Result summaries follow changelog
		See patches for details
		Fork and clone samples available on request (too large for email)
		Fork and clone benchmark sources will be posted as replies to 00
v2:
	Dropped use of notifier chains
	Dropped per-task watchers
		Can be implemented on top of this
		Still requires notifier chains
	Dropped taskstats conversion
		Parts of taskstats had to move away from the regions of
		copy_process() and do_exit() where task_watchers are notified
	Used linker script mechanism suggested by Al Viro
	Created one "list" of watchers per event as requested by Andrew Morton
		No need to multiplex a single function call
	Easier to static register/unregister watchers: 1 line of code
	val param now used for:
		WATCH_TASK_INIT:  clone_flags
		WATCH_TASK_CLONE: clone_flags
		WATCH_TASK_EXIT:  exit code
		WATCH_TASK_*:     <unused>
	Renamed notify_watchers() to notify_task_watchers()
	Replaced: if (err != 0) --> if (err)
	Added patches converting more "features" to use task watchers
	Added return code handling to WATCH_TASK_INIT
		Return code handling elsewhere didn't seem appropriate
		since there was generally no response necessary
	Fixed process keys free to handle failure in fork as originally coded
		in copy_process
	Added process keys code to watch for [er][ug]id changes

v1:
        Added ability to cause fork to fail with NOTIFY_STOP_MASK
        Added WARN_ON() when watchers cause WATCH_TASK_FREE to stop early
        Moved fork invocation
        Moved exec invocation
        Added current as argument to exec invocation
        Moved exit code assignment
        Added id change invocations
	(70 insertions)
v0:
	Based on Jes Sorensen's Task Notifiers patches (posted to LSE-Tech)


Benchmark result summaries (sorry, this part is 86 columns):
System: 4 1.7GHz ppc64 (Power 4+) processors, 30968600MB RAM, 2.6.19-rc2-mm2 kernel

Clone - Incremental worst-case costs measured in tasks/second and as a percentage of
	expected rate
		Patch
		1 	2 	3 	4 	5 	6 	7 	8 	9
--------------------------------------------------------------------------------------
Incremental
Cost (tasks/s)	-38.12 	12.5 	-84 	25.2 	-187.5 	-0.5834 -11.36 	-125.2 	-64.05
Cost Err	122.3 	17.84 	67.11 	61.03 	41.8 	34.64 	45.53 	58.28 	53.18
Cost (%)	-0.2 	0.07 	-0.5 	0.1 	-1 	-0.004 	-0.06 	-0.7 	-0.4
Cost Err (%)	0.7 	0.1 	0.4 	0.3 	0.2 	0.2 	0.2 	0.3 	0.3


Fork - Incremental worst-case costs measured in tasks/second and as a percentage of
	expected rate
		Patch
		1 	2 	3 	4 	5 	6 	7 	8 	9
--------------------------------------------------------------------------------------
Incremental
Cost (tasks/s)	-64.58 	-35.74 	-33.29 	-25.8 	-139.5 	-7.311 	-9.2 	-131.4 	-50.47
Cost Err	54.09 	27.58 	41.76 	42.47 	49.87 	60.94 	29.72 	39.7 	40.89
Cost (%)	-0.3 	-0.2 	-0.2 	-0.1 	-0.8 	-0.04 	-0.05 	-0.7 	-0.3
Cost Err (%)	0.3 	0.2 	0.2 	0.2 	0.3 	0.3 	0.2 	0.2 	0.2

Kernbench Measurements
Patch	  Elapsed(s) User(s)    System(s) CPU(%)
-	  124.406    439.947    46.615    390.700  <-- baseline 2.6.19-rc2-mm2
1	  124.353    439.935    46.334    390.400
2	  124.234    439.700    46.503    390.800
3	  124.248    439.830    46.258    390.700
4	  124.357    439.753    46.582    390.600
5	  124.333    439.787    46.491    390.700
6	  124.532    439.732    46.497    389.900
7	  124.359    439.756    46.457    390.300
8	  124.272    439.643    46.320    390.500
9	  124.400    439.787    46.485    390.300

Mean:	  124.349    439.787    46.454    390.490
Stddev:	  0.087641   0.095917   0.115309  0.272641

Kernbench - Incremental costs
Patch	  Elapsed(s)  User(s)     System(s)   CPU(%)
1	  -0.053      -0.012      -0.281      -0.3      
2	  -0.119      -0.235       0.169       0.4      
3	   0.014       0.130      -0.245      -0.1      
4	   0.109      -0.077       0.324      -0.1      
5	  -0.024       0.034      -0.091       0.1      
6	   0.199      -0.055       0.006      -0.8      
7	  -0.173       0.024      -0.040       0.4      
8	  -0.087      -0.113      -0.137       0.2      
9	   0.128       0.144       0.165      -0.2      

Mean:	   0.005875   -0.0185      0.018875   -0.0125   
Stddev:	   0.13094     0.12738     0.1877      0.39074

Andrew, please consider these patches for 2.6.20's -mm tree.

Cheers,
	-Matt Helsley

--
