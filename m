Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276585AbRJYWyF>; Thu, 25 Oct 2001 18:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276612AbRJYWxq>; Thu, 25 Oct 2001 18:53:46 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:53437 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S276585AbRJYWxl>; Thu, 25 Oct 2001 18:53:41 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Patrick Mochel <mochel@osdl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 26 Oct 2001 01:53:59 +0200
Message-Id: <20011025235359.12066@smtp.adsl.oleane.com>
In-Reply-To: <1004046722.9892.120.camel@nomade>
In-Reply-To: <1004046722.9892.120.camel@nomade>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> One job kernel drivers have is to say "I can't safely sleep at this moment"
>> Even windows/XP beta gets this right.
>
>The other solution (let cdrecord tell I-dunno-how the PM daemon that
>it's doing something "important") is IMHO better: the PM daemon could
>judge if it should honor the suspend request depending on its priority
>(inactivity, power button or low battery) and the running "important"
>jobs.

The cdrecord case is a high level issue, and scsi is a mess ;)

We are not yet at a point where we can be more constructive
than what was already said. Ultimately we need to move a bit
forward with the real implementation and see how some problems
show up. The architecture as it was designed so far is light,
and most of the debate is not around it, it's around how it
should be used by drivers & kernel subsystems ;)

Also, there will always be corner cases where a kernel driver will
be able to override whatever policy was set. Drivers can register
to the PM layer and can return errors. It have to be exceptional,
but I beleive some critical flash algorithm or whatever would
benefit from it.

I would however vote for making that a bit simpler by providing a
kernel-global sleep rw semaphore. The idea here is that drivers, file
systems, or whatever bits of kernel code that, for a given momment,
won't afford beeing put to sleep will take a read lock on it. The
sleep code will take a write lock. The read lockers won't make the
PM code fail. It will just block a bit, waiting for the critical
operations to complete.

I'm thinking about things like jffs2 on embedded. That (nice) flash
file system has a background thread that does garbage collecting
of your flash in order to be able to erase unused parts. It would
benefit greatly embedded boards that implement system sleep if
that thread could make sure sleep won't happen in the middle of
moving blocks, or whatever atomicity it may want for its operations.

A firmware flashing facility in a driver may use that mecanism too.

It's a corner case, it's not meant to be used a lot, but it nice
to have it.

Ben.


