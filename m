Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132097AbQKVBoy>; Tue, 21 Nov 2000 20:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbQKVBoo>; Tue, 21 Nov 2000 20:44:44 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:28938 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132097AbQKVBoh>; Tue, 21 Nov 2000 20:44:37 -0500
Date: Tue, 21 Nov 2000 19:14:32 -0600
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-ID: <20001121191432.H2918@wire.cadcamlab.org>
In-Reply-To: <14874.25691.629724.306563@wire.cadcamlab.org> <20001121071327.R1514@devserv.devel.redhat.com> <20001121215145.C748@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001121215145.C748@werewolf.able.es>; from jamagallon@able.es on Tue, Nov 21, 2000 at 09:51:45PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    [I wrote]
> > >   void foo (void)
> > >   {
> > >     if (0)
> > >       printk(KERN_INFO "bar");
> > >   }
> > > 

[J . A . Magallon]
> Is it related to opt level ? -O3 does auto-inlining and -O2 does not
> (discovered that here, auto inlining in kernel trashes the cache...)

See for yourself.  'gcc -S' is most helpful.  The above generates a
string constant "bar\0" for all optimization levels.

Jakub Jelinek claims to have fixed this particular bug in the last week
or so, although I have not downloaded and compiled recent CVS to verify
this.  (Didn't someone at some point have a cgi frontend to
CVS-snapshot 'gcc -S'?  I can't find it now.)

There is a similar case of scoped 'static' variables, like 'bar' here:

  extern void baz (int *);
  void foo (void)
  {
    if (0) {
      static int bar[1024];	/* useless 4096-byte hole in bss */
      baz(bar);
    }
  }

and according to Jeff Law, this case is *not* fixed yet.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
