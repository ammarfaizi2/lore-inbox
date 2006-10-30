Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbWJ3LH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWJ3LH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbWJ3LH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:07:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53471 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161250AbWJ3LH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:07:28 -0500
Date: Mon, 30 Oct 2006 03:06:35 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030030635.98563962.pj@sgi.com>
In-Reply-To: <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> The cpusets code which this was based on simply locked the task list,
> and traversed it to find threads in the cpuset of interest; you could
> do the same thing in any other resource controller.

I get away with this in the cpuset code because:
 1) I have the cpuset pointer directly in 'task_struct', so don't
    have to chase down anything, for each task, while scanning the
    task list.  I just have to ask, for each task, if its cpuset
    pointer points to the cpuset of interest.
 2) I don't care if I get an inconsistent answer, so I don't have
    to lock each task, nor do I even lockout the rest of the cpuset
    code.  All I know, at the end of the scan, is that each task that
    I claim is attached to the cpuset in question was attached to it at
    some point during my scan, not necessarilly all at the same time.
 3) It's not a flaming disaster if the kmalloc() of enough memory
    to hold all the pids I collect in a single array fails.  That
    just means that some hapless users open for read of a cpuset
    'tasks' file failed, -ENOMEM.  Oh well ...

If someone is actually trying to manage system resources accurately,
they probably can't get away being as fast and loose as this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
