Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268880AbTBZSKn>; Wed, 26 Feb 2003 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268881AbTBZSKn>; Wed, 26 Feb 2003 13:10:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8065 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268880AbTBZSKj>; Wed, 26 Feb 2003 13:10:39 -0500
Date: Wed, 26 Feb 2003 13:23:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jt@hpl.hp.com
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: Invalid compilation without -fno-strict-aliasing
In-Reply-To: <20030226172054.GA3731@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.3.95.1030226131903.4664A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Jean Tourrilhes wrote:

> On Tue, Feb 25, 2003 at 11:33:09PM -0500, Albert Cahalan wrote:
> > Jean Tourrilhes writes:
> > 
> > > It looks like a compiler bug to me...
> > > Some users have complained that when the following
> > > code is compiled without the -fno-strict-aliasing,
> > > the order of the write and memcpy is inverted (which
> > > mean a bogus len is mem-copied into the stream).
> > > Code (from linux/include/net/iw_handler.h) :
> > > --------------------------------------------
> > > static inline char *
> > > iwe_stream_add_event(char * stream,  /* Stream of events */
> > >        char * ends,  /* End of stream */
> > >        struct iw_event *iwe, /* Payload */
> > >        int event_len) /* Real size of payload */
> > > {
> > >  /* Check if it's possible */
> > >  if((stream + event_len) < ends) {
> > >   iwe->len = event_len;
> > >   memcpy(stream, (char *) iwe, event_len);
> > >   stream += event_len;
> > >  } return stream;
> > > }
> > > --------------------------------------------
> > > IMHO, the compiler should have enough context to
> > > know that the reordering is dangerous. Any suggestion
> > > to make this simple code more bullet proof is welcomed.
> > >
> > > Have fun...
> > 
> > Since (char*) is special, I agree that it's a bug.
> > In any case, a warning sure would be nice!
> > 
> > Now for the fun. Pass iwe->len into this
> > macro before the memcpy, and all should be well.
> > 
> > #define FORCE_TO_MEM(x) asm volatile(""::"r"(&(x)))
> > 
> > Like this:
> > 
> >    iwe->len = event_len;
> >    FORCE_TO_MEM(iwe->len);
> >    memcpy(stream, (char *) iwe, event_len);
> 
> 	I'll try that, that sounds absolutely clever (but I only
> understand half of it).
> 	Thanks a lot !
> 
> 	Jean
> -

This does absoultely nothing with egcs-2.91.66. I also modified

 #define FORCE_TO_MEM(x) asm volatile(""::"r"(&(x)))
                                           |________ this to "memory"

and it still does nothing. The result of gcc -O2 -S -o xxx xxx.c just
shows:

#AP
#NOAP

With no code in-between.

I also changed it to:
 #define FORCE_TO_MEM(x) __asm__ __volatile__(""::"r"(&(x)))
to no avail.

What's up?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


