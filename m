Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWBCSU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWBCSU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWBCSU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:20:57 -0500
Received: from mail.gmx.net ([213.165.64.21]:45242 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751312AbWBCSU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:20:56 -0500
X-Authenticated: #428038
Date: Fri, 3 Feb 2006 19:20:49 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: acahalan@gmail.com, linux-kernel@vger.kernel.org, cdwrite@other.debian.org
Subject: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203182049.GB11083@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	acahalan@gmail.com, linux-kernel@vger.kernel.org,
	cdwrite@other.debian.org
References: <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E374CF.nail5CAMKAKEV@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-03:

> Albert Cahalan <acahalan@gmail.com> wrote:
> 
> > On 2/2/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> > >
> > > > I see the same thing with, the only external kernel patch I have
> > > > applied is Suspend2. The ATA scanbus code tries to
> > > > open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
> > >
> > > This is not cdrecord but a bastardized version......
> >
> > True enough, but it would work great if you'd fix that bug
> > that makes cdrecord give up while scanning. I guess
> > that's one more patch Debian will be applying.
> 
> As including O_EXCL would disallow to use more than one cdrecord
> program at the same time, there is no chance for the mains stream source.

Nobody suggested O_EXCL as a fix for the scanning bug.
It seems your capabilities to follow a complex discussion are generally
overtaxed a bit... sorry for overestimating you.

So patches to the rescue -- please review the patch below (for 2.01.01a05).
Note that GPL 2a and 2c apply, so you cannot merge a modified version of
my patch without adding a tag that you goofed my fixes.

If deemed safe, please apply and test. It appears to work for me
(as in: blanks and writes CD-RW when setuid root) on SUSE Linux 10.0
(kernel 2.6.13-15.7 i686 bigmem 4kstacks blah sülz) and it compiles
properly on FreeBSD 6-STABLE i686.

(Sorry for the off-topic bloat, but as we've had so many messages, a few
KB patching won't add much to the pain any more.)

And no, I am not going to read Solaris sources. Linux does not have to
care how Solaris works, but your Linux interface code has to work
properly on Linux and not put up artificial obstacles.

> Well the big difference with Solaris is that several modifications have been 
> applied by Sun to the vold sub-system on Solaris in order to decently 
> support cdrecord.

For the 100th time, you need to substantiate your bug claims or feature
requests with good reasons. "Somebody else is doing it." is not sufficient.

> The last change was done with Nevada Build 21 in August 2005.

Is this part of the Solaris 10 update shipped earlier this year?


Now for the patch diff, diffstat and comments first:

# cdrecord/cdrecord.c    |  114         2 +     105 -   7 !
# mkisofs/write.c        |    4         0 +     0 -     4 !
# libscg/scsi-linux-sg.c |   82         3 +     54 -    25 !
# 3 files changed, 5 insertions(+), 159 deletions(-), 36 modifications(!)

- The cdrecord patch removes bogus Linux warnings and
  adds the GPL 2a/2c guacamole.

- The write.c patch fixes trigraph, a patch Jörg keeps losing.

- The libscg patch removes bogus warnings, kills the ATA transport --
  this is an alpha version, not stable code (it can be autodetected by
  looking at the device name, I'm not sure if the LF_ATA is really
  useful nowaday), fixes the scanning bugs and unifies Linux SG_IO
  device namespaces.

Further observations:

- Jörg wants the kernel to add junk for device enumeration when removing
  artificial barriers from libscg does the same job?

  Now that's impressive after all his bold claims. I think Jens and a
  few other people deserve apologies.

- the code should glob /dev/sg* and probe everything and filter out
  dupes by looking at major/minor.

- linuxcheck() was broken and assuming fixed-format, the
  changed-interface warning disappeared with linux 2.6.10 ('1' < '8'),
  and is obsolete anyhow since 2.01.01a05. Nevermind the whining :-P

- Jörg makes a big fuss about duplicated code in Linux kernel, but this
  appears more of a "not in my back-yard" kind complaint... duplicated
  code in cdrecord anyone? Two screenful removed by the patch, help yourself.

How does this look (setuid root, the kernel appears to refuse the
obsolete "REZERO UNIT" which breaks f.i. cdrecord -toc)?

$ bins/i686-linux-cc/cdrecord -scanbus
Cdrecord-Clone 2.01.01a04 (i686-pc-linux-gnu) Copyright (C) 1995-2006 Joerg Schilling, 2006 Matthias Andree
NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
      that removed some bogus whining of the original author. Although unlikely,
      it may have bugs that are not present in the original version.
      Please send bug reports and support requests to <matthias.andree@gmx.de>.
      The original author should not be bothered with problems of this version.

Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
bins/i686-linux-cc/cdrecord: Warning: using inofficial libscg transport code version (-scsi-linux-sg.c-1.86+ma '@(#)scsi-linux-sg.c     1.86 05/11/22 Copyright 1997 J. Schilling').
scsibus0:
        0,0,0     0) 'ATA     ' 'SAMSUNG SP2004C ' 'VM10' Disk
        0,1,0     1) *
        ...
