Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTEIOrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTEIOrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:47:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57610 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263270AbTEIOrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:47:13 -0400
Date: Fri, 9 May 2003 16:56:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030509145621.GA17581@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030509132757.GA16649@alpha.home.local> <20030509154637.5cf14c8d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509154637.5cf14c8d.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:46:37PM +0200, Stephan von Krawczynski wrote:
> On Fri, 9 May 2003 15:27:57 +0200
> Willy Tarreau <willy@w.ods.org> wrote:
> 
> > On Fri, May 09, 2003 at 03:02:07PM +0200, Stephan von Krawczynski wrote:
> >  
> > > I cannot say which version of the driver it was, the only thing I can tell
> > > you is that the archive was called aic79xx-linux-2.4-20030410-tar.gz.
> > 
> > That's really interesting, because I got the bug since around this version
> > (20030417 IIRC), and it locked up only on SMP, sometimes during boot, or
> > during heavy disk accesses caused by "updatedb" and "make -j dep". It's
> > fixed in 20030502 from http://people.freebsd.org/~gibbs/linux/SRC/
> 
> I tried to merge the latest aic archive into 2.4.21-rc2, besides the "usual"
> signed/unsigned warnings I got this one:
> 
> aic7xxx_osm.c: In function `ahc_linux_map_seg':
> aic7xxx_osm.c:770: warning: integer constant is too large for "long" type

Good catch, but in fact, it's more this line which worries me :

758:                if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {

I don't see how ~0xFFFFFFFF can be non-null on 32 bits archs, because addr is
a bus_addr_t which is in turn dma_addr_t which itself is u32. So unless I don't
find the trick this would mean that this code should never be executed. Perhaps
~0xFFFFFFFFULL would be more appropriate, or even >0xFFFFFFFF, since this can be
detected with u32 using the carry left by the addition.

Regards,
Willy

