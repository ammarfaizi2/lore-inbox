Return-Path: <linux-kernel-owner+w=401wt.eu-S932190AbWLLK5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWLLK5v (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWLLK5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:57:51 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:55325 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932190AbWLLK5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:57:51 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 2.6.19] Do not always end the stack trace with ULONG_MAX
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Date: Tue, 12 Dec 2006 10:57:44 +0000
Message-ID: <20061212105744.18657.76136.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2006 10:58:06.0703 (UTC) FILETIME=[6755B7F0:01C71DDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It makes more sense to end the stack trace with ULONG_MAX only if
nr_entries < max_entries. Otherwise, we lose one entry in the long
stack traces and cannot know whether the trace was complete or not.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/x86_64/kernel/stacktrace.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/stacktrace.c b/arch/x86_64/kernel/stacktrace.c
index 6026b31..65ac2c6 100644
--- a/arch/x86_64/kernel/stacktrace.c
+++ b/arch/x86_64/kernel/stacktrace.c
@@ -32,7 +32,7 @@ static void save_stack_address(void *data, unsigned long addr)
 		trace->skip--;
 		return;
 	}
-	if (trace->nr_entries < trace->max_entries - 1)
+	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = addr;
 }
 
@@ -49,7 +49,8 @@ static struct stacktrace_ops save_stack_ops = {
 void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
 	dump_trace(task, NULL, NULL, &save_stack_ops, trace);
-	trace->entries[trace->nr_entries++] = ULONG_MAX;
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL(save_stack_trace);
 
