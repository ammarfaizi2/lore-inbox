Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423563AbWJaQ30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423563AbWJaQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423564AbWJaQ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:29:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41965 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423563AbWJaQ3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:29:24 -0500
Date: Tue, 31 Oct 2006 22:04:18 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061031163418.GD9588@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45460743.8000501@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 05:08:03PM +0300, Pavel Emelianov wrote:
> 1. One of the major configfs ideas is that lifetime of
>    the objects is completely driven by userspace.
>    Resource controller shouldn't live as long as user
>    want. It "may", but not "must"! As you have seen from
>    our (beancounters) patches beancounters disapeared
>    as soon as the last reference was dropped. Removing
>    configfs entries on beancounter's automatic destruction
>    is possible, but it breaks the logic of configfs.

cpusets has a neat flag called notify_on_release. If set, some userspace
agent is invoked when the last task exists from a cpuset.

Can't we use a similar flag as a configfs file and (if set) invoke a
userspace agent (to cleanup) upon last reference drop? How would this
violate logic of configfs?

> 2. Having configfs as the only interface doesn't alow
>    people having resource controll facility w/o configfs.
>    Resource controller must not depend on any "feature".

One flexibility configfs (and any fs-based interface) offers is, as Matt
had pointed out sometime back, the ability to delage management of a
sub-tree to a particular user (without requiring root permission).

For ex:

			/
			|
		 -----------------
		|		  |
	       vatsa (70%)	linux (20%)
		|
	 ----------------------------------
	|	         | 	          |
      browser (10%)   compile (50%)    editor (10%)

In this, group 'vatsa' has been alloted 70% share of cpu. Also user
'vatsa' has been given permissions to manage this share as he wants. If
the cpu controller supports hierarchy, user 'vatsa' can create further
sub-groups (browser, compile ..etc) -without- requiring root access.

Also it is convenient to manipulate resource hierarchy/parameters thr a
shell-script if it is fs-based.

> 3. Configfs may be easily implemented later as an additional
>    interface. I propose the following solution:

Ideally we should have one interface - either syscall or configfs - and
not both.

Assuming your requirement of auto-deleting objects in configfs can be
met thr' something similar to cpuset's notify_on_release, what other
killer problem do you think configfs will pose?


> > 	- Should we have different groupings for different resources?
> 
> This breaks the idea of groups isolation.

Sorry dont get you here. Are you saying we should support different
grouping for different controllers?

> > 	- Support movement of all threads of a process from one group
> > 	  to another atomically?
> 
> This is not a critical question. This is something that
> has difference in

It can be a significant pain for some workloads. I have heard that
workload management products often encounter processes with anywhere
between 200-700 threads in a process. Moving all those threads one by
one from user-space can suck.


-- 
Regards,
vatsa
