Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275005AbTHLD6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 23:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275003AbTHLD6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 23:58:08 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:63749
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S275005AbTHLD6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 23:58:05 -0400
Date: Mon, 11 Aug 2003 22:58:03 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030812035803.GA17921@furrr.two14.net>
Reply-To: maney@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay, further testing is clearly indicated (and I'm recompiling a test
kernel while writing this to try to narrow it down a little), but I've
got a very repeatable file corruption under 2.4.22-rc2 that does not
manifest under 2.4.21.  My repeatable test case only (so far?) causes
the data in the file to be corrupted, but I suspect metadata can get
hit as well, and I have seen some filesystem errors that were probably
caused by this, but not so that I can say so with certainty.

The recipie is simple: cp a large file across filesystems.  All looks
well (md5sums match, etc), but the file is all still present in memory. 
But if you then unmount the destination filesystem to invalidate the
buffers, after mounting the file data will have changed.  I'm pretty
certain that I have observed the same effect without the mass
invalidation of umount in a couple of cases, but I haven't replicated
that.

In all cases I have investigated, the corruption seems to take the form
of four bytes of garbage at the beginning of a block; two small scripts
have been observed with 4 NULLs prepended and the last four characters
truncated.  In another case I found a block of over 100 bytes (I got
tired of wading through it after a while) in the same form - four bytes
were inserted into the corrupted file, pushing the data back.  In
hindsight I wish I had investigated that case further; as it is, I'm
not positive the dislocation was at a disk block boundary.

(I have one example I saved that appears NOT to begin at a block
boundary, with a dislocation that continues for at least 8KB (by spot
checking of cmp --verbose output).)

The machine is a PIII/850 on an Asus 440BX board with a Promise 20265
controller; the Seagate ST340016A is the only device connected to the
Promise's ports.  There's 640MB of ECC'd memory on board, and I haven't
had an SBE reported on this system in a year or so (the last hardware
changes was two or three months ago).  (I disabled the ECC monitoring
module while verifying this problem; made no difference.)

The "large file" I've been using (becuase it was where I first observed
an issue) was the XFree86 4.2.1 source archive.  At 54MB, it is less
than 1/10th the size of physical RAM.

-- 
There is nothing perhaps so generally consoling to a man as a
well-established grievance; a feeling of having been injured,
on which his mind can brood from hour to hour, allowing him
to plead his own cause in his own court, within his own heart,
and always to plead it successfully.  -- Anthony Trollope

