Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVLUAPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVLUAPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLUAPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:15:34 -0500
Received: from smtp6.libero.it ([193.70.192.59]:1421 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id S1751076AbVLUAPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:15:34 -0500
From: borsa77@libero.it
To: Jesper Juhl <jesper.juhl@gmail.com>
Date: Wed, 21 Dec 2005 01:15:52 +0100
Subject: Re: [PATCH] Correction to kmod.c control loop
CC: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Message-ID: <43A8ACC8.3080.10A9FC4@localhost>
In-reply-to: <9a8748490512201511v62153b33pfae22e512103552a@mail.gmail.com>
References: <43A89499.1824.AC225C@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Dec 2005 at 0:11, Jesper Juhl wrote:

> > That is the right way of course, but the portion of kmod.c I look is the
> > same from 2.2.x series.
> >
> That may be so, but if you don't work against the latest kernel your
> patches are unlikely to apply cleanly (other nearby bits of the file
> may have changed causing patch to become confused), and also,
> maintainers will usually request that you submit a re-diff'ed patch
> against the latest kernel *anyway* before they will consider merging
> your patch, so by working against an old kernel you are only creating
> more work for both yourself and people reviewing and/or considering
> applying your patches.
> Work to make review and merging as easy on everyone else as you can -
> starting out by submitting patches only against latest 2.4.x or 2.6.x
> is a good place to start.

I look in the kmod.c for 2.6.x that you have linked below, actually it was 
reimplemented, so the patch is only for 2.4.x.

> > > Why are you changing the type of waitpid_result ?
> >
> > Because the man page for waitpid function tells the return type is pid_t.
> >
> Ok, but you just created a potential problem by then later returning
> pid_t from a function supposed to be returning int.
> When making changes like this you should explain in your mail that go
> along with your patch *why* you are changing things and how you've
> made sure they are safe - you need to be able to explain that.

It would be only a formal change, and as you have reported below pid_t 
is an integer.

> > > You changed MAX_KMOD_CONCURRENT from a constant to a variable above,
> > > but you never assign a value to it, so here you are comparing i to an
> > > uninitialized variable, not good.
> >
> >
> > It is a _static_ local variable so it is assigned automatically to zero, I
> > think.
> >
> Not good enough. Either you *know* that it will be initialized to
> zero, and if so you should state that in your explanation of what the
> patch does or you should explicitly initialize it.

I have read the K&R: now I know.

> > > >         if (atomic_read(&kmod_concurrent) > i) {
> > > > @@ -208,6 +206,7 @@
> > > >                         printk(KERN_ERR
> > > >                                "kmod: runaway modprobe
> > loop assumed
> > > > and stopped\n");
> > > >                 atomic_dec(&kmod_concurrent);
> > > > +               MAX_KMOD_CONCURRENT =
> > > > 2*MAX_KMOD_CONCURRENT+1;
> > >
> > > why multiply by two and add 1 here?
> >
> >
> > For to grow up the previously zero value at each failure loop.
> > See (ii) below.
> >
> Yes, I understand that you wish to grow it, it's just not clear to me
> why you want to grow it like that.

To tune system capability to user request.

> > > >                 return -ENOMEM;
> > > >         }
> > > >
> > > > @@ -237,6 +236,7 @@
> > > >         if (waitpid_result != pid) {
> > > >                 printk(KERN_ERR "request_module[%s]: waitpid(%d,...)
> > > > failed, errno %d\n",
> > > >                        module_name, pid, -waitpid_result);
> > > > +               return waitpid_result;
> > >
> > > Ehh, the function returns an int, but you just changed the type of
> > > waitpid_result to pid_t above...
> >
> >
> > True, I had better control with grep that pid_t is an integer type.
> >
> pid_t is defined as
>   typedef __kernel_pid_t          pid_t;
> and __kernel_pid_t is
>   typedef int                     __kernel_pid_t;
> on all archs as far as I know, so you end up actually being safe, but
> the problem is you didn't make that clear.
> But, the point I was trying to make was mainly that you shouldn't
> count on that always being true. if the function needs to return an
> int you should return an int, not a pid_t.
> 
> Also, take a look at how the function is implemented in recent kernels :
> http://sosdg.org/~coywolf/lxr/source/kernel/kmod.c#L66
> 
> >
> > > >         }
> > > >         return 0;
> > > >  }

