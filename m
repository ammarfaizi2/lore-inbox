Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264416AbRGNRek>; Sat, 14 Jul 2001 13:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRGNReU>; Sat, 14 Jul 2001 13:34:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50789 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264416AbRGNReK>; Sat, 14 Jul 2001 13:34:10 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: Remove swap file support
In-Reply-To: <E15LS1o-0001OU-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jul 2001 11:28:42 -0600
In-Reply-To: <E15LS1o-0001OU-00@the-village.bc.nu>
Message-ID: <m17kxb4dyt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > The case of swap files with holes would be a nice thing to have.
> > It would effectivly give us a way to say "use the extra space on this
> > file system for swap" and at the same time the ability to set a limit
> > on how much space could be taken up by swap.  For example you could
> > create a totally sparse 1G file at bootup, and use it as a swap file.
> > If the system needed swap it could grow the file, but you would know
> > that it would never grow beyond 1G.
> 
> Growing a swap file gets complex and complex where complexity is bad and 
> resources are constrained due to memory pressure. 

I'll agree with that.  The big thing we lack in 2.4 is filesystem
space reservation.  It's the companion of allocate on write, and with
a little care could handle a lot of the bad cases with sparse files.
If done right we don't need to care how a file is layed out on disk.
We reserve the whole 1G during swapon, or more likely we reserve
storage from the swap page when we allocate it.  But this garantees we
won't have space problems later on during the write.  

> We do need to sort this out for 2.5, for one the way that swap is 'different'
> to the rest of the backing store is ugly in itself and causes a lot of
> duplication and overcomplex code.

Unifying the cases is good, but a lot of the over complex code is simply
because people just don't get around to updating the swap code to use
the new inferfaces when everything else is updated.  The code is just
patched to keep working when inerfaces are changed.

> Really there should be no pages going to some anonymous magic 'swap' object.
> Instead each virtual memory area should be backed by a file system object,
> including a 'swapfs' - which might be the existing style of swap, might be
> something stacked onto an existing fs that allocates and manages free space
> or might be completely bizarre (eg a high speed SAN network swap protocol)

Hmm.  I'm not certain what you are going for here.  Having swap going
to an address_space object is only a couple of days work to get
going, and gives the benefits you are describing.  Basically the only
case left in the code would be the swap file case.

Removing anonymous shared copy on write pages is something that might
be worth doing but it is something we need to examine very closely.
Over simplying things in the case of swap is very dangerous.  Last
time we tried we would up cache tons of worthless dead swap pages.

Eric


