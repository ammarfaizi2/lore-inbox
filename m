Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUH1QJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUH1QJX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUH1QIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:08:24 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:52464 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267363AbUH1QFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:05:38 -0400
In-Reply-To: <20040828151544.GB12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151544.GB12772@fs.tum.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Date: Sat, 28 Aug 2004 12:05:10 -0400
To: Adrian Bunk <bunk@fs.tum.de>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28, 2004, at 11:15, Adrian Bunk wrote:
> The patch below does BUG -> BUG_ON conversions in ipc/ .
> --- linux-2.6.9-rc1-mm1-full-3.4/ipc/shm.c.old	2004-08-28 
> 15:55:28.000000000 +0200
> +++ linux-2.6.9-rc1-mm1-full-3.4/ipc/shm.c	2004-08-28 
> 16:02:56.000000000 +0200
> @@ -86,8 +86,7 @@
>  static inline void shm_inc (int id) {
>  	struct shmid_kernel *shp;
>
> -	if(!(shp = shm_lock(id)))
> -		BUG();
> +	BUG_ON(!(shp = shm_lock(id)));

This won't work:

With debugging mode:
if (unlikely(!(shp = shm_lock(id)))) BUG();

Without debugging mode:
do { } while(0)

Anything you put in BUG_ON() must *NOT* have side effects.


>  	shp->shm_atim = get_seconds();
>  	shp->shm_lprid = current->tgid;
>  	shp->shm_nattch++;
> @@ -137,8 +136,7 @@
>
>  	down (&shm_ids.sem);
>  	/* remove from the list of attaches of the shm segment */
> -	if(!(shp = shm_lock(id)))
> -		BUG();
> +	BUG_ON(!(shp = shm_lock(id)));

Same here

>  	shp->shm_lprid = current->tgid;
>  	shp->shm_dtim = get_seconds();
>  	shp->shm_nattch--;
> @@ -744,8 +741,7 @@
>  	up_write(&current->mm->mmap_sem);
>
>  	down (&shm_ids.sem);
> -	if(!(shp = shm_lock(shmid)))
> -		BUG();
> +	BUG_ON(!(shp = shm_lock(shmid)));

And here

>  	shp->shm_nattch--;
>  	if(shp->shm_nattch == 0 &&
>  	   shp->shm_flags & SHM_DEST)

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


