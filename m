Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVFUACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVFUACH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVFUABj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:01:39 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:30129 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261776AbVFTXeL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:34:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCI5pdrKHdCWeF+kXPx/3SdLn7cYGQW3H+geAmwVqVNcXC+zsJTf41lop28gkZivdcFYQBggqVcvyQRE6AhFV4FJx5UmN5G45H685Ru0hkTV5JlMaaRRQPVQuIyLcYrDvl5baYP8tVbx4oTVvCUZbZAI6Y4navU/vYf941056r0=
Message-ID: <9a87484905062016347da01201@mail.gmail.com>
Date: Tue, 21 Jun 2005 01:34:10 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [patch 2/4] cdrom/aztcd: remove sleep_on() usage
Cc: "domen@coderock.org" <domen@coderock.org>, emoenke@gwdg.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050620232403.GC2623@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620215148.561754000@nd47.coderock.org>
	 <9a87484905062016141082daff@mail.gmail.com>
	 <20050620232403.GC2623@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> On 21.06.2005 [01:14:11 +0200], Jesper Juhl wrote:
> > On 6/20/05, domen@coderock.org <domen@coderock.org> wrote:
> > > From: Nishanth Aravamudan <nacc@us.ibm.com>
> > >
> > >
> > >
> > > Directly use wait-queues instead of the deprecated sleep_on().
> > > This required adding a local waitqueue. Patch is compile-tested.
> > >
> > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > > Signed-off-by: Domen Puncer <domen@coderock.org>
> > > ---
> > >  aztcd.c |    6 +++++-
> > >  1 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > Index: quilt/drivers/cdrom/aztcd.c
> > > ===================================================================
> > > --- quilt.orig/drivers/cdrom/aztcd.c
> > > +++ quilt/drivers/cdrom/aztcd.c
> > > @@ -179,6 +179,7 @@
> > >  #include <linux/ioport.h>
> > >  #include <linux/string.h>
> > >  #include <linux/major.h>
> > > +#include <linux/wait.h>
> > >
> > >  #include <linux/init.h>
> > >
> > > @@ -429,9 +430,12 @@ static void dten_low(void)
> > >  #define STEN_LOW_WAIT   statusAzt()
> > >  static void statusAzt(void)
> > >  {
> > > +       DEFINE_WAIT(wait);
> > >         AztTimeout = AZT_STATUS_DELAY;
> > >         SET_TIMER(aztStatTimer, HZ / 100);
> > > -       sleep_on(&azt_waitq);
> > > +       prepare_to_wait(&azt_waitq, &wait, TASK_UNINTERRUPTIBLE);
> > > +       schedule();
> > > +       finish_wait(&azt_waitq, &wait);
> > >         if (AztTimeout <= 0)
> > >                 printk("aztcd: Error Wait STEN_LOW_WAIT command:%x\n",
> > >                        aztCmd);
> > >
> >
> > Hmm, now that noone's sleeping on azt_waitq the two
> > wake_up(&azt_waitq); calls in aztStatTimer() don't seem to make much
> > sense any more... Can they just go away or?  If they can go away then
> > axt_waitq itself would seem to be a goner as well...   It might just
> > be me missing something, but this patch looks incomplete and not
> > completely thought through to me.
> 
> Huh? prepare_to_wait() means the 'wait' here is sleeping on azt_waitq...
> 
Ahh damn, sorry. Somehow I misread the first argument of
prepare_to_wait() and completely missed the fact that it was sleeping
on azt_waitq. It must be past my bedtime...
My bad - it looks good.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
