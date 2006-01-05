Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752161AbWAETVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbWAETVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWAETVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:21:03 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29098 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752159AbWAETVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:21:00 -0500
Subject: [PATCH 01/01][RFC] Move Exit Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@engr.sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <1136486566.22868.127.camel@stark>
References: <43BB05D8.6070101@watson.ibm.com>
	 <43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	 <1136414431.22868.115.camel@stark>  <20060104151730.77df5bf6.akpm@osdl.org>
	 <1136486566.22868.127.camel@stark>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 11:17:35 -0800
Message-Id: <1136488655.22868.138.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch moves the process event connector exit function above
exit_mm() with the expectation that it will later be removed from the
exit function with other calls that need to take place before exit_mm().

	I'm looking into how this affects the exit_signal field. Please review
but do not apply.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c
+++ linux-2.6.15/kernel/exit.c
@@ -844,10 +844,13 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead) {
  		del_timer_sync(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
+
+	tsk->exit_code = code;
+	proc_exit_connector(tsk);
 	exit_mm(tsk);
 
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -860,13 +863,10 @@ fastcall NORET_TYPE void do_exit(long co
 		disassociate_ctty(1);
 
 	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
-
-	tsk->exit_code = code;
-	proc_exit_connector(tsk);
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
 #endif


