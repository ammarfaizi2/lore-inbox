Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSLHBHC>; Sat, 7 Dec 2002 20:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSLHBHB>; Sat, 7 Dec 2002 20:07:01 -0500
Received: from crack.them.org ([65.125.64.184]:34447 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265081AbSLHBGT>;
	Sat, 7 Dec 2002 20:06:19 -0500
Date: Sat, 7 Dec 2002 20:14:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
Message-ID: <20021208011403.GA7729@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com> <3DF27EE7.4010508@pobox.com> <3DF2844C.F9216283@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF2844C.F9216283@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 03:29:16PM -0800, Andrew Morton wrote:
> Jeff Garzik wrote:
> > 
> > David S. Miller wrote:
> > > Can't the cacheline_aligned attribute be applied to individual
> > > struct members?  I remember doing this for thread_struct on
> > > sparc ages ago.
> > 
> > Looks like it from the 2.4 processor.h code.
> > 
> > Attached is cut #2.  Thanks for all the near-instant feedback so far :)
> >   Andrew, does the attached still need padding on SMP?
> 
> It needs padding _only_ on SMP.  ____cacheline_aligned_in_smp.
> 
> #define offsetof(t, m)  ((int)(&((t *)0)->m))
> 
> struct foo {
>         int a;
>         int b __attribute__((__aligned__(1024)));
>         int c;
> } foo;
> 
> main()
> {
>         printf("%d\n", sizeof(struct foo));
>         printf("%d\n", offsetof(struct foo, a));
>         printf("%d\n", offsetof(struct foo, b));
>         printf("%d\n", offsetof(struct foo, c));
> }
> 
> ./a.out
> 2048
> 0
> 1024
> 1028
> 
> So your patch will do what you want it to do.  You should just tag the
> first member of a group with ____cacheline_aligned_in_smp, and keep an
> eye on things with offsetof().
> 
> Not sure why sizeof() returned 2048 though.

The structure contains an __aligned__(1024) item.  Think about an array
of 'struct foo' items.  They have to be 2048 bytes or you won't align
correctly.

C allows for empty space in structure padding, but not in arrays,
AFAIK.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
