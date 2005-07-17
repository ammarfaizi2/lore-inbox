Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVGQPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVGQPxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVGQPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 11:53:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52164 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261316AbVGQPwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 11:52:49 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17114.32450.420164.971783@tut.ibm.com>
Date: Sun, 17 Jul 2005 10:52:34 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.LNX.4.61.0507171551390.3728@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
	<20050711193409.043ecb14.akpm@osdl.org>
	<Pine.LNX.4.61.0507131809120.3743@scrub.home>
	<17110.32325.532858.79690@tut.ibm.com>
	<Pine.LNX.4.61.0507171551390.3728@scrub.home>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
 > Hi,
 > 
 > On Thu, 14 Jul 2005, Tom Zanussi wrote:
 > 
 > > The netlink control channel seems to work very well, but I can
 > > certainly change the examples to use something different.  Could you
 > > suggest something?
 > 
 > It just looks like a complicated way to do an ioctl, a control file that 
 > you can read/write would be a lot simpler and faster.

You're right - in previous versions, we did use ioctl - we ended up
using netlink as it seemed like least offensive option to most people.
I'll try modifying the example code to use a control file or something
like that instead though.

 > 
 > >  > Looking through the patch there are still a few areas I'm concerned about:
 > >  > - the usage of atomic_t look a little silly, there is only a single 
 > >  > writer and probably needs some cache line optimisations
 > > 
 > > The only things that are atomic are the counts of produced and
 > > consumed buffers and these are only ever updated or read in the slow
 > > buffer-switch path.  They're atomic because if they weren't, wouldn't
 > > it be possible for the client to read an unfinished value if the
 > > producer was in the middle of updating it?
 > 
 > No.
 > 
 > >  > - I would prefer "unsigned int" over just "unsigned"
 > >  > - the padding/commit arrays can be easily managed by the client
 > > 
 > > Yes, I can move them out and update the examples to reflect that, but
 > > I thought that if this was something that most clients would need to
 > > do, it made some sense to keep it in relayfs and avoid duplication in
 > > the clients.
 > 
 > If a lot of clients needs this, there a different ways to do this, e.g. by 
 > introducing some helper functions that clients can use. This way you can 
 > keep the core simple and allow the client to modify its behaviour.

OK, I'll think about the best way to change this.

 > 
 > >  > - overwrite mode can be implemented via the buffer switch callback
 > > 
 > > The buffer switch callback is already where this is handled, unless
 > > you're thinking of something else - one of the first checks in the
 > > buffer switch is relay_buf_full(), which always returns 0 if the
 > > buffer is in overwrite mode.
 > 
 > I mean, relayfs doesn't has to know about this, the client itself can do 
 > it (e.g. via helper functions).

In a previous version, we did something like having the client pass
back a return value from the callback indicating whether or not to
continue or stop.  I can try doing something like that instead again.

Tom


