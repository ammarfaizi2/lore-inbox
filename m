Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136950AbREJVep>; Thu, 10 May 2001 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136951AbREJVeZ>; Thu, 10 May 2001 17:34:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136950AbREJVeP>; Thu, 10 May 2001 17:34:15 -0400
Date: Thu, 10 May 2001 23:32:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Deadlock in 2.2 sock_alloc_send_skb?
Message-ID: <20010510233225.Y848@athlon.random>
In-Reply-To: <C1256A48.00451BD1.00@d12mta11.de.ibm.com> <E14xq0v-0004j0-00@the-village.bc.nu> <20010510193047.A22970@gruyere.muc.suse.de> <20010510231300.W848@athlon.random> <20010510231717.A25610@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010510231717.A25610@gruyere.muc.suse.de>; from ak@suse.de on Thu, May 10, 2001 at 11:17:17PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 11:17:17PM +0200, Andi Kleen wrote:
> On Thu, May 10, 2001 at 11:13:00PM +0200, Andrea Arcangeli wrote:
> > On Thu, May 10, 2001 at 07:30:47PM +0200, Andi Kleen wrote:
> > > On Thu, May 10, 2001 at 01:57:49PM +0100, Alan Cox wrote:
> > > > > If that happens, and the socket uses GFP_ATOMIC allocation, the while (1)
> > > > > loop in sock_alloc_send_skb() will endlessly spin, without ever calling
> > > > > schedule(), and all the time holding the kernel lock ...
> > > > 
> > > > If the socket is using GFP_ATOMIC allocation it should never loop. That is
> > > > -not-allowed-. 
> > > 
> > > It is just not clear why any socket should use GFP_ATOMIC. I can understand
> > > it using GFP_BUFFER e.g. for nbd, but GFP_ATOMIC seems to be rather radical
> > > and fragile.
> > 
> > side note, the only legal use of GFP_ATOMIC in sock_alloc_send_skb is
> > with noblock set and fallback zero, remeber GFP_BUFFER will sleep, it
> > may not sleep in vanilla 2.2.19 but the necessary lowlatency hooks in
> > the memory balancing that for example I have on my 2.2 tree will make it
> > to sleep.
> 
> Even with nonblock set the socket code will sleep in some circumstances
> (e.g. when aquiring the socket lock) so interrupt operation is out anyways.
> 
> 
> > The patch self contained looks perfect (I didn't checked that the
> > callers are happy with a -ENOMEM errorcode though), if alloc_skb()
> > failed that's a plain -ENOMEM. The caller must _not_ try again, they
> > must take a recovery fail path instead.
> 
> I think the callers are likely broken.
> The patch is still good of course, but not for GFP_ATOMIC. 

you said interrupt won't call that function so I don't see the
GFP_ATOMIC issue.

I also don't what's the issue with GFP_ATOMIC regardless somebody uses
it or not, the patch itself has nothing to do with GFP_ATOMIC. All
gfpmasks can fail, allock_skb can fail regardless of the gfpmask, not
only GFP_ATOMIC will fail, of course GFP_ATOMIC can fail even if the
machine is not totally out of memory but you never know and you cannot
assume anything and when alloc_skb fails you must assume the machine is
totally out of memory or you will deadlock, so if alloc_skb fails we
must return -ENOMEM and take the fail path and the patch does the right
thing in such case as well.

Andrea
