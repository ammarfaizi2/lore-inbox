Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTLVBsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLVBsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:48:10 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:33217
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264291AbTLVBsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:48:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Christian Meder <chris@onestepahead.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Date: Mon, 22 Dec 2003 12:47:57 +1100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, gnomemeeting-devel-list@gnome.org
References: <200312201355.08116.kernel@kolivas.org> <20031221085716.GA21322@elte.hu> <1072055962.999.69.camel@localhost>
In-Reply-To: <1072055962.999.69.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312221247.57447.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003 12:19, Christian Meder wrote:
> On Sun, 2003-12-21 at 09:57, Ingo Molnar wrote:
> > * Christian Meder <chris@onestepahead.de> wrote:
> > > I tried to verify your suggestion and found that the P_RTEMS symbol is
> > > not defined on Linux. It seems to be some other kind of realtime
> > > operating system. So the code in question already uses usleep. Now I'm
> > > still digging for other occurances of sched_yield in the pwlib
> > > sources.
> >
> > could you try to strace -f gnomemeeting? Maybe there's no sched_yield()
> > at all. Could you also try to run the non-yielding loop code via:
> >
> > 	nice -19 ./loop &
> >
> > do a couple of such loops still degrade gnomemeeting?
>
> I found the culprit. It's sched_yield again. When I straced gnomemeeting
> even without load I saw a lot of sched_yields. So I googled around for
> 2.6 and sched_yield and found among others
> http://www.hpl.hp.com/research/linux/kernel/o1-openmp.php by David
> Mosberger. I tried gnomemeeting with the romp hack at the end of the
> article which changes all sched_yields to noops via library preloading.
> The difference was _really_ impressive. No matter how many non-yield
> loops and kernel compiles I ran gnomemeeting didn't even skip once.

It's a valuable lesson to us that the sched_yield() issue is one we should be 
suspicious of. I'm very happy that it performs well for you once the coding 
is corrected.

[SNIP]

> Defining Yield to noop and building a new libpt solved the problem
> permanently for me.
>
> It seems that not all people have got problems with gnomemeeting and
> 2.6. Damien Sandras (the gnomemeeting maintainer) for example reported
> that he hasn't got any problems with gnomemeeting on 2.6 while compiling
> in parallel. So I guess it's depending on the frequency of sched_yields
> one gets in gnomemeeting. Which is probably depending on the processor
> speed, etc.

It probably hits that code path less frequently in slower cpus ironically.

> That just leaves the question what is the proper fix, to send it
> upstream and to note the phenomenon down in a faq.

The sched_yield issue is noted in faqs, but it should be highlighted in the 
interactivity section.

> Thanks to all who helped me with debugging advice and if anybody needs
> further information just ask.

No, thank you for tracking this down fully. No amount of reassuring that it's 
not 2.6's fault will suffice for us unless we can find the real cause and 
solutions for these issues.

Regards,
Con

