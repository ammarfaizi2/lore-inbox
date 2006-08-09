Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030582AbWHILSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbWHILSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030689AbWHILSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:18:32 -0400
Received: from smoker.itak.sztaki.hu ([195.111.0.10]:45494 "EHLO
	smoker.itak.sztaki.hu") by vger.kernel.org with ESMTP
	id S1030582AbWHILSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:18:31 -0400
From: merlin@sztaki.hu
To: linux-kernel@vger.kernel.org
Subject: question about kill PIDTYPE_TGID patch
Date: Wed, 9 Aug 2006 13:23:12 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608091323.12426.merlin@sztaki.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to compile IBM GPFS(2.3.0-15) Portability Layer with a 2.6.16 
kernel (2.6.16-1.2289_FC6-xen-i686). The compiler stops with 
the error message below:

kdump-kern.c:163: error: `PIDTYPE_TGID' undeclared (first use in this 
function)

As I think, this is because of the PIDTYPE_TGID patch. 

I don't want to get out that patch from the kernel , if there's
a more simple solution.

I hope you can suggest me a solution for the three lines where PIDTYPE_TGID
appears (see below) in the source code.

I'm not subscribed, please CC me the answer!
Thank you very much.
Michael HÉDER

Here comes a part of /usr/lpp/mmfs/src/gpl-linux/kdump-kern.c, this is the 
only function where  PIDTYPE_TGID appears.
=========================================== 
/* Step to next thread in current task.  If no more threads, step to
   next task.  If no more tasks, return false. */
static Boolean tiNext(struct threadIter *ti)
{
#if LINUX_KERNEL_VERSION >= 2060000

#if LINUX_KERNEL_VERSION < 2060900
  unsigned long pidAddr, headAddr, nextAddr;
  struct pid_link *linkP;

  assert(ti->taskP != NULL);
  linkP = &ti->threadP->pids[PIDTYPE_TGID];

  pidAddr = (unsigned long) linkP->pidptr;
  headAddr = pidAddr + offsetof(struct pid, task_list);

  nextAddr = (unsigned long) linkP->pid_chain.next;

  if (nextAddr == headAddr)
  {
    struct pid *pidP = GenericGet(pidAddr, sizeof(struct pid));
    nextAddr = (unsigned long) pidP->task_list.next;
    kFree(pidP);
  }
#else
  unsigned long nextAddr;
  nextAddr = ti->threadP->pids[PIDTYPE_TGID].pid_list.next;
#endif

  ti->threadAddr = (unsigned long) pid_task((struct list_head *) nextAddr,
                                            PIDTYPE_TGID);
  if (ti->threadAddr != ti->taskAddr)
  {
    if (ti->threadP != ti->taskP)
      kFree(ti->threadP);
    ti->threadP = GetTaskStruct(ti->threadAddr);
  }
  else
  {
    ti->taskAddr = ti->threadAddr = (unsigned long) NEXT_TASK(ti->taskP);
    kFree(ti->taskP);
    if (ti->threadP != ti->taskP)
      kFree(ti->threadP);
    ti->taskP = ti->threadP = (ti->taskAddr == TaskAddress) ?
      NULL : GetTaskStruct(ti->taskAddr);
  }

  return ti->threadP != NULL;
#else
  assert(ti->taskP != NULL);
  ti->taskAddr = ti->threadAddr = (unsigned long) NEXT_TASK(ti->taskP);
  kFree(ti->taskP);
                  ti->taskP = ti->threadP = (ti->taskAddr == TaskAddress) ?
    NULL : GetTaskStruct(ti->taskAddr);

  return ti->threadP != NULL;
#endif
}
     
