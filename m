Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317646AbSFMPJE>; Thu, 13 Jun 2002 11:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317650AbSFMPJD>; Thu, 13 Jun 2002 11:09:03 -0400
Received: from www.microgate.com ([216.30.46.105]:10250 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S317646AbSFMPJC>; Thu, 13 Jun 2002 11:09:02 -0400
Message-ID: <009101c212eb$d460e690$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <klaus.herb@ikon-gmbh.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <01C212F6.F1993680.klaus.herb@ikon-gmbh.de>
Subject: Re: ppp_synctty and in_interrupt
Date: Thu, 13 Jun 2002 10:06:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am currently developing a tty-Driver which is used for synchronous PPP.
> ...
> The ppp_synctty ldisc only calls my ttywrite function in interrupt
context.
> But to avoid a race condition I must include a Semaphore in my ttywrite
> function, so I get a Kernel Oops when this Semaphore causes a call to
> schedule().
>
> Is there a way to stop this ppp_synctty ldisc from sending in Interrupt
> Context?
> or
> Why does this ldisc only write in interrupt context?
>
> Please CC your replay to klaus.herb@ikon-gmbh.de

It should not call the tty write function in interrupt context.

The ldisc will call the tty write in two situtations:
1. when a new packet to send is available
2. when the tty driver calls the ldisc write_wakeup
  to send queued frames

My guess is that your driver is calling write_wakeup
in an interrupt context (in response to a tx complete IRQ).
You should call write_wakeup() from a bottom half
handler scheduled by the interrupt service routine instead
of directly from the ISR.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com

