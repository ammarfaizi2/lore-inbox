Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWJCSuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWJCSuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWJCSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:50:10 -0400
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210]:20126 "HELO
	web25224.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030182AbWJCSuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:50:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=pYU/cZrOeiDZ91GUTTIIiqQv9ouj497H81PXcRFCi6ovxHNu6Fx2KNXnlsUfkeHR1/oBxogEywX1A/yMSNolIh9wLByorlm1/xhUVrLs3d8zHEy/+/HrbZE+JTo8SfwolgANFhzIEevHC6JQ2Nu9oUQ5XP+xNJZGNvor7v5ACBI=  ;
Message-ID: <20061003185006.91302.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 3 Oct 2006 20:50:06 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Close file descriptor leaks
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061001220727.GA5194@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sun, Oct 01, 2006 at 07:10:37PM +0200, Blaisorblade wrote:
> > NACK on the ubd driver part. It adds a bugs and does fix the one
> you found in
> > the right point. ACK on the other hunk.

I'm answering away from the code (limited Internet access) so I'll
have to look better some things. The patch has been merged, I'll care
for that in any case (avoiding conflicts with my changes as needed).

> However, neither manipulates
> dev->count (this is done by ubd_open/ubd_release) and the call to
> ubd_add_disk indirectly calls ubd_open, which, since dev->count is
> still zero redoes the initialization, leaking the descriptor and
> vmalloc space allocated by the first ubd_open_dev call.

Ah, ok. I fixed exactly this - now ubd_open_dev and ubd_close_dev are
called only through ubd_{get,put}_dev, which manage the refcount. I
did this also for other reasons - the refcount makes "close while it
is being used" impossible, so solves "mutual exclusion without
locking" (like the network layer state machine does for network
devices, this is used in general for fds; I'll write something about
this).

> The fix is simple - there is no need for ubd_add to call
> ubd_open_dev
> or ubd_close (ubd_file_size doesn't require the device be opened),

I know ubd_file_size doesn't require opening, I thought (and still
think) that call was for error checking. I'll have to re-read the
code now that I saw your point.
> so
> the calls can simply be deleted.  With the non-count-changing
> device-opening call gone, the leaks just disappear.

> There are multiple things wrong with the code, many of which are
> still
> there, but I don't see this as being an argument against this
> change.
> It eliminates some useless code, which is good from both a
> maintenance
> and performance standpoint.  However, leaks aside, the main benefit
> of
> this change is that eliminates the one call to ubd_open_dev outside
> of
> ubd_open, and thus opening stuff on the host and allocating memory
> is
> always inside a check of dev->open.

Well, this may simplify locking, so it may be interesting - I'll see.

> > I've done huge changes to the UBD driver and I'll
> > send them you briefly for your tree (they work but they're not
> yet in a 
> > perfect shape).

> OK, just make sure you preserve (or add) this property.

> > For what I can gather from your description and code, the leak
> you diagnosed 
> > is a bug in ubd_open_dev(), and is valid for any call to it: 

> No, the bug is doing the work of opening the device outside a check
> of
> the device refcount.

Ok, but the one I saw exists (in the error: label), (but I have the
patch for it).

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito per i tuoi file e i messaggi 
http://mail.yahoo.it 