scsibus1:
        1,0,0   100) '_NEC    ' 'DVD_RW ND-4550A ' '1.07' Removable CD-ROM
        1,1,0   101) 'PLEXTOR ' 'CD-R   PX-W4824A' '1.06' Removable CD-ROM
        1,2,0   102) *
        ...
scsibus2:
        2,0,0   200) *
        2,1,0   201) *
        2,2,0   202) 'PLEXTOR ' 'CD-ROM PX-32TS  ' '1.02' Removable CD-ROM
        2,3,0   203) *
        ...

0,0,0 is  /dev/sda /dev/sg0, driven by sd and sg (libata)
1,*,0 are /dev/hdc /dev/hdd, driven by ide-cd    (via82cxxx)
2,2,0 is  /dev/sr0 /dev/sg1, driven by sr and sg (sym53c8xx_2)


Sorry 'bout posting this as bloated context patch,
this is for Jörg-Schilling-compliance and perhaps Solaris 2.6 too.

*** ./cdrecord/cdrecord.c.orig	Sun Jan 29 19:52:03 2006
--- ./cdrecord/cdrecord.c	Fri Feb  3 17:17:08 2006
***************
*** 245,251 ****
  LOCAL	void	print_wrmodes	__PR((cdr_t *dp));
  LOCAL	BOOL	check_wrmode	__PR((cdr_t *dp, int wmode, int tflags));
  LOCAL	void	set_wrmode	__PR((cdr_t *dp, int wmode, int tflags));
