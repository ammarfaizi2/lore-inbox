Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270801AbTGNUNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270809AbTGNULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:11:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17040
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270807AbTGNUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:10:06 -0400
Date: Mon, 14 Jul 2003 22:24:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030714202434.GS16313@dualathlon.random>
References: <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 05:09:40PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Mon, 14 Jul 2003, Jens Axboe wrote:
> 
> > Some initial results with the attached patch, I'll try and do some more
> > fine grained tomorrow. Base kernel was 2.4.22-pre5 (obviously), drive
> > tested is a SCSI drive (on aic7xxx, tcq fixed at 4), fs is ext3. I would
> > have done ide testing actually, but the drive in that machine appears to
> > have gone dead. I'll pop in a new one tomorrow and test on that too.
> >
> > no_load:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.22-pre5            2        134     196.3   0.0     0.0     1.00
> > 2.4.22-pre5-axboe      3        133     196.2   0.0     0.0     1.00
> > ctar_load:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
> > 2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46
> > xtar_load:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.22-pre5            3        309     86.4    15.0    14.9    2.31
> > 2.4.22-pre5-axboe      3        249     107.2   11.3    14.1    1.87
> > io_load:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
> > 2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06
> > io_other:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.22-pre5            3        576     47.2    107.7   19.8    4.30
> > 2.4.22-pre5-axboe      3        452     59.7    85.3    19.5    3.40
> > read_load:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.22-pre5            3        150     181.3   8.1     9.3     1.12
> > 2.4.22-pre5-axboe      3        152     178.9   8.2     9.9     1.14
> 
> Awesome. I'll add it in -pre6.

this isn't what we had in pre4, this is more equivalent to an hack in
pre4 where the requests aren't distributed anymore 50/50 but 10/90. Of
course an I/O queue filled mostly by parallel sync reads, will make the
writer go slower since it will very rarely find the queue not oversized
in presence of a flood of readers. So the writer won't be able to make
progress.

This is a "stop the writers and give unlimited requests to the reader"
hack, not a "reserve some request for the reader", of course then the
reader is faster. of course then, contest shows huge improvements for
the read loads.

But contest only benchmarks the reader, it has no clue how fast the
writer is AFIK. I would love to hear the bandwidth the writer is writing
into the xtar_load. Maybe it's shown in some of the Loads/LCPU or
something, but I don't know the semantics of those fields and I only
look at time and ratio which I understand. so if any contest expert can
enaborate if the xtar_load bandwidth is taken into consideration
somewhere I would love to hear.

thanks,

Andrea
