Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131006AbRBNIxe>; Wed, 14 Feb 2001 03:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131761AbRBNIxZ>; Wed, 14 Feb 2001 03:53:25 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:2999 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131006AbRBNIxM>; Wed, 14 Feb 2001 03:53:12 -0500
Date: Wed, 14 Feb 2001 08:53:06 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Tim Waugh <twaugh@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <Pine.LNX.3.96.1010214020126.28011B-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.SOL.4.21.0102140851320.11339-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Jeff Garzik wrote:

> On Tue, 13 Feb 2001, Tim Waugh wrote:
> > Here's a patch that fixes a bug that can cause PCI driver list
> > corruption.  If parport_pc's init_module fails after it calls
> > pci_register_driver, cleanup_module isn't called and so it's still
> > registered when it gets unloaded.
> 
> > --- linux/drivers/parport/parport_pc.c.init	Tue Feb 13 23:31:25 2001
> > +++ linux/drivers/parport/parport_pc.c	Tue Feb 13 23:35:56 2001
> > @@ -89,6 +89,7 @@
> >  } superios[NR_SUPERIOS] __devinitdata = { {0,},};
> >  
> >  static int user_specified __devinitdata = 0;
> > +static int registered_parport;
> >  
> >  /* frob_control, but for ECR */
> >  static void frob_econtrol (struct parport *pb, unsigned char m,
> > @@ -2605,6 +2606,7 @@
> >  	count += parport_pc_find_nonpci_ports (autoirq, autodma);
> >  
> >  	r = pci_register_driver (&parport_pc_pci_driver);
> > +	registered_parport = 1;
> >  	if (r > 0)
> >  		count += r;
> 
> Bad patch.  It should be
> 
> 	if (r >= 0) {
> 		registered_parport = 1;
> 		if (r > 0)
> 			count += r;
> 	}

The second "if" is redundant here: if r==0, count+=r has no effect. I
don't think gcc would spot that on optimization, would it??


James.

