Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTFUTRW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTFUTRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 15:17:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265279AbTFUTRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 15:17:21 -0400
Date: Sat, 21 Jun 2003 20:31:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030621193124.GK6754@parcelfarce.linux.theplanet.co.uk>
References: <3EF3F08B.5060305@aros.net> <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk> <3EF48A30.3010203@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF48A30.3010203@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 10:39:12AM -0600, Lou Langholtz wrote:
> >Why not put these into nbd_device?
> >
> I'd considered that and I'm reconsidering it again now. Not convinced 
> which way to go... Putting something as large as struct request_queue 
> within the nbd_device seems unbalanced somehow. Then again, until 2.5 
> the request_queue was typically shared by multiple devices of the same 
> MAJOR so part of the way the code is has to do with the legacy code. 
> Like the nbd_lock spinlock array and the struct request_queue queue_lock 
> field. Along the lines you're pushing for, why not have struct 
> requests_queue's queue_lock field then be the spinlock itself instead of 
> just being a pointer to a spinlock???

Because often that lock protects driver-internal objects that are used
by all queues.

Prefered variant (actually, we'll have to do it in 2.5 anyway) is to
allocate request_queue dynamically.  Just put a pointer to it into nbd_device.

BTW, could you please kill the ..._t silliness?  There is nothing wroung
with using 'struct nbd_device' directly.
 
> >>+static uint32_t request_magic;
> >>   
> >>
> >
> >???  htonl(NBD_REQUEST_MAGIC) is perfectly OK in the place where you
> >use it and more likely than not will give better code.
> >
> > 
> >
> >>+static uint32_t reply_magic;
> >>   
> >>
> >
> >Ditto.
> >
> What's wrong with having an explicit cache of this value that we can 
> rest assured doesn't in the worst case get compiled into multiple calls 
> to the htonl code?? Possible waste of one 4 byte memory location in the 
> worst compiler case or is there another problem?

htonl() honours constants.  If it doesn't, we are in for much more serious
problems, simply because a lot of codepaths in networking are using it.
A lot.  IOW, you are obfuscating code for no good reason (and add an extra
memory access, thus giving actually worse code - it's not an optimisation
at all).
