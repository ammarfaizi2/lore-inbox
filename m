Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUCWHqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 02:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUCWHpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 02:45:46 -0500
Received: from [196.25.168.8] ([196.25.168.8]:40644 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S262345AbUCWHpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 02:45:04 -0500
Date: Tue, 23 Mar 2004 09:44:52 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] DVD+-RW for 2.6.4
Message-ID: <20040323074452.GN2347@lbsd.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gQyIpR7q4QSXYu+"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7gQyIpR7q4QSXYu+
Content-Type: multipart/mixed; boundary="TMgB3/Ch1aWgZB1L"
Content-Disposition: inline


--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guys,

I've done some work based on what Any Polakov had in 2.4.x in regards to
DVD+-RW.=20

Attached are patches I've created to support DVD+-RW in 2.6.4, just beware=
=20
on my LG GSA-4040B drive I get a vendor specific error code when I try
finalize the media. I have however not noticed any dataloss in 10
multisession dvd's i burnt last night.

Please test and let me know what the results are. BTW the DVD-RW patch
requires the packet writing patch to be applied first.

http://w1.894.telia.com/~u89404340/patches/packet/2.6/packet-2.6.4-rc2.patc=
h.bz2



Thanks
Nigel Kukard


--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.4_dvd+rw.patch"
Content-Transfer-Encoding: quoted-printable

diff -c --new-file --recursive linux-2.6.4_vanilla/drivers/cdrom/cdrom.c li=
nux-2.6.4_dvd+rw/drivers/cdrom/cdrom.c
*** linux-2.6.4_vanilla/drivers/cdrom/cdrom.c	Thu Mar 11 04:55:22 2004
--- linux-2.6.4_dvd+rw/drivers/cdrom/cdrom.c	Mon Mar 22 14:12:28 2004
***************
*** 766,771 ****
--- 766,774 ----
 =20
  	/* if this was a O_NONBLOCK open and we should honor the flags,
  	 * do a quick open without drive/disc integrity checks. */
+ 	/* But do it earlier so that media_change can (re)sense MMC3
+ 	   profile and tune mask accordingly. <appro@fy.chalmers.se> */
+ 	check_disk_change(ip->i_bdev);
  	cdi->use_count++;
  	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS)) {
  		ret =3D cdi->ops->open(cdi, 1);
***************
*** 787,793 ****
  			cdi->name, cdi->use_count);
  	/* Do this on open.  Don't wait for mount, because they might
  	    not be mounting, but opening with O_NONBLOCK */
- 	check_disk_change(ip->i_bdev);
  	return 0;
  err:
  	cdi->use_count--;
--- 790,795 ----
diff -c --new-file --recursive linux-2.6.4_vanilla/drivers/scsi/sr.c linux-=
2.6.4_dvd+rw/drivers/scsi/sr.c
*** linux-2.6.4_vanilla/drivers/scsi/sr.c	Thu Mar 11 04:55:24 2004
--- linux-2.6.4_dvd+rw/drivers/scsi/sr.c	Mon Mar 22 16:13:19 2004
***************
*** 30,35 ****
--- 30,39 ----
   *
   *	Modified by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   *	check resource allocation in sr_init and some cleanups
+  *=09
+  *	Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
+  *	2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
+  *
   */
 =20
  #include <linux/module.h>
***************
*** 149,157 ****
  	/* If the disk changed, the capacity will now be different,
  	 * so we force a re-read of this information */
  	if (retval) {
- 		/* check multisession offset etc */
- 		sr_cd_check(cdi);
-=20
  		/*=20
  		 * If the disk changed, the capacity will now be different,
  		 * so we force a re-read of this information=20
--- 153,158 ----
***************
*** 161,170 ****
--- 162,191 ----
  		 */
  		cd->needs_sector_size =3D 1;
  		cd->device->sector_size =3D 2048;
+ 		/* DVD+RW bookkeeping, mark clean */
+ 		cd->media_written =3D 0;
+=20
+ 		/* check multisession offset etc */
+ 		sr_cd_check(cdi);
  	}
  	return retval;
  }
  =20
