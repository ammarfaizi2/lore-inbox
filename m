Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTEKWWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTEKWWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:22:15 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:7601 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S261320AbTEKWWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:22:13 -0400
Date: Sun, 11 May 2003 18:32:43 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>,
       "arjanv@redhat.com" <arjanv@redhat.com>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <200305111642_MC3-1-3868-F544@compuserve.com>
Message-ID: <Pine.LNX.4.33.0305111813570.29887-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 May 2003, Chuck Ebbert wrote:

> Yoav Weiss wrote:
>
> > No one specified what audit_log does in this case.  Usually, in such
> > modules, the audit function doesn't just log everything.  It can, for
> > example, rate-limit the logging and just spit a message about the user
> > DoSing the log system.
>
>   Not on the systems I've seen.  Max log file size is 4GB and the
> logs are on their own partition.  If the file fills up the system
> crashes immediately and only administrators can log in after reboot
> until the logs are archived.

In a production system various things happen (no particular order):

-- The audit log functionality allows synchrnous or asynchrnous logging,
as driven by security policy. This would mostly be asynch (think how klog
works)

-- The audit log probably does not go to a local disk but to a log server.

-- The system allows for more finely controlled auditing and gives the
security admin the ability to observe a particular system call for a
particular user, under particular circumstances. (Audit a failed system
call or a successful system call).  In case of unlink, it's probably more
useful to observe a system call that does a ret=0 than ret=-Exxx.

-- Really what we are interested in auditing are untrusted users, who
should be given a limited access to begin with.

In addition, because it provides allow/deny control ability on a per-uid
per-syscall basis, we can simply deny unlink to any thing which is rogue
and not audit it's success or failure. :^) . It WILL fail with an -EPERM,
so why audit it permanently? (One can audit it for a brief period to
create an evidence trail and then turn the audit tap off).

The system I am talking about already allows for all of the above. The
only problem was the issue of defeating accurate due to potential multiple
copy_from_user calls ... Which has been addressed rather nicely thanks to
you all (my thanks to Arjan for pointing out the issue and to Yoav and
Terje for giving solution hints).


Cheers,

Ahmed.

