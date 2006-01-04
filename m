Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965315AbWADWqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbWADWqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWADWqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:46:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:1465 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965315AbWADWqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:46:06 -0500
Subject: Re: [ckrm-tech] Re: [Patch 6/6] Delay accounting: Connector
	interface
From: Matt Helsley <matthltc@us.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <43BC1C43.9020101@engr.sgi.com>
References: <43BB05D8.6070101@watson.ibm.com>
	 <43BB09D4.2060209@watson.ibm.com>  <43BC1C43.9020101@engr.sgi.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 14:40:31 -0800
Message-Id: <1136414431.22868.115.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 11:04 -0800, Jay Lan wrote:
> Shailabh Nagar wrote:
<snip>
> >Index: linux-2.6.15-rc7/kernel/exit.c
> >===================================================================
> >--- linux-2.6.15-rc7.orig/kernel/exit.c
> >+++ linux-2.6.15-rc7/kernel/exit.c
> >@@ -29,6 +29,7 @@
> > #include <linux/syscalls.h>
> > #include <linux/signal.h>
> > #include <linux/cn_proc.h>
> >+#include <linux/cn_stats.h>
> >
> > #include <asm/uaccess.h>
> > #include <asm/unistd.h>
> >@@ -865,6 +866,7 @@ fastcall NORET_TYPE void do_exit(long co
> >
> > 	tsk->exit_code = code;
> > 	proc_exit_connector(tsk);
> >+	cnstats_exit_connector(tsk);
> >  
> 
> We need to move both proc_exit_connector(tsk) and
> cnstats_exit_connector(tsk) up to before exit_mm(tsk) statement.
> There are task statistics collected in task->mm and those stats
> will be lost after exit_mm(tsk).
> 
> Thanks,
>  - jay
> 
> > 	exit_notify(tsk);
> > #ifdef CONFIG_NUMA
> > 	mpol_free(tsk->mempolicy);
> >-

	Good point. The assignment of the task exit code will also have to move
up before exit_mm(tsk) because the process event connector exit function
retrieves the exit code from the task struct.

	Moving these may also affect the job/pagg/task_notify/cpuset exit
notification if we're eventually going to remove *direct* calls to these
from kernel/exit.c.

Cheers,
	-Matt Helsley