+ static void flush_intr(struct scsi_cmnd *SCpnt)
+ {
+ 	/* this is a temporary hack which suspends i/o if unexpected happens */
+ 	if (driver_byte(SCpnt->result) !=3D 0 && SCpnt->sense_buffer[0] & 0xF0) {
+ 		printk("sr%d: unable to \"SYNCHRONIZE CACHE\" [%02x/%02x]? "
+ 		       "Suspending I/O...\n",
+ 		       SCpnt->sense_buffer[2],
+ 		       SCpnt->sense_buffer[12],
+ 		       SCpnt->sense_buffer[13]);
+ 		SCpnt->device->changed =3D 1;
+ 	}
+=20
+ 	scsi_release_request(SCpnt->sc_request);
+ }
+=20
  static inline struct scsi_cd *scsi_cd(struct gendisk *disk)
  {
  	return container_of(disk->private_data, struct scsi_cd, driver);
***************
*** 251,256 ****
--- 272,357 ----
  		}
  	}
 =20
+ 	if (cd->mmc3_profile =3D=3D 0x1A &&
+ 	    driver_byte(result) !=3D 0 &&
+ 	    SCpnt->sense_buffer[0] & 0xF0) /* permit for vendor codes */ {
+ 		if (SCpnt->sense_buffer[2] =3D=3D MEDIUM_ERROR &&
+ 		    SCpnt->sense_buffer[12] =3D=3D 0x15 &&
+ 		    rq_data_dir(SCpnt->request) =3D=3D WRITE) {
+ 			printk("%s: This one beats me! Suspending I/O...\n",
+ 				cd->cdi.name);
+ 			SCpnt->device->changed =3D 1;
+ 		}
+ 		else if (SCpnt->sense_buffer[2] =3D=3D ILLEGAL_REQUEST &&
+ 		    SCpnt->sense_buffer[12] =3D=3D 0x2c) do {
+ 			Scsi_Request *SRpnt;
+=20
+ 			printk("%s: injecting \"SYNCHRONIZE CACHE\"\n",
+ 				cd->cdi.name);
+=20
+ 			SRpnt =3D scsi_allocate_request(SCpnt->device,GFP_KERNEL);
+ 			if (SRpnt =3D=3D NULL) {
+ 				printk ("%s: out of kernel memory :-(\n",
+ 					cd->cdi.name);
+ 				SCpnt->device->changed =3D 1;
+ 				break; /* mind do{}while(0) around */
+ 			}
+=20
+ 			SRpnt->sr_cmnd[0] =3D 0x35;
+ 			SRpnt->sr_cmd_len =3D 10;
+ 			SRpnt->sr_data_direction =3D SCSI_DATA_NONE;
+ 			SRpnt->sr_timeout_per_command =3D 30*HZ;
+ 			SRpnt->sr_done =3D flush_intr;
+=20
+ #if 0			/* scsi_insert_special_req isn't exported :-( */
+ 			scsi_insert_special_req(SRpnt,1);
+ #elseif 0
+ 			/*
+ 			 * As scsi_insert_special_req is not exported, I
+ 			 * just copy corresponding code from scsi_lib.c.
+ 			 * This is a TEMPORARY solution and the ONLY
+ 			 * reason for doing this is that I don't want to
+ 			 * patch scsi_syms.c just yet! Below is inlined
+ 			 * call to __scsi_insert_special(q,rq,SRpnt,1)
+ 			 * from 2.4.18.
+ 			 */
+ 			{
+ 				request_queue_t *q =3D &SRpnt->sr_device->request_queue;
+ 				struct request *rq =3D &SRpnt->sr_request;
+ 				unsigned long flags;
+=20
+ 				rq->cmd =3D SPECIAL;
+ 				rq->special =3D SRpnt;
+ 				rq->q =3D NULL;
+ 				rq->nr_segments =3D 0;
+ 				rq->elevator_sequence =3D 0;
+=20
+ 				spin_lock_irqsave(&io_request_lock, flags);
+=20
+ 				list_add(&rq->queue, &q->queue_head);
+=20
+ 				q->request_fn(q);
+=20
+ 				spin_unlock_irqrestore(&io_request_lock, flags);
+ 			}
+ #else
+ 	SRpnt->sr_request->flags &=3D ~REQ_DONTPREP;
+ 	blk_insert_request(SRpnt->sr_device->request_queue, SRpnt->sr_request,
+ 		       	   1, SRpnt, 0);
+ #endif
+ 			/*
+ 			 * fake "LOGICAL UNIT IS IN PROCESS OF BECOMING READY"
+ 			 * for current command to fool scsi_io_completion().
+ 			 */
+ 			SCpnt->sense_buffer[0] =3D 0xF0;
+ 			SCpnt->sense_buffer[2] &=3D 0xF0;
+ 			SCpnt->sense_buffer[2] |=3D NOT_READY;
+ 			SCpnt->sense_buffer[12] =3D 4;
+ 			SCpnt->sense_buffer[13] =3D 1;
+ 			good_bytes =3D 0;
+ 		} while (0);
+ 	}
+=20
  	/*
  	 * This calls the generic completion function, now that we know
  	 * how many actual sectors finished, and how many sectors we need
***************
*** 295,301 ****
--- 396,405 ----
  		if (!rq->data_len)
  			SCpnt->sc_data_direction =3D SCSI_DATA_NONE;
  		else if (rq_data_dir(rq) =3D=3D WRITE)
+ 		{
  			SCpnt->sc_data_direction =3D SCSI_DATA_WRITE;
+ 	 		cd->media_written =3D 1;
+ 		}
  		else
  			SCpnt->sc_data_direction =3D SCSI_DATA_READ;
 =20
***************
*** 550,555 ****
--- 654,661 ----
  	cd->use =3D 1;
  	cd->readcd_known =3D 0;
  	cd->readcd_cdda =3D 0;
+ 	cd->media_written =3D 0;
+ 	cd->close_track_sniffed =3D 0;
 =20
  	cd->cdi.ops =3D &sr_dops;
  	cd->cdi.handle =3D cd;
diff -c --new-file --recursive linux-2.6.4_vanilla/drivers/scsi/sr.h linux-=
2.6.4_dvd+rw/drivers/scsi/sr.h
*** linux-2.6.4_vanilla/drivers/scsi/sr.h	Thu Mar 11 04:55:25 2004
--- linux-2.6.4_dvd+rw/drivers/scsi/sr.h	Mon Mar 22 14:12:28 2004
***************
*** 12,17 ****
--- 12,21 ----
   *       Modified by Eric Youngdale eric@andante.org to
   *       add scatter-gather, multiple outstanding request, and other
   *       enhancements.
+  *=09
+  *	Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
+  *	2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
+  *
   */
 =20
  #ifndef _SR_H
