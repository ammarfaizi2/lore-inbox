Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRGEPR2>; Thu, 5 Jul 2001 11:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265381AbRGEPRS>; Thu, 5 Jul 2001 11:17:18 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:1836 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265390AbRGEPRF>; Thu, 5 Jul 2001 11:17:05 -0400
Date: Thu, 5 Jul 2001 16:06:32 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: O_DIRECT! or O_DIRECT?
Message-ID: <20010705160632.A9968@redhat.com>
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru> <20010704185230.F28793@redhat.com> <9hvn61$rkb$1@ncc1701.cistron.net> <20010704193402.A6403@redhat.com> <9hvtvd$9o2$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9hvtvd$9o2$1@ncc1701.cistron.net>; from miquels@cistron-office.nl on Wed, Jul 04, 2001 at 08:23:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 04, 2001 at 08:23:10PM +0000, Miquel van Smoorenburg wrote:

> >huge copies.  But what part of the normal handling of sequential files
> >would O_SEQUENTIAL change?  Good handling of sequential files should
> >be the default, not an explicitly-requested feature.
> 
> exactly what I meant, since that is what MADV_SEQUENTIAL seems to do:
> 
> linux/mm/filemap.c:
> 
>  *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
>  *              once, so they can be aggressively read ahead, and
>  *              can be freed soon after they are accessed.

We already have "drop-behind" for sequential reads --- we lower the
priority of recently read-in pages so that if they don't get accessed
again, they can be reclaimed.  This should be, and is, part of the
default kernel behaviour for such things.

The trouble is that you still need the VM to go around and clean up
those pages if you need the memory for something else.  There's a big
difference between "can be freed" and "are forcibly freed".  O_DIRECT
behaves like the latter: the memory is automatically reclaimed after
use so it results in no memory pressure at all, whereas the
MADV_SEQUENTIAL type of behaviour just allows the VM to reclaim those
pages on demand --- the VM still has to do the work.

Cheers,
 Stephen
