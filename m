Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTD0COS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 22:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTD0COS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 22:14:18 -0400
Received: from smtp-out.comcast.net ([24.153.64.110]:26811 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263285AbTD0CNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 22:13:35 -0400
Date: Sat, 26 Apr 2003 22:24:04 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Re:  Swap Compression
In-reply-to: <20030426160920.GC21015@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304262224040410.031419FD@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what's the best way to do this?  I was originally thinking like this:

Grab some swap data
Stuff it into fcomp_push()
When you have 100k of data, seal it up
Write that 100k block

But does swap compress in 64k blocks?  80x86 has 64k segments.
The calculation for compression performance loss, 256/size_of_input,
gives a loss of 0.003906 (0.3906%) for a dataset 65536 bytes long.
So would it be better to just compress segments, whatever size they
may be, and index those?  This would, of course, be much more efficient
in terms of finding the data to uncompress.  (And system dependant)

The algo is flexible; it doesn't care about the size of the input.  If you
pass full segments at once, you could gain a little more speed.  Best
part, if you rewrite my decompression code to do the forward calculations
for straight data copy (I'll likely do this before the night is up myself),
you will evade a lot of realloc()'s in the data copy between pointers.  This
could also optimize out the decriments of the distance-to-next-pointer
counter, and total this all together gives a lot of speed increase over my
original code.  Since this is a logic change, the compiler can't do this
optimization for you.

Another thing, I did state the additional overhead (which now is going to be
64K + code + 256 byte analysis section + 64k uncompressed data)
before, but you can pull in less than the full block, decompress it, put it
where it goes, and pull in more.  So on REALLY small systems, you
can still do pagefile buffering and not blow out RAM with the extra 128k
you may need.  (heck, all the work could be done in one 64k segment if
you're that determined.  Then you could compress the swap on little 6 MB
boxen).

--Bluefox Icy

