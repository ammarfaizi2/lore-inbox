Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVDMBmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVDMBmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVDMBiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:38:13 -0400
Received: from webmail.topspin.com ([12.162.17.3]:45273 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262720AbVDMBed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:34:33 -0400
Date: Tue, 12 Apr 2005 18:04:47 -0700
From: Libor Michalek <libor@topspin.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050412180447.E6958@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050411171347.7e05859f.akpm@osdl.org>; from akpm@osdl.org on Mon, Apr 11, 2005 at 05:13:47PM -0700
X-OriginalArrivalTime: 13 Apr 2005 01:04:48.0357 (UTC) FILETIME=[C9E93150:01C53FC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 05:13:47PM -0700, Andrew Morton wrote:
> Roland Dreier <roland@topspin.com> wrote:
> >
> >     Troy> Do we even need the mlock in userspace then?
> > 
> > Yes, because the kernel may go through and unmap pages from userspace
> > while trying to swap.  Since we have the page locked in the kernel,
> > the physical page won't go anywhere, but userspace might end up with a
> > different page mapped at the same virtual address.

With the last few kernels I haven't had a chance to retest the problem
that pushed us in the direction of using mlock. I will go back and do
so with the latest kernel. Below I've given a quick description of the
issue.

> That shouldn't happen.  If get_user_pages() has elevated the refcount on a
> page then the following can happen:
> 
> - The VM may decide to add the page to swapcache (if it's not mmapped
>   from a file).
> 
> - Once the page is backed by either swapcache of a (mmapped) file, the VM
>   may decide the unmap the application's pte's.  A later minor fault by the
>   app will cause the same physical page to be remapped.

The driver did use get_user_pages() to elevated the refcount on all the
pages it was going to use for IO, as well as call set_page_dirty() since
the pages were going to have data written to them from the device.

The problem we were seeing is that the minor fault by the app resulted
in a new physical page getting mapped for the application. The page that
had the elevated refcount was still waiting for the data to be written
to by the driver at the time that the app accessed the page causing the
minor fault. Obviously since the app had a new mapping the data written
by the driver was lost.

It looks like code was added to try_to_unmap_one() to address this, so
hopefully it's no longer an issue...


-Libor
