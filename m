Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314740AbSEHSTI>; Wed, 8 May 2002 14:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314758AbSEHSTI>; Wed, 8 May 2002 14:19:08 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:29963 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314740AbSEHSTG>; Wed, 8 May 2002 14:19:06 -0400
Message-Id: <5.1.0.14.2.20020508184421.040cdd70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 May 2002 19:17:33 +0100
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Fwd: NLS mappings for iso-8859-* encodings
Cc: Urban Widmark <urban@teststation.com>, linux-kernel@vger.kernel.org
In-Reply-To: <48A1C5128EB@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:07 08/05/02, Petr Vandrovec wrote:
>On  8 May 02 at 0:08, Urban Widmark wrote:
> > On Tue, 7 May 2002, Petr Vandrovec wrote:
> > But if you have checked that you are not mapping two values to the same
> > thing (which would break the back-and-forth translation that smbfs does) I
> > don't see how that patch can harm anything.
>
>Yes, I checked it. After changing iso* all singlebyte encodings except
>cp874 contain unique mapping for all byte values (cp874 is unique, but
>some values are unmappable).

Wrong. The NLS tables do not guarantee unique mapping. So all fs which do 
"back-and-forth" translation are broken, the only encoding which really 
works is UTF-8.

We found out the hard way in ntfs. An example: take CP936 (GB2312).

Take a Unicode character between 0x4e00 and 0x9fa5, i.e. the CJK Ideograph 
range (yes we found examples using these characters on various (chinese?) 
websites).

Convert to gb2312 using NLS and then back to Unicode and you end up with a 
Unicode character in the range 0xF900-0xFA2D, i.e. the CJK Compatibility 
Ideographs.

Concrete example we ran into with ntfs, Unicode character 0x884C (a CJK 
Ideograph). Translates to gb2312 character sequence 0xD0, 0xD0, and then 
back to Unicode character 0xFA08 (a CJK Compatibility Ideograph).

I double checked the translation manually and I also checked the original 
translation tables on the microsoft website and this is indeed what 
happens. If you looks at the translation table there are several Unicode 
characters mapping to the gb2312 character sequence 0xD0, 0xD0, but 
obviously this only maps back to a single Unicode character.

Also if you lookup the Unicode character database 2.1 (I checked rev 2.1.8) 
from the Unicode Consortium it specifies this as correct:

[snip]
4E00;<CJK Ideograph, First>;Lo;0;L;;;;;N;;;;;
9FA5;<CJK Ideograph, Last>;Lo;0;L;;;;;N;;;;;
[snip]
FA08;CJK COMPATIBILITY IDEOGRAPH-FA08;Lo;0;L;884C;;;;N;;;;;
[snip]

This means that Unicode itself is not a one-to-one mapping. Apparently 
multiple characters have the same meanings... )))-:

I never imagined I would find something so braindamaged in Unicode but 
there you go!

Basically this means, at least for NTFS, but I think it is the same for all 
file systems, that on directory lookups, either we have to search the 
directory by just looking at EVERY directory entry and converting each to 
the current NLS and comparing for identity to the name being searched for 
or we have to use UTF-8 as that guarantees to preserve back-and-forth 
mappings one-to-one (I believe).

Doing a directory lookup where the whole directory is scanned linearly is 
incredibly slow and the overhead of having to convert every single 
directory entry to compare it every time a lookup() happens is very large, 
so I don't want to implement that on NTFS, so if anyone complains to me 
about their character translation not working properly they will just hear 
use UTF-8 and it will work.

But you will have to find UTF-8 fonts and user space support code in order 
to see the correct output displayed. Otherwise you just see random 
characters in your filenames... But at least It Works(TM).

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

