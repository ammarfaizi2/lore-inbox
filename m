Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317168AbSFKQim>; Tue, 11 Jun 2002 12:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFKQil>; Tue, 11 Jun 2002 12:38:41 -0400
Received: from dsl-213-023-038-217.arcor-ip.net ([213.23.38.217]:56449 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317168AbSFKQik>;
	Tue, 11 Jun 2002 12:38:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Date: Tue, 11 Jun 2002 18:36:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020609175804.B8761@flint.arm.linux.org.uk> <E17HoBz-0000A0-00@starship> <20020611173147.C3665@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17HodQ-0000AV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 18:31, Russell King wrote:
> On Tue, Jun 11, 2002 at 06:08:22PM +0200, Daniel Phillips wrote:
> > Are you sure that complexity was added just to handle commas in names?
> > Or is it really an example of how good design never gave this bug a
> > chance to exist in the first palce.
> > 
> > I *really* don't like the idea of papering over such bugs by curing the
> > symptoms, as you seem to be advocating.
> 
> Lets see.
> 
> We have two places in 2.5.21 where commas are unacceptable:
> 
> 1. -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
> 
>    We need to do this because to do because KBUILD_BASENAME is used in
>    places where commas are not acceptable.
> 
>    We papered over the fact that make can't subst commas by using the
>    $(comma) construct.
> 
> 2. -Wp,-MD,.$(subst /,_,$@).d (currently unfixed)
> 
>    This would need to become something like:
> 
>    -Wp,-MD,.$(subst /,_,$(subst $(comma,_,$@)).d
> 
> So now we have two places where the same yucky substing of commas to
> something more palettable happens.  Now, what if we had:
> 
> 	foo,bar.c
> 
> and
> 
> 	foo_bar.c
> 
> in the same directory?  The kbuild system goes wrong, destroying dependency
> information, using the wrong KBUILD_BASENAME.  Oops.  I guess we papered
> over a bug by allowing commas in filenames.

Yup.

> In addition, I'd like to point out the following paragraph in the make
> info files:
> 
>    The variant variables' names are formed by
>    appending `D' or `F', respectively.  These variants are semi-obsolete
>    in GNU `make' since the functions `dir' and `notdir' can be used to get
>    a similar effect (*note Functions for File Names: File Name
>    Functions.).
> 
> Both kbuild-2.5 and the existing kernel build make heavy use of the
> "$(*F)" notation.  Should we really be putting semi-obsolete features
> into either of the kernel build system?

No, agreed.  Now this is sensible.

-- 
Daniel
