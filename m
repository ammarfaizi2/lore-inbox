Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTJHKCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 06:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJHKCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 06:02:10 -0400
Received: from gaia.cela.pl ([213.134.162.11]:52748 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261336AbTJHKCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 06:02:06 -0400
Date: Wed, 8 Oct 2003 12:01:01 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Tian, Kevin" <kevin.tian@intel.com>
cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       "Sharma, Arun" <arun.sharma@intel.com>, <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: RE: [PATCH] incorrect use of sizeof() in ioctl definitions
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8F3283B@pdsmsx403.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0310081153400.31957-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Maybe I got something wrong, but could someone please help me to
> understand why introduce _IOR_BAD here? Thanks first! :)

So as not to break userspace we must still support old values, at the same 
time we want new programs to start using the new correct values - hence 
the introduction of _backward compatibility_ values.

> (old)	#define MATROXFB_SET_OUTPUT_MODE
> _IOW('n',0xFA,sizeof(struct matroxioc_output_mode))
> (now)	#define MATROXFB_SET_OUTPUT_MODE        _IOW('n',0xFA,size_t)

the old was bad since it was sizeof(sizeof(...)) - it so happens that by 
def sizeof(anything) is a size_t - thus replacing sizeof(sizeof(..)) with 
sizeof(size_t) changes nothing - just shortens the code...
Of course what we probably should really have is the above (now) code 
defined as "BAD" and the previous (old) define without the sizeof as the 
current (no BAD prefix).

> 	The size of matroxioc_output_mode is 8 bytes on all platforms,
> however size_t will be calculated as 4 bytes on 32bit arch and 8 bytes
> on 64bit arch. So this is also like using sizeof(), which imposes the
> difference between 32bit ioctl number and 64bit ioctl number. However in
> standard manner, I mean:
> 	#define MATROXFB_SET_OUTPUT_MODE        _IOW('n',0xFA,struct
> matroxioc_output_mode)
>  	The value should be identical on all platforms, which save our
> efforts to do useless conversion when running 32bit apps on 64bit
> platform.

Precisely - unfortunately due to coding errors (the erroneous double 
sizeof invocation) this isn't the way it is - and for backwards 
compatibility it can't be broken... sad, really...

> 
> 	The most important is: to use sizeof() or size_t here both
> messed the ioctl definition, which violate the initial motivation of
> _IO**, is it?

Yap, both violate.  It is a mess and there is no easy fix due to the need
to retain the old invalid ioctl's as well... and the real 'tough' mess is
on platforms where due to type sizes both the OLD and the NEW defines
result in the same IOCTL define value... that'll probably screw over
switch statements (I'm not sure - but I think you can't have the same
value twice in a case statement).  If this happens on all platforms than 
the conversion OLD==BAD to NEW can be done quietly - otherwise... we've 
got hell.

Cheers,
MaZe.

