Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289573AbSAVXi0>; Tue, 22 Jan 2002 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSAVXiQ>; Tue, 22 Jan 2002 18:38:16 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6674 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289575AbSAVXiD>; Tue, 22 Jan 2002 18:38:03 -0500
Date: Tue, 22 Jan 2002 15:18:21 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: END GAME (Re: Linux 2.5.3-pre1-aia1)
In-Reply-To: <20020122110621.K1018@suse.de>
Message-ID: <Pine.LNX.4.10.10201221449500.19685-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Jens,

I need a function that performs the kmapping to return a pointer with all
the data needed for that transaction of the data phase, and will cross
pages correctly, and may cross more than 2 pages at a time in PIO.
I do not care how you do.

char * majic_voodoo_mapping (
	struct request *rq,
	int nsect,
	unsigned long *flags)
{
	char * buffer_walk = ide_map_rq(rq, &flags);
	nsect -= ide_rq_offset(rq);
	do {
		buffer_walk += get_some_more(rq, nsect);
	} while (nsect)
	return buffer_walk;
}

This should solve all the problems in the data-phases and let the driver
run correctly. The result is on each "get_some_more" will all BLOCK/BIO to
return the partial competions of at least one page

The function would behave like ide_end_request but only to adjust the 
buffer in process, and make block/bio deal with munging it back to the top
layers on the partial completions, it will not stop the data IO process of
the ATOMIC command in process.

There is a possible place in while hanging on the HPIOO1 T-BAR to safely
leave and collect "ALL" of the buffer to be put down once we start IO'ing.
If it return with only a partial, YOU WILL HANG THE DRIVE, with one
acception the REMAINDER of the BLOCK_DATA transaction.

You get your early partial complete, and a correct running driver.
Better yet, I will shut my PIEHOLE!

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

