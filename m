Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbREZPmZ>; Sat, 26 May 2001 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbREZPmT>; Sat, 26 May 2001 11:42:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50699 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261628AbREZPl3>;
	Sat, 26 May 2001 11:41:29 -0400
Date: Sat, 26 May 2001 16:58:00 +0200
From: Jens Axboe <axboe@suse.de>
To: A Duston <hald@sound.net>
Cc: "Gortmaker, Paul" <p_gortmaker@yahoo.com>,
        "Andersen, Rasmus" <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Esdi patch #8
Message-ID: <20010526165800.C553@suse.de>
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net> <3B0D733F.1829DC88@yahoo.com> <20010525164615.C14899@suse.de> <3B0FC26B.D210E416@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0FC26B.D210E416@sound.net>; from hald@sound.net on Sat, May 26, 2001 at 09:49:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26 2001, A Duston wrote:
> > On Thu, May 24 2001, Paul Gortmaker wrote:
> > > Hal Duston wrote:
> > >
> > > > http://www.sound.net/~hald/projects/ps2esdi/ps2esdi-2.4.4-patch4
> > > >
> > > > Hal Duston
> > > > hald@sound.net
> > >
> > > You PS/2 ESDI guys might want to set the max sectors for your
> > > driver - old default used to be 128, currently 255 (which maybe
> > > hardware can handle ok?) - the xd and hd drivers were broken until
> > > a similar fix was added to them.
> > >
> > > Probably makes sense for driver to set it regardless, seeing
> > > as default (MAX_SECTORS) has changed several times over last
> > > few months.  At least then it will be under driver control
> > > and not at the mercy of some global value.
> >
> > You might want to assign that max_sect array too, otherwise it's just
> > going to waste space :-)
> >
> > Take a look at how ps2esdi handles requests -- always processing just
> > the first segment. Alas, it doesn't matter how big the request is.
> 
> OK, obviously I am still missing something here from when I got the
> driver booting again.  Presumably something with current_nr_sectors,
> vs nr_sectors, maybe?  I thought it was odd that all the transfers were
> exactly 2 blocks. I'll go ahead and take this one.  I will also go ahead
> and check to see how much data the hardware can transfer at once
> as well, but I expect it is quite a bit.  I am still working on getting a

Consider the following request, with attached bh list:

	req -> bh1 -> bh2 -> bh3 -> bh4

Lets say this is a 4kB fs, so each bh linked to the request is 4kB in
size. You'll then have

	current_nr_sectors 8 (4096 >> 9)
	nr_sectors 32 (the four buffer heads)
	req->buffer == req->bh1->b_data

ps2esdi only processes one chunk of the time (looks at
current_nr_sectors for request and buffer size). Once you complete that
hunk and call end_request, your request will then look like this:

	req -> bh2 -> bh3 -> bh4
	current_nr_sectors 8
	nr_sectors 24
	req->buffer == req->bh2->b_data

and so it continues. This is the easy way to process requests. However,
if you can start I/O on more than one buffer at the time (scatter
gather), you could then setup your sg tables by browsing the entire
request buffer_head list and initiate I/O as needed.

Bigger requests on the queue, means more I/O in progress being possible.
There's no rule that you have to finish a request in one go, so even if
you can only handle eg 64 sectors per request with sg, you could do
just start I/O on as many segments as you can and simply don't dequeue
the request until it's completely done. So the max_sectors patch is
never really needed if you know what you are doing.

-- 
Jens Axboe

