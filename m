Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268846AbTBZReu>; Wed, 26 Feb 2003 12:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268847AbTBZReu>; Wed, 26 Feb 2003 12:34:50 -0500
Received: from palrel10.hp.com ([156.153.255.245]:13197 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id <S268846AbTBZRes>;
	Wed, 26 Feb 2003 12:34:48 -0500
Date: Wed, 26 Feb 2003 09:20:54 -0800
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030226172054.GA3731@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1046233990.1111.45.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046233990.1111.45.camel@cube>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 11:33:09PM -0500, Albert Cahalan wrote:
> Jean Tourrilhes writes:
> 
> > It looks like a compiler bug to me...
> > Some users have complained that when the following
> > code is compiled without the -fno-strict-aliasing,
> > the order of the write and memcpy is inverted (which
> > mean a bogus len is mem-copied into the stream).
> > Code (from linux/include/net/iw_handler.h) :
> > --------------------------------------------
> > static inline char *
> > iwe_stream_add_event(char * stream,  /* Stream of events */
> >        char * ends,  /* End of stream */
> >        struct iw_event *iwe, /* Payload */
> >        int event_len) /* Real size of payload */
> > {
> >  /* Check if it's possible */
> >  if((stream + event_len) < ends) {
> >   iwe->len = event_len;
> >   memcpy(stream, (char *) iwe, event_len);
> >   stream += event_len;
> >  } return stream;
> > }
> > --------------------------------------------
> > IMHO, the compiler should have enough context to
> > know that the reordering is dangerous. Any suggestion
> > to make this simple code more bullet proof is welcomed.
> >
> > Have fun...
> 
> Since (char*) is special, I agree that it's a bug.
> In any case, a warning sure would be nice!
> 
> Now for the fun. Pass iwe->len into this
> macro before the memcpy, and all should be well.
> 
> #define FORCE_TO_MEM(x) asm volatile(""::"r"(&(x)))
> 
> Like this:
> 
>    iwe->len = event_len;
>    FORCE_TO_MEM(iwe->len);
>    memcpy(stream, (char *) iwe, event_len);

	I'll try that, that sounds absolutely clever (but I only
understand half of it).
	Thanks a lot !

	Jean
