Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbRFHJCi>; Fri, 8 Jun 2001 05:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263935AbRFHJC2>; Fri, 8 Jun 2001 05:02:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31200 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263933AbRFHJCQ>;
	Fri, 8 Jun 2001 05:02:16 -0400
Date: Fri, 8 Jun 2001 11:02:11 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106080902.LAA228227.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, COTTE@de.ibm.com, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Subject: [PATCH] Re: BUG: race-cond with partition-check
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From COTTE@de.ibm.com Fri Jun  8 09:57:01 2001

    >Well, among the irrelevant details you left out is the fact that
    >it is not
    >    blk_size[dev->major] =3D NULL;
    >but
    >    if(!dev->sizes)
    >         blk_size[dev->major] =3D NULL;

    Well, this is absoloutely right, the behaviour to clear blk_size
    when dev->sizes
    is NULL looks sensible to me. But seven lines below it says
    -unconditionaly-:
         blk_size[dev->major] =3D NULL;

Ah, yes. This second assignment can just be deleted, I suppose.

--- partitions/check.c~	Thu May 31 22:26:56 2001
+++ partitions/check.c	Fri Jun  8 10:44:02 2001
@@ -418,11 +418,10 @@
 		blk_size[dev->major] = NULL;
 
 	dev->part[first_minor].nr_sects = size;
-	/* No Such Agen^Wdevice or no minors to use for partitions */
+	/* No such device or no minors to use for partitions */
 	if (!size || minors == 1)
 		return;
 
-	blk_size[dev->major] = NULL;
 	check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);
 
  	/*

[In the good old days it wasn't there. It was added in 1.3.19,
don't know why, probably as a safeguard to make sure nobody
used these values while they are being set up. But someone
was bit by the assignment, since it is not undone if we take
the return, so in 2.3.48 the assignment was moved past the
return, with a conditional assignment before it. I believe
you are right, and we only want the conditional assignment.]

Andries
