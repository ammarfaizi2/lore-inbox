Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUEAC1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUEAC1l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 22:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUEAC1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 22:27:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:62616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261672AbUEAC1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 22:27:39 -0400
Date: Fri, 30 Apr 2004 19:27:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-Id: <20040430192712.2e085895.akpm@osdl.org>
In-Reply-To: <20040430113751.GA18296@in.ibm.com>
References: <20040430113751.GA18296@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> Noticed a possible deadlock in __create_workqueue when CONFIG_HOTPLUG_CPU is
>  set.  This can happen when create_workqueue_thread fails to create a worker
>  thread. In that case, we call destroy_workqueue with cpu hotplug lock held.
>  destroy_workqueue however also attempts to take the same lock.

Can we not simply do:


diff -puN kernel/workqueue.c~a kernel/workqueue.c
--- 25/kernel/workqueue.c~a	2004-04-30 19:26:32.003303600 -0700
+++ 25-akpm/kernel/workqueue.c	2004-04-30 19:26:44.492404968 -0700
@@ -334,6 +334,7 @@ struct workqueue_struct *__create_workqu
 				destroy = 1;
 		}
 	}
+	unlock_cpu_hotplug();
 
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -342,7 +343,6 @@ struct workqueue_struct *__create_workqu
 		destroy_workqueue(wq);
 		wq = NULL;
 	}
-	unlock_cpu_hotplug();
 	return wq;
 }
 

_

