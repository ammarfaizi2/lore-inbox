Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286120AbRLJAke>; Sun, 9 Dec 2001 19:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286122AbRLJAkY>; Sun, 9 Dec 2001 19:40:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30227 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286120AbRLJAkM>; Sun, 9 Dec 2001 19:40:12 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Mon, 10 Dec 2001 00:49:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.40.0112091558190.996-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 09, 2001 04:33:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DEdR-0008Tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What we lose is the mm ( + 1) goodness() but the eventual cost of
> switching mm is melted inside the long execution time ( 50-60 ms ) typical
> of CPU bound tasks ( note that matching MMs does not mean matching cache
> image ).

The mm matching and keeping an mm on the same cpu is critical for a lot of
applications (your 50ms execution time includes 2ms loading the cache from
the other CPU in some cases). Keeping the same mms together on the processor
is critical for certain platforms (eg ARM) but not for x86 so much.

Biasing an mm towards a given CPU is easy with any per cpu queue system. 
I've tried a few variants for sticking the same mm tasks together and one
that might work - especially with your two queue setup is:

	/* other live users of this mm */
	if(new->mm->runnable && is_cpuhog(new))
		list_add(&new->run_list, &new->mm->livehog->run_list);
	else
		...
	

in other words - if we have the mm in flow then throw ourselves onto the
list of cpu hogs adjacent to the other users of that mm.

