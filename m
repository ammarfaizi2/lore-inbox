Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUCDALm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUCDALm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:11:42 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46766 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261303AbUCDALk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:11:40 -0500
Subject: [RFC][PATCH] vsyscall-gtod_B3 (0/3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Content-Type: text/plain
Message-Id: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 16:11:22 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This is my port of the x86-64 vsyscall gettimeofday code to i386. This
patch moves gettimeofday into userspace, so it can be calledwithout the
syscall overhead, greatly improving performance. This is important for
any application, like a database, which heavily uses gettimeofday for
time-stamping. It supports both the TSC and IBM x44X cyclone time
source.
	
Example performance gain (using cyclone timesource):

int80 gettimeofday:
gettimeofday ( 1665576us / 1000000runs ) = 1.665574us

systenter gettimeofday:
gettimeofday ( 1239215us / 1000000runs ) = 1.239214us

vsyscall gettimeofday:
gettimeofday ( 875876us / 1000000runs ) = 0.875875us


I've broken the patch into three logical chuncks for clarity and to make
it easier to cherry pick the desired bits. 

o Part 1: Renames variables in timer_cyclone.c and timer_tsc.c to avoid
conflicts in the global namespace.
o Part 2: Core vsyscall-gtod implementation. 
o Part 3: vDSO hooks to avoid LD_PRELOADing or needing changes to glibc

Please let me know if you have any comments or suggestions.

thanks
-john

Existing issues:
----------------
o Bad pointers cause segfaults, rather then -EFAULT.

Release History:
----------------
B2 -> B3:
o Broke the patch up into 3 chunks
o Added vsyscall-int80.S hooks (4G disables SEP)

B1 -> B2:
o No LD_PRELOADing or changes to userspace required!
o removed hard-coded address in linker script

B0 -> B1:
o Cleaned up 4/4 split code, so no additional patch is needed.
o Fixed permissions on fixmapped cyclone pageo Improved
alternate_instruction workaround 
o Use NTP variables to avoid related time inconsistencieso minor code
cleanups

