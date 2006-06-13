Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWFMX7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWFMX7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWFMX7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:59:10 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10683 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932363AbWFMX7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:59:09 -0400
Subject: [PATCH 00/11] Task watchers:  Introduction
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:52:01 -0700
Message-Id: <1150242721.21787.138.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Task watchers is a notifier chain that sends notifications to registered
callers whenever a task forks, execs, changes its [re][ug]id, or exits.
The goal is to keep the these paths comparatively simple while
enabling the addition of per-task intialization, monitoring, and tear-down
functions by existing and proposed kernel features.

The first patch adds a global atomic notifier chain, registration
functions, and a function to invoke the callers on the chain.

Later patches:

Register a task watcher for process events, shuffle bits of process events
functions around to reduce the code, and turn it into a module. 

Switch task watchers from an atomic to a blocking notifier chain

Register task watchers for:
	Audit
	Per Task Delay Accounting (note: not the taskstats calls)
	Profile

Add a per-task raw notifier chain

Add a task watcher for semundo

Switch the semundo task watcher to a per-task watcher

I've broken up the patches this way for clarity, to allow cherry-picking, and
to help focus the discussion of any potentially controversial details.

Testing:

Each patch applies to 2.6.17-rc6-mm2, compiles, boots, and runs with
audit=1 profile=2 and auditctl -e 0 or 1 during a run of random system calls
with all config values set to y.

I've tested a variety of combinations with respect to the CONNECTOR
and PROC_EVENTS config values:
CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=y
CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=m
CONFIG_CONNECTOR=m, CONFIG_PROC_EVENTS=m
CONFIG_CONNECTOR=n, CONFIG_PROC_EVENTS=n

while all the rest were =y|n:
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

I also did some touch testing of process events with the modular configuration.

While I haven't done every combination of configuration possible I
believe this covers a wide number of common configurations.

Andrew, please consider these patches for inclusion in -mm. Assuming
there are no objections I'd like to aim the task watchers and process events
patches for 2.6.18.

I've Cc'd most of the folks who responded with comments last time and added
folks listed in MAINTAINERS for the audit and profile patches. If anyone
would like to be removed from future Ccs or if there's anyone I ought to add
please let me know.

Cheers,
	-Matt Helsley

-------------------------------------------------------------------------------
Here are some performance numbers for those interested in getting a
rough idea of how applying each patch affects performance. I ran the
benchmarks with two other patches I've posted recently that aren't in this
series:
	profile_make_notifier_blocks_read_mostly
	semundo_simplify

Kernbench
NUMAQ - 16 700MHz PIII processors, Debian Sarge

+Patch 0 - None
Elapsed: 100.99s User: 1163.63s System: 224.24s CPU: 1373.67%
1163.68user 224.49system 1:41.35elapsed 1369%CPU (0avgtext+0avgdata 0maxresident)k
1164.11user 222.03system 1:40.41elapsed 1380%CPU (0avgtext+0avgdata 0maxresident)k
1163.10user 226.21system 1:41.20elapsed 1372%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 0 - None (second run)
Elapsed: 100.57s User: 1163.10s System: 224.01s CPU: 1378.33%
1163.48user 223.40system 1:40.06elapsed 1385%CPU (0avgtext+0avgdata 0maxresident)k
1161.64user 224.99system 1:40.63elapsed 1377%CPU (0avgtext+0avgdata 0maxresident)k
1164.18user 223.64system 1:41.01elapsed 1373%CPU (0avgtext+0avgdata 0maxresident)k

+Patch - profile_make_notifier_blocks_read_mostly (Posted outside of this series)
Elapsed: 100.74s User: 1163.92s System: 223.10s CPU: 1376.66%
1164.58user 222.78system 1:41.33elapsed 1369%CPU (0avgtext+0avgdata 0maxresident)k
1163.26user 224.21system 1:40.17elapsed 1385%CPU (0avgtext+0avgdata 0maxresident)k
1163.93user 222.32system 1:40.73elapsed 1376%CPU (0avgtext+0avgdata 0maxresident)k

