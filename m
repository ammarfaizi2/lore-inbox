Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVAGMLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVAGMLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVAGMLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:11:08 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:22267 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261383AbVAGMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:10:53 -0500
Message-ID: <41DE7C69.3030008@ak.jp.nec.com>
Date: Fri, 07 Jan 2005 21:11:21 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       holt@sgi.com, jeffrey.hundstad@mnsu.edu, schwab@suse.de,
       rusty@rustcorp.com.au, chrisw@osdl.org, pagg@oss.sgi.com
Subject: Re: [RFC][PATCH] a revised job patch (with jobfs)
References: <200412160006.iBG06Zj25577@dbear.engr.sgi.com>
In-Reply-To: <200412160006.iBG06Zj25577@dbear.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Limin Gu

This JOB-fs approach is so ambitious, I think.
I tried to apply your JOB-fs patch toward 2.6.9,
then I noticed some promlems as follows.

(1) The JOB-fs patch needs include/linux/jobctl.h and include/linux/job_acct.h.
  But these are contained in linux-2.6.9-job.patch, not JOB-fs patch.
  Since those patches conflict, we need to extract the jobctl.h and job_acct.h
  from linux-2.6.9-job.patch.

(2) The return value of mkdir() under the /jids is strange.
  The directory of 'jids' has a mkdir() method implemented by jobfs_mkdir().
  Since jobfs_mkdir() returns the result of job_create() transparently,
  my mkdir operations alwaly failed.
  ----------------
  /*
   * job_create - create a new job and attache the calling process to it.
   * @jid: new job id
   * @user: job owner
   * @options: not used
   *
   * return 0 on job is DISABLE, -errno on failure, 1 on success
   */
  ----------------
  This is the description of job_create(). This returns 1 on success,
  but VFS layer recognize it as a failure.

  I modified this as follows:
--- job.c   2005-01-06 20:03:47.000000000 +0900
+++ kaigai_job.c       2005-01-07 20:16:55.518703400 +0900
@@ -1505,5 +1505,5 @@
                 return -EINVAL;
         ret = job_create(jid, current->uid, 0);
-       return ret;
+       return (ret==1) ? 0 : ((ret==0) ? -EINVAL : ret); // Dirty?
  }

(3) We can not make a JOB by using a /bin/mkdir command.
  When I execute '/bin/mkdir' on shell program, new process was fork()'ed and execve()'ed.
  This process calls mkdir() system-call and it create a JOB which contains only
  the self process.
  Then '/bin/mkdir' exits process, and the JOB created by '/bin/mkdir' contains no process.
  So, the JOB was destroied soon.
  For avoidance the problem, we need to 'create_job' command which calls mkdir() and
  execve('/bin/bash') in the one process.
  Or pagg+job framework need to allow the existance of the empty JOB.

(4) "echo '123' > hid" fails by -EPERM.
  When we open the 'hid' with O_TRUNC flag, operation returns -EPERM.
  setattr() method of 'hid' was called on extention of sys_open().
  * sys_open() -> filp_open() -> open_namei() -> may_open()
    -> do_truncate() (When O_TRUNC was appended)
      -> notify_change()
        -> inode's setattr() (It always returns -EPERM.)
  If we can't use 'echo', it's pretty inexpediency.

And, would you have this discussion on PAGG-ML also ?
Because LKML has huge traffic, I have not noticed job-fs for two weeks. orz
Thanks.
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
