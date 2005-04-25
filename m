Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVDYTPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVDYTPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVDYTPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:15:13 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:36895 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S262750AbVDYTLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:11:38 -0400
Date: Mon, 25 Apr 2005 12:11:11 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, hch@infradead.org, roland@topspin.com,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050425191111.GC2511@hexapodia.org>
References: <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423194421.4f0d6612.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 07:44:21PM -0700, Andrew Morton wrote:
> Timur Tabi <timur.tabi@ammasso.com> wrote:
> > As I said, the testcase only works with our hardware, and it's also
> > very large.  It's one small test that's part of a huge test suite.
> > It takes a couple hours just to install the damn thing.
> > 
> > We want to produce a simpler test case that demonstrates the problem in an 
> > easy-to-understand manner, but we don't have time to do that now.
> 
> If your theory is correct then it should be able to demonstrate this
> problem without any special hardware at all: pin some user memory, then
> generate memory pressure then check the contents of those pinned pages.
> 
> But if, for the DMA transfer, you're using the array of page*'s which were
> originally obtained from get_user_pages() then it's rather hard to see how
> the kernel could alter the page's contents.
> 
> Then again, if mlock() fixes it then something's up.  Very odd.

Andrew,

Libor Michalek posted a much more reasonable (to my limited
understanding) bug description in <20050412180447.E6958@topspin.com>.

(And I'd love to provide a URL, but damned if I can figure out how to
find that message on gmane.  Clue-bat applications gladly accepted.)

Libor Michalek wrote:
# The driver did use get_user_pages() to elevated the refcount on all the
# pages it was going to use for IO, as well as call set_page_dirty() since
# the pages were going to have data written to them from the device.
# 
# The problem we were seeing is that the minor fault by the app resulted
# in a new physical page getting mapped for the application. The page that
# had the elevated refcount was still waiting for the data to be written
# to by the driver at the time that the app accessed the page causing the
# minor fault. Obviously since the app had a new mapping the data written
# by the driver was lost.
# 
# It looks like code was added to try_to_unmap_one() to address this, so   
# hopefully it's no longer an issue...

Which makes me think that Timur's bug is just an
insufficiently-understood version of Libor's.

-andy
