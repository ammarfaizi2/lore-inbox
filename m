Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTFTSp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTFTSp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:45:28 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:51899 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264340AbTFTSp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:45:26 -0400
Date: Fri, 20 Jun 2003 20:59:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: [RFC] Breaking data compatibility with userspace bzlib
Message-ID: <20030620185915.GD28711@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm almost finished with adding bzlib support to the kernel.  You
could also say, I'm already 150% finished, as there is only cleanup
left to do.  Since bzlib is new to the kernel, I don't see a point in
keeping the uglies in the userspace interface for the kernel as well
and have already killed most of them.

However, one of the uglies, blockSize100k, is also part of the data
format as well, being one field in the header.  So now I have to
decide whether to kill this wart or to keep it for compatibility.

The whole interface of the bzlib was modelled after the zlib
interface.  blockSize100k is supposed to imitate the zlib compression
levels, the valid range is from 1 to 9 as well.  The semantic is that
a block of 100k * blockSize100k is compressed at a time.

Now, the cost of the underlying BWT is O(n) in memory and O(n*ln(n))
in time.  That given, I consider it odd to use a linear semantic of
blockSizeXXXX and would prefer an exponential one, as the zlib uses
here and there.  Thus blockSizeBits would now give the blockSize as
1 << blockSizeBits, allowing to go well below 100k, resulting in lower
memory consumption for some and well above 900k, giving better
compression ratios.


Long intro, short question: Jay O Nay?


The change would make bzlib much more useful for jffs2, assuming it is
useful for jffs2 at all.  But if any kernel bzlib users have to
interface with a userspace bzlib, things will break.  That might be a
good reason to postpone the change for a while and rename the whole
thing when it gets done,,,, so my personal tendency is Nay.

Jörn

PS: Kept the surplus commata as a personal reminder that 2.5.72 still
has problems with my keyboard.  Should check Andrews Must-Fix List and
add this one it not yet present.

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
