Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268630AbTBZE0j>; Tue, 25 Feb 2003 23:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268633AbTBZE0j>; Tue, 25 Feb 2003 23:26:39 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:39874 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S268630AbTBZE0h>; Tue, 25 Feb 2003 23:26:37 -0500
Subject: Re: Invalid compilation without -fno-strict-aliasing
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: jt@bougret.hpl.hp.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Feb 2003 23:33:09 -0500
Message-Id: <1046233990.1111.45.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes writes:

> It looks like a compiler bug to me...
> Some users have complained that when the following
> code is compiled without the -fno-strict-aliasing,
> the order of the write and memcpy is inverted (which
> mean a bogus len is mem-copied into the stream).
> Code (from linux/include/net/iw_handler.h) :
> --------------------------------------------
> static inline char *
> iwe_stream_add_event(char * stream,  /* Stream of events */
>        char * ends,  /* End of stream */
>        struct iw_event *iwe, /* Payload */
>        int event_len) /* Real size of payload */
> {
>  /* Check if it's possible */
>  if((stream + event_len) < ends) {
>   iwe->len = event_len;
>   memcpy(stream, (char *) iwe, event_len);
>   stream += event_len;
>  } return stream;
> }
> --------------------------------------------
> IMHO, the compiler should have enough context to
> know that the reordering is dangerous. Any suggestion
> to make this simple code more bullet proof is welcomed.
>
> Have fun...

Since (char*) is special, I agree that it's a bug.
In any case, a warning sure would be nice!

Now for the fun. Pass iwe->len into this
macro before the memcpy, and all should be well.

#define FORCE_TO_MEM(x) asm volatile(""::"r"(&(x)))

Like this:

   iwe->len = event_len;
   FORCE_TO_MEM(iwe->len);
   memcpy(stream, (char *) iwe, event_len);


