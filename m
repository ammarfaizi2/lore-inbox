Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVGROnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVGROnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVGROnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:43:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45244 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261777AbVGROls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:41:48 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17115.49049.576527.324806@tut.ibm.com>
Date: Mon, 18 Jul 2005 09:41:29 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Merging relayfs?
In-Reply-To: <1121694275.12862.23.camel@localhost.localdomain>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
	<20050711193409.043ecb14.akpm@osdl.org>
	<Pine.LNX.4.61.0507131809120.3743@scrub.home>
	<17110.32325.532858.79690@tut.ibm.com>
	<Pine.LNX.4.61.0507171551390.3728@scrub.home>
	<17114.32450.420164.971783@tut.ibm.com>
	<1121694275.12862.23.camel@localhost.localdomain>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt writes:
 > On Sun, 2005-07-17 at 10:52 -0500, Tom Zanussi wrote:
 > 
 > >  > 
 > >  > >  > - overwrite mode can be implemented via the buffer switch callback
 > >  > > 
 > >  > > The buffer switch callback is already where this is handled, unless
 > >  > > you're thinking of something else - one of the first checks in the
 > >  > > buffer switch is relay_buf_full(), which always returns 0 if the
 > >  > > buffer is in overwrite mode.
 > >  > 
 > >  > I mean, relayfs doesn't has to know about this, the client itself can do 
 > >  > it (e.g. via helper functions).
 > > 
 > > In a previous version, we did something like having the client pass
 > > back a return value from the callback indicating whether or not to
 > > continue or stop.  I can try doing something like that instead again.
 > 
 > Tom,
 > 
 > I'm actually very much against this. Looking at a point of view from the
 > logdev device. Having a callback to know to continue at every buffer
 > switch would just be slowing down something that is expected to be very
 > fast. I don't see the problem with having an overwrite mode or not. Why
 > can't relayfs know this? It _is_ an operation of relayfs, and having it
 > pushed to the client would seem to make the client need to know more
 > about how relayfs works that it needs to.  Because, the logdev device
 > doesn't care about buffer switches.

I don't think it would slow anything down - it would be pretty much
the same code being executed as before e.g. the buffer_start()
callback for overwrite mode could look like this:

int buffer_start()
{
	...	
	return 1; // continue unconditionally
}

And for no-overwrite mode:

int buffer_start()
{
	...	
	return !relay_buf_full(buf); // continue if not full
}

Since the buffer start callback already returns the amount that's
supposed to be reserved at the start of the sub-buffer, I'd have to
make that an outparam instead, I guess, but it's basically the same
code handling the overwrite/no-overwrite condition.

Tom


