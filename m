Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWKCUqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWKCUqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbWKCUqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:46:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48594 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753528AbWKCUqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:46:44 -0500
Date: Fri, 3 Nov 2006 12:46:41 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204641.15739.87085.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
References: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/7] Avoid taking rq lock in wake_priority_sleeper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid taking the rq lock in wake_priority sleeper

Avoid taking the request queue lock in wake_priority_sleeper if
there are no running processes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-02 17:31:05.964060772 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-03 12:51:15.281805162 -0600
@@ -2899,6 +2899,9 @@ static inline int wake_priority_sleeper(
 	int ret = 0;
 
 #ifdef CONFIG_SCHED_SMT
+	if (!rq->nr_running)
+		return 0;
+
 	spin_lock(&rq->lock);
 	/*
 	 * If an SMT sibling task has been put to sleep for priority