+Patch - semundo_simplify (Posted outside of this series)
Elapsed: 100.92s User: 1162.45s System: 224.52s CPU: 1373.67%
1163.16user 224.83system 1:40.85elapsed 1376%CPU (0avgtext+0avgdata 0maxresident)k
1162.95user 223.99system 1:41.33elapsed 1368%CPU (0avgtext+0avgdata 0maxresident)k
1161.23user 224.74system 1:40.58elapsed 1377%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 1 - task_watchers
Elapsed: 100.99s User: 1163.45s System: 224.78s CPU: 1374%
1163.45user 224.74system 1:40.30elapsed 1384%CPU (0avgtext+0avgdata 0maxresident)k
1164.55user 223.82system 1:41.12elapsed 1372%CPU (0avgtext+0avgdata 0maxresident)k
1162.34user 225.78system 1:41.56elapsed 1366%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 2 - add a process events task watcher
Elapsed: 100.87s User: 1163.36s System: 225.11s CPU: 1375.67%
1164.12user 225.32system 1:41.13elapsed 1373%CPU (0avgtext+0avgdata 0maxresident)k
1163.05user 226.86system 1:40.87elapsed 1377%CPU (0avgtext+0avgdata 0maxresident)k
1162.92user 223.16system 1:40.61elapsed 1377%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 3 - refactor process events
Elapsed: 100.66s User: 1162.81s System: 227.08s CPU: 1380.33%
1162.62user 226.87system 1:40.69elapsed 1379%CPU (0avgtext+0avgdata 0maxresident)k
1163.26user 226.93system 1:40.56elapsed 1382%CPU (0avgtext+0avgdata 0maxresident)k
1162.54user 227.45system 1:40.72elapsed 1380%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 4 - process events module
Elapsed: 101.06s User: 1162.57s System: 225.67s CPU: 1373%
1164.08user 224.63system 1:40.57elapsed 1380%CPU (0avgtext+0avgdata 0maxresident)k
1160.70user 226.88system 1:40.79elapsed 1376%CPU (0avgtext+0avgdata 0maxresident)k
1162.94user 225.50system 1:41.82elapsed 1363%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 5 - switch to use a blocking notifier chain
Elapsed: 102.52s User: 1162.54s System: 224.73s CPU: 1353.67%
1162.57user 224.95system 1:40.50elapsed 1380%CPU (0avgtext+0avgdata 0maxresident)k
1162.77user 224.85system 1:46.22elapsed 1306%CPU (0avgtext+0avgdata 0maxresident)k
1162.28user 224.39system 1:40.84elapsed 1375%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 6 - add an audit task watcher
Elapsed: 101.07s User: 1161.91s System: 224.90s CPU: 1371.33%
1162.64user 224.15system 1:40.79elapsed 1375%CPU (0avgtext+0avgdata 0maxresident)k
1162.21user 225.85system 1:41.50elapsed 1367%CPU (0avgtext+0avgdata 0maxresident)k
1160.88user 224.69system 1:40.92elapsed 1372%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 7 - add a delayacct task watcher
Elapsed: 101.00s User: 1163.59s System: 224.08s CPU: 1373.33%
1163.09user 225.15system 1:41.04elapsed 1373%CPU (0avgtext+0avgdata 0maxresident)k
1164.51user 221.55system 1:40.89elapsed 1373%CPU (0avgtext+0avgdata 0maxresident)k
1163.17user 225.55system 1:41.06elapsed 1374%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 8 - add a profile task watcher
Elapsed: 100.61s User: 1162.95s System: 224.36s CPU: 1378.33%
1163.38user 224.60system 1:40.93elapsed 1375%CPU (0avgtext+0avgdata 0maxresident)k
1162.59user 224.10system 1:41.00elapsed 1372%CPU (0avgtext+0avgdata 0maxresident)k
1162.88user 224.38system 1:39.89elapsed 1388%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 8 - add a profile task watcher (second run)
Elapsed: 100.95s User: 1164.07s System: 224.58s CPU: 1375%
1164.13user 224.69system 1:40.90elapsed 1376%CPU (0avgtext+0avgdata 0maxresident)k
1164.74user 224.09system 1:40.96elapsed 1375%CPU (0avgtext+0avgdata 0maxresident)k
1163.34user 224.96system 1:40.99elapsed 1374%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 9 - introduce per-task watchers
Elapsed: 100.76s User: 1162.49s System: 225.37s CPU: 1377%
1162.65user 225.80system 1:40.89elapsed 1376%CPU (0avgtext+0avgdata 0maxresident)k
1162.09user 225.44system 1:40.53elapsed 1380%CPU (0avgtext+0avgdata 0maxresident)k
1162.72user 224.86system 1:40.85elapsed 1375%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 10 - add a semundo task watcher
Elapsed: 101.27s User: 1163.71s System: 224.82s CPU: 1370.67%
1163.84user 224.10system 1:41.55elapsed 1366%CPU (0avgtext+0avgdata 0maxresident)k
1163.43user 224.76system 1:41.16elapsed 1372%CPU (0avgtext+0avgdata 0maxresident)k
1163.86user 225.59system 1:41.10elapsed 1374%CPU (0avgtext+0avgdata 0maxresident)k

+Patch 11 - switch the semundo task watcher to a per-task watcher
Elapsed: 100.96s User: 1162.93s System: 224.76s CPU: 1374%
1163.14user 223.37system 1:40.61elapsed 1378%CPU (0avgtext+0avgdata 0maxresident)k
1162.92user 226.02system 1:41.34elapsed 1370%CPU (0avgtext+0avgdata 0maxresident)k
1162.73user 224.88system 1:40.94elapsed 1374%CPU (0avgtext+0avgdata 0maxresident)k

--

