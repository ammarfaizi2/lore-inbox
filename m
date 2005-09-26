Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbVIZJee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbVIZJee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbVIZJee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:34:34 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:18135 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751614AbVIZJed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:34:33 -0400
Date: Mon, 26 Sep 2005 18:33:59 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] CPUMETER (Re: [PATCH 0/5] SUBCPUSETS: a resource
 control functionality using CPUSETS)
In-Reply-To: <20050910015209.4f581b8a.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050926093432.626D07003D@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jackson-san,

Sorry for the late reply.

I've implemented the cpumeter based on your idea with small modification
on handling meter_cpu.  To make grouping the metered cpus and nodes 
easier,  I modified your idea so that the meter_cpu file is also used for
marking the toplevel of the metered CPUSET (CPUSET 1).  The toplevel 
CPUSET (CPUSET 1) is also metered, that is different from the 
subcpuset_top file of SUBCPUSETS.


      +-----------------------------------+
      |                                   |
   CPUSET 0                            CPUSET 1
   sched domain A                      sched domain B
   cpus: 0, 1                          cpus: 2, 3
   cpu_exclusive=1                     cpu_exclusive=1
   meter_cpu=0                         meter_cpu=1
                                       meter_cpu_*
                                          |
                         +----------------+----------------+
                         |                |                |
                      CPUSET 1a        CPUSET 1b        CPUSET 1c
                      cpus: 2, 3       cpus: 2, 3       cpus: 2, 3
 		     cpu_exclusive=0  cpu_exclusive=0  cpu_exclusive=0
                      meter_cpu=1      meter_cpu=1      meter_cpu=1
                      meter_cpu_*      meter_cpu_*      meter_cpu_*
                         |
            +------------+------------+
            |                         |
         CPUSET 2a                CPUSET 2b
         cpus: 2, 3               cpus: 2, 3
        cpu_exclusive=0          cpu_exclusive=0
         meter_cpu=1              meter_cpu=1
         meter_cpu_*              meter_cpu_*

Here are other rules around meters:
- If meter_cpu is 1, meter_cpu_* files appear.
- The children (CPUSET 1a, 1b, 1c) inherit CPUSET 1's value of 
  cpus/mems/meter_cpu/... and do not have their specific values.
- The metered CPUSETS can have their children
  (this is not allowed in SUBCPUSETS).
- meter_cpu in the children of metered CPUSETS can not be modified
  (can not create normal CPUSETS under metered CPUSETS).

I'll send patches right after this mail.

Comments appreciated,
KUROSAWA, Takahiro
