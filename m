Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUJEX6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUJEX6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUJEX6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:58:03 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:51790 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266477AbUJEX5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:57:43 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <1096922369.2666.177.camel@cube>
	<200410041926.57205.jbarnes@sgi.com>
	<1096945479.24537.15.camel@gaston>
	<200410050833.49654.jbarnes@engr.sgi.com>
	<1097016099.27222.14.camel@gaston>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Oct 2004 16:57:41 -0700
In-Reply-To: <1097016099.27222.14.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 06 Oct 2004 08:41:40 +1000")
Message-ID: <52r7ocra4q.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] I/O space write barrier
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 05 Oct 2004 23:57:41.0916 (UTC) FILETIME=[19E44DC0:01C4AB37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> I don't understand that neither. You can never guarantee
    Benjamin> any ordering between writes from different CPUs unless
    Benjamin> you have a sinlock. If you have an ordering problem with
    Benjamin> spinlocks, then it's a totally different issue, a bit
    Benjamin> more like MMIO vs. cacheable mem that we have on PPC. If
    Benjamin> this is the problem you are trying to chase, then we
    Benjamin> could use such a barrier on ppc too and make it a hard
    Benjamin> sync, but it has nothing to do with the write barrier we
    Benjamin> already have in our IO accessors...

As I understand it, the problem is that on some Itanium boxes, it's
possible to have the following code run:

	CPU 1				CPU 2
    spin_lock(&devlock);
    writel(foo);
    spin_unlock(&devlock);

				    spin_lock(&devlock);
				    writel(bar);
				    spin_unlock(&devlock);

and still have bar arrive at the device before foo.  One possibility
would be to add a read after the writel() to flush the posted write.
The proposed mmiowb() function is somewhat lighter weight -- it
guarantees that later writes will not hit the device before any writes
already issued, but it doesn't say anything about writes making it all
the way to the device.

I could be wrong but I think that the eieio in the ppc IO write
functions should be strong enough that mmiowb() can be a no-op.

By the way, are the ordering rules different for ppc32 and ppc64?  I
notice that the ppc32 out_xxx() functions do eieio while the ppc64
versions do a full sync.

Thanks,
  Roland


