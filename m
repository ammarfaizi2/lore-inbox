Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVBUKr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVBUKr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBUKr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:47:27 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:16221 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261943AbVBUKrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:47:22 -0500
Message-ID: <4219BC1A.1060007@zensonic.dk>
Date: Mon, 21 Feb 2005 11:46:50 +0100
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Help tracking down problem --- endless loop in __find_get_block_slow
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There

I am trying to develop a device mapper plugin which does transparent 
block encryption and sector shuffling in the style freebsd does it (GBDE)

Reads are support and working, but have trouble getting writes to work 
properly.

If I do a simple:

echo "test" > /mnt/test (where /mnt is /dev/mapper/gbde)
sync

it works just fine. If I do

dd if=/dev/zero of=/mnt/testfile count=N, N=1..6 it works fine

But if I do

dd if=/dev/zero of=/mnt/testfile count=N, N>6

I get into an endless loop in __find_get_block_slow. My write path does 
something like this:

recieve original BIO (eg. size=4096). Split BIO into sectorsize chunks.
map chunks to physical sectors.
encrypt sectors
generate keys
write sectors
update keysectors
... when all sectors are written call bio_endio on the original request.

To awoid allocating alot of pages during writes, I use the mem from the 
original request to do encryption "inplace". Could that be the cause of 
my problems? I would clearly like to minimize the need for page 
allocation in my dm-module, so I hope it isn't.

Whats going on here? Every comments appriciated!

Regards Thomas
