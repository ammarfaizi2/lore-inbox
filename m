Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRLFRxd>; Thu, 6 Dec 2001 12:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281717AbRLFRxY>; Thu, 6 Dec 2001 12:53:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281692AbRLFRxN>; Thu, 6 Dec 2001 12:53:13 -0500
Subject: Re: Linux/Pro  -- clusters
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 6 Dec 2001 18:02:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9uo83q$aa7$1@penguin.transmeta.com> from "Linus Torvalds" at Dec 06, 2001 04:58:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C2qa-0002RR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Timeouts for different commands were so different that people ended up
> making most timeouts so long that they no longer made sense for other
> commands etc.

Thats per _target_ not host. Which needs to be common code.

> Other device drivers have been able to handle timeouts and errors on
> their own before, and have _not_ had the kinds of horrendous problems
> that the SCSI layer has had.

Every IDE layer uses the same IDE error handling code, because every IDE
driver would otherwise have to make a copy of it - ditto scsi. 

> that it is a major mistake to try to have generic error handling.  The
> only true generic thing is "this request finished successfully / with an
> error", and _no_ high-level retries etc. It's up to the driver to decide
> if retries make sense.

Retries and retry handling are target specific not host specific (think
about the ton of logic you need every time your cd rom decides to error
a read). You can have a read turn into a sequence of operations while you
go and work out why it failed, ask it if its ready, tell it to lock the
door, spin up the media, wait for it to be ready, reissue the I/O.

This processing has to be robust because scsi cd-roms for example are
rarely robust themselves.

So its very much

	request->controller
			libscsi -> make me a command block
			issue command
	
	interrupt->controller
		error ?
			libscsi recommend an action please
			add suggested recovery to queue head
			kick request handling

> (Often retrying _doesn't_ make sense, because the firmware on the
> high-end card or disk itself may already have done retries on its own,
> and high-level error handling is nothing but a waste of time and causes
> the error notification to be even more delayed).

Those devices aren't SCSI controllers, and they don't want to appear as one.
Thats a horrible windows NT habit that harms performance badly. Of course
everyone is now doing it with Linux because someone wouldn't provide more
major numbers.

Which is another thing - can you make the internal dev_t 32 or 64bits now.
You can have 65536 volumes on an S/390 so even with perfectly distributed
devfs allocated device identifiers - we don't have enough.

Alan
