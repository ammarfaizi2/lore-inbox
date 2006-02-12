Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWBLHtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWBLHtX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 02:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBLHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 02:49:23 -0500
Received: from [194.90.237.34] ([194.90.237.34]:4032 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932311AbWBLHtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 02:49:23 -0500
Date: Sun, 12 Feb 2006 09:50:37 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [git patch review 1/4] IPoIB: Don't start send-only joins while multicast thread is stopped
Message-ID: <20060212075037.GA11550@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1139689341370-68b63fa9b8e76d91@cisco.com> <20060211140209.57af1b16.akpm@osdl.org> <ada8xsh49ll.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada8xsh49ll.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Feb 2006 07:51:08.0015 (UTC) FILETIME=[154F87F0:01C62FA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Subject: [openib-general] Re: [git patch review 1/4] IPoIB: Don't start send-only joins while multicast thread is stopped
> 
>  > Roland Dreier <rolandd@cisco.com> wrote:
>  > >
>  > >  +	spin_lock_irq(&priv->lock);
>  > >  +	set_bit(IPOIB_MCAST_STARTED, &priv->flags);
>  > >  +	spin_unlock_irq(&priv->lock);
>  > 
>  > Strange to put a lock around an atomic op like that.
>  > 
>  > Sometimes it's valid.   If another cpu was doing:
>  > 
>  > 	spin_lock(lock);
>  > 
>  > 	if (test_bit(IPOIB_MCAST_STARTED))
>  > 		something();
>  > 	...
>  > 	if (test_bit(IPOIB_MCAST_STARTED))
>  > 		something_else();
>  > 
>  > 	spin_unlock(lock);
>  > 
>  > then the locked set_bit() makes sense.
>  > 
>  > But often it doesn't ;)
> 
> Good point.  Michael, any reason why the lock is there around the
> set_bit()?  (And similarly for the corresponding clear_bit())
> 
> Thanks,
>  Roland

Basically, its as Andrew said: the lock around clear_bit is there to ensure that
ipoib_mcast_send isnt running already when we stop the thread.  Thats why
test_bit has to be inside the lock, too.

This was discussed with Krishna Kumar when I posted the patch originally.
For more detail, please review this thread:
http://www.mail-archive.com/openib-general@openib.org/msg13206.html
or here
http://openib.org/pipermail/openib-general/2005-December/014370.html


-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
