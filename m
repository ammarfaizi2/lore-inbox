Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbRFPSbS>; Sat, 16 Jun 2001 14:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264645AbRFPSbI>; Sat, 16 Jun 2001 14:31:08 -0400
Received: from be02.imake.com ([151.200.87.11]:49164 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S264644AbRFPSaw>;
	Sat, 16 Jun 2001 14:30:52 -0400
Message-ID: <3B2BA68D.984A2808@247media.com>
Date: Sat, 16 Jun 2001 14:33:50 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: threading question
In-Reply-To: <E15BHrC-0008Ba-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a user-space implemenation (library?) for coroutines that would work from C?


Alan Cox wrote:

> > Can you provide any info and/or examples of co-routines? I'm curious to
> > see a good example of co-routines' "betterness."
>
> With co-routines you don't need
>
>         8K of kernel stack
>         Scheduler overhead
>         Fancy locking
>
> You don't get the automatic thread switching stuff though.
>
> So you might get code that reads like this (note that aio_ stuff works rather
> well combined with co-routines as it fixes a lack of asynchronicity in the
> unix disk I/O world)
>
>         select(....)
>
>         if(FD_ISSET(copier_fd))
>                 run_coroutine(&copier_state);
>
>         ...
>
> and the copier might be something like
>
>         while(1)
>         {
>                 // Yes 1 at a time is dumb but this is an example..
>                 // Yes Im ignoring EOF for this
>                 if(read(copier_fd, buf[bufptr], 1)==-1)
>                 {
>                         if(errno==-EWOULDBLOCK)
>                         {
>                                 coroutine_return();
>                                 continue;
>                         }
>                 }
>                 if(bufptr==255  || buf[bufptr]=='\n')
>                 {
>                         run_coroutine(run_command, buf);
>                         bufptr=0;
>                 }
>                 else
>                         bufptr++;
>         }
>
> it lets you express a state machine as a set of multiple such small state
> machines instead.  run_coroutine() will continue a routine where it last
> coroutine_return()'d from. Thus in the above case we are expressing read
> bytes until you see a new line cleanly - not mangled in with keeping state
> in global structures but by using natural C local variables and code flow
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com
---------------------------------------------------


