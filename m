Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIV60>; Tue, 9 Jan 2001 16:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAIV6P>; Tue, 9 Jan 2001 16:58:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54223 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129431AbRAIV56>;
	Tue, 9 Jan 2001 16:57:58 -0500
Date: Tue, 9 Jan 2001 16:57:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mathieu Chouquet-Stringer <mchouque@e-steel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Floppy disk strange behavior
In-Reply-To: <E14G6S5-0007UK-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0101091642260.9953-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Alan Cox wrote:

> > dd bug. It tries to ftruncate() the output file and gets all upset when
> > kernel refuses to truncate a block device (surprise, surprise).
> 
> Standards compliant but unexpected. 

dd is supposed to be portable. On Solaris:
% man ftruncate
[snip]
      EINVAL    The fildes argument  does  not  correspond  to  an
               ordinary file.
 
> Actually its explicitly mentioned by the spec that truncate _may_ extend
> a file but need not do so. 

However, it also explicitly mentions that truncate can fail for non-regular
file.

> > Try to build GNU dd on other Unices and you will be able to trigger that
> > bug on quite a few of them.
> 
> I think not

Solaris, for one thing. OK, let's ask folks to test it on different systems
and see what it gives.

> > ftruncate(2) is _not_ supposed to succeed on anything other than regular
> > files. I.e. dd(1) should not call it and expect success if file is not
> > regular. Plain and simple...
> 
> 2.2 is least suprise 2.4 is most information, but misleading errno IMHO

Agreed. It should be -EINVAL, not -EPERM.

IMO there are two issues:
	* dd(1) portability bug. Obviously there - ftruncate(2) is allowed
to fail on non-regular ones. Fix is trivial and it (or something equivalent)
should go into the fileutils.
	* What should 2.4 do here? I would prefer -EINVAL - it is true
(requested action is invalid for the arguments we got), it is consistent
with other systems and it doesn't hide the failure. Data that used to
be in the file we were trying to truncate is still there. -EPERM is
arguably wrong here - it's not like the problem was in the lack of
permissions.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
