Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTKYG6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 01:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKYG6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 01:58:49 -0500
Received: from blr-dsmaster.blr.novell.com ([164.99.147.9]:18278 "EHLO
	BLR-DSMASTER.BLR.NOVELL.COM") by vger.kernel.org with ESMTP
	id S261936AbTKYG6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 01:58:47 -0500
Subject: Re: Fix for "MT2032 Fatal Error: PLLs didn't lock"
From: "Subbu K. K." <kksubramaniam@novell.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20031124114620.GA29771@bytesex.org>
References: <20031124004835.3abbb4cf.akpm@osdl.org>
	 <20031124114620.GA29771@bytesex.org>
Content-Type: text/plain
Message-Id: <1069743507.1270.2.camel@dog.blr.novell.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 25 Nov 2003 12:28:28 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 17:16, Gerd Knorr wrote: 
> > I saw others report same issues but didnt see any
> > fixes/patches/solutions. With the debug option on for bttv and tuner in
> > /etc/modules.conf and the TV frequency set to 133.25MHz and then
> > 140.25MHz, the sign extension defect pops up in rfin value below. This
> > is because 133.25MHz is 0x7F13BD0 and 140.25MHz is 0x85C0B90. The high
> > bit gets sign extended in as 0xFFFFFFFFF85C0B90 (-128185456)
> 
> Huh?  I can't see where a sign extension happens.  0x85C0B90 has the bit
> #27 set to one, not #31 ...
I know this sounds weird, but sign extension is happening between
invocation of set_tv_freq and the dprintk in mt2032_set_tv_freq.

> Beside that the values are passed around as unsigned values everythere.
> Can you please explain in more detail what is going on?
Except in one place where there is an implicit conversion to signed ints
in line 746:

746         mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */, 
> > Nov 16 21:45:56 localhost kernel: tuner: tv freq set to 133.25
> > Nov 16 21:45:56 localhost kernel: mt2032_set_if_freq rfin=133250000
> > if1=1090000000 if2=38900000 from=32900000 to=39900000
> 
> > Nov 16 21:45:58 localhost kernel: tuner: tv freq set to 140.25
> > Nov 16 21:45:58 localhost kernel: mt2032_set_if_freq rfin=-128185456
> > if1=1090000000 if2=38900000 from=32900000 to=39900000
> 
> Works fine here:
> 
> tuner: tv freq set to 140.25
> mt2032_set_if_freq rfin=140250000 if1=1090000000 if2=38900000 from=32900000 to=39900000
Thanks for the clue. Perhaps the problem is gcc/athlon related?

> >  	case VIDIOCSFREQ:
> >  	{
> > -		unsigned long *v = arg;
> > +		unsigned int *v = arg;
> 
> Wrong, VIDIOCSFREQ is "_IOW('v',15, unsigned long)".  Beside that I'm
> very surprised that this actually makes a difference.  What architecture
> is that?  And what size int/long have there?
I agree that the change is rather kludgy. I was using stock Mandrake
9.1/gcc3.2.2 on AMD Athlon 1.4GHz. I have seen the error pop up on the
Knoppix (2.4.18..2.4.20 kernels) also on the same box so it doesnt seem
to be distro-specific. I dont have a Intel system to check if the
problem is related to the cpu. Clues anyone?

Let me poke around in the assembly code tonight to find out why the sign
change happens on my box. I suspect this could be due to gcc/athlon
combo.

Subbu K. K.

