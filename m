Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVAYVTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVAYVTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVAYVRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:17:15 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:16944 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262145AbVAYVNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:13:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mNddc/r9iqKMaLSmVfBsBHdkTnQ7/TqD6EeK3q/4Ttal5iNTqumZmwh7F2Jh0BqUdNQa6qdsfxjRsS4wTXi3EKIaM8fJCla0wA1BWJ9M4wuQWz3xSWb+AcejIfxvPflK1lpargO6PEK0w4cWoC/wLg9G0SX9GrH+wxQ4yJfjCjQ=
Message-ID: <3f250c7105012513136ae2587e@mail.gmail.com>
Date: Tue, 25 Jan 2005 17:13:15 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050122033219.GG11112@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111083837.GE26799@dualathlon.random>
	 <3f250c71050121132713a145e3@mail.gmail.com>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Your OOM Killer patch was tested and a strange behaviour was found.
Basically as normal user we started some applications as openoffice,
mozilla and emacs.
And as a root (in another tty) we started a simple program that uses
malloc in a forever loop as below:

int main (void)
{
  int * mem;
  for (;;)
        mem = (int *) malloc(sizeof(int));
  return 0;
}


Using the original OOM Killer, malloc is the first killed application
and the sytem is restored in a useful state. After applying your patch
and accomplish the same experiment, the OOM Killer it does not kill
malloc program and it enters in a kind of forever loop as below:

1) out_of_memory is invoked;
2) select_bad_process is invoked;
3) the following condition is fullfied;
if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags &
PF_EXITING)) &&
			    !(p->flags & PF_DEAD))
				return ERR_PTR(-1UL);
4) step 1, 2 ,3 above is executed again;

This loop (step 1 until step 4) lasts during a long time (and nothing
is killed) until I give up and reboot the system after waiting for
some minutes.

Any comments? What do you think about our test case? Could you
accomplish the same test case using malloc program as root and other
graphical applications as normal user?

Let me know about your ideas.

BR,

Mauricio Lin.

On Sat, 22 Jan 2005 04:32:19 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Fri, Jan 21, 2005 at 05:45:13PM -0400, Mauricio Lin wrote:
> > Hi Andrew,
> >
> > I have another question. You included an oom_adj entry in /proc for
> > each process. This was the approach you used in order to allow someone
> > or something to interfere the ranking algorithm from userland, right?
> > So if i have an another ranking algorithm in user space, I can use it
> > to complement the kernel decision as necessary. Was it your idea?
> 
> Yes, you should use your userspace algorithm to tune the oom killer via
> the oom_adj and you can check the effect of your changes with oom_score.
> I posted a one liner ugly script to do that a few days ago on l-k.
> 
> The oom_adj has this effect on the badness() code:
> 
>         /*
>          * Adjust the score by oomkilladj.
>          */
>         if (p->oomkilladj) {
>                 if (p->oomkilladj > 0)
>                         points <<= p->oomkilladj;
>                 else
>                         points >>= -(p->oomkilladj);
>         }
> 
> The biggest the points become, the more likely the task will be choosen
> by the oom killer.
>
