Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWCaQRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWCaQRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCaQRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:17:49 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:18067 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751298AbWCaQRs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:17:48 -0500
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <200603311800.19364.ak@suse.de>
From: Jes Sorensen <jes@sgi.com>
Date: 31 Mar 2006 11:18:57 -0500
In-Reply-To: <200603311800.19364.ak@suse.de>
Message-ID: <yq0odzmtwni.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

Andi> On Friday 31 March 2006 17:38, Jes Sorensen wrote:
>> Hi,
>> 
>> Patch 70674f95c0a2ea694d5c39f4e514f538a09be36f [PATCH] Optimize
>> select/poll by putting small data sets on the stack resulted in the
>> poll stack being 4-byte aligned on 64-bit architectures, causing
>> misaligned accesses to elements in the array.
>> 
>> This patch fixes it by declaring the stack in terms of 'long'
>> instead of 'char'.

Andi> You should do that for poll too then.

I assume you mean select().

Updated patch attached.

Jes

Force alignment of poll and select stacks to long to avoid unaligned
access on 64 bit architectures.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 fs/select.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6/fs/select.c
===================================================================
--- linux-2.6.orig/fs/select.c
+++ linux-2.6/fs/select.c
@@ -314,7 +314,7 @@
 	int ret, size, max_fdset;
 	struct fdtable *fdt;
 	/* Allocate small arguments on the stack to save memory and be faster */
-	char stack_fds[SELECT_STACK_ALLOC];
+	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
 
 	ret = -EINVAL;
 	if (n < 0)
@@ -639,8 +639,10 @@
  	struct poll_list *walk;
 	struct fdtable *fdt;
 	int max_fdset;
-	/* Allocate small arguments on the stack to save memory and be faster */
-	char stack_pps[POLL_STACK_ALLOC];
+	/* Allocate small arguments on the stack to save memory and be
+	   faster - use long to make sure the buffer is aligned properly
+	   on 64 bit archs to avoid unaligned access */
+	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
 	struct poll_list *stack_pp = NULL;
 
 	/* Do a sanity check on nfds ... */
