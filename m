Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUDNOkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUDNOkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:40:07 -0400
Received: from [80.72.36.106] ([80.72.36.106]:56223 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261380AbUDNOjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:39:49 -0400
Date: Wed, 14 Apr 2004 16:39:42 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Cc: Paulo Marques <pmarques@grupopie.com>,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
In-Reply-To: <200404141602.43695.Guillaume@Lacote.name>
Message-ID: <Pine.LNX.4.58.0404141612250.16891@alpha.polcom.net>
References: <200404131744.40098.Guillaume@Lacote.name>
 <200404141202.07021.Guillaume@Lacote.name> <407D3231.2080605@grupopie.com>
 <200404141602.43695.Guillaume@Lacote.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that not only compression should be moved to fs layer but 
possibly encryption also.

How?
In Reiser4 there are plugins.
In other fses (as far as I remember e2compr and maybe other posts on 
this list) there is only one bigger problem with compression and only if 
we want to support mmap (I do not remember more details about the problem) 
and the problem is somewhere between current mm and vfs implementation. I 
think that (probably) Linus said once that this problem can be solved by 
changing these implementations. The same probably goes for encryption.
In order to protect guessing the key from decrypting possibly-well-known 
values in superblock and other metadata (cuch as fs size and signature) we 
could probably place random numbers before them and xor each 4 bytes with 
last 4 bytes before encryption (or use any other hash function).

Why?
Because in dm approach you are encrypting entire blocks at once and in fs 
approach you are encrypting only needed parts. This can even bring more 
security because if fs is merging small files into one block and if it is 
patched to move begining of not full block data into random position in 
that block attacker must crack all fs and its metadata structures to know 
where your data actually is and what key is used to encrypt them (we can 
have several different keys for different parts of fs to make things 
harder). So we can have situation that in one block there is 2 or 3 or 
maybe more files (or parts) encrypted using different keys and hashes and 
that these files reside at different offsets in that block. I think that 
this is easier to implement and protects better.

What do you think?


Grzegorz Kulewski

