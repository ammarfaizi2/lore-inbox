Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTCOUdu>; Sat, 15 Mar 2003 15:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCOUdt>; Sat, 15 Mar 2003 15:33:49 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13607
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261545AbTCOUdr>; Sat, 15 Mar 2003 15:33:47 -0500
Date: Sat, 15 Mar 2003 15:41:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: bert hubert <ahu@ds9a.nl>
cc: dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, "" <wrlk@riede.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: Any hope for ide-scsi (error handling)?
In-Reply-To: <20030315202509.GA4374@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.50.0303151534220.9158-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net> <20030315202509.GA4374@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, bert hubert wrote:

> A construct like this was suggested for use in swsusp too to make sure that
> only *one* request is outstanding for a controler. This was also mentioned
> to be the unclean way and that there are taskfile interfaces which are
> cleaner.

hmm..

cpu0:

do_IRQ();
handle_IRQ_event();
...
static ide_startstop_t read_intr (ide_drive_t *drive)
{
	msect = drive->mult_count; /* let msect = 0 */
...
	
	if (i > 0) {
		if (msect)
			goto read_next;
		if (HWGROUP(drive)->handler != NULL) <- [1]
			BUG();
		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL); <- [2]
                return ide_started;
	}

}

cpu1:
swsusp code;
...
	spin_lock_irqsave(&ide_lock, flags);
	while (HWGROUP(drive)->handler) {
		HWGROUP(drive)->handler = NULL; <- [1]
		schedule_timeout(1);
	}
	<- [2]
...

Ok so at event [1] we have a ->handler set on cpu0 so we pass that check. 
Then cpu1 acquires ide_lock and NULLs it out. cpu0 blocks on the lock in 
ide_set_handler and when cpu1 releases it it re-assigns ->handler. What 
happens then?

	Zwane

