Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVD1Fl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVD1Fl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVD1Fl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:41:29 -0400
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:62813 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262024AbVD1FlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:41:10 -0400
Date: Thu, 28 Apr 2005 08:43:21 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg KH <gregkh@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO
 etc.
In-Reply-To: <1114619928.18809.118.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
References: <20050427171446.GA3195@kroah.com>  <20050427171649.GG3195@kroah.com>
 <1114619928.18809.118.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, Alan Cox wrote:

> On Mer, 2005-04-27 at 18:16, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> This patch is just wrong on so many different levels its hard to know
> where to begin.
> 
> 1. The auth for arbitary commands is CAP_SYS_RAWIO

Valid complaint.

> 2. "The SCSI command permissions were discussed widely on the linux
> lists but this did not result in any useful refinement of the
> permissions." - this is false. The process was refined, a table setup
> was added and debugged.

Any user having write access to the device is still allowed to send MODE 
SELECT (and some other commands useful for CD/DVD writers but being 
potentially dangerous to other). The assumption that _any_ command needed 
for burning CDs/DVDs is safe for all device types is ridiculous. This is 
why I don't consider the refinements useful.

Controlling high-level access and pass-through with the same permissions 
is not a very good model.

> Someone even wrote an fs for managing it that is
> not yet merged.

Yes. So we should wait for a miracle happen and it get merged? My patch 
is meant to fix the problems at low level until a more general fix is 
merged (if that ever happens).

> Perhaps the patch author would care to re-read the
> archives and submit a new patch if one is even needed
> 3. Pleas explain *what* the specific consistency problems are

OK. Once again....

Using MODE SELECT you can change the drive behaviour so that it may become 
practically useless for other users (and even break very quickly). A 
simple method is to disable drive buffering. The inconsistency here is 
that to the users the drive status is not what the system managers meant 
it to be.

Another inconsistency comes from using commands moving the tape so that 
the tape driver does not know it. The tape driver provides users some 
status information about the tape head location (file and block number, 
BOT, EOF, etc.). This information is not valid if tape is moved using 
pass-through. The basic problem is that the driver for this kind of a 
sequential access device has to maintain some state information and it 
gets distorted if pass-through is used. One solution would, of course, be 
to interpret the commands and statuses going to/coming from pass-through 
but this is a quite heavy solution.


OK. If the Linux solution to these kind of security problems in the not so 
central areas of kernel is to wait and see if the problem disappears 
without any action, I have to accept that. But I have tried...

-- 
Kai
