Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVFUBuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVFUBuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVFUAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:00:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1451 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261804AbVFTXYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:24:07 -0400
Date: Mon, 20 Jun 2005 16:24:03 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "domen@coderock.org" <domen@coderock.org>, emoenke@gwdg.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] cdrom/aztcd: remove sleep_on() usage
Message-ID: <20050620232403.GC2623@us.ibm.com>
References: <20050620215148.561754000@nd47.coderock.org> <9a87484905062016141082daff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a87484905062016141082daff@mail.gmail.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2005 [01:14:11 +0200], Jesper Juhl wrote:
> On 6/20/05, domen@coderock.org <domen@coderock.org> wrote:
> > From: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > 
> > 
> > Directly use wait-queues instead of the deprecated sleep_on().
> > This required adding a local waitqueue. Patch is compile-tested.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> > ---
> >  aztcd.c |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > Index: quilt/drivers/cdrom/aztcd.c
> > ===================================================================
> > --- quilt.orig/drivers/cdrom/aztcd.c
> > +++ quilt/drivers/cdrom/aztcd.c
> > @@ -179,6 +179,7 @@
> >  #include <linux/ioport.h>
> >  #include <linux/string.h>
> >  #include <linux/major.h>
> > +#include <linux/wait.h>
> > 
> >  #include <linux/init.h>
> > 
> > @@ -429,9 +430,12 @@ static void dten_low(void)
> >  #define STEN_LOW_WAIT   statusAzt()
> >  static void statusAzt(void)
> >  {
> > +       DEFINE_WAIT(wait);
> >         AztTimeout = AZT_STATUS_DELAY;
> >         SET_TIMER(aztStatTimer, HZ / 100);
> > -       sleep_on(&azt_waitq);
> > +       prepare_to_wait(&azt_waitq, &wait, TASK_UNINTERRUPTIBLE);
> > +       schedule();
> > +       finish_wait(&azt_waitq, &wait);
> >         if (AztTimeout <= 0)
> >                 printk("aztcd: Error Wait STEN_LOW_WAIT command:%x\n",
> >                        aztCmd);
> > 
> 
> Hmm, now that noone's sleeping on azt_waitq the two
> wake_up(&azt_waitq); calls in aztStatTimer() don't seem to make much
> sense any more... Can they just go away or?  If they can go away then
> axt_waitq itself would seem to be a goner as well...   It might just
> be me missing something, but this patch looks incomplete and not
> completely thought through to me.

Huh? prepare_to_wait() means the 'wait' here is sleeping on azt_waitq...

Thanks,
Nish
