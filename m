Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161304AbWGNVHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWGNVHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbWGNVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 17:07:04 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:46471 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1161304AbWGNVHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 17:07:03 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	<m3sllxtfbf.fsf@telia.com>
	<1151000451.3120.56.camel@laptopd505.fenrus.org>
	<m3u05kqvla.fsf@telia.com>
	<1152884770.3159.37.camel@laptopd505.fenrus.org>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2006 23:06:51 +0200
In-Reply-To: <1152884770.3159.37.camel@laptopd505.fenrus.org>
Message-ID: <m3odvrc2vo.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> On Fri, 2006-07-14 at 13:22 +0200, Peter Osterlund wrote:
> > > and what locking prevents this? And via multiple opens?
> > 
> > You are right that my reasoning was incorrect. If someone is doing
> > "pktsetup ; pktsetup -d" quickly in a loop while someone else is
> > trying to open the device, one thread could be at the start of
> > pkt_open() at the same time as another thread is in pkt_new_dev().
> > 
> > However, I added a 5s delay in pkt_open() to enlarge the race window.
> > I still couldn't make the driver lock up though. The explanation is
> > that pkt_new_dev() calls blkdev_get() with the CD device (eg /dev/hdc)
> > as bdev parameter, while do_open() locks the bd_mutex for the pktcdvd
> > device (eg /dev/pktcdvd/0).
> > 
> > Do you still think this could deadlock? If not, how should the code be
> > annotated to make this warning go away?
> 
> unless we KNOW it won't deadlock (eg we have a "this cannot deadlock
> BECAUSE of X, Y and Z") I don't think annotations are the right idea. In
> addition, the "how to annotate" really depends on what X, Y and Z
> are....

In the first call chain, do_open -> pkt_open, the bd_mutex object that
is being locked corresponds to a pktcdvd block device, because those
are the only devices that have their open method set to pkt_open.

In the second call chain, pkt_ctl_ioctl -> pkt_new_dev -> do_open, the
bd_mutex object that is being locked *does not* correspond to a
pktcdvd block device, because pkt_new_dev will bail out with a "Can't
chain pktcdvd devices" error if you call it with "dev" set to a
pktcdvd device.

Therefore, there is no AB-BA deadlock possibility. The locking
dependencies are A -> B and B -> A', where it is known that A, B and
A' are all different.

So the claim from the lockdep code, "BUG: possible circular locking
deadlock detected!", is a false alarm.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