- LOCAL	void	linuxcheck	__PR((void));
  
  struct exargs {
  	SCSI	*scgp;
--- 245,250 ----
***************
*** 352,368 ****
  #	define	CLONE_TITLE	""
  #endif
  	if ((flags & F_MSINFO) == 0 || lverbose || flags & F_VERSION) {
! 		printf("Cdrecord%s%s %s (%s-%s-%s) Copyright (C) 1995-2006 Jörg Schilling\n",
  								PRODVD_TITLE,
  								CLONE_TITLE,
  								cdr_version,
  								HOST_CPU, HOST_VENDOR, HOST_OS);
  
  #if	defined(SOURCE_MODIFIED) || !defined(IS_SCHILY_XCONFIG)
! #define	INSERT_YOUR_EMAIL_ADDRESS_HERE
  #define	NO_SUPPORT	0
  		printf("NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord\n");
! 		printf("      and thus may have bugs that are not present in the original version.\n");
  #if	NO_SUPPORT
  		printf("      The author of the modifications decided not to provide a support e-mail\n");
  		printf("      address so there is absolutely no support for this version.\n");
--- 351,370 ----
  #	define	CLONE_TITLE	""
  #endif
  	if ((flags & F_MSINFO) == 0 || lverbose || flags & F_VERSION) {
! 		printf("Cdrecord%s%s %s (%s-%s-%s) Copyright (C) 1995-2006 Joerg Schilling, 2006 Matthias Andree\n",
  								PRODVD_TITLE,
  								CLONE_TITLE,
  								cdr_version,
  								HOST_CPU, HOST_VENDOR, HOST_OS);
  
+ #define SOURCE_MODIFIED 1
+ 
  #if	defined(SOURCE_MODIFIED) || !defined(IS_SCHILY_XCONFIG)
! #define	INSERT_YOUR_EMAIL_ADDRESS_HERE "matthias.andree@gmx.de"
  #define	NO_SUPPORT	0
  		printf("NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord\n");
! 		printf("      that removed some bogus whining of the original author. Although unlikely,\n");
! 		printf("      it may have bugs that are not present in the original version.\n");
  #if	NO_SUPPORT
  		printf("      The author of the modifications decided not to provide a support e-mail\n");
  		printf("      address so there is absolutely no support for this version.\n");
***************
*** 380,410 ****
  #endif
  	}
  
- 	/*
- 	 * I am sorry that even for version 1.308 of cdrecord.c, I am forced to do
- 	 * things like this, but defective versions of cdrecord cause a lot of
- 	 * work load to me and it seems to be impossible to otherwise convince
- 	 * SuSE to cooperate.
- 	 * As people contact me and bother me with the related problems,
- 	 * it is obvious that SuSE is violating subsection 6 in the preamble of
- 	 * the GPL.
- 	 *
- 	 * The reason for including a test against SuSE's private
- 	 * distribution environment is only that SuSE violates the GPL for
- 	 * a long time and seems not to be willing to follow the requirements
- 	 * imposed by the GPL. If SuSE starts to ship non defective versions
- 	 * of cdrecord or informs their customers that they would need to
- 	 * compile cdrecord themselves in order to get a working cdrecord,
- 	 * they should contact me for a permission to change the related test.
- 	 *
- 	 * Note that although the SuSE test is effective only for SuSE, the
- 	 * intention to have non bastardized versions out is not limited
- 	 * to SuSE. It is bad to see that in special in the "Linux" business,
- 	 * companies prefer a model with many proprietary differing programs
- 	 * instead of cooperating with the program authors.
- 	 */
- 	linuxcheck();	/* For version 1.308 of cdrecord.c */
- 
  	if (flags & F_VERSION)
  		exit(0);
  	/*
--- 382,387 ----
***************
*** 4699,4780 ****
  	}
  	dsp->ds_wrmode = WM_NONE;
  }
- 
- /*
-  * I am sorry that even for version 1.308 of cdrecord.c, I am forced to do
-  * things like this, but defective versions of cdrecord cause a lot of
-  * work load to me and it seems to be impossible to otherwise convince
-  * SuSE to cooperate.
-  * As people contact me and bother me with the related problems,
-  * it is obvious that SuSE is violating subsection 6 in the preamble of
-  * the GPL.
-  *
-  * The reason for including a test against SuSE's private
-  * distribution environment is only that SuSE violates the GPL for
-  * a long time and seems not to be willing to follow the requirements
-  * imposed by the GPL. If SuSE starts to ship non defective versions
-  * of cdrecord or informs their customers that they would need to
-  * compile cdrecord themselves in order to get a working cdrecord,
-  * they should contact me for a permission to change the related test.
-  *
-  * Note that although the SuSE test is effective only for SuSE, the
-  * intention to have non bastardized versions out is not limited
-  * to SuSE. It is bad to see that in special in the "Linux" business,
-  * companies prefer a model with many proprietary differing programs
-  * instead of cooperating with the program authors.
-  */
- #if	defined(linux) || defined(__linux) || defined(__linux__)
- #ifdef	HAVE_UNAME
- #include <sys/utsname.h>
- #endif
- #endif
- 
- LOCAL void
- linuxcheck()				/* For version 1.308 of cdrecord.c */
- {
- #if	defined(linux) || defined(__linux) || defined(__linux__)
- #ifdef	HAVE_UNAME
- 	struct	utsname	un;
- 
- 	if (uname(&un) >= 0) {
- 		/*
- 		 * I really hope that the Linux kernel developers will soon
- 		 * fix the most annoying bugs (as promised). Linux-2.6.8
- 		 * has still much more reported problems than Linux-2.4.
- 		 */
- 		if ((un.release[0] == '2' && un.release[1] == '.') &&
- 		    (un.release[2] == '5' || un.release[2] == '6')) {
- 			errmsgno(EX_BAD,
- 			"Warning: Running on Linux-%s\n", un.release);
- 			errmsgno(EX_BAD,
- 			"There are unsettled issues with Linux-2.5 and newer.\n");
- 			errmsgno(EX_BAD,
- 			"If you have unexpected problems, please try Linux-2.4 or Solaris.\n");
- 		}
- 		if ((un.release[0] == '2' && un.release[1] == '.') &&
- 		    (un.release[2] > '6' ||
- 		    (un.release[2] == '6' && un.release[3] == '.' && un.release[4] >= '8'))) {
- 			errmsgno(EX_BAD,
- 			"Warning: Linux-2.6.8 introduced incompatible interface changes.\n");
- 			errmsgno(EX_BAD,
- 			"Warning: SCSI transport does no longer work for suid root programs.\n");
- 			errmsgno(EX_BAD,
- 			"Warning: if cdrecord fails, try to run it from a root account.\n");
- 		}
- 	}
- #endif
- #if	0
- 	if (streql(HOST_VENDOR, "suse")) { /* For version 1.308 of cdrecord.c */
- /* 1.308 */	errmsgno(EX_BAD,
- /* 1.308 */	"SuSE Linux is known to ship bastardized and defective versions of cdrecord.\n");
- /* 1.308 */	errmsgno(EX_BAD,
- /* 1.308 */	"SuSE is unwilling to cooperate with the authors.\n");
- /* 1.308 */	errmsgno(EX_BAD,
- /* 1.308 */	"If you like to have a working version of cdrtools, get the\n");
- /* 1.308 */	errmsgno(EX_BAD,
- /* 1.308 */	"original source from ftp://ftp.berlios.de/pub/cdrecord/\n");
- 
- 	}
- #endif
- #endif
- }
--- 4676,4678 ----
*** ./mkisofs/write.c.orig	Fri Feb  3 15:49:23 2006
--- ./mkisofs/write.c	Fri Feb  3 15:49:25 2006
***************
*** 834,843 ****
  	if (dcount < 2) {
  #ifdef	USE_LIBSCHILY
  		errmsgno(EX_BAD,
! 			"Directory size too small (. or .. missing ???)\n");
  #else
  		fprintf(stderr,
! 			"Directory size too small (. or .. missing ???)\n");
  #endif
  		sort_goof = 1;
  
--- 834,843 ----
  	if (dcount < 2) {
  #ifdef	USE_LIBSCHILY
  		errmsgno(EX_BAD,
! 			"Directory size too small (. or .. missing ??\077)\n");
  #else
  		fprintf(stderr,
! 			"Directory size too small (. or .. missing ??\077)\n");
  #endif
  		sort_goof = 1;
  
*** ./libscg/scsi-linux-sg.c.orig	Fri Feb  3 15:44:39 2006
--- ./libscg/scsi-linux-sg.c	Fri Feb  3 16:31:03 2006
***************
*** 120,126 ****
   *	Choose your name instead of "schily" and make clear that the version
   *	string is related to a modified source.
   */
! LOCAL	char	_scg_trans_version[] = "scsi-linux-sg.c-1.86";	/* The version for this transport*/
  
  #ifndef	SCSI_IOCTL_GET_BUS_NUMBER
  #define	SCSI_IOCTL_GET_BUS_NUMBER 0x5386
--- 120,126 ----
   *	Choose your name instead of "schily" and make clear that the version
   *	string is related to a modified source.
   */
! LOCAL	char	_scg_trans_version[] = "scsi-linux-sg.c-1.86+ma";	/* The version for this transport*/
  
  #ifndef	SCSI_IOCTL_GET_BUS_NUMBER
  #define	SCSI_IOCTL_GET_BUS_NUMBER 0x5386
***************
*** 273,279 ****
  		 * return "schily" for the SCG_AUTHOR request.
  		 */
  		case SCG_AUTHOR:
! 			return (_scg_auth_schily);
  		case SCG_SCCS_ID:
  			return (__sccsid);
  		case SCG_KVERSION:
--- 273,279 ----
  		 * return "schily" for the SCG_AUTHOR request.
  		 */
  		case SCG_AUTHOR:
! 			return ("");
  		case SCG_SCCS_ID:
  			return (__sccsid);
  		case SCG_KVERSION:
***************
*** 308,315 ****
  #ifdef	USE_ATA
  	scgo_ahelp(scgp, f);
  #endif
- 	__scg_help(f, "ATA", "ATA Packet specific SCSI transport using sg interface",
- 		"ATA:", "bus,target,lun", "1,2,0", TRUE, FALSE);
  	return (0);
  }
  
--- 308,313 ----
***************
*** 328,334 ****
  	register int	l;
  	register int	nopen = 0;
  	char		devname[64];
- 		BOOL	use_ata = FALSE;
  
  	if (busno >= MAX_SCG || tgt >= MAX_TGT || tlun >= MAX_LUN) {
  		errno = EINVAL;
--- 326,331 ----
***************
*** 338,381 ****
  				busno, tgt, tlun);
  		return (-1);
  	}
- 	if (device != NULL && *device != '\0') {
  #ifdef	USE_ATA
  		if (strncmp(device, "ATAPI", 5) == 0) {
  			scgp->ops = &ata_ops;
  			return (SCGO_OPEN(scgp, device));
  		}
- #endif
- 		if (strcmp(device, "ATA") == 0) {
- 			/*
- 			 * Sending generic SCSI commands via /dev/hd* is a
- 			 * really bad idea when there also is a generic
- 			 * SCSI driver interface - it breaks the protocol
- 			 * layering model. A better idea would be to
- 			 * have a SCSI host bus adapter driver that sends
- 			 * the SCSI commands via the ATA hardware. This way,
- 			 * the layering model would be honored.
- 			 *
- 			 * People like Jens Axboe should finally fix the DMA
- 			 * bugs in the ide-scsi hostadaptor emulation module
- 			 * from Linux instead of publishing childish patches
- 			 * to the comment above.
- 			 */
- 			use_ata = TRUE;
- 			device = NULL;
- 			if (scgp->overbose) {
- 				/*
- 				 * I strongly encourage people who believe that
- 				 * they need to patch this message away to read
- 				 * the messages in the Solaris USCSI libscg
- 				 * layer instead of wetting their tissues while
- 				 * being unwilling to look besides their
- 				 * own belly button.
- 				 */
- 				js_fprintf((FILE *)scgp->errfile,
- 				"Warning: Using badly designed ATAPI via /dev/hd* interface.\n");
- 			}
- 		}
  	}
  
  	if (scgp->local == NULL) {
  		scgp->local = malloc(sizeof (struct scg_local));
--- 335,348 ----
  				busno, tgt, tlun);
  		return (-1);
  	}
  #ifdef	USE_ATA
+ 	if (device != NULL && *device != '\0') {
  		if (strncmp(device, "ATAPI", 5) == 0) {
  			scgp->ops = &ata_ops;
  			return (SCGO_OPEN(scgp, device));
  		}
  	}
+ #endif
  
  	if (scgp->local == NULL) {
  		scgp->local = malloc(sizeof (struct scg_local));
***************
*** 389,396 ****
  		scglocal(scgp)->drvers = -1;
  		scglocal(scgp)->isold = -1;
  		scglocal(scgp)->flags = 0;
- 		if (use_ata)
- 			scglocal(scgp)->flags |= LF_ATA;
  		scglocal(scgp)->xbufsize = 0L;
  		scglocal(scgp)->xbuf = NULL;
  
--- 356,361 ----
***************
*** 403,415 ****
  		}
  	}
  
