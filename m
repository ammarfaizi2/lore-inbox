Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWHVJCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWHVJCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHVJCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:02:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:32682 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750785AbWHVJCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:02:09 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060820174839.GH13917@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 11:10:36 +0000
Message-Id: <1156245036.6482.16.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 23:18 +0530, Srivatsa Vaddagiri wrote:

> As an example, follow these steps to create metered cpusets:
> 
> 
> 	# cd /dev
> 	# mkdir cpuset
> 	# mount -t cpuset cpuset cpuset
> 	# cd cpuset
> 	# mkdir grp_a
> 	# cd grp_a
> 	# /bin/echo "6-7" > cpus	# assign CPUs 6,7 for this cpuset
> 	# /bin/echo 0 > mems		# assign node 0 for this cpuset
> 	# /bin/echo 1 > cpu_exclusive
> 	# /bin/echo 1 > meter_cpu
> 
> 	# mkdir very_imp_grp
> 	# Assign 80% bandwidth to this group
> 	# /bin/echo 80 > very_imp_grp/cpu_quota
> 
> 	# echo $apache_webserver_pid > very_imp_grp/tasks
> 
> 	# mkdir less_imp_grp
> 	# Assign 5% bandwidth to this group
> 	# /bin/echo 5 > less_imp_grp/cpu_quota
> 
> 	# echo $mozilla_browser_pid > less_imp_grp/tasks

Doesn't seem to work here, but maybe I'm doing something wrong.

I set up cpuset "all" containing cpu 0-1 (all, 1.something cpus I have;)
exactly as you created grp_a.  I then creaded sub-groups mikeg and root,
and gave them 20% and 80% sub-group/cpu_quota respectively, and plunked
one shell in mikeg/tasks, and two in root/tasks.

In each root shell, I started a proggy that munches ~80% cpu.

top - 10:51:12 up 32 min, 10 users,  load average: 2.00, 2.81, 2.69
Tasks: 114 total,   3 running, 111 sleeping,   0 stopped,   0 zombie
Cpu(s): 79.7% us,  0.0% sy,  0.0% ni, 20.3% id,  0.0% wa,  0.0% hi,  0.0% si

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 6503 root      15   0  1368  276  228 S   79  0.0   0:31.03 f
 6504 root      15   0  1368  280  228 R   78  0.0   0:29.17 f

I then add the same to the mikeg shell.

top - 10:54:37 up 35 min, 10 users,  load average: 3.80, 2.95, 2.74
Tasks: 115 total,   6 running, 109 sleeping,   0 stopped,   0 zombie
Cpu(s): 94.7% us,  0.5% sy,  0.0% ni,  4.8% id,  0.0% wa,  0.0% hi,  0.0% si

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 6503 root      15   0  1368  276  228 S   65  0.0   3:12.86 f
 6505 mikeg     15   0  1368  276  228 R   64  0.0   0:11.77 f
 6504 root      16   0  1368  280  228 R   59  0.0   3:10.58 f

If I add a third to root, the percentages go to roughly 50% per.

	-Mike

