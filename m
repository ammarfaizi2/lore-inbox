Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSF0TyQ>; Thu, 27 Jun 2002 15:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSF0TyP>; Thu, 27 Jun 2002 15:54:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53257 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293680AbSF0TyN>; Thu, 27 Jun 2002 15:54:13 -0400
Date: Thu, 27 Jun 2002 16:01:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shm_destroy lock hang
In-Reply-To: <Pine.LNX.4.21.0206272007480.2791-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206271558330.11719-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just please avoid doing that locking nastyness:

function() {
unlock();
}


lock();
if (something)
	function();
else
	unlock();


For this case its OK, but please avoid that.

On Thu, 27 Jun 2002, Hugh Dickins wrote:

> Martin reported "Bug with shared memory" to LKML 14 May: hang due to
> schedule in truncate_list_pages called from .... shm_destroy holding
> the shm_lock spinlock.  shm_destroy needs that lock for shm_rmid, but
> it can be safely unlocked once link from id to shp has been removed.
> Patch against 2.4.19-rc1 or -pre10-ac2, applies at offset to 2.5.24.
>
> --- 2.4.19-rc1/ipc/shm.c	Mon Jun 24 19:14:58 2002
> +++ linux/ipc/shm.c	Thu Jun 27 19:34:51 2002
> @@ -117,12 +117,14 @@
>   *
>   * @shp: struct to free
>   *
> - * It has to be called with shp and shm_ids.sem locked
> + * It has to be called with shp and shm_ids.sem locked,
> + * but returns with shp unlocked and freed.
>   */
>  static void shm_destroy (struct shmid_kernel *shp)
>  {
>  	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	shm_rmid (shp->id);
> +	shm_unlock(shp->id);
>  	shmem_lock(shp->shm_file, 0);
>  	fput (shp->shm_file);
>  	kfree (shp);
> @@ -150,8 +152,8 @@
>  	if(shp->shm_nattch == 0 &&
>  	   shp->shm_flags & SHM_DEST)
>  		shm_destroy (shp);
> -
> -	shm_unlock(id);
> +	else
> +		shm_unlock(id);
>  	up (&shm_ids.sem);
>  }
>
> @@ -511,11 +513,9 @@
>  			shp->shm_flags |= SHM_DEST;
>  			/* Do not find it any more */
>  			shp->shm_perm.key = IPC_PRIVATE;
> +			shm_unlock(shmid);
>  		} else
>  			shm_destroy (shp);
> -
> -		/* Unlock */
> -		shm_unlock(shmid);
>  		up(&shm_ids.sem);
>  		return err;
>  	}
> @@ -653,7 +653,8 @@
>  	if(shp->shm_nattch == 0 &&
>  	   shp->shm_flags & SHM_DEST)
>  		shm_destroy (shp);
> -	shm_unlock(shmid);
> +	else
> +		shm_unlock(shmid);
>  	up (&shm_ids.sem);
>
>  	*raddr = (unsigned long) user_addr;
>