- 	if (use_ata)
- 		goto scanopen;
- 
  	if ((device != NULL && *device != '\0') || (busno == -2 && tgt == -2))
  		goto openbydev;
  
- scanopen:
  	/*
  	 * Note that it makes no sense to scan less than all /dev/hd* devices
  	 * as even /dev/hda may be a device that talks SCSI (e.g. a ATAPI
--- 368,376 ----
***************
*** 417,423 ****
  	 * look silly but there may be users that did boot from a SCSI hdd
  	 * and connected 4 CD/DVD writers to both IDE cables in the PC.
  	 */
! 	if (use_ata) for (i = 0; i <= 25; i++) {
  		js_snprintf(devname, sizeof (devname), "/dev/hd%c", i+'a');
  					/* O_NONBLOCK is dangerous */
  		f = open(devname, O_RDWR | O_NONBLOCK);
--- 378,384 ----
  	 * look silly but there may be users that did boot from a SCSI hdd
  	 * and connected 4 CD/DVD writers to both IDE cables in the PC.
  	 */
! 	for (i = 0; i <= 25; i++) {
  		js_snprintf(devname, sizeof (devname), "/dev/hd%c", i+'a');
  					/* O_NONBLOCK is dangerous */
  		f = open(devname, O_RDWR | O_NONBLOCK);
***************
*** 433,439 ****
  				if (scgp->errstr)
  					js_snprintf(scgp->errstr, SCSI_ERRSTR_SIZE,
  							"Cannot open '%s'", devname);
! 				return (0);
  			}
  		} else {
  			int	iparm;
--- 394,400 ----
  				if (scgp->errstr)
  					js_snprintf(scgp->errstr, SCSI_ERRSTR_SIZE,
  							"Cannot open '%s'", devname);
! 				continue;
  			}
  		} else {
  			int	iparm;
***************
*** 446,463 ****
  				continue;
  			}
  			sg_clearnblock(f);	/* Be very proper about this */
  			if (sg_setup(scgp, f, busno, tgt, tlun, i))
  				return (++nopen);
  			if (busno < 0 && tgt < 0 && tlun < 0)
  				nopen++;
  		}
  	}
