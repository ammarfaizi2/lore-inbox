Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268600AbRGYRZR>; Wed, 25 Jul 2001 13:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268599AbRGYRZH>; Wed, 25 Jul 2001 13:25:07 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:36617 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S268598AbRGYRY4>;
	Wed, 25 Jul 2001 13:24:56 -0400
From: tpepper@vato.org
Date: Wed, 25 Jul 2001 10:24:47 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: Design-Question: end_that_request_* and bh->b_end_io hooks
Message-ID: <20010725102447.A16615@cb.vato.org>
In-Reply-To: <OF3CC2BFB9.69086721-ONC1256A93.0059C650@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <OF3CC2BFB9.69086721-ONC1256A93.0059C650@de.ibm.com>; from COTTE@de.ibm.com on Tue, Jul 24, 2001 at 07:20:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Are you confusing generic_make_request() and __make_request().
generic_make_request() doesn't itself grab any locks or sleep.  It mostly
sets some stuff up and calls the make_request function that was registered
for the given queue.  If the driver hasn't done anything special for its
make_request() function then __make_request() will be that function,
in which case your statements about locking and sleeping are correct.
I suppose that either way you're triggering stuff to run which might
sleep so you shouldn't be holding locks.

You bring up an interresting point though aside from locking.
What I've read has given me the indication that a person writing
a b_end_io() function should assume that they could be called from
interrupt context.  If that is the case then any b_end_io() wanting to
call generic_make_request() would need to defer that call until it was
outside of interrupt context.  Otherwise the b_end_io() could sleep
within interrupt context.  Drivers at the "md" level tend to call
generic_make_request() after b_end_io(), but in the kernel proper I
don't see any others.  I haven't traced through the md drivers enough
to know but it does look like they do defer.

I think this may be something I'm doing wrong in a driver on which I'm
working...

Tim
