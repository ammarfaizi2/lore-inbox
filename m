Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUDNPPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDNPPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:15:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:55997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264256AbUDNPOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:14:24 -0400
Date: Wed, 14 Apr 2004 08:14:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
In-Reply-To: <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404140803040.12398@ppc970.osdl.org>
References: <20040406145544.GA19553@MAIL.13thfloor.at>
 <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk>
 <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Tue, Apr 06, 2004 at 09:48:44PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> > noatime/nodiratime: OK, but we still have direct modifications of i_atime
> > that need to be taken care of.
> 
> Particulary interesting one is in tty_io.c.  There we
> 	1) unconditionally touch i_atime on read()
> 	2) do not touch it on write()
> 	3) never mark the inode dirty.

All of 1-3 are correct.

They all mean that:

 - atime never gets written out for tty devices, because there is no
   point, and we shouldn't cause disk activity (or worse, network 
   activity) just because somebody is typing at the keyboard. Thus #3.

 - atime is maintained properly for "last effective read" purposes, which 
   is what "ps"/"w" and friends want to see for idle time reporting.
   Thus both #1 and #2 are important.

 - atime is only valid as long as the tty is open (again, think "idle 
   time" - nobody actually cares what the atime is after the device has 
   been closed). Thus "atime potentially going backwards" due to #3 is a 
   non-issue.

So yes, tty atime updates are strange, but they are strange on PURPOSE. 

> Note that the last one means that doing stat() in a loop will sometimes
> give atime going backwards.  We also completely ignore noatime here.

Ignoring noatime is potentially the only one we should look at, but since 
tty's really _are_ "noatime" as far as the filesystem is concerned, I 
think it makes sense in the situation we are in anyway. The real reason 
for "noatime" is to avoid unnecessary filesystem activity, not that we 
necessarily want a constant atime.

> There are similar places in some other char drivers.  Obvious step would
> be to have them do file_accessed() instead; however, I'd really like to
> hear the rationale for existing behaviour.  Comments?

I don't know about other char drivers, those may well be wrong. But for
tty's in particular, idle time calculations really do pretty much require
the behaviour (apart from #3 - and #3 is, I think, effectively required by
not wanting to touch the disk on keyboard accesses).

Doing effectively a update_atime() on final tty close might be ok just to
avoid the backwards-running time, but you'd have to open-code it to avoid 
the "inode_times_differ()" check. Not worth it, I feel, since atime on a 
tty that has been closed is irrelevant.

		Linus
