Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbTA2Q7G>; Wed, 29 Jan 2003 11:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTA2Q7C>; Wed, 29 Jan 2003 11:59:02 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:49661 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266438AbTA2Q6D>; Wed, 29 Jan 2003 11:58:03 -0500
Message-Id: <200301291359.h0TDxK3f001217@eeyore.valparaiso.cl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: =?iso-8859-2?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, brand@eeyore.valparaiso.cl
Subject: Re: [BUG] in drivers/char/joystick/magellan.c 
In-Reply-To: Your message of "Tue, 28 Jan 2003 16:57:19 +0100."
             <20030128165719.A382@ucw.cz> 
Date: Wed, 29 Jan 2003 14:59:20 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> said:
> On Tue, Jan 28, 2003 at 04:53:12PM +0100, Jörn Engel wrote:
> > Hi!
> > 
> > Without the patch below, the \0 terminating the string is written
> > anywhere.

No. As the length is explicitly given, C will just fill out that many bytes
from the given string.

> >           nibbles[] would be even better, I guess.
> 
> Well, the zero isn't used, so it might make sense to use '0', 'A', 'B' ...
> ... though that's not very nice either.
> 
> > Can you check for stupidity on my side?
> 
> Can't find any. ;) Patch applied with [].

> > diff -Naur linux-2.4.21-pre3-ac4/drivers/char/joystick/magellan.c scratch/dri
> vers/char/joystick/magellan.c
> > --- linux-2.4.21-pre3-ac4/drivers/char/joystick/magellan.c	Thu Sep 13 00:3
> 4:06 2001
> > +++ scratch/drivers/char/joystick/magellan.c	Mon Jan 27 13:49:54 2003
> > @@ -66,7 +66,7 @@
> >  
> >  static int magellan_crunch_nibbles(unsigned char *data, int count)
> >  {
> > -	static unsigned char nibbles[16] = "0AB3D56GH9:K<MN?";
> > +	static unsigned char nibbles[17] = "0AB3D56GH9:K<MN?";
> >  
> >  	do {
> >  		if (data[count] == nibbles[data[count] & 0xf])

C says only the first 16 bytes get used as initializer, i.e., the '\0' is
(silently) discarded. The patch makes the array grow, for no reason; thus
making its read-only data usage probably 4 or even 16 bytes (padding)
larger.

Sure, it can be argued that this is bad style as nibbles[] really isn't a
string, and should not be initialized like such... but

	static unsigned char nibbles[] = {'0', 'A', ..., '?'};

is just awful.

Please leave it alone, or add a comment like:

 /* nibbles is no string, it is just initialized as such for convenience */
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
