Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUGWTKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUGWTKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 15:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267909AbUGWTKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 15:10:00 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:57098 "EHLO
	anchor-post-37.mail.demon.net") by vger.kernel.org with ESMTP
	id S267899AbUGWTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 15:09:40 -0400
Message-ID: <410156ED.40102@lougher.demon.co.uk>
Date: Fri, 23 Jul 2004 19:20:29 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: pmarques@grupopie.com
Subject: Re: Compression filter for Loopback device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-23 Paulo Marques wrote:
 >
 >I did start working on something like that a while ago. I even
 >registered for a project on sourceforge:
 >
 >http://sourceforge.net/projects/zloop/
 >
 >    - The block device doesn't understand anything about files. This is
 >an advantage because it will compress the filesystem metadata
 >transparently, but it is bad because it compresses "unused" blocks of
 >data. This could probably be avoided with a patch I saw floating around
 >a while ago that zero'ed delete ext2 files. Zero'ed blocks didn't accupy
 >any space at all in my compressed scheme, only metadata (only 2 bytes
 >per block).
 >

The fact the block device doesn't understand anything about the 
filesystem is a *major* disadvantage.  Cloop has a I/O and seeking 
performance hit because it doesn't understand the filesystem, and this 
will be far worse for write compression.  Every time a block update is 
seen by your block layer you'll have to recompress the block, it is 
going to be difficult to cache the block because you're below the block 
cache (any writes you see shouldn't be cached).  If you use a larger 
compressed block size than the block size, you'll also have to 
decompress each compressed block to obtain the missing data to 
recompress.  Obviously Linux I/O scheduling has a large part to play, 
and you better hope to see bursts of writes to consecutive disk blocks.

 >I did a proof of concept using a nbd server. This way I could test
 >everything in user space.
 >
 >With this NBD server I tested the compression ratios that my scheme
 >could achieve, and they were much better than those achieved by cramfs,
 >and close to tar.gz ratios. This I wasn't expecting, but it was a nice
 >surprise :)

I'm very surprised you got ratios better than CramFS, which were close 
to tar.gz.  Cramfs is actually quite efficient in it's use of metadata, 
what lets cramfs down is that it compresses in units of the page size or 
4K blocks.  Cloop/Squashfs/tar.gz use much larger blocks which obtain 
much better compression ratios.

What size blocks did you do your compression and/or what compression 
algorithm did you use?  There is a dramatic performance trade-off here. 
If you used larger than 4K blocks every time your compressing block 
device is presented with a (probably 4K) block update, you need to 
decompress your larger compression block, very slow.  If you used 4K 
blocks then I cannot see how you obtained better compression than cramfs.

Phillip

