Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318971AbSICWqF>; Tue, 3 Sep 2002 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318969AbSICWqF>; Tue, 3 Sep 2002 18:46:05 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33735 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318966AbSICWqC>; Tue, 3 Sep 2002 18:46:02 -0400
Date: Tue, 3 Sep 2002 18:50:36 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020903185036.G12201@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <alan@lxorguk.ukuu.org.uk> <200209032132.g83LWdD09043@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209032132.g83LWdD09043@localhost.localdomain>; from James.Bottomley@SteelEye.com on Tue, Sep 03, 2002 at 04:32:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> alan@lxorguk.ukuu.org.uk said:
> > Next you only need to return stuff if commands have been issued
> > between the aborting command and a barrier. Since most sane systems
> > will never be causing REQ_BARRIER

Hmmm...I thought a big reason for adding REQ_BARRIER was to be able to 
support more robust journaling with order requirement verification.  If 
that's true, then REQ_BARRIER commands could become quite common on disks 
using ext3.

On Tue, Sep 03, 2002 at 04:32:38PM -0500, James Bottomley wrote:
> However, in all honesty, I have to say that I just don't believe ABORTs are 
> ever particularly effective.  As part of error recovery, If a device is 
> tipping over into failure, adding another message isn't a good way to pull it 
                             ^^^^^^^^^^^^^^^^^^^^^^
Then you might as well skip device resets since they are implemented using 
messages and go straight to bus resets.  Shot deflected, no score.

> back.  ABORT is really part of the I/O cancellation API, and, like all 
> cancellation implementations, it's potentially full of holes.  The only uses 
> it might have---like oops I didn't mean to fixate that CD, give it back to me 
> now---aren't clearly defined in the SPEC to produce the desired effect (stop 
> the fixation so the drive door can be opened).

In my experience, aborts have always actually worked fairly well in any 
scenario where a bus device reset will work.  Generally speaking, the 
problems I've always ran into with SCSI busses have been either A) this 
command is screwing up but it isn't confusing the drive so we can abort it 
or BDR it because the drive still responds to us or B) the bus is hung 
hard and no transfers or messages of any kind can make it through.  In the 
B case, a full bus reset is the only thing that works.  In the A case, 
aborts work just as often as anything else.

> The pain of coming back from a reset (and I grant, it isn't trivial) is well 
> known and well implemented in SCSI.  It also, from error handlings point of 
> view, sets the device back to a known point in the state model.

So does a successful abort.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