***************
*** 24,29 ****
--- 28,37 ----
  /* In fact, it is very slow if it has to spin up first */
  #define IOCTL_TIMEOUT 30*HZ
 =20
+ /* primitive to determine whether we need to have GFP_DMA set based on
+  * the status of the unchecked_isa_dma flag in the host structure */
+ #define SR_GFP_DMA(cd) (((cd)->device->host->unchecked_isa_dma) ? GFP_DMA=
 : 0)
+=20
  typedef struct scsi_cd {
  	struct scsi_driver *driver;
  	unsigned capacity;	/* size in blocks                       */
***************
*** 35,40 ****
--- 43,51 ----
  	unsigned xa_flag:1;	/* CD has XA sectors ? */
  	unsigned readcd_known:1;	/* drive supports READ_CD (0xbe) */
  	unsigned readcd_cdda:1;	/* reading audio data using READ_CD */
+ 	unsigned media_written:1;	/* dirty flag, DVD+RW bookkeeping */
+ 	unsigned close_track_sniffed:1;	/* dirty flag, DVD+RW bookkeeping */
+ 	unsigned short mmc3_profile;	/* current MMC3 profile, see sr_vendor.c */
  	struct cdrom_device_info cdi;
  	struct gendisk *disk;
  } Scsi_CD;
