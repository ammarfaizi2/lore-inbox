Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUDNPHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUDNPHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:07:13 -0400
Received: from p4.ensae.fr ([195.6.240.202]:59051 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S264246AbUDNPHG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:07:06 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 17:07:03 +0200
User-Agent: KMail/1.5.3
Cc: Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org,
       Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404141602.43695.Guillaume@Lacote.name> <Pine.LNX.4.58.0404141612250.16891@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404141612250.16891@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404141707.03743.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comments.

Le Mercredi 14 Avril 2004 16:39, Grzegorz Kulewski a écrit :
> I think that not only compression should be moved to fs layer but
> possibly encryption also.
This is way easier IMHO, and totally preserves from the burden of meta-data 
versus plain-data encryption. However there is one big drawback: you benefit 
from encryption only when using the file-system for which you have such a 
plugin (for example, you can _not_ do a RAID5 array over encrypted disks).
I believe this is too much of a drawback, put perhaps I am wrong.
>
> How?
> In Reiser4 there are plugins. [...]
> In order to protect guessing the key from decrypting possibly-well-known
> values in superblock and other metadata (cuch as fs size and signature) we
> could probably place random numbers before them and xor each 4 bytes with
> last 4 bytes before encryption (or use any other hash function).
This is the idea I have in mind, but with a little more sophisticated scheme 
(see my reply to Paulo Marques): basically the sole purpose to "compress" is 
to improve the per-bit entropy, and you can mix this with adequately 
inserting random bytes before your data according to your compression 
algorithm.

>
> Why?
> Because in dm approach you are encrypting entire blocks at once and in fs
> approach you are encrypting only needed parts. [...]
> So we can have situation that in one block there is 2 or 3 or 
> maybe more files (or parts) encrypted using different keys and hashes and
> that these files reside at different offsets in that block. I think that
> this is easier to implement and protects better.
Actually I would have used the counter-argument to prove your point ;)
Let me explain : I believe (but I am no cryptographer) that it is a very 
unwise idea to encrypt both data and meta-data at the same time. I prefer 
extracting all meta-data, possibly encrypting them somewhere, and encrypt 
data independently. This is basically because you can easily gain information 
on meta-data (but not so easily on data themselves). This is the reason why 
encrypting at the file-system level (where you encipher the content of files) 
is better than at the device level (where you also encrypt meta-data; this is 
however what I plan to do).

To follow your example, I would even prefer the offsets of the 2 or 3 files be 
public rather than having them encrypted and let the attacker know that the 
first 8 bytes of my sector encodes for offsets for 2 files, each of which 
being less than 4096 (thus having many 0 bits inside it) : this might 
tremendously help him reduce his search space.

But I do agree that encrypting at the file-system level might be a better 
approach. However I believe this raises two issues:
1) you may want to also encipher the meta-data itself. A basic way to do this 
would be to additionnaly use dm-crypt.
2) you can only profit from encryption with the file-system it has been 
implemented for.

I personally have no political stance on wether developping a Reiser4-only 
compression+encryption plugin would be unwise. I just loosily believe that it 
is always better to support several FSes. Unless, of course, if this is 
doomed to failed, which is the question I would like to answer before working 
further on it.

What to you think ?

Guillaume.

