Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSFPVer>; Sun, 16 Jun 2002 17:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSFPVer>; Sun, 16 Jun 2002 17:34:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48616 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316589AbSFPVeq>;
	Sun, 16 Jun 2002 17:34:46 -0400
Date: Sun, 16 Jun 2002 17:34:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206162041.g5GKfhn13251.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206161733000.5807-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

> > If you want to try - by all means, go ahead,
> > I'll be glad to see the current situation improved.
> 
> OK, let me attempt something in the style as sketched earlier today.
> There are two stages: Step One is changing follow_link in all
> filesystems to not call vfs_follow_link but to return immediately
> so that the caller can call vfs_follow_link and release resources.
> 
> Somewhat boring work. The patch is below.
> I do not doubt that you'll find all typos, so I did not try
> to compile and test.
> 
> Yes, so the question was how to communicate between filesystem
> and namei.c about what resources have to be freed.
> I considered (i) calling the filesystem with a preallocated page,
> (ii) requiring a page, (iii) requiring page or kmalloc,
> (iv) letting the filesystem supply a callback.
> 
> Since I am lazy and (iii) was easiest, I did (iii).
> That is also reasonable: in almost all cases it really is a page,
> and a flag can signal otherwise.
> 
> The communication between filesystems and namei.c uses
> char **link and page **page and two bits in nd->flags.
> The filesystem gets char **link and page **page.
> Its job is to fill *link with the string, but in case
> it did the complete follow_link itself (as happens under /proc)
> it sets the DONE flag.
> Now namei.c will release page when it is nonzero, and will free
> link when the filesystem tells that that is needed in the KFREE flag.
> 
> What is wrong? You will tell me, but what I disliked while doing
> this was the name prepare_follow_link. Too long. A second time
> I might pick get_link or so.
> 
> The result of Step One is that the loop no longer touches all
> filesystems but lives entirely in namei.c. So, the second patch,
> that only changes namei.c can change the recursion into iteration.
> Maybe tomorrow or the day after.

Obvious breakage: nd->flags can be clobbered by __vfs_follow_link(), so
your do_follow_link() and friends are broken.

