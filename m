Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRGYNdv>; Wed, 25 Jul 2001 09:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268571AbRGYNdl>; Wed, 25 Jul 2001 09:33:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33810 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268570AbRGYNdc>; Wed, 25 Jul 2001 09:33:32 -0400
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
To: nave@stanford.edu (Evan Parker)
Date: Wed, 25 Jul 2001 14:34:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.31.0107241704430.11742-100000@myth10.Stanford.EDU> from "Evan Parker" at Jul 24, 2001 05:08:23 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15POo8-00020x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> other 10 are questionable.  Those 10 are all simple variations on the
> following code:
> 
> Start --->
> 	if (!tmp_buf) {
> 		page = get_free_page(GFP_KERNEL);
> 
> Error --->
> 		if (tmp_buf)
> 			free_page(page);
> 		else
> 			tmp_buf = (unsigned char *) page;
> 	}

That one is not a bug. The serial drivers do this to handle a race. Really
it should be

		page = get_free_page(GFP_KERNEL)

		rmb();
		if (tmp_buf)
			..

but this will go away as and when someone switches the tty layer to new 
style locking. The precise code flow (under lock_kernel in both cases) is

	
	if (!tmp_buf)
	{
		/* tmp_buf was 0
		page = get_free_page (...)
		[SLEEPS, TASK SWITCH]

		if(tmp_buf)
		/* tmp buf was non zero - another thread allocated it */


Alan
