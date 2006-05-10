Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWEJQYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWEJQYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWEJQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:24:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59919 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965021AbWEJQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:24:02 -0400
Date: Wed, 10 May 2006 18:24:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510162404.GR3570@stusta.de>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> <1147257266.17886.3.camel@localhost.localdomain> <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 11:24:31AM -0400, Steven Rostedt wrote:
> 
> On Wed, 10 May 2006, Daniel Walker wrote:
> 
> > On Wed, 2006-05-10 at 16:09 +0100, Alan Cox wrote:
> > > On Mer, 2006-05-10 at 07:31 -0700, Daniel Walker wrote:
> > > > > Hiding warnings like this can be a hazard as it will hide real warnings
> > > > > later on.
> > > >
> > > > How could it hide real warnings? If anything these patch allow other
> > > > (real warnings) to be seen .
> > >
> > > Because while the warning is present people will check it now and again.
> >
> > But it's pointless to review it, in this case and for this warning .
> >
> > > If you set the variable to zero then you generate extra code and you
> > > ensure nobody will look in future.
> >
> > The extra code is a problem , I'll admit that . But the warning should
> > disappear , it's just a waste .
> >
> 
> What is really needed is an attribute to add to function parameters, that
> tells gcc that the parameter, if a pointer, will be initialize via the
> function.
> 
> For example:
> 
> #define __assigned  __attribute__((initialized))
> 
> then declare a function:
> 
> int my_init_variabl(__assigned struct mystruct *var);
> 
> So gcc can know that the passed in variable will be updated. It could
> then check to see if the function actually does initialize the pointer,
> if the declaration is visible to the function definition itself.
> 
> Any gcc developers watching :)


It seems you don't understand the problem at all:


First of all note that your example does not apply in this case:

copy_semid_from_user() does _not_ initialize sembuf in all cases.


And you do not understand where gcc's problem is:

gcc does in fact see that setbuf is always initialized if 
copy_semid_from_user() returns 0.

setbuf is only initialized in the (cmd == IPC_SET) case and later only 
used in the (cmd == IPC_SET) case. And cmd can't change between the two 
occurences.

Therefore, gcc should in theory already have enough information to prove 
that sembuf is always initialized before it's used.


> -- Steve


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