! 	if (use_ata && nopen == 0)
! 		return (0);
  	if (nopen > 0 && scgp->errstr)
  		scgp->errstr[0] = '\0';
  
! 	if (nopen == 0) for (i = 0; i < 32; i++) {
  		js_snprintf(devname, sizeof (devname), "/dev/sg%d", i);
  					/* O_NONBLOCK is dangerous */
  		f = open(devname, O_RDWR | O_NONBLOCK);
--- 407,424 ----
  				continue;
  			}
  			sg_clearnblock(f);	/* Be very proper about this */
+ 			scglocal(scgp)->flags |= LF_ATA;
  			if (sg_setup(scgp, f, busno, tgt, tlun, i))
  				return (++nopen);
  			if (busno < 0 && tgt < 0 && tlun < 0)
  				nopen++;
  		}
  	}
! 
  	if (nopen > 0 && scgp->errstr)
  		scgp->errstr[0] = '\0';
  
! 	for (i = 0; i < 32; i++) {
  		js_snprintf(devname, sizeof (devname), "/dev/sg%d", i);
  					/* O_NONBLOCK is dangerous */
  		f = open(devname, O_RDWR | O_NONBLOCK);
***************
*** 473,479 ****
  				if (scgp->errstr)
  					js_snprintf(scgp->errstr, SCSI_ERRSTR_SIZE,
  							"Cannot open '%s'", devname);
! 				return (0);
  			}
  		} else {
  			sg_clearnblock(f);	/* Be very proper about this */
--- 434,440 ----
  				if (scgp->errstr)
  					js_snprintf(scgp->errstr, SCSI_ERRSTR_SIZE,
  							"Cannot open '%s'", devname);
! 				continue;
  			}
  		} else {
  			sg_clearnblock(f);	/* Be very proper about this */
***************
*** 502,508 ****
  				if (scgp->errstr)
  					js_snprintf(scgp->errstr, SCSI_ERRSTR_SIZE,
  							"Cannot open '%s'", devname);
! 				return (0);
  			}
  		} else {
  			sg_clearnblock(f);	/* Be very proper about this */
--- 463,469 ----
  				if (scgp->errstr)
  					js_snprintf(scgp->errstr, SCSI_ERRSTR_SIZE,
  							"Cannot open '%s'", devname);
! 				continue;
  			}
  		} else {
  			sg_clearnblock(f);	/* Be very proper about this */
***************
*** 523,541 ****
  			if (b < 0 || b > 25)
  				b = -1;
  		}
