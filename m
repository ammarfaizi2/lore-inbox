Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSFFQqm>; Thu, 6 Jun 2002 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317010AbSFFQql>; Thu, 6 Jun 2002 12:46:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2314 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316996AbSFFQql>; Thu, 6 Jun 2002 12:46:41 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: device model update 2/2
Date: Thu, 6 Jun 2002 16:45:25 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ado3j5$304$1@penguin.transmeta.com>
In-Reply-To: <A183DF60AC72D5119B990002A5749CB301E9C106@ROMADG-MAIL01> <Pine.LNX.4.33.0206060808050.654-100000@geena.pdx.osdl.net>
X-Trace: palladium.transmeta.com 1023381990 22356 127.0.0.1 (6 Jun 2002 16:46:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Jun 2002 16:46:30 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0206060808050.654-100000@geena.pdx.osdl.net>,
Patrick Mochel  <mochel@osdl.org> wrote:
>-
> 		/* detach from driver */
> 		if (dev->driver->remove)
> 			dev->driver->remove(dev);
> 		put_driver(dev->driver);
>+
>+		lock_device(dev);
>+		dev->driver = NULL;
>+		unlock_device(dev);

Code like the above just basically can _never_ be correct.

The locking just doesn't make any sense like that. 

Real locking looks something like this:

	lock_device(dev);
	driver = dev->driver;
	dev->driver = NULL;
	unlock_device(dev);

	if (driver->remove)
		driver->remove(dev);
	put_driver(driver);

together with some promise that "dev" cannot go away from under us (ie a
refcount on "dev" itself).

		Linus
