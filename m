Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVCZH0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVCZH0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 02:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVCZH0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 02:26:07 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:30625 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262015AbVCZHZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 02:25:58 -0500
Date: Sat, 26 Mar 2005 09:27:33 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
In-Reply-To: <1111778388.5692.38.camel@mulgrave>
Message-ID: <Pine.LNX.4.61.0503260907450.19764@kai.makisara.local>
References: <20050323021335.960F95F8@htj.dyndns.org>  <20050323021335.4682C732@htj.dyndns.org>
  <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com> 
 <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave> 
 <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave> 
 <20050325031511.GA22114@htj.dyndns.org> <1111726965.5612.62.camel@mulgrave>
  <20050325053842.GA24499@htj.dyndns.org> <1111778388.5692.38.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, James Bottomley wrote:

> On Fri, 2005-03-25 at 14:38 +0900, Tejun Heo wrote:
> >  We have users of scsi_do_req() other than scsi_wait_req() and they
> > use different done() functions to do different things.  I've checked
> > other done functions and none uses contents inside the passed
> > scsi_cmnd, so using a dummy command should be okay with them.  Am I
> > missing something here?
> 
> Well ... the other users are supposed to be going away.  They're
> actually all coded wrongly in some way or other ... perhaps I should
> speed up the process.
> 
I have seen you mention this several times now and I am getting more and 
more worried. The reason is that scsi_wait_req() is a synchronous 
interface and it does not allow a driver to do this:

- send a request
- do other useful things/let the user do useful work
- wait for completion before starting another request

I fully agree that doing done() correctly _is_ a problem, especially when 
the SCSI subsystem evolves and the high-level driver writers do not follow 
the development closely enough.

One solution to these problems would be to let the drivers still use 
scsi_do_req() and their own done() function, but create two 
(three) helpers:
- one to be called at the beginning of done(); it would do what needs to 
  be done here but lets the driver to do some special things of its own if
  necessary
- one to be called to wait for the request to finish
(- one to do scsi_ro_req() and the things necessary before these)

Having these helpers would isolate the user of the SCSI subsystem from the 
internals. scsi_wait_req() should call these functions and no additional 
maintenance would be needed for this additional asynchronous interface.

The current drivers may not do any work in done() that could not be done 
later but there is one patch pending where this happens: the st 
performance statistics patch needs to get the time stamp when the SCSI 
command is processed.

-- 
Kai
