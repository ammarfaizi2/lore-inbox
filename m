Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317262AbSFGJ7T>; Fri, 7 Jun 2002 05:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFGJ7S>; Fri, 7 Jun 2002 05:59:18 -0400
Received: from hermes4.atos-group.com ([160.92.18.11]:43527 "EHLO
	hermes4.atos-group.com") by vger.kernel.org with ESMTP
	id <S317262AbSFGJ7O>; Fri, 7 Jun 2002 05:59:14 -0400
Message-Id: <20020607095914Z317262-22021+89@vger.kernel.org>
From: <linux-kernel-owner@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Date: Fri, 7 Jun 2002 05:59:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

&	id <M3AL96JH>; Fri, 7 Jun 2002 08:38:00 +0200
Received: from mx3.postwall.mm.fr.atosorigin.com (mx003.axime.com [160.92.18.153]) by hermes8.segin.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id MM6SML5B; Thu, 6 Jun 2002 18:46:19 +0200
Received: from vger.kernel.org (vger.kernel.org [209.116.70.75])
	by mx3.postwall.mm.fr.atosorigin.com (Postfix) with ESMTP id 779F3180B5
	for <ryan.sweet@atosorigin.com>; Thu,  6 Jun 2002 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSFFQqm>; Thu, 6 Jun 2002 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317010AbSFFQql>; Thu, 6 Jun 2002 12:46:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2314 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316996AbSFFQql>; Thu, 6 Jun 2002 12:46:41 -0400
Received: (from root@localhost)
	by neon-gw.transmeta.com (8.9.3/8.9.3) id JAA17531
	for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2002 09:46:39 -0700
Received: from mailhost.transmeta.com(10.1.1.15) by neon-gw.transmeta.com via smap (V2.1)
	id xma017519; Thu, 6 Jun 02 09:46:28 -0700
Received: from palladium.transmeta.com (palladium.transmeta.com [10.1.1.46])
	by deepthought.transmeta.com (8.11.6/8.11.6) with ESMTP id g56GkUj06428
	for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2002 09:46:30 -0700 (PDT)
Received: (from mail@localhost)
	by palladium.transmeta.com (8.9.3/8.9.3) id JAA22361
	for linux-kernel@vger.kernel.org; Thu, 6 Jun 2002 09:46:30 -0700
X-Authentication-Warning: palladium.transmeta.com: mail set sender to news@transmeta.com using -f
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: device model update 2/2
Date:	Thu, 6 Jun 2002 16:45:25 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ado3j5$304$1@penguin.transmeta.com>
In-Reply-To: <A183DF60AC72D5119B990002A5749CB301E9C106@ROMADG-MAIL01> <Pine.LNX.4.33.0206060808050.654-100000@geena.pdx.osdl.net>
X-Trace: palladium.transmeta.com 1023381990 22356 127.0.0.1 (6 Jun 2002 16:46:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Jun 2002 16:46:30 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
