Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbTD3V71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTD3V71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:59:27 -0400
Received: from findaloan-online.cc ([216.209.85.42]:54533 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S262453AbTD3V70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:59:26 -0400
Date: Wed, 30 Apr 2003 18:18:34 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: =?iso-8859-1?B?UOVs?= Halvorsen <paalh@ifi.uio.no>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: sendfile
Message-ID: <20030430221834.GA23109@mark.mielke.cc>
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no> <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:57:59PM +0200, P?l Halvorsen wrote:
> On Wed, 30 Apr 2003, bert hubert wrote:
> > On Wed, Apr 30, 2003 at 09:12:17PM +0200, P?l Halvorsen wrote:
> > > It could be useful for applications like streaming video where other
> > > protocols on top provide additional functionality or in a multicast
> > > session where TCP migth not be appropriate.
> > sendfile on UDP would try to send gigabits per second over ppp0...
> YES, I guess sendfile will send "count" bytes as fast as possible using
> UDP. However, can't sendfile be called several times, allowing the
> sender to keep track of the offsett and byte count, e.g., sending the
> data needed for a second video each second? Or does sendfile
> close the file/socket after each call (really making it useful for only
> whole file transfers at a time like retrieving a www-document)?

At some point, I would wonder 'why'? I've always considered the real
benefit of sendfile() that the system never has to fully swap your
process in, in order to do work on your behalf as would be necessary
with read() and write(). The zero copy architecture doesn't seem
significant to me if you are going to wait between sendfile()
requests.

> > > But should not the 2.4.X kernels have support for chained sk_buffs (like
> > > the BSD mbufs) meaning that support for scatter-gatter I/O from the NIC
> > > should be unneccessary to support zero-copy (i.e., NO in-memory data
> > > copy operations)?
> > No clue what you mean over here. Zero copy means different things to
> > different people. Sendfile eliminates the 'read(to buffer);write(buffer to
> > network);' copy.
> First, zero-copy for me is to have no copy operations from one main memory
> location to another (not counting the transfer from disk to memory and
> from memory to NIC). Thus, I would like to read data into one memory
> location and transfer the same data form the same location to the NIC.

To some degree, couldn't sendto() fit this description? (Assuming the kernel
implemented 'zero-copy' on sendto()) The benefit of sendfile() is that
data isn't coming from a memory location. It is coming from disk, meaning
that your process doesn't have to become active in order for work to be
done. In the case of UDP packets, you almost always want a layer on top
that either times the UDP packet output, or sends output in response to
input, mostly defeating the purpose of sendfile()...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

