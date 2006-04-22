Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWDVUt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWDVUt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWDVUt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:49:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18900 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751184AbWDVUt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:49:56 -0400
Organization: Dipartimento di Informatica
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: "Ulrich Drepper" <drepper@gmail.com>
Subject: Re: [PATCH] Extending getrusage
Date: Sat, 22 Apr 2006 12:25:30 +0200
User-Agent: KMail/1.8
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       luto@myrealbox.com, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       kernel-janitors@lists.osdl.org, bert.hubert@netherlabs.nl
References: <d0191dad0604200821l3fa0ed70ga2faabe79d7718ec@mail.gmail.com> <d0191dad0604210305n7ce4b59aja5d215d92f95e1f4@mail.gmail.com> <a36005b50604210732h69f4408ey99b7895de8dbd902@mail.gmail.com>
In-Reply-To: <a36005b50604210732h69f4408ey99b7895de8dbd902@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221225.31851.cloud.of.andor@gmail.com>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: non spam, SpamAssassin (punteggio=-1.44,
	necessario 5, autolearn=disabled, ALL_TRUSTED -1.44)
X-MailScanner-From: cloud.of.andor@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 16:32, Ulrich Drepper wrote:
> On 4/21/06, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> > Recently, while writing some code at user level, I needed a fast way
> > to have such information about another process.
> 
> That's not very specific.  And one program isn't really a compelling
> reason.  You should specify with some level of detail why you need
> that information and why you cannot depend on collaboration of the
> process you try to get the information for.

I'm just adding a new feature "for free":

- Without adding any new syscall
- Without changing the prototype of the current syscall (sys_getrusage)
- Ensuring backward compatibility (all old programs will continue to work properly)

This new feature can be used by any process that needs to profile another process for whatever reason.

Since it just adds a new feature without any drawback, I don't understand why it would be wrong...
 
> 
> > -               return -EINVAL;
> > -       return getrusage(current, who, ru);
> > +       struct rusage r;
> > +       struct task_struct *tsk = current;
> > +       read_lock(&tasklist_lock);
> 
> You are introducing scalability problems where there were none before.
>  Even if there is some justification revealed in the end IMO the patch
> shouldn't be accepted in this form.  You should not slow down the
> normal case of operation.  If the current thread is observed the lock
> isn't needed.

I think you're wrong: I'm not introducing any *new* scalability issue. 

Currently the code is:

asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
{
        if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
                return -EINVAL;
        return getrusage(current, who, ru);
}

which in turn calls

int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
{
        struct rusage r;
        read_lock(&tasklist_lock);
        k_getrusage(p, who, &r);
        read_unlock(&tasklist_lock);
        return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
}

As you can see, the lock is acquired also when not needed. That's how it is currently implemented.

With my patch, k_getrusage is called directly from sys_getrusage without going through getrusage.

               Claudio