***************
*** 58,62 ****
--- 69,75 ----
  void sr_vendor_init(Scsi_CD *);
  int sr_cd_check(struct cdrom_device_info *);
  int sr_set_blocklength(Scsi_CD *, int blocklength);
+ /* anchor for DVD+RW "finalization" at unlock */
+ void sr_vendor_lock_door (Scsi_CD *,int lock);
 =20
  #endif
diff -c --new-file --recursive linux-2.6.4_vanilla/drivers/scsi/sr_ioctl.c =
linux-2.6.4_dvd+rw/drivers/scsi/sr_ioctl.c
*** linux-2.6.4_vanilla/drivers/scsi/sr_ioctl.c	Thu Mar 11 04:55:35 2004
--- linux-2.6.4_dvd+rw/drivers/scsi/sr_ioctl.c	Mon Mar 22 14:12:28 2004
***************
*** 160,165 ****
--- 160,172 ----
  			err =3D -EIO;
  		}
  	}
+ 	else if (cgc->cmd[0] =3D=3D 0x5B) {
+ 		/* Even though this flag is commented as DVD+RW specific
+ 		 * in sr.h, no check if currently mounted media is DVD+RW
+ 		 * is performed. That's because the flag does good in
+ 		 * in either case. */
+ 		cd->close_track_sniffed =3D 1;
+ 	}
 =20
  	if (cgc->sense)
  		memcpy(cgc->sense, SRpnt->sr_sense_buffer, sizeof(*cgc->sense));
***************
*** 205,210 ****
--- 212,218 ----
  {
  	Scsi_CD *cd =3D cdi->handle;
 =20
+  	sr_vendor_lock_door(cd,lock);
  	return scsi_set_medium_removal(cd->device, lock ?
  		       SCSI_REMOVAL_PREVENT : SCSI_REMOVAL_ALLOW);
  }
***************
*** 262,271 ****
  	return 0;
  }
 =20
- /* primitive to determine whether we need to have GFP_DMA set based on
-  * the status of the unchecked_isa_dma flag in the host structure */
- #define SR_GFP_DMA(cd) (((cd)->device->host->unchecked_isa_dma) ? GFP_DMA=
 : 0)
