Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVAGSNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVAGSNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAGSLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:11:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:1229 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261424AbVAGSG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:06:28 -0500
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200501071805.j07I5R428218@dbear.engr.sgi.com>
Subject: Re: [RFC][PATCH] a revised job patch (with jobfs)
To: kaigai@ak.jp.nec.com (Kaigai Kohei)
Date: Fri, 7 Jan 2005 10:05:27 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de (Jan Engelhardt),
       holt@sgi.com, jeffrey.hundstad@mnsu.edu, schwab@suse.de,
       rusty@rustcorp.com.au, chrisw@osdl.org, pagg@oss.sgi.com,
       limin@dbear.engr.sgi.com (Limin Gu)
In-Reply-To: <41DE7C69.3030008@ak.jp.nec.com> from "Kaigai Kohei" at Jan 07, 2005 09:11:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi, Limin Gu
> 
> This JOB-fs approach is so ambitious, I think.
> I tried to apply your JOB-fs patch toward 2.6.9,
> then I noticed some promlems as follows.

Hi KaiGai Kohei,

Thank you for your interest in job. I am planning to post a slightly modified
version of job patch against 2.6.10 pretty soon, and also the pointer to the 
job userland library and commands.

> 
> (1) The JOB-fs patch needs include/linux/jobctl.h and include/linux/job_acct.h.
>   But these are contained in linux-2.6.9-job.patch, not JOB-fs patch.
>   Since those patches conflict, we need to extract the jobctl.h and job_acct.h
>   from linux-2.6.9-job.patch.

The jobfs patch I posted last time should not need include/linux/jobctl.h and 
include/linux/job_acct.h, it only needed include/linux/job.h. I don't know 
why you had that problem.  

Your questions below 2-4 are all related to how to use job in the userland.
We provide an extensive job library (libjob.so) for C codes, and serveral
job commands for shell enviroment. User should use the library and commands
instead of directly use /bin/mkdir and echo, the reason is that we want to
maintain the job library and command the same as before and we want jobfs
as simple as possible.  

> 
> (2) The return value of mkdir() under the /jids is strange.

Yes, the return value is hacked to return the newly created jid. 

>   The directory of 'jids' has a mkdir() method implemented by jobfs_mkdir().
>   Since jobfs_mkdir() returns the result of job_create() transparently,
>   my mkdir operations alwaly failed.
>   ----------------
>   /*
>    * job_create - create a new job and attache the calling process to it.
>    * @jid: new job id
>    * @user: job owner
>    * @options: not used
>    *
>    * return 0 on job is DISABLE, -errno on failure, 1 on success
>    */
>   ----------------
>   This is the description of job_create(). This returns 1 on success,
>   but VFS layer recognize it as a failure.
> 
>   I modified this as follows:
> --- job.c   2005-01-06 20:03:47.000000000 +0900
> +++ kaigai_job.c       2005-01-07 20:16:55.518703400 +0900
> @@ -1505,5 +1505,5 @@
>                  return -EINVAL;
>          ret = job_create(jid, current->uid, 0);
> -       return ret;
> +       return (ret==1) ? 0 : ((ret==0) ? -EINVAL : ret); // Dirty?
>   }
> 
> (3) We can not make a JOB by using a /bin/mkdir command.

We provide job_create() library call for job creation.

We also provide a library pam_job.so that allows job creation through 
PAM modules. For example, if add "account optional /lib/security/pam_job.so" 
line to /etc/pam.d/rlogin file, every rlogin will create a new job, and
all the processes from that login are contained in the same job, unless
somebody with proper permission decide to detach (processes or the job). 


>   When I execute '/bin/mkdir' on shell program, new process was fork()'ed and execve()'ed.
>   This process calls mkdir() system-call and it create a JOB which contains only
>   the self process.
>   Then '/bin/mkdir' exits process, and the JOB created by '/bin/mkdir' contains no process.
>   So, the JOB was destroied soon.
>   For avoidance the problem, we need to 'create_job' command which calls mkdir() and
>   execve('/bin/bash') in the one process.
>   Or pagg+job framework need to allow the existance of the empty JOB.
> 
> (4) "echo '123' > hid" fails by -EPERM.

We have job_sethid() library call, and jsethid command avaible.


>   When we open the 'hid' with O_TRUNC flag, operation returns -EPERM.
>   setattr() method of 'hid' was called on extention of sys_open().
>   * sys_open() -> filp_open() -> open_namei() -> may_open()
>     -> do_truncate() (When O_TRUNC was appended)
>       -> notify_change()
>         -> inode's setattr() (It always returns -EPERM.)
>   If we can't use 'echo', it's pretty inexpediency.
> 
> And, would you have this discussion on PAGG-ML also ?
> Because LKML has huge traffic, I have not noticed job-fs for two weeks. orz
> Thanks.

Good idea. Thanks!

I am planning to post the new job patch(with jobfs implementation) and a new
job userland rpm, i.e. the job library and commands that work with jobfs 
instead of the current ioctl calls, today on oss.sgi.com/projects/pagg.
Let me know any problems. I appreciate your time.

--Limin


> -- 
> Linux Promotion Center, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
> 

