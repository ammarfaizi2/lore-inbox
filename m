Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRBVK1j>; Thu, 22 Feb 2001 05:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRBVK13>; Thu, 22 Feb 2001 05:27:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28688 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129190AbRBVK1T>; Thu, 22 Feb 2001 05:27:19 -0500
Subject: Re: Linux 2.4.1-ac15
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 22 Feb 2001 10:29:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <971tdk$10p$1@penguin.transmeta.com> from "Linus Torvalds" at Feb 21, 2001 06:27:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Vt0b-0003qo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >We can take page faults in interrupt handlers in 2.4 so I had to use a 
> >spinlock, but that sounds the same
> 
> Umm? The above doesn't really make sense.
> 
> We can take a page fault on the kernel region with the lazy page
> directory filling, but that code will just set the PGD entry and exit
> without taking any lock at all. So it basically ends up being an
> "invisible" event.

Its only normally invisible. Mark Hemment pointed out there is currently a
race where if both cpus go to fill in the same entry the logic goes

	CPU1					CPU2

	pgd present 				pgd present
	pmd not present
	load pmd
						pmd present
						Explode messily


The race looks right to me since both CPU's can be running from the same
mm.

The obvious fix (removing the 2nd check) of course hangs the WP check. I
have a hack [not for Linus grade] for that now but really need to walk as
far as the pte in the racey case to check for a WP fault.

> 2.4.x. In that case you would take the exception table lock, but that is
> true in both 2.2.x and in 2.4.x.

I didnt say it wasnt 

Alan