- 		if (scgp->overbose) {
- 			/*
- 			 * Before you patch this away, are you sure that you
- 			 * know what you are going to to?
- 			 *
- 			 * Note that this is a warning that helps users from
- 			 * cdda2wav, mkisofs and other programs (that
- 			 * distinguish SCSI addresses from file names) from
- 			 * getting unexpected results.
- 			 */
- 			js_fprintf((FILE *)scgp->errfile,
- 			"Warning: Open by 'devname' is unintentional and not supported.\n");
- 		}
  					/* O_NONBLOCK is dangerous */
  		f = open(device, O_RDWR | O_NONBLOCK);
  /*		if (f < 0 && errno == ENOENT)*/
--- 484,489 ----
***************
*** 634,645 ****
  }
  
  /*
!  * The Linux kernel becomes more and more unmaintainable.
!  * Every year, a new incompatible SCSI transport interface is added.
!  * Each of them has it's own contradictory constraints.
!  * While you cannot have O_NONBLOCK set during operation, at least one
!  * of the drivers requires O_NONBLOCK to be set during open().
!  * This is used to clear O_NONBLOCK immediately after open() succeeded.
   */
  LOCAL void
  sg_clearnblock(f)
--- 582,588 ----
  }
  
  /*
!  * This is used to clear O_NONBLOCK immediately after open() succeeded.
   */
  LOCAL void
  sg_clearnblock(f)

-- 
Matthias Andree

"Il semble que la perfection soit atteinte non quand il n'y a plus rien à
ajouter, mais quand il n'y a plus rien à retrancher." A. de Saint-Exupéry
