Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135738AbREDB7h>; Thu, 3 May 2001 21:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135774AbREDB71>; Thu, 3 May 2001 21:59:27 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:15298 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S135738AbREDB7J>; Thu, 3 May 2001 21:59:09 -0400
Message-Id: <m14vTua-001QLyC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: l.s.r@web.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strtok -> strsep (The Easy Cases) 
In-Reply-To: Your message of "Tue, 01 May 2001 20:58:06 +0200."
             <01050120580701.01713@golmepha> 
Date: Fri, 04 May 2001 10:57:36 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <01050120580701.01713@golmepha> you write:
> Hello,
> 
> the patch at the bottom does the bulk job of strtok replacement. It's a
> very boring patch, containing easy cases, only. It became a bit big, too,
> but I trust you can digest it nevertheless. It's made against kernel
> version 2.4.4.

There are two cases where the substitution is problematic:

Array:
	char tmparray[500];
	strcpy(tmparray, str);

	/* for (p = strtok(tmparray, "n"); p; p = strtok(NULL, "n")) { */
	while ((p = strsep(&tmparray, ","))) {

This is clearly wrong, and invokes a compiler warning.  &tmparray ==
tmparray (a cute C oddity I've never really liked).  You are blowing
away the first few characters in tmparray, and your parser won't work
properly.

Dynamic:

	char *tmp = strdup(str);

	/* for (p = strtok(tmp, "n"); p; p = strtok(NULL, "n")) { */
	while ((p = strsep(&tmp, ","))) {
	...
	}

	kfree(tmp);

Here, tmp has changed in the strsep implementation, and kfree will do
bad things.

There is a real reason to avoid strtok, and that is SMP and multple
threads calling it at once (that said, I don't know of a problem yet).
But this patch is a step backwards.

Rusty.
--
Premature optmztion is rt of all evl. --DK
