Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWBJOjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWBJOjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBJOjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:39:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932118AbWBJOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:39:48 -0500
Date: Fri, 10 Feb 2006 15:39:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: pktcdvd stack usage regression
Message-ID: <20060210143947.GE19918@stusta.de>
References: <20060209020932.GY3524@stusta.de> <m3lkwl6pfu.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3lkwl6pfu.fsf@telia.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 07:01:25AM +0100, Peter Osterlund wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > Hi Phillip,
> > 
> > your recent patch "pktcdvd: Allow larger packets" changed 
> > PACKET_MAX_SIZE in the pktcdvd driver from 32 to 128.
> > 
> > Unfortunately, drivers/block/pktcdvd.c contains the following:
> > 
> > <--  snip  -->
> > 
> > ...
> > static void pkt_start_write(struct pktcdvd_device *pd, struct 
> > packet_data *pkt)
> > {
> >         struct bio *bio;
> >         struct page *pages[PACKET_MAX_SIZE];
> >         int offsets[PACKET_MAX_SIZE];
> > ...
> > 
> > <--  snip  -->
> > 
> > With PACKET_MAX_SIZE=128, this allocates more than 1 kB on the stack 
> 
> Yes, I know.
> 
> > which is not acceptable considering that we might have only 4 kB stack 
> > altogether.
> 
> Why is it not acceptable? The pkt_start_write() function is only
> called from the kcdrwd() kernel thread and the pkt_start_write()
> function doesn't call anything else in the kernel that could require
> lots of stack space.
> 
> The actual I/O is started from pkt_iosched_process_queue(), which
> calls generic_make_request(). However pkt_iosched_process_queue() is
> on a different call chain than pkt_start_write(), so I don't see how
> this could be a problem.

You might be able to verify this is true today, but it is a bit fragile 
and other changes might always add even more stack usage in some places. 
Therefore, functions using 1 kB stack aren't a good idea.

As an exercise, pkt_open() currently uses more than 0,5 kB stack
(kernel 2.6.16-rc2-mm1, i386, gcc 4.0). Try to understand where this 
stack usage comes from (hint: add up the stack usages of all only once 
used static functions gcc automatically inlines).

> Peter Osterlund

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