-=20
  int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
  {
  	Scsi_CD *cd =3D cdi->handle;
--- 270,275 ----
diff -c --new-file --recursive linux-2.6.4_vanilla/drivers/scsi/sr_vendor.c=
 linux-2.6.4_dvd+rw/drivers/scsi/sr_vendor.c
*** linux-2.6.4_vanilla/drivers/scsi/sr_vendor.c	Thu Mar 11 04:55:27 2004
--- linux-2.6.4_dvd+rw/drivers/scsi/sr_vendor.c	Mon Mar 22 19:04:12 2004
***************
*** 32,37 ****
--- 32,41 ----
   *   - HP:      Much like SONY, but a little different... (Thomas)
   *              HP-Writers only ??? Maybe other CD-Writers work with this=
 too ?
   *              HP 6020 writers now supported.
+  * ----------------------------------------------------------------------=
----
+  *=09
+  *	Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
+  *	2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
   */
 =20
  #include <linux/config.h>
***************
*** 61,79 ****
 =20
  #define VENDOR_TIMEOUT	30*HZ
 =20
  void sr_vendor_init(Scsi_CD *cd)
  {
  #ifndef CONFIG_BLK_DEV_SR_VENDOR
  	cd->vendor =3D VENDOR_SCSI3;
  #else
  	char *vendor =3D cd->device->vendor;
  	char *model =3D cd->device->model;
  =09
  	/* default */
  	cd->vendor =3D VENDOR_SCSI3;
! 	if (cd->readcd_known)
  		/* this is true for scsi3/mmc drives - no more checks */
  		return;
 =20
  	if (cd->device->type =3D=3D TYPE_WORM) {
  		cd->vendor =3D VENDOR_WRITER;
--- 65,203 ----
 =20
  #define VENDOR_TIMEOUT	30*HZ
 =20
+ static unsigned short sr_mmc3_profile(Scsi_CD *cd)
+ {
+ 	char *buffer =3D kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
+ 	int rc, mmc3_profile;
+ 	struct cdrom_generic_command cgc;
+=20
+ 	/* Read MMC-3 profile */
+ 	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+ 	cgc.cmd[0] =3D GPCMD_GET_CONFIGURATION;
+ 	cgc.cmd[1] =3D (cd->device->scsi_level <=3D SCSI_2) ?
+ 	         (cd->device->lun << 5) : 0;
+ 	cgc.cmd[2] =3D cgc.cmd[3] =3D 0;		/* Starting Feature Number */
+ 	cgc.cmd[4] =3D cgc.cmd[5] =3D cgc.cmd [6] =3D 0;	/* Reserved */
+ 	cgc.cmd[7] =3D 0; cgc.cmd [8] =3D 8;	/* Allocation Length */
+ 	cgc.cmd[9] =3D 0;			/* Control */
+ 	cgc.buffer =3D buffer;
+ 	cgc.buflen =3D 8;
+ 	cgc.timeout =3D IOCTL_TIMEOUT;
+ 	cgc.data_direction =3D SCSI_DATA_READ;
+=20
+ 	rc =3D sr_do_ioctl(cd, &cgc);
+ 	if (rc) {	/* doesn't seem to support MMC3 profiles!!!	*/
+ 		mmc3_profile =3D 0xFFFF;
+ 	} else {
+ 		mmc3_profile =3D (buffer[6] << 8) | buffer[7];
+ 		switch (mmc3_profile) {
+ 		    case 0x0A:  /* CD-RW */
+ 			cd->cdi.mask &=3D ~CDC_CD_RW;
+ 			cd->device->writeable =3D 1;
+ 			break;
+ 		    case 0x12:	/* DVD-RAM	*/
+ 		    case 0x1A:	/* DVD+RW	*/
+ 			cd->cdi.mask &=3D ~CDC_DVD_RAM;
+ 			cd->device->writeable =3D 1;
+ 			break;
+ 		    case 0x1B:	/* DVD+R	*/
+ 			/* Needed for accessing of opened media */
+ 			cgc.cmd[0] =3D GPCMD_READ_FORMAT_CAPACITIES;
+ 			cgc.cmd[8] =3D 12;
+ 			cgc.timeout =3D VENDOR_TIMEOUT;
+=20
+ 			rc =3D sr_do_ioctl(cd, &cgc);
+ 		        if (!rc) {
+ 			    cd->capacity =3D ((buffer[4] << 24) |
+ 							(buffer[5] << 16) |
+ 							(buffer[6] << 8)  |
+ 							 buffer[7]) * 4;
+ 			    cd->device->sector_size =3D 2048;
+ 			    cd->disk->capacity =3D cd->disk->capacity >> (BLOCK_SIZE_BITS - 9);
+ 			    cd->needs_sector_size =3D 0;
+ 			}
+ 			/* no break; */
+ 		    default:
+ 			cd->cdi.mask |=3D CDC_DVD_RAM;
+ 			cd->device->writeable =3D 0;
+ 			break;
+ 		}
+ 	}
+ 	cd->mmc3_profile =3D mmc3_profile;
+=20
+ 	kfree(buffer);
+ 	return mmc3_profile;
+ }
+=20
+ void sr_vendor_lock_door(Scsi_CD *cd, int lock)
+ {
+ 	struct cdrom_generic_command cgc;
+=20
+ 	if (lock !=3D 0) return;
+=20
+ 	if ( (cd->media_written) &&
+ 	     (cd->mmc3_profile =3D=3D 0x1A) ) {
+ 		printk ("%s: dirty DVD+RW media, \"finalizing\"\n",
+ 			cd->cdi.name);
+=20
+ 		memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+ 		cgc.cmd[0] =3D GPCMD_FLUSH_CACHE;
+ 		cgc.timeout =3D IOCTL_TIMEOUT;
+ 		cgc.data_direction =3D SCSI_DATA_NONE;
+ 		sr_do_ioctl(cd, &cgc);
+=20
+ 		memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+ 		cgc.cmd[0] =3D GPCMD_CLOSE_TRACK;
+ 		cgc.timeout =3D 3000*HZ;
+ 		cgc.data_direction =3D SCSI_DATA_NONE;
+ 		sr_do_ioctl(cd, &cgc);
+=20
+ 		memset(&cgc, 0, sizeof(struct cdrom_generic_command));
+ 		cgc.cmd[0] =3D GPCMD_CLOSE_TRACK;
+ 		cgc.cmd[2] =3D 2;	 /* Close session */
+ 		cgc.timeout =3D 3000*HZ;
+ 		cgc.data_direction =3D SCSI_DATA_NONE;
+ 		sr_do_ioctl(cd, &cgc);
+=20
+ 		/* bookkeeping, mark clean and changed */
+ 		cd->media_written =3D 0;
+ 		cd->close_track_sniffed =3D 0;
+ 		cd->device->changed =3D 1;
+ 	}
+ 	else if (cd->close_track_sniffed) {
+ 		cd->close_track_sniffed =3D 0;
+ 		cd->device->changed =3D 1;
+ 	}
+ }
+=20
  void sr_vendor_init(Scsi_CD *cd)
  {
+ 	int rc;
  #ifndef CONFIG_BLK_DEV_SR_VENDOR
  	cd->vendor =3D VENDOR_SCSI3;
+=20
+ 	/* check for MMC-3 Profile capability */
+ 	rc =3D sr_mmc3_profile(cd);
+ 	if (rc !=3D 0xFFFF)
+ 		printk ("%s: mmc-3 profile capable,"
+ 			" current profile: %Xh\n", cd->cdi.name, rc);
+ 	return;
  #else
  	char *vendor =3D cd->device->vendor;
  	char *model =3D cd->device->model;
  =09
  	/* default */
  	cd->vendor =3D VENDOR_SCSI3;
! 	if (cd->readcd_known) {
! 		/* this is true for scsi3/mmc drives */
! 		/* check for MMC-3 Profile capability */
! 		rc =3D sr_mmc3_profile(cd);
! 		if (rc !=3D 0xFFFF)
! 			printk ("%s: mmc-3 profile capable,"
! 				" current profile: %Xh\n", cd->cdi.name, rc);
  		/* this is true for scsi3/mmc drives - no more checks */
  		return;
+ 	}
 =20
  	if (cd->device->type =3D=3D TYPE_WORM) {
  		cd->vendor =3D VENDOR_WRITER;
***************
*** 160,165 ****
--- 284,300 ----
  	struct cdrom_generic_command cgc;
  	int rc, no_multi;
 =20
+=20
+ 	if ((cd->vendor =3D=3D VENDOR_SCSI3) &&
+ 	    (cd->mmc3_profile !=3D 0xFFFF)) {
+ 		rc =3D sr_mmc3_profile(cd);
+ 		if (rc !=3D 0xFFFF)
+ 			printk ("%s: mmc-3 profile: %Xh\n", cd->cdi.name, rc);
+ 		else
+ 			printk ("%s: Failed to sense mmc-3 profile\n",
+ 				cd->cdi.name);
+ 	}
+=20
  	if (cd->cdi.mask & CDC_MULTI_SESSION)
  		return 0;
 =20
***************
*** 177,184 ****
 =20
  	case VENDOR_SCSI3:
  		cgc.cmd[0] =3D READ_TOC;
  		cgc.cmd[8] =3D 12;
- 		cgc.cmd[9] =3D 0x40;
  		cgc.buffer =3D buffer;
  		cgc.buflen =3D 12;
  		cgc.quiet =3D 1;
--- 312,319 ----
 =20
  	case VENDOR_SCSI3:
  		cgc.cmd[0] =3D READ_TOC;
+ 		cgc.cmd[2] =3D 1;
  		cgc.cmd[8] =3D 12;
  		cgc.buffer =3D buffer;
  		cgc.buflen =3D 12;
  		cgc.quiet =3D 1;
***************
*** 187,193 ****
  		rc =3D sr_do_ioctl(cd, &cgc);
  		if (rc !=3D 0)
  			break;
! 		if ((buffer[0] << 8) + buffer[1] < 0x0a) {
  			printk(KERN_INFO "%s: Hmm, seems the drive "
  			   "doesn't support multisession CD's\n", cd->cdi.name);
  			no_multi =3D 1;
--- 322,328 ----
  		rc =3D sr_do_ioctl(cd, &cgc);
  		if (rc !=3D 0)
  			break;
! 		if ((buffer[0] << 8) + buffer[1] < 8) {
  			printk(KERN_INFO "%s: Hmm, seems the drive "
  			   "doesn't support multisession CD's\n", cd->cdi.name);
  			no_multi =3D 1;

--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.4_dvd-rw.patch"
Content-Transfer-Encoding: quoted-printable

diff -c --recursive linux-2.6.4_packet/drivers/block/Kconfig linux-2.6.4_dv=
d-rw/drivers/block/Kconfig
*** linux-2.6.4_packet/drivers/block/Kconfig	Mon Mar 22 14:44:56 2004
--- linux-2.6.4_dvd-rw/drivers/block/Kconfig	Mon Mar 22 15:03:56 2004
***************
*** 345,351 ****
  	  compliant ATAPI or SCSI drive, which is just about any newer CD
  	  writer.
 =20
! 	  Currently only writing to CD-RW discs is possible.
 =20
  	  To compile this driver as a module, choose M here: the
  	  module will be called pktcdvd.
--- 345,353 ----
  	  compliant ATAPI or SCSI drive, which is just about any newer CD
  	  writer.
 =20
! 	  Currently only writing to CD-RW, DVD-RW and DVD+RW discs is possible.
!=20
! 	  DVD-RW disks must be in restricted overwrite mode.
 =20
  	  To compile this driver as a module, choose M here: the
  	  module will be called pktcdvd.
diff -c --recursive linux-2.6.4_packet/drivers/block/pktcdvd.c linux-2.6.4_=
dvd-rw/drivers/block/pktcdvd.c
*** linux-2.6.4_packet/drivers/block/pktcdvd.c	Mon Mar 22 14:44:56 2004
--- linux-2.6.4_dvd-rw/drivers/block/pktcdvd.c	Mon Mar 22 15:21:43 2004
***************
*** 1346,1351 ****
--- 1346,1357 ----
  	char buffer[128];
  	int ret, size;
 =20
+ 	/* doesn't apply to DVD+RW (?) */
+ 	if (pd->mmc3_profile =3D=3D 0x1a)
+ 		return 0;
+ /*	if (pd->mmc3_profile =3D=3D 0x13) */
+ /*		return 0; */
+=20
  	memset(buffer, 0, sizeof(buffer));
  	init_cdrom_command(&cgc, buffer, sizeof(*wp), CGC_DATA_READ);
  	cgc.sense =3D &sense;
***************
*** 1451,1456 ****
--- 1457,1475 ----
   */
  static int pkt_good_disc(struct pktcdvd_device *pd, disc_information *di)
  {
+ 	switch (pd->mmc3_profile) {
+ 		case 0x0a: /* CD-RW */
+ 		case 0xffff: /* MMC3 not supported ? */
+ 			break;
+ 		case 0x1a: /* DVD+RW */
+ 			return 0;
+ 		case 0x13: /* DVD-RW Experimental */
+ 			return 0;
+ 		default:
+ 			printk("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
+ 			return 1;
+ 	}
+=20
  	/*
  	 * for disc type 0xff we should probably reserve a new track.
  	 * but i'm not sure, should we leave this to user apps? probably.
***************
*** 1480,1489 ****
--- 1499,1516 ----
 =20
  static int pkt_probe_settings(struct pktcdvd_device *pd)
  {
+ 	struct cdrom_generic_command cgc;
+ 	unsigned char buf[12];
  	disc_information di;
  	track_information ti;
  	int ret, track;
 =20
+ 	init_cdrom_command(&cgc, buf, 8, CGC_DATA_READ);
+ 	cgc.cmd[0] =3D GPCMD_GET_CONFIGURATION;
+ 	cgc.cmd[8] =3D 8;
+ 	ret =3D pkt_generic_packet(pd, &cgc);
+ 	pd->mmc3_profile =3D ret ? 0xffff : buf[6] << 8 | buf[7];
+=20
  	memset(&di, 0, sizeof(disc_information));
  	memset(&ti, 0, sizeof(track_information));
 =20
***************
*** 1818,1831 ****
 =20
  	if ((ret =3D pkt_get_max_speed(pd, &write_speed)))
  		write_speed =3D 16;
! 	if ((ret =3D pkt_media_speed(pd, &media_write_speed)))
! 		media_write_speed =3D 16;
! 	write_speed =3D min_t(unsigned, write_speed, media_write_speed);
! 	read_speed =3D (write_speed * 3) / 2;
 =20
  	if ((ret =3D pkt_set_speed(pd, write_speed, read_speed))) {
  		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
  		return -EIO;
  	}
  	DPRINTK("pktcdvd: speed (R/W) %u/%u\n", read_speed, write_speed);
  	pd->write_speed =3D write_speed;
--- 1845,1868 ----
 =20
  	if ((ret =3D pkt_get_max_speed(pd, &write_speed)))
  		write_speed =3D 16;
! 	switch (pd->mmc3_profile) {
! 		case 0x13: /* DVD-RW Experimental */
! 		case 0x1a: /* DVD+RW */
! 			read_speed =3D write_speed;
! 			break;
! 		default:
! 			if ((ret =3D pkt_media_speed(pd, &media_write_speed)))
! 				media_write_speed =3D 16;
! 			write_speed =3D min_t(unsigned, write_speed, media_write_speed);
! 			read_speed =3D (write_speed * 3) / 2;
! 			break;
! 	}
 =20
  	if ((ret =3D pkt_set_speed(pd, write_speed, read_speed))) {
  		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
+ 		/*
  		return -EIO;
+ 		*/
  	}
  	DPRINTK("pktcdvd: speed (R/W) %u/%u\n", read_speed, write_speed);
  	pd->write_speed =3D write_speed;
diff -c --recursive linux-2.6.4_packet/drivers/scsi/sr_vendor.c linux-2.6.4=
_dvd-rw/drivers/scsi/sr_vendor.c
*** linux-2.6.4_packet/drivers/scsi/sr_vendor.c	Mon Mar 22 14:51:24 2004
--- linux-2.6.4_dvd-rw/drivers/scsi/sr_vendor.c	Mon Mar 22 15:03:56 2004
***************
*** 117,122 ****
--- 117,125 ----
  			    cd->needs_sector_size =3D 0;
  			}
  			/* no break; */
+ 		    case 0x13: /* DVD-RW Restricted Overwrite */
+ 			cd->device->writeable =3D 1;
+ 			break;
  		    default:
  			cd->cdi.mask |=3D CDC_DVD_RAM;
  			cd->device->writeable =3D 0;
diff -c --recursive linux-2.6.4_packet/include/linux/pktcdvd.h linux-2.6.4_=
dvd-rw/include/linux/pktcdvd.h
*** linux-2.6.4_packet/include/linux/pktcdvd.h	Mon Mar 22 14:44:56 2004
--- linux-2.6.4_dvd-rw/include/linux/pktcdvd.h	Mon Mar 22 15:03:56 2004
***************
*** 244,249 ****
--- 244,250 ----
  	__u8			mode_offset;	/* 0 / 8 */
  	__u8			type;
  	unsigned long		flags;
+ 	__u16				mmc3_profile;
  	__u8			disc_status;
  	__u8			track_status;	/* last one */
  	__u32			nwa;		/* next writable address */

--TMgB3/Ch1aWgZB1L--

--7gQyIpR7q4QSXYu+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAX+r0KoUGSidwLE4RAgTlAKC7A1w6fJDK1xy+UmzivKg5+93lswCeMIzB
kMOcdHUzPR9bxHu94USWEoA=
=sf+G
-----END PGP SIGNATURE-----

--7gQyIpR7q4QSXYu+--
