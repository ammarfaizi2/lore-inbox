Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbRFPPVQ>; Sat, 16 Jun 2001 11:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRFPPVH>; Sat, 16 Jun 2001 11:21:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46347 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261190AbRFPPUw>; Sat, 16 Jun 2001 11:20:52 -0400
Subject: Re: threading question
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Sat, 16 Jun 2001 16:19:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <992701010.9390.4.camel@gromit> from "Michael Rothwell" at Jun 16, 2001 10:16:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BHrC-0008Ba-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you provide any info and/or examples of co-routines? I'm curious to
> see a good example of co-routines' "betterness."

With co-routines you don't need

	8K of kernel stack
	Scheduler overhead
	Fancy locking

You don't get the automatic thread switching stuff though.

So you might get code that reads like this (note that aio_ stuff works rather
well combined with co-routines as it fixes a lack of asynchronicity in the
unix disk I/O world)


	select(....)

	if(FD_ISSET(copier_fd))
		run_coroutine(&copier_state);

	...


and the copier might be something like

	while(1)
	{
		// Yes 1 at a time is dumb but this is an example..
		// Yes Im ignoring EOF for this
		if(read(copier_fd, buf[bufptr], 1)==-1)
		{
			if(errno==-EWOULDBLOCK)
			{
				coroutine_return();
				continue;
			}
		}
		if(bufptr==255  || buf[bufptr]=='\n')
		{
			run_coroutine(run_command, buf);
			bufptr=0;
		}
		else
			bufptr++;
	}


it lets you express a state machine as a set of multiple such small state
machines instead.  run_coroutine() will continue a routine where it last
coroutine_return()'d from. Thus in the above case we are expressing read
bytes until you see a new line cleanly - not mangled in with keeping state
in global structures but by using natural C local variables and code flow

Alan



