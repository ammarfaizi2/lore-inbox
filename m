Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267475AbRGZBN7>; Wed, 25 Jul 2001 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbRGZBNu>; Wed, 25 Jul 2001 21:13:50 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:13795 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S267475AbRGZBNe>;
	Wed, 25 Jul 2001 21:13:34 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200107260113.SAA11847@csl.Stanford.EDU>
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 25 Jul 2001 18:13:34 -0700 (PDT)
Cc: nave@stanford.edu (Evan Parker), linux-kernel@vger.kernel.org,
        mc@CS.Stanford.EDU
In-Reply-To: <E15POo8-00020x-00@the-village.bc.nu> from "Alan Cox" at Jul 25, 2001 02:34:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

bunch of quoting for context:

> > other 10 are questionable.  Those 10 are all simple variations on the
> > following code:
> > 
> > Start --->
> > 	if (!tmp_buf) {
> > 		page = get_free_page(GFP_KERNEL);
> > 
> > Error --->
> > 		if (tmp_buf)
> > 			free_page(page);
> > 		else
> > 			tmp_buf = (unsigned char *) page;
> > 	}
> 
> That one is not a bug. The serial drivers do this to handle a race. Really
> it should be
> 
> 		page = get_free_page(GFP_KERNEL)
> 
> 		rmb();
> 		if (tmp_buf)
> 			..
> 
> but this will go away as and when someone switches the tty layer to new 
> style locking. The precise code flow (under lock_kernel in both cases) is
> 
> 	
> 	if (!tmp_buf)
> 	{
> 		/* tmp_buf was 0
> 		page = get_free_page (...)
> 		[SLEEPS, TASK SWITCH]
> 

Does this mean that the 'cli' in the following code is redundant?

	/* 2.4.7/drivers/char/generic_serial.c:953:gs_init_port: */
        if (!tmp_buf) {
                page = get_free_page(GFP_KERNEL);

                cli (); /* Don't expect this to make a difference. */
                if (tmp_buf)
                        free_page(page);
                else
                        tmp_buf = (unsigned char *) page;

Dawson
