Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282702AbRLKStM>; Tue, 11 Dec 2001 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282695AbRLKSsx>; Tue, 11 Dec 2001 13:48:53 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43527 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282684AbRLKSsV>; Tue, 11 Dec 2001 13:48:21 -0500
Date: Tue, 11 Dec 2001 15:31:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch with scsi probing fixes
In-Reply-To: <20011210193307.A23516@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.21.0112111531290.26181-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete, 

Lets queue this one for 2.4.18pre, OK ?

On Mon, 10 Dec 2001, Pete Zaitcev wrote:

> Dear Marcelo:
> 
> You said - only bugfixes for -rc1, so here's a bugfix for you.
> Attached is a conservative version of the scsi fix that I developed
> for our customers. Only the actual oops material is included,
> but no cleanups (I am working on cleanups with Andreas for 2.5.x,
> they are more radical).
> 
> As a maintainer, I guess, you may take offense to scsi_dev->detected.
> It is a bloat. But personally, I see no other way to handle a failure
> of sd_init(). Traditional thinking is to call ->detach(), but it's totally
> useless before ->attach() was called. So ->detected is how I roll back
> the ->detect().
> 
> -- Pete
> 
> P.S. Alan tasked me with changing sd.c to allocate reasonably sized
> structures in relation to this fix, but I am not done with it yet.
> It would not be an oops fix anyways.
> 
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/hosts.c linux-2.4.17-pre8-p3/drivers/scsi/hosts.c
> --- linux-2.4.17-pre8/drivers/scsi/hosts.c	Thu Jul  5 11:28:17 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/hosts.c	Mon Dec 10 16:07:47 2001
> @@ -275,6 +275,24 @@
>      return 0;
>  }
>  
> +void
> +scsi_deregister_device(struct Scsi_Device_Template * tpnt)
> +{
> +    struct Scsi_Device_Template *spnt;
> +    struct Scsi_Device_Template *prev_spnt;
> +
> +    spnt = scsi_devicelist;
> +    prev_spnt = NULL;
> +    while (spnt != tpnt) {
> +	prev_spnt = spnt;
> +	spnt = spnt->next;
> +    }
> +    if (prev_spnt == NULL)
> +        scsi_devicelist = tpnt->next;
> +    else
> +        prev_spnt->next = spnt->next;
> +}
> +
>  /*
>   * Overrides for Emacs so that we follow Linus's tabbing style.
>   * Emacs will notice this stuff at the end of the file and automatically
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/hosts.h linux-2.4.17-pre8-p3/drivers/scsi/hosts.h
> --- linux-2.4.17-pre8/drivers/scsi/hosts.h	Thu Nov 22 11:49:15 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/hosts.h	Mon Dec 10 16:07:47 2001
> @@ -526,6 +526,7 @@
>  void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
>  
>  int scsi_register_device(struct Scsi_Device_Template * sdpnt);
> +void scsi_deregister_device(struct Scsi_Device_Template * tpnt);
>  
>  /* These are used by loadable modules */
>  extern int scsi_register_module(int, void *);
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/scsi.c linux-2.4.17-pre8-p3/drivers/scsi/scsi.c
> --- linux-2.4.17-pre8/drivers/scsi/scsi.c	Mon Dec 10 15:57:51 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/scsi.c	Mon Dec 10 16:07:47 2001
> @@ -2261,7 +2261,7 @@
>  		for (SDpnt = shpnt->host_queue; SDpnt;
>  		     SDpnt = SDpnt->next) {
>  			if (tpnt->detect)
> -				SDpnt->attached += (*tpnt->detect) (SDpnt);
> +				SDpnt->detected = (*tpnt->detect) (SDpnt);
>  		}
>  	}
>  
> @@ -2269,9 +2269,19 @@
>  	 * If any of the devices would match this driver, then perform the
>  	 * init function.
>  	 */
> -	if (tpnt->init && tpnt->dev_noticed)
> -		if ((*tpnt->init) ())
> +	if (tpnt->init && tpnt->dev_noticed) {
> +		if ((*tpnt->init) ()) {
> +			for (shpnt = scsi_hostlist; shpnt;
> +			     shpnt = shpnt->next) {
> +				for (SDpnt = shpnt->host_queue; SDpnt;
> +				     SDpnt = SDpnt->next) {
> +					SDpnt->detected = 0;
> +				}
> +			}
> +			scsi_deregister_device(tpnt);
>  			return 1;
> +		}
> +	}
>  
>  	/*
>  	 * Now actually connect the devices to the new driver.
> @@ -2279,6 +2289,8 @@
>  	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
>  		for (SDpnt = shpnt->host_queue; SDpnt;
>  		     SDpnt = SDpnt->next) {
> +			SDpnt->attached += SDpnt->detected;
> +			SDpnt->detected = 0;
>  			if (tpnt->attach)
>  				(*tpnt->attach) (SDpnt);
>  			/*
> @@ -2314,9 +2326,7 @@
>  {
>  	Scsi_Device *SDpnt;
>  	struct Scsi_Host *shpnt;
> -	struct Scsi_Device_Template *spnt;
> -	struct Scsi_Device_Template *prev_spnt;
> -	
> +
>  	lock_kernel();
>  	/*
>  	 * If we are busy, this is not going to fly.
> @@ -2347,16 +2357,7 @@
>  	/*
>  	 * Extract the template from the linked list.
>  	 */
> -	spnt = scsi_devicelist;
> -	prev_spnt = NULL;
> -	while (spnt != tpnt) {
> -		prev_spnt = spnt;
> -		spnt = spnt->next;
> -	}
> -	if (prev_spnt == NULL)
> -		scsi_devicelist = tpnt->next;
> -	else
> -		prev_spnt->next = spnt->next;
> +	scsi_deregister_device(tpnt);
>  
>  	MOD_DEC_USE_COUNT;
>  	unlock_kernel();
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/scsi.h linux-2.4.17-pre8-p3/drivers/scsi/scsi.h
> --- linux-2.4.17-pre8/drivers/scsi/scsi.h	Thu Nov 22 11:49:15 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/scsi.h	Mon Dec 10 16:07:48 2001
> @@ -575,8 +575,8 @@
>  					 * vendor-specific cmd's */
>  	unsigned sector_size;	/* size in bytes */
>  
> -	int attached;		/* # of high level drivers attached to 
> -				 * this */
> +	int attached;		/* # of high level drivers attached to this */
> +	int detected;		/* Delta attached - don't use in drivers! */
>  	int access_count;	/* Count of open channels/mounts */
>  
>  	void *hostdata;		/* available to low-level driver */
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/sd.c linux-2.4.17-pre8-p3/drivers/scsi/sd.c
> --- linux-2.4.17-pre8/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/sd.c	Mon Dec 10 16:07:48 2001
> @@ -1078,6 +1078,7 @@
>  		for (i = 0; i < N_USED_SD_MAJORS; i++) {
>  			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
>  				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
> +				sd_template.dev_noticed = 0;
>  				return 1;
>  			}
>  		}
> @@ -1175,7 +1176,8 @@
>  		kfree(sd_gendisks[i].de_arr);
>  		kfree(sd_gendisks[i].flags);
>  	}
> -	kfree(sd_gendisks);
> +	if (sd_gendisks != &sd_gendisk)
> +		kfree(sd_gendisks);
>  cleanup_sd_gendisks:
>  	kfree(sd);
>  cleanup_sd:
> @@ -1188,11 +1190,13 @@
>  	kfree(sd_sizes);
>  cleanup_disks:
>  	kfree(rscsi_disks);
> +	rscsi_disks = NULL;
>  cleanup_devfs:
>  	for (i = 0; i < N_USED_SD_MAJORS; i++) {
>  		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
>  	}
>  	sd_registered--;
> +	sd_template.dev_noticed = 0;
>  	return 1;
>  }
>  
> @@ -1251,7 +1255,7 @@
>  	if (SDp->type != TYPE_DISK && SDp->type != TYPE_MOD)
>  		return 0;
>  
> -	if (sd_template.nr_dev >= sd_template.dev_max) {
> +	if (sd_template.nr_dev >= sd_template.dev_max || rscsi_disks == NULL) {
>  		SDp->attached--;
>  		return 1;
>  	}
> @@ -1259,8 +1263,13 @@
>  		if (!dpnt->device)
>  			break;
>  
> -	if (i >= sd_template.dev_max)
> -		panic("scsi_devices corrupt (sd)");
> +	if (i >= sd_template.dev_max) {
> +		printk(KERN_WARNING "scsi_devices corrupt (sd),"
> +		    " nr_dev %d dev_max %d\n",
> +		    sd_template.nr_dev, sd_template.dev_max);
> +		SDp->attached--;
> +		return 1;
> +	}
>  
>  	rscsi_disks[i].device = SDp;
>  	rscsi_disks[i].has_part_table = 0;
> @@ -1348,6 +1357,9 @@
>  	int max_p;
>  	int start;
>  
> +	if (rscsi_disks == NULL)
> +		return;
> +
>  	for (dpnt = rscsi_disks, i = 0; i < sd_template.dev_max; i++, dpnt++)
>  		if (dpnt->device == SDp) {
>  
> @@ -1365,7 +1377,6 @@
>  			}
>                          devfs_register_partitions (&SD_GENDISK (i),
>                                                     SD_MINOR_NUMBER (start), 1);
> -			/* unregister_disk() */
>  			dpnt->has_part_table = 0;
>  			dpnt->device = NULL;
>  			dpnt->capacity = 0;
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/sg.c linux-2.4.17-pre8-p3/drivers/scsi/sg.c
> --- linux-2.4.17-pre8/drivers/scsi/sg.c	Mon Dec 10 15:57:51 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/sg.c	Mon Dec 10 16:07:48 2001
> @@ -1344,6 +1344,7 @@
>              printk(KERN_ERR "Unable to get major %d for generic SCSI device\n",
>                     SCSI_GENERIC_MAJOR);
>  	    write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
> +            sg_template.dev_noticed = 0;
>              return 1;
>          }
>          sg_registered++;
> @@ -1356,6 +1357,7 @@
>      if (NULL == sg_dev_arr) {
>          printk(KERN_ERR "sg_init: no space for sg_dev_arr\n");
>  	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
> +        sg_template.dev_noticed = 0;
>          return 1;
>      }
>      memset(sg_dev_arr, 0, sg_template.dev_max * sizeof(Sg_device *));
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/sr.c linux-2.4.17-pre8-p3/drivers/scsi/sr.c
> --- linux-2.4.17-pre8/drivers/scsi/sr.c	Thu Oct 25 13:58:35 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/sr.c	Mon Dec 10 16:07:48 2001
> @@ -789,6 +789,7 @@
>  	if (!sr_registered) {
>  		if (devfs_register_blkdev(MAJOR_NR, "sr", &sr_bdops)) {
>  			printk("Unable to get major %d for SCSI-CD\n", MAJOR_NR);
> +			sr_template.dev_noticed = 0;
>  			return 1;
>  		}
>  		sr_registered++;
> @@ -830,8 +831,10 @@
>  	kfree(sr_sizes);
>  cleanup_cds:
>  	kfree(scsi_CDs);
> +	scsi_CDs = NULL;
>  cleanup_devfs:
>  	devfs_unregister_blkdev(MAJOR_NR, "sr");
> +	sr_template.dev_noticed = 0;
>  	sr_registered--;
>  	return 1;
>  }
> @@ -905,6 +908,8 @@
>  	Scsi_CD *cpnt;
>  	int i;
>  
> +	if (scsi_CDs == NULL)
> +		return;
>  	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
>  		if (cpnt->device == SDp) {
>  			/*
> diff -ur -X dontdiff linux-2.4.17-pre8/drivers/scsi/st.c linux-2.4.17-pre8-p3/drivers/scsi/st.c
> --- linux-2.4.17-pre8/drivers/scsi/st.c	Fri Nov  9 13:52:21 2001
> +++ linux-2.4.17-pre8-p3/drivers/scsi/st.c	Mon Dec 10 16:07:48 2001
> @@ -3818,6 +3818,7 @@
>  			write_unlock_irqrestore(&st_dev_arr_lock, flags);
>  			printk(KERN_ERR "Unable to get major %d for SCSI tapes\n",
>                                 MAJOR_NR);
> +			st_template.dev_noticed = 0;
>  			return 1;
>  		}
>  		st_registered++;
> 

