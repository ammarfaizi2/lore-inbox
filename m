Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVJHI3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVJHI3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 04:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVJHI3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 04:29:25 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:28954 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVJHI3Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 04:29:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=diluw6vTjH4QmenaUDixi+/km/5jynYojCy/qLFdbVTHyQ4iJIRPVy3u41IWPavSiVaAG5uz+jbw7Oge2fNBMnmapr0AoPZDhFwIe64g2I+iZWW4yG5YtFN8SJuTWmRgvyuAivgGwlIPiNtHOTQ5tVy6sd8cczZAWIqqdmBnmbU=
Message-ID: <58cb370e0510080129i80710c7gc2178b9330a1ee19@mail.gmail.com>
Date: Sat, 8 Oct 2005 10:29:22 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IDE issues with "choose_drive"
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <1128734104.17365.73.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128559019.22073.19.camel@gaston>
	 <1128560569.22073.25.camel@gaston> <1128734104.17365.73.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2005-10-06 at 11:02 +1000, Benjamin Herrenschmidt wrote:
> > > The first one is the one I'm trying to fix, it's basically a hang on
> > > wakeup from sleep. What happens is that both drives are blocked
> > > (suspended, drive->blocked is set). Their IO queues contains some
> > > requests that haven't been serviced yet. We receive the resume()
> > > callback for one of them. We react by inserting a wakeup request at the
> > > head of the queue and waiting for it to complete. However, when we reach
> > > ide_do_request(), choose_drive() may return the other drive (the one
> > > that is still sleeping). In this case, we hit the test for blocked queue
> > > and just break out of the loop. We end up never servicing the other
> > > drive queue which is the one we are trying to wakeup, thus we hang.
> >
> > Oh, and here's the ugly workaround beeing tested by the users who are
> > having the problem so far. Not really a proper fix though...
>
> No reply ... it's a bit urgent as it may bite any system trying to
> suspend with a slave IDE disk at least (not including the other possible
> problems I've spotted  with this code).

It is a old problem from what I understand.
However it would still be nice to have it fixed for 2.6.14.

> I'm tempted to just send my workaround patch to Linus & Andrew (might
> still make it into 2.6.14). That would at least fix the bug with resume
> from sleep. What do you think ?

It seems we need internal ide_dev_do_request(ide_drive_t *, int)
which will explicitly state which device we want to service as I see
no sane way to fix the problem in choose_drive().

Your workaround is OK for 2.6.14 given that you will document it
now and later fix it properly for 2.6.15.

Bartlomiej
