Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbREXVSU>; Thu, 24 May 2001 17:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbREXVSE>; Thu, 24 May 2001 17:18:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54170 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262320AbREXVRn>;
	Thu, 24 May 2001 17:17:43 -0400
Date: Thu, 24 May 2001 17:17:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0105241710560.24073-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Dawson Engler wrote:

> [BUG] [BAD] Returns a freed pointer -- very very bad.

... and easy to fix.
> /u2/engler/mc/oses/linux/2.4.4/fs/proc/generic.c:438:proc_symlink: ERROR:FREE:430:438: WARN: Use-after-free of "ent"! set by 'kfree':430
> 	ent->namelen = len;
> 	ent->nlink = 1;
> 	ent->mode = S_IFLNK|S_IRUGO|S_IWUGO|S_IXUGO;
> 	ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
> 	if (!ent->data) {
> Start --->
> 		kfree(ent);
> 		goto out;
> 	}
> 	strcpy((char*)ent->data,dest);
> 
> 	proc_register(parent, ent);
> 	
> out:
> Error --->
> 	return ent;


--- linux/fs/proc/generic.c.old	Fri Feb 16 21:01:43 2001
+++ linux/fs/proc/generic.c	Thu May 24 17:13:22 2001
@@ -428,6 +428,7 @@
 	ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
 	if (!ent->data) {
 		kfree(ent);
+		ent = NULL;
 		goto out;
 	}
 	strcpy((char*)ent->data,dest);

Linus, apply it, please.

