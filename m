Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUHVFez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUHVFez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUHVFey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:34:54 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:30816 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266200AbUHVFev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:34:51 -0400
Message-ID: <41282FC0.1090103@yahoo.com.au>
Date: Sun, 22 Aug 2004 15:31:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 2/2] use hlist for pid hash
References: <412824BE.4040801@yahoo.com.au>	<4128252E.1080002@yahoo.com.au> <20040821220044.6974387d.davem@redhat.com>
In-Reply-To: <20040821220044.6974387d.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060108010708050709090403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060108010708050709090403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> On Sun, 22 Aug 2004 14:46:38 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Any reason why this shouldn't be done? Anyone know of a decent test that
>>stresses the pid hash?
> 
> 
> I can't think of any way in which this could decrease
> performance.  I highly recommend this patch :-)
> 

Oh good :)

The only thing that could hurt is that the hash list traversal in
find_pid now does prefetch.

This would be trivial to remove by introducing another list.h entity
similar to __list_for_each for hlists, however I would have thought
that if anything, the prefetch might help a tiny bit on the odd
workloads where the number of tasks is much greater than the number
of hash entries. Ingo? WLI?

I expect you could get a good bit of overlap on the prefetch if the
next hash pointer isn't in the same cacheline as ->nr... although,
on a 64-bit architecture with a 32byte cacheline size, this is
guaranteed to be the case. Why not put them together?

--------------060108010708050709090403
Content-Type: text/x-patch;
 name="pid-search-cacheline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pid-search-cacheline.patch"




---

 linux-2.6-npiggin/include/linux/pid.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN include/linux/pid.h~pid-search-cacheline include/linux/pid.h
--- linux-2.6/include/linux/pid.h~pid-search-cacheline	2004-08-22 15:14:33.000000000 +1000
+++ linux-2.6-npiggin/include/linux/pid.h	2004-08-22 15:16:33.000000000 +1000
@@ -12,11 +12,12 @@ enum pid_type
 
 struct pid
 {
+	/* Try to keep hash_chain in the same cacheline as nr for find_pid */
+	struct hlist_node hash_chain;
 	int nr;
 	atomic_t count;
 	struct task_struct *task;
 	struct list_head task_list;
-	struct hlist_node hash_chain;
 };
 
 struct pid_link

_

--------------060108010708050709090403--
