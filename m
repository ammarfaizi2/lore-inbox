Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUDNQOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbUDNQOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:14:18 -0400
Received: from [80.72.36.106] ([80.72.36.106]:26528 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264279AbUDNQOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:14:08 -0400
Date: Wed, 14 Apr 2004 18:14:03 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Cc: Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org,
       Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
In-Reply-To: <200404141707.03743.Guillaume@Lacote.name>
Message-ID: <Pine.LNX.4.58.0404141733440.16891@alpha.polcom.net>
References: <200404131744.40098.Guillaume@Lacote.name>
 <200404141602.43695.Guillaume@Lacote.name> <Pine.LNX.4.58.0404141612250.16891@alpha.polcom.net>
 <200404141707.03743.Guillaume@Lacote.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Guillaume [iso-8859-1] Lacôte wrote:

> However there is one big drawback: you benefit 
> from encryption only when using the file-system for which you have such a 
> plugin (for example, you can _not_ do a RAID5 array over encrypted disks).

Why do you need this? Why encrypting fs is not enough?


> Let me explain : I believe (but I am no cryptographer) that it is a very 
> unwise idea to encrypt both data and meta-data at the same time. I prefer 
> extracting all meta-data, possibly encrypting them somewhere, and encrypt 
> data independently. This is basically because you can easily gain information 
> on meta-data (but not so easily on data themselves). This is the reason why 
> encrypting at the file-system level (where you encipher the content of files) 
> is better than at the device level (where you also encrypt meta-data; this is 
> however what I plan to do).

It depends on the data and on the metadata. Of course we can use 
compression and hashing (already discussed on this list in dm-crypt 
thread) to make data more protected. But, at fs level, we can encrypt 
metadata with different key (for metadata or part of metadata only) and 
this way keep it still near the data (this helps performance by reducing 
expensive disk seeks) but encrypted "differently".


> To follow your example, I would even prefer the offsets of the 2 or 3 files be 
> public rather than having them encrypted and let the attacker know that the 
> first 8 bytes of my sector encodes for offsets for 2 files, each of which 
> being less than 4096 (thus having many 0 bits inside it) : this might 
> tremendously help him reduce his search space.

But why do you want to make attacker life easier? With fs level encryption 
we can hide the offsets in secure way, encrypt both data and metadata (but 
differently).


> However I believe this raises two issues:
> 1) you may want to also encipher the meta-data itself. A basic way to do this 
> would be to additionnaly use dm-crypt.

But it will not help performance.


> 2) you can only profit from encryption with the file-system it has been 
> implemented for.
> 
> I personally have no political stance on wether developping a Reiser4-only 
> compression+encryption plugin would be unwise. I just loosily believe that it 
> is always better to support several FSes. Unless, of course, if this is 
> doomed to failed, which is the question I would like to answer before working 
> further on it.

Well, changing some parts of VFS and maybe MM we can make encryption and 
compression easier to implement for various fs developers. Maybe we can 
add some generic "messing with the data and metadata" (compressing, 
encrypting, etc.) hooks to VFS?

I think that generic solution is best, but compression on block level is 
very hard to implement. Remember you must keep block size the same 
(because majority of fs will work only with 512, 1024, ... block sizes) 
while still keeping your additional compression data near the compressed data 
(for disk seek performance reasons). And you will not gain any size 
effects from this type of compression (building not constant block size 
device is horrible, and you must probably change significant amount of 
kernel to do that; think about fragmentation also). And compression is cpu 
consumming process (I think you cannot implement Huffman in O(n) time, 
probably someting like O(nlogn) with not very small constant is required). 
And if you want just make your data harder to decrypt or to analyse its 
encrypted form you can use some O(n) simple algorithms designed for this 
purpose (some were discussed on this list in dm-crypt thread).

But feel free to try :-)


Grzegorz Kulewski

