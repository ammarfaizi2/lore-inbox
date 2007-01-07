Return-Path: <linux-kernel-owner+w=401wt.eu-S965242AbXAGW6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbXAGW6a (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbXAGW6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:58:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48919 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965242AbXAGW6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:58:30 -0500
X-Greylist: delayed 8782 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 17:58:30 EST
Date: Sun, 7 Jan 2007 15:31:20 -0500
From: "Shawn O. Pearce" <spearce@spearce.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
Message-ID: <20070107203120.GA4970@spearce.org>
References: <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <m3odpazxit.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3odpazxit.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Hmm... Perhaps it should be possible to push git updates as a pack
> file only? I mean, the pack file would stay packed = never individual
> files and never 256 directories?

Latest Git does this.  If the server is later than 1.4.3.3 then
the receive-pack process can actually store the pack file rather
than unpacking it into loose objects.  The downside is that it will
copy any missing base objects onto the end of a thin pack to make
it not-thin.

There's actually a limit that controls when to keep the pack and when
not to (receive.unpackLimit).  In 1.4.3.3 this defaulted to 5000
objects, which meant all but the largest pushes will be exploded
into loose objects.  In 1.5.0-rc0 that limit changed from 5000 to
100, though Nico did a lot of study and discovered that the optimum
is likely 3.  But that tends to create too many pack files so 100
was arbitrarily chosen.

So if the user pushes <100 objects to a 1.5.0-rc0 server we unpack
to loose; >= 100 we keep the pack file.  Perhaps this would help
kernel.org.
 
-- 
Shawn.
