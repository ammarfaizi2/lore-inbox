Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWEJRTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWEJRTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWEJRTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:19:42 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40895 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965009AbWEJRTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:19:42 -0400
Date: Wed, 10 May 2006 13:18:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Adrian Bunk <bunk@stusta.de>
cc: Daniel Walker <dwalker@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <20060510162404.GR3570@stusta.de>
Message-ID: <Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
 <1147257266.17886.3.camel@localhost.localdomain>
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <1147273787.17886.46.camel@localhost.localdomain>
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Adrian Bunk wrote:

>
> It seems you don't understand the problem at all:
>

Actually I do, altough I admit my reply was for more the general case with
pointers. And that I was using TAGS to jump around the function and didn't
notice that copy_semid_from_user was defined just above the function :-/
OK, it's getting late for me.

>
> First of all note that your example does not apply in this case:
>
> copy_semid_from_user() does _not_ initialize sembuf in all cases.

Yes, but the attribute could still remove the warning without adding more
instructions.  And the fact that the attribute is there, we can use it to
know that it was looked at and remind us that it's used.

OK, we could just have an attribute on the declaration of the variable
that keeps that warning turned off.  It also lets us know that someone
looked at that variable to make sure it is ok. And we can still undefine
the attribute definition with a make parameter if we want to recheck all
those warnings.

>
> And you do not understand where gcc's problem is:
>
> gcc does in fact see that setbuf is always initialized if
> copy_semid_from_user() returns 0.


>
> setbuf is only initialized in the (cmd == IPC_SET) case and later only
> used in the (cmd == IPC_SET) case. And cmd can't change between the two
> occurences.
>
> Therefore, gcc should in theory already have enough information to prove
> that sembuf is always initialized before it's used.
>

OK in theory, with this example it does have enough info.  But how much
info do you want gcc to hold while it's compiling?

To know that it's ok you need to know the following:

(what you've mentioned)
 setbuf is initialized
     cmd == IPC_SET
      and
     if copy_sem_from_user returns zero.

 setbuf isn't used unless cmd == IPC_SET

Now gcc will also need to know (which is there, but extra info for
compiling):

  setbuf->uid is updated in copy_sem_from_user and it returns zero.
  setbuf->out is updated in copy_sem_from_user and it returns zero.
  setbuf->mode is updated in copy_sem_from_user and it returns zero.

So it isn't enough to just know sembuf was updated, but you also need to
know what parts of the structure is initialized and used.  This example is
trivial, but what happens when you have structures with 100 elements, and
some with pointers to other elements.  Should gcc keep track of all that
too?

-- Steve


