Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUBTBiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUBTBiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:38:17 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:47062 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267591AbUBTBiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:38:05 -0500
Message-ID: <403564DA.8040303@cyberone.com.au>
Date: Fri, 20 Feb 2004 12:37:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, LSE <lse-tech@lists.sourceforge.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Anton Blanchard <anton@samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.3-rc3-mm1: sched-group-power
References: <200402200117.i1K1H8i06599@owlet.beaverton.ibm.com>
In-Reply-To: <200402200117.i1K1H8i06599@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:

>Nick, I'm not sure what capability this patch adds .. perhaps some words
>of explanation.
>
>So we have SMT/HT situations where we'd prefer to balance across cores;
>that is, if 0, 1, 2, and 3 share a core and 4, 5, 6, and 7 share a core,
>you'd like two processes to arrange themselves so one is on [0123] and
>another is on [4567].  This is what the SD_IDLE flag indicated before.
>
>With this patch, we can "weight" the load imposed by certain cpus, right?
>What advantage does this give us?  On a given machine, won't the "weight"
>of any one set of SMT siblings and cores be uniform with respect to all
>the cores and siblings anyway?
>
>

It is difficult to propogate the SD_FLAG_IDLE attribute up
multiple domains.

For example, with SMT + CPU + NODE domains you can get into
the following situation:

01, 23 are 4 siblings in 2 cores on node 0,
45, 67 are " " " on node 1.

The top level balancing domain now spans 01234567, and wants to
balance between groups 0123, and 4567. We don't want SD_FLAG_IDLE
semantics here, because that would mean if two tasks were running
on node 0, one would be migrated to node 1. We want to migrate 1
task if one node is idle, and the other has 3 processes running for
example.

Also this copes with siblings becoming much more powerful, or
some groups with SMT turned off, some on (think hotplug cpu),
different speed CPUs, etc.

