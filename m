Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262900AbTCVRCM>; Sat, 22 Mar 2003 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262898AbTCVRCM>; Sat, 22 Mar 2003 12:02:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57096 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262900AbTCVRCK>; Sat, 22 Mar 2003 12:02:10 -0500
Date: Sat, 22 Mar 2003 17:13:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030322171312.H8712@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030322103121.A16994@flint.arm.linux.org.uk> <1048345130.8912.9.camel@irongate.swansea.linux.org.uk> <20030322141006.A8159@flint.arm.linux.org.uk> <1048346885.1708.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048346885.1708.2.camel@laptop.fenrus.com>; from arjanv@redhat.com on Sat, Mar 22, 2003 at 04:28:05PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 04:28:05PM +0100, Arjan van de Ven wrote:
> 
> > --- orig/kernel/ptrace.c	Wed Mar 19 15:54:45 2003
> > +++ linux/kernel/ptrace.c	Sat Mar 22 10:14:01 2003
> > @@ -22,7 +22,7 @@
> >  int ptrace_check_attach(struct task_struct *child, int kill)
> >  {
> >  	mb();
> > -	if (!is_dumpable(child))
> > +	if (!is_dumpable(child) && !(child->ptrace & PT_PTRACE_CAP))
> >  		return -EPERM;
> >  
> >  	if (!(child->ptrace & PT_PTRACED))
> 
> this sounds really wrong; the child says it doesn't want to be ptraced
> and now you allow it anyway. I think the problem is more that the child
> isn't dumpable.... checking why

ptrace has always explicitly allowed a process with the CAP_SYS_PTRACE
capability to ptrace a task which isn't dumpable.  With the ptrace "fix"
in place, you can attach to a non-dumpable thread:

int ptrace_attach(struct task_struct *task)
{
	...
-       if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
+       if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
                goto bad;
}

but you can't do anything with it (not even detach from it):

int ptrace_check_attach(struct task_struct *child, int kill)
{
	...
+       if (!is_dumpable(child))
+               return -EPERM;
}

So, we went from being able to ptrace daemons as root, to being able to
attach daemons and then being unable to do anything with them, even if
you're root (or have the CAP_SYS_PTRACE capability).  I think this
behaviour is getting on for being described as "insane" 8) and is
clearly wrong.

Note that processes become "undumpable" as soon as they starts playing
with its [GU]IDs (via setre[gu]id, set[gu]id, set_res[gu]id, setfs[ug]id.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

