Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUIKAfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUIKAfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUIKAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:35:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:8954 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268055AbUIKAfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:35:11 -0400
Subject: Re: [Patch 0/6]: Cleanup and rbtree for ext3 reservations in
	2.6.9-rc1-mm4
From: Mingming Cao <cmm@us.ibm.com>
To: Stephen Tweedie <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       pbadari@us.ibm.com, Ram Pai <linuxram@us.ibm.com>
In-Reply-To: <200409071302.i87D2Dus030892@sisko.scot.redhat.com>
References: <200409071302.i87D2Dus030892@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Sep 2004 17:34:44 -0700
Message-Id: <1094862886.1637.7078.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 06:02, Stephen Tweedie wrote:
> The patches in the following set contain several cleanups for ext3
> reservations, fix a reproducable SMP race, and turn the per-superblock
> linear list of reservations into an rbtree for better scaling.

> These changes have been in rawhide for a couple of weeks, and have
> been undergoing testing both within Red Hat and at IBM.  
> 

We have run several tests on this set of the reservation changes. We
compared the results w/o reservation, rbtree based reservation vs link
list based reservation. Here is the tiobench sequential test
results.Note that 2.6.8.1-mm4 kernel include the double link based
per-fs reservation tree.

            tiobench sequential write throughputs
============================================================
Threads no reservation  2.6.8.1-mm4     2.6.8.1-mm4+rbtree patch
1       29              29              29
4       3               29              29
8       4               28              28
16      3               27              27
32      4               27              27
64      3               27              27
128     2               20              25
256     1               20              24 

We did see the rbtree changes scales better on more than 128 threads. We
also run tio random tests, did not see throughput regression there. 

We also re-run the dbench, test results showing that these two
reservations(rbtree based vs link based) performs almost equally well.

dbench average throughputs on 4 runs
==================================================
Threads no reservation  2.6.8.1-mm4     2.6.8.1-mm4_rbtree
1       97              93              96
4       234             250             213
8       201             213             213
16      156             168             169
32      73              106             105
64      38              65              67

We had some concerns about the cpu cost for seeky random write workload
with all the reservation changes before. We are doing some tests in that
area too. 

Mingming

