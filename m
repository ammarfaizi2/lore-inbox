Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVBWIdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVBWIdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 03:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVBWIdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 03:33:49 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56236 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261420AbVBWIdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 03:33:46 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, jlan@sgi.com,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com, elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050222232002.4d934465.akpm@osdl.org>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <20050222232002.4d934465.akpm@osdl.org>
Date: Wed, 23 Feb 2005 09:33:42 +0100
Message-Id: <1109147623.1738.91.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 09:42:36,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 09:42:39,
	Serialize complete at 23/02/2005 09:42:39
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 23:20 -0800, Andrew Morton wrote:
> Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
> >
> >  The common agreement for the method of dealing with process aggregation
> >  has not been constructed yet, I understood. And, we will not able to
> >  integrate each process aggregation model because of its diverseness.
> > 
> >  For example, a process which belong to JOB-A must not belong any other
> >  'JOB-X' in CSA-model. But, In ELSA-model, a process in BANK-B can concurrently
> >  belong to BANK-B1 which is a child of BANK-B.
> > 
> >  And, there are other defferences:
> >  Whether a process not to belong to any process-aggregation is permitted or not ?
> >  Whether a process-aggregation should be inherited to child process or not ?
> >  (There is possibility not to be inherited in a rule-based process aggregation like CKRM)
> > 
> >  Some process-aggregation model have own philosophy and implemantation,
> >  so it's hard to integrate. Thus, I think that common 'fork/exec/exit' event handling
> >  framework to implement any kinds of process-aggregation.

I can add "policies". With ELSA, a process belongs to one or several
groups and if a process is removed from one group, its children still
belong to the group. Thus a good idea could be to associate a
"philosophy" to a group. For exemple, when a group of processes is
created it can be tagged as UNIQUE or SHARED. UNIQUE means that a
process that belongs to it could not be added in another group by
opposition to SHARED. It's not needed inside the kernel.

> We really want to avoid doing such stuff in-kernel if at all possible, of
> course.
> 
> Is it not possible to implement the fork/exec/exit notifications to
> userspace so that a daemon can track the process relationships and perform
> aggregation based upon individual tasks' accounting?  That's what one of
> the accounting systems is proposing doing, I believe.

It's what I'm proposing. The problem is to be alerted when a new process
is created in order to add it in the correct group of processes if the
parent belongs to one (or several) groups. The notification can be done
with the fork connector patch. 

> (In fact, why do we even need the notifications?  /bin/ps can work this
> stuff out).

Yes it can but the risk is to lose some forks no? 
I think that /bin/ps is using the /proc interface. If we're polling
the /proc to catch process creation we may lost some of them. With the
fork connector we catch all forks and we can check that by using the
sequence number (incremented by each fork) of the message.

Guillaume

