Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVKORAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVKORAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVKORAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:00:19 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:63699 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S964952AbVKORAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:00:17 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: New getrusage
User-Agent: KMail/1.8
Cc: Chris Wright <chrisw@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>,
       Lee Revell <rlrevell@joe-job.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <Pine.LNX.4.63.0511111547310.18982@twinlark.arctic.org> <20051112011006.GD7991@shell0.pdx.osdl.net>
In-Reply-To: <20051112011006.GD7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 15 Nov 2005 18:00:08 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511151800.09279.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I think that a better implementation of getrusage would be the 
following one, but it requires a (new) third parameter. That's why I didn't 
suggest it...

Many thanks,

            Claudio

Signed-off-by: Claudio Scordino <cloud.of.andor@gmail.com>

asmlinkage long sys_getrusage(int who, struct rusage __user *ru, pid_t pid)
{
 struct rusage r;
 struct task_struct* tsk = current;
 if ((pid < 0) || 
    ((who != RUSAGE_SELF) && (who != RUSAGE_CHILDREN))) 
  return -EINVAL;
 read_lock(&tasklist_lock);
 if (pid > 0) {
  tsk = find_task_by_pid(pid);
  if (tsk == NULL)
         goto bad; 
  if (((current->uid != tsk->euid) ||
     (current->uid != tsk->suid) ||
     (current->uid != tsk->uid) ||
     (current->gid != tsk->egid) ||
     (current->gid != tsk->sgid) ||
     (current->gid != tsk->gid)) && !capable(CAP_SYS_PTRACE))
   goto bad;
 }
 k_getrusage(tsk, who, &r);
 read_unlock(&tasklist_lock);
 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;

 bad:
 read_unlock(&tasklist_lock);
 return tsk ? -EPERM : -EINVAL;
}
