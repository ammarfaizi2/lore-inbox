Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbRFIH7x>; Sat, 9 Jun 2001 03:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbRFIH7n>; Sat, 9 Jun 2001 03:59:43 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:36227 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S264438AbRFIH71>;
	Sat, 9 Jun 2001 03:59:27 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106090759.AAA15771@csl.Stanford.EDU>
Subject: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
To: linux-kernel@vger.kernel.org
Date: Sat, 9 Jun 2001 00:59:24 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

we're starting to develop a checker that finds deadlocks by (1)
computing all lock acquisition paths and (2) checking if two paths
violate a partial order.

E.g., for two threads T1 and T2:
	T1: foo acquires A --> calls bar which tries to acquire B
	T2: baz acquires B --> calls blah which tries to acquire A
all else being equal, this deadlocks.

The checker is pretty primitive.  In particular:
	- lots of false negatives come from the fact that it does not 
	  track interrupt disabling.  A missed deadlock:
		foo acquires A
		bar interrupts foo, disables interrupts, tries to acquire A
	  (Is this the most common deadlock?)

	- many potential false positives since it does not realize when
	two kernel call traces are mutually exclusive.

To check it's mechanics I've enclosed what look to me to be two potential
deadlocks --- given the limits of the tool and my understanding of what
can happen when, these could be (likely be?) false positive, so I'd
appreciate any corrective feedback.

Dawson
--------------------------------------------------------------------
ERROR: violated partial order [lock_super:sb<--->lock_kernel:$none$]
   path for lock_super:sb -> lock_kernel:$none$

seems reasonable: all contained in the same FS.

       path for lock_super:sb -> lock_kernel:$none$
                sysv_new_inode:100:lock_super(sb) --> 145:sysv_write_inode
                        -->sysv_write_node:1183:lock_kernel

        path for lock_kernel -> lock_super:sb
                sysv_get_block:812:lock_kernel --> 855:block_getblk
                  --> block_getblk:766:sysv_free_block
                  --> sysv_free_block:45:lock_super

--------------------------------------------------------------------
ERROR: violated partial order [lock_super:sb<--->lock_kernel:$none$]
   path for lock_super:sb -> lock_kernel:$none$

[BUG] Unless lock_kernel already held, which is certainly possible...

       path for lock_super:sb -> lock_kernel:$none$
               sysv_new_inode:100:lock_super(sb);
                        --> sysv_write_inode:1134:lock_kernel();

       path for lock_kernel--> lock_super:
                fsync_dev:325:lock_kernel --> sync_supers:599:lock_super

-------------------------------------------------------------------
