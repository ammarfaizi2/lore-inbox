Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSFKQbz>; Tue, 11 Jun 2002 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317166AbSFKQby>; Tue, 11 Jun 2002 12:31:54 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:46864 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317165AbSFKQbx>; Tue, 11 Jun 2002 12:31:53 -0400
Date: Tue, 11 Jun 2002 17:31:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020611173147.C3665@flint.arm.linux.org.uk>
In-Reply-To: <20020609175804.B8761@flint.arm.linux.org.uk> <5896.1023750165@ocs3.intra.ocs.com.au> <20020611083947.A1346@flint.arm.linux.org.uk> <E17HoBz-0000A0-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 06:08:22PM +0200, Daniel Phillips wrote:
> Are you sure that complexity was added just to handle commas in names?
> Or is it really an example of how good design never gave this bug a
> chance to exist in the first palce.
> 
> I *really* don't like the idea of papering over such bugs by curing the
> symptoms, as you seem to be advocating.

Lets see.

We have two places in 2.5.21 where commas are unacceptable:

1. -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))

   We need to do this because to do because KBUILD_BASENAME is used in
   places where commas are not acceptable.

   We papered over the fact that make can't subst commas by using the
   $(comma) construct.

2. -Wp,-MD,.$(subst /,_,$@).d (currently unfixed)

   This would need to become something like:

   -Wp,-MD,.$(subst /,_,$(subst $(comma,_,$@)).d

So now we have two places where the same yucky substing of commas to
something more palettable happens.  Now, what if we had:

	foo,bar.c

and

	foo_bar.c

in the same directory?  The kbuild system goes wrong, destroying dependency
information, using the wrong KBUILD_BASENAME.  Oops.  I guess we papered
over a bug by allowing commas in filenames.

In addition, I'd like to point out the following paragraph in the make
info files:

   The variant variables' names are formed by
   appending `D' or `F', respectively.  These variants are semi-obsolete
   in GNU `make' since the functions `dir' and `notdir' can be used to get
   a similar effect (*note Functions for File Names: File Name
   Functions.).

Both kbuild-2.5 and the existing kernel build make heavy use of the
"$(*F)" notation.  Should we really be putting semi-obsolete features
into either of the kernel build system?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

