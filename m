Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272191AbSISWXX>; Thu, 19 Sep 2002 18:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272192AbSISWXX>; Thu, 19 Sep 2002 18:23:23 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:31222 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S272191AbSISWXW>; Thu, 19 Sep 2002 18:23:22 -0400
Date: Thu, 19 Sep 2002 18:28:09 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Jason Lunz <lunz@falooley.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>, <edward_peng@dlink.com.tw>
Subject: Re: PATCH: sundance #5 (variable per-interface MTU support)
In-Reply-To: <20020919210348.GC17492@orr.falooley.org>
Message-ID: <Pine.LNX.4.44.0209191821050.29420-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Jason Lunz wrote:

> This is a straightforward merge of variable mtu from donald's driver.

-	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
+	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 36);

Errrmm, not quite right.

Try
	np->rx_buf_sz = (dev->mtu <= 1520 ? PKT_BUF_SZ : dev->mtu + 16);

The idea is that all ethernet-like drivers always allocate skbuffs of
the same size, PKT_BUF_SZ (1536=3*512), unless a jumbo MTU forces a
larger size. 

Specificially, using VLANs (+4 bytes on the frame size) on some interfaces
should not result in a mix of allocation sizes.  Most VLAN-like
encapsulation should add fewer than (1536-1518 = 18) 18 extra bytes.

BTW, always leave a few extra bytes at the end of the data buffer.
You never know when some chip might decide to dribble an extra word or
two, or include the CRC because someone frobbed the driver.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

