Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbRGMJ2u>; Fri, 13 Jul 2001 05:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266992AbRGMJ2k>; Fri, 13 Jul 2001 05:28:40 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:40648 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266991AbRGMJ2a>; Fri, 13 Jul 2001 05:28:30 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Abramo Bagnara <abramo@alsa-project.org>
Date: Fri, 13 Jul 2001 19:27:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15182.48923.214510.180434@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs-devel@linux.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS
In-Reply-To: message from Abramo Bagnara on Friday July 13
In-Reply-To: <3B4E93E9.F6506CC0@alsa-project.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 13, abramo@alsa-project.org wrote:
> 
> I have found a bug in NFSv2.
> 
> [root@igor /tmp]# mount igor:/u u
> [root@igor /tmp]# cd u
> [root@igor u]# umask 000
> [root@igor u]# ls -l q
> ls: q: File o directory inesistente
> [root@igor u]# touch q
> [root@igor u]# ls -l q
> -rw-r--r--    1 root     root            0 lug 13 07:56 q
> 
> This seems to be caused by use of unitialized current->fs->umask via
> vfs_create called by nfsd_create.
> 

Hmmm..  I think there is more here than immediately meets the eye.

current->fs->umask is initialised, to 0, in include/linux/fs_struct.h
The "INIT_FS" define is used to set the initial value of the fs_struct
(see arch/i386/kernel/init_task.c - other archs are the same).
The third field here is the umask field.

This is the fs_struct for init, and for every kernel thread that call
daemonise, as the nfsd threads do ever since 2.4.3pre5 or there abouts.

If the umask for nfsd is getting set to 022, as it would appear from
your experiment, then either:
  - your init process is setting it, or
  - you are using some odd architecture that doesn't use INIT_FS

So: what init program are you running, what architecture, any other
patches, anything else that might explain why your machine is
different from mine.  Because on mine, the touched file gets the right
permissions.

NeilBrown


> Patch for 2.4.6 follows.
> 
> -- 
> Abramo Bagnara                       mailto:abramo@alsa-project.org
> 
> Opera Unica                          Phone: +39.546.656023
> Via Emilia Interna, 140
> 48014 Castel Bolognese (RA) - Italy
> 
> ALSA project               http://www.alsa-project.org
> It sounds good!--- linux-2.4/fs/nfsd/auth.c.~1~	Mon Jul 24 08:04:10 2000
> +++ linux-2.4/fs/nfsd/auth.c	Fri Jul 13 08:00:10 2001
> @@ -34,6 +34,7 @@
>  				cred->cr_groups[i] = exp->ex_anon_gid;
>  	}
>  
> +	current->fs->umask = 0;
>  	if (cred->cr_uid != (uid_t) -1)
>  		current->fsuid = cred->cr_uid;
>  	else
> 
