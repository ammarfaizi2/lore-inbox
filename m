Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268616AbRGYTLU>; Wed, 25 Jul 2001 15:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268615AbRGYTLL>; Wed, 25 Jul 2001 15:11:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26886 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268613AbRGYTKw>; Wed, 25 Jul 2001 15:10:52 -0400
Subject: Re: user-mode port 0.44-2.4.7
To: jim@intra.blueskylabs.com (James W. Lake)
Date: Wed, 25 Jul 2001 20:12:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "James W. Lake" at Jul 25, 2001 12:03:48 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PU4j-0002Xw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Should head and tail be volatile in the definition, or should they be
> accessed with:
> int head = (volatile)myqueue.head;
> or with barrier() around the read/write?

The best way is to use barrier calls. It makes your assumptions about
ordering absolutely explicit. However you should still be careful - you
can't be sure that head will be read atomically or written atomically on
all processors eg if it was

	struct
	{
		unsigned char head;
		unsigned char tail;
		char buf[256];
	}

you would get some suprisingly unpleasant suprises on SMP Alpha. Currently
"int" is probably safe for all processors.

So unless this is a precision tuned fast path it is better to play safe with
this and use atomic_t or locking. The spinlock cost on an Athlon or a later
PIII is pretty good in most cases. Using the -ac prefetch stuff can make it
good in almost all cases, but thats probably a 2.5 thing for the generic
case.

Basically locks are getting cheaper on x86, the suprises are getting more
interesting on non-x86

Alan
