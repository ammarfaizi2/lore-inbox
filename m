Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVBWHbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVBWHbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 02:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVBWHbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 02:31:03 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21670 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261355AbVBWHaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 02:30:52 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <421B9205.7060704@sgi.com>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org>
	 <1108968681.8398.44.camel@frecb000711.frec.bull.fr>
	 <421B9205.7060704@sgi.com>
Date: Wed, 23 Feb 2005 08:30:50 +0100
Message-Id: <1109143851.16029.40.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 08:39:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/02/2005 08:39:47,
	Serialize complete at 23/02/2005 08:39:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 12:11 -0800, Jay Lan wrote:
>  How ELSA adds per process accounting data
> to your grouping (banks) when a process exit? How do you save
> accounting data you need in task_struct before it is disposed? BSD
> handles that through acct_process() hook at do_exit(). CSA also
> depends on a hook at do_exit() to merge per-process data to per-job
> data. How does ELSA handle this without a need of a do_exit() hook?

  There are three parts in ELSA. 

  There is a job daemon that does process aggregation. It needs a hook
in the do_fork() routine to be able to manage group of processes. So
this part handles process-aggregation by maintaining a complete picture
of the process/thread hierarchy. 

  You can interact with the job daemon with classical IPC and message
operations. Thus we wrote a second part that is the interface between
the user and the job daemon. Through this interface you can add and
remove a process in/from a group, you can stop the job daemon and you
can dump information in a file about current group of processes. 

  This file (that contains information about group of processes) is used
by ELSA, with the accounting file provided by the accton(8) command and
the BSD accounting, to provide per-group of process accounting. So the
third part of ELSA is a parser and also an analyzer. 

  The architecture of ELSA is as follow (I hope that the ASCII picture
will be readable):


         KERNEL             |         USER SPACE
                            |
    -------------------     |       --------------- 
   | 1. Fork connector |  Netlink  | 2. Job Daemon |
   |                   |---------->|               |
    -------------------     |       ---------------
                            |         ^
                            |         | IPC  -----------------
                            |          ---->| 3. Interface    |
                            |               |   (webmin, ...) |---
                            |           --->|                 |   |
                            |          |     -----------------    |
                                       |                   Per-group of
                                 Accounting File            processes
                                 (see accton(8))            accounting


You can see how it works on the following web page:
http://elsa.sourceforge.net/sample_session.html
In the session we're using the fork_history.ko which will be replace by
the fork hook connector.

Best regards,
Guillaume


