Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVJMAxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVJMAxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJMAxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:53:05 -0400
Received: from silver.veritas.com ([143.127.12.111]:13461 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932477AbVJMAxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:53:04 -0400
Date: Thu, 13 Oct 2005 01:52:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] mm: mm_struct hiwaters moved
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130150580.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:53:03.0792 (UTC) FILETIME=[778D5B00:01C5CF90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slight and timid rearrangement of mm_struct: hiwater_rss and hiwater_vm
were tacked on the end, but it seems better to keep them near _file_rss,
_anon_rss and total_vm, in the same cacheline on those arches verified.

There are likely to be more profitable rearrangements, but less obvious
(is it good or bad that saved_auxv[AT_VECTOR_SIZE] isolates cpu_vm_mask
and context from many others?), needing serious instrumentation.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/sched.h |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

--- mm06/include/linux/sched.h	2005-10-11 23:54:33.000000000 +0100
+++ mm07/include/linux/sched.h	2005-10-11 23:55:22.000000000 +0100
@@ -280,16 +280,19 @@ struct mm_struct {
 						 * by mmlist_lock
 						 */
 
-	unsigned long start_code, end_code, start_data, end_data;
-	unsigned long start_brk, brk, start_stack;
-	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long total_vm, locked_vm, shared_vm;
-	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
-
 	/* Special counters protected by the page_table_lock */
 	mm_counter_t _file_rss;
 	mm_counter_t _anon_rss;
 
+	unsigned long hiwater_rss;	/* High-watermark of RSS usage */
+	unsigned long hiwater_vm;	/* High-water virtual memory usage */
+
+	unsigned long total_vm, locked_vm, shared_vm, exec_vm;
+	unsigned long stack_vm, reserved_vm, def_flags, nr_ptes;
+	unsigned long start_code, end_code, start_data, end_data;
+	unsigned long start_brk, brk, start_stack;
+	unsigned long arg_start, arg_end, env_start, env_end;
+
 	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:2;
@@ -309,11 +312,7 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
-
 	struct kioctx		default_kioctx;
-
-	unsigned long hiwater_rss;	/* High-water RSS usage */
-	unsigned long hiwater_vm;	/* High-water virtual memory usage */
 };
 
 struct sighand_struct {
