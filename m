Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSHAWmH>; Thu, 1 Aug 2002 18:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSHAWmH>; Thu, 1 Aug 2002 18:42:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49912 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317169AbSHAWmF>;
	Thu, 1 Aug 2002 18:42:05 -0400
Date: Thu, 1 Aug 2002 18:45:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Dalecki <dalecki@cs.net.pl>, linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
In-Reply-To: <200208012219.g71MJV109133@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0208011840130.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Linus Torvalds wrote:

> You probably saw this. Looks like blocksize has been buggered somehow.
> Apparently Petr has a 1kB blocksize optical device..

Yeah - with partition boundaries set not on a physical sector boundary ;-/

He's actually lucky that beginning of partition was not in the middle of
a physical sector...

Looks like we need
	a) accurate hardsect_size for these beasts (which is a problem
with current setup, since it's per-queue and not per-device; master and
slave can have different hardsect sizes).
	b) extra check in check_partitions() that would verify that
partition doesn't end in the middle of a sector (and round it down
if it does).

Basically, old code worked by accident on that setup - Petr had half-Kb
in the end of partition unaccessible and do_open() didn't notice that.
Now it does and tries to give such access.  Disk is not happy...

