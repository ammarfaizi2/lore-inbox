Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUCHV1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUCHV1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:27:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261258AbUCHV1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:27:09 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Martin Peschke3 <MPESCHKE@de.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan Van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
In-Reply-To: <OFE401C565.89112EED-ONC1256E20.0054728B-C1256E20.0077264F@de.ibm.com>
References: <OFE401C565.89112EED-ONC1256E20.0054728B-C1256E20.0077264F@de.ibm.com>
Content-Type: text/plain
Message-Id: <1078781112.3159.11.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 08 Mar 2004 16:25:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 16:36, Martin Peschke3 wrote:
> Doug Ledford wrote:
> > On Tue, 2004-01-13 at 15:55, Marcelo Tosatti wrote:
> > > What is this mlqueue patchset fixing ? To tell you the truth, I'm not
> > > aware of the SCSI stack problems.
> >
> > OK.  This is a different problem entirely.  The current 2.4 scsi stack
> > has a problem handling QUEUE_FULL and BUSY status commands.  Amongst
> > other things, it retries the command immediately and will basically hang
> > the SCSI bus if the low level driver doesn't intervene.  Most well
> > written drivers have workaround code in them (including my aic7xxx_old
> > driver). The mlqueue patch changes it so that the mid layer implements
> > delayed retries of QUEUE_FULL and BUSY commands.  It also makes the mid
> > layer recognize the situation where you get a QUEUE_FULL or BUSY command
> > status with 0 outstanding commands.  This used to cause the mid layer to
> > hang on that device because there would be no command completion to kick
> > the queue back into gear.
> 
> http://marc.theaimsgroup.com/?t=106001205900001&r=1&w=2
> We also stumbled about this problem last year. Our patch wasn't
> as sophisticated as Doug's new patch. However, it worked,
> and some fix is certainly needed.

I got tied up on other stuff and Marcelo's tree went into -rc mode.  So,
I waited out the next release.  At this point, there is some stuff up
and available for testing.  There are some very minimal patches in the
bk://linux-scsi.bkbits.net/2.4-for-marcelo tree.  The 2.4-drivers tree
is just a clone of the 2.4-for-marcelo tree because I haven't done the
drivers yet.  The 2.4-everything tree includes the io_request_lock
patch, the few patches the io_request_lock patch depended on, the
softirq patch, the mlqueue fixes patch, and some more misc. stuff.  I'm
not done with the 2.4-everything tree, but what I've got so far is now
working for me.  I haven't done much testing yet so caveat emptor.  I'll
make another announcement when I've both A) finished putting everything
in the 2.4-everything tree that I was planning on putting in and B)
completed the audit of the code to make sure the merges were all
successful.  But I know Jens had asked to see the mlqueue patch in
particular, so I figured I would announce that the forward ported
version is in the 2.4-everything tree for people to look at.

The number of pure bugfix patches in the 2.4-for-marcelo tree is
actually pretty small.  The biggest bugfix patch by far is the mlqueue
patch in the 2.4-everything tree, but it depends on a lot of other stuff
so it would be hard to stick it into the 2.4-for-marcelo tree.  Quite a
few of the patches in the 2.4-everything tree are there for performance
reasons only, but they do a pretty good job of making the 2.4 scsi stack
not feel like it's moving at about the same speed as a heavily salted
slug.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


