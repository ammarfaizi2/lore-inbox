Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135596AbRDSKrM>; Thu, 19 Apr 2001 06:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135614AbRDSKq4>; Thu, 19 Apr 2001 06:46:56 -0400
Received: from smtp1.libero.it ([193.70.192.51]:21753 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S135596AbRDSKqf>;
	Thu, 19 Apr 2001 06:46:35 -0400
Message-ID: <3ADEC192.F016A873@alsa-project.org>
Date: Thu, 19 Apr 2001 12:44:34 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.GSO.4.21.0104190457050.15153-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> I suspect that simple pipe with would be sufficient to handle contention
> case - nothing fancy needed (read when you need to block, write upon up()
> when you have contenders)
> 
> Would something along the lines of (inline as needed, etc.)
> 
> down:
>         lock decl count
>         js __down_failed
> down_done:
>         ret
> 
> up:
>         lock incl count
>         jle __up_waking
> up_done:
>         ret
> 
> __down_failed:
>         call down_failed
>         jmp down_done
> __up_waking:
>         call up_waking
>         jmp up_done
> 
> down_failed()
> {
>         read(pipe_fd, &dummy, 1);
> }
> 
> up_waking()
> {
>         write(pipe_fd, &dummy, 1);
> }
> 
> be enough?

There is something wonderful in this simple solution.

However I've a few doubts:
- choice policy for thread to wake is not selectable
- we separate shared memory area from file descriptor
- the implementation of down_try has neither been discussed nor
excluded, but I don't see how to implement it

The implementation of a specific filesystem seems to me more flexyble.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
