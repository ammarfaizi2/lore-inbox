Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUKXBXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUKXBXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 20:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUKXBXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 20:23:40 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:24683 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261406AbUKXBS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 20:18:57 -0500
Message-ID: <41A3E17C.1000308@google.com>
Date: Tue, 23 Nov 2004 17:18:52 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation for IDE and CDROM ioctls.
Content-Type: multipart/mixed;
 boundary="------------070905090208090703050603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905090208090703050603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi all; this should about cover it.  I've written two document files, 
and packaged them as a patch.

Two things caught my eye while I was writing this up:

The header comments for CDROMREADRAW, CDROMREADMODE1, and CDROMREADMODE2 
disagree with the actual source code.  The header comments imply that a 
cdrom_read structure is used to pass data, but the source code actually 
reads a cdrom_msf structure and then overwrites it with raw data.  I'm 
not sure if there's a bug in the header comments, in the driver source, 
or I misread something.

The CDROM_LOCKDOOR ioctl seems to lock/unlock all doors on all drives, 
because it uses a global variable.

	-ed falk

--------------070905090208090703050603
Content-Type: text/plain;
 name="patch-ioctl-doc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ioctl-doc"

diff -urpP linux.old/Documentation/ioctl/cdrom.txt linux/Documentation/ioctl/cdrom.txt
--- linux.old/Documentation/ioctl/cdrom.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/ioctl/cdrom.txt	2004-11-23 14:51:39.000000000 -0800
@@ -0,0 +1,935 @@
+		Summary of CDROM ioctl calls.
+		============================
+
+		Edward A. Falk <efalk@google.com>
+
+		November, 2004
+
+This document attempts to describe the ioctl(2) calls supported by
+the CDROM layer.  These are by-and-large implemented (as of Linux 2.6)
+in drivers/cdrom/cdrom.c and drivers/block/scsi_ioctl.c
+
+ioctl values are listed in <linux/cdrom.h>.  As of this writing, they
+are as follows:
+
+	CDROMPAUSE		Pause Audio Operation 
+	CDROMRESUME		Resume paused Audio Operation
+	CDROMPLAYMSF		Play Audio MSF (struct cdrom_msf)
+	CDROMPLAYTRKIND		Play Audio Track/index (struct cdrom_ti)
+	CDROMREADTOCHDR		Read TOC header (struct cdrom_tochdr)
+	CDROMREADTOCENTRY	Read TOC entry (struct cdrom_tocentry)
+	CDROMSTOP		Stop the cdrom drive
+	CDROMSTART		Start the cdrom drive
+	CDROMEJECT		Ejects the cdrom media
+	CDROMVOLCTRL		Control output volume (struct cdrom_volctrl)
+	CDROMSUBCHNL		Read subchannel data (struct cdrom_subchnl)
+	CDROMREADMODE2		Read CDROM mode 2 data (2336 Bytes) 
+					   (struct cdrom_read)
+	CDROMREADMODE1		Read CDROM mode 1 data (2048 Bytes)
+					   (struct cdrom_read)
+	CDROMREADAUDIO		(struct cdrom_read_audio)
+	CDROMEJECT_SW		enable(1)/disable(0) auto-ejecting
+	CDROMMULTISESSION	Obtain the start-of-last-session 
+				  address of multi session disks 
+				  (struct cdrom_multisession)
+	CDROM_GET_MCN		Obtain the "Universal Product Code" 
+				   if available (struct cdrom_mcn)
+	CDROM_GET_UPC		CDROM_GET_MCN  (deprecated)
+	CDROMRESET		hard-reset the drive
+	CDROMVOLREAD		Get the drive's volume setting 
+					  (struct cdrom_volctrl)
+	CDROMREADRAW		read data in raw mode (2352 Bytes)
+					   (struct cdrom_read)
+	CDROMREADCOOKED		read data in cooked mode
+	CDROMSEEK		seek msf address
+	CDROMPLAYBLK		scsi-cd only, (struct cdrom_blk)
+	CDROMREADALL		read all 2646 bytes
+	CDROMGETSPINDOWN
+	CDROMSETSPINDOWN
+	CDROMCLOSETRAY		pendant of CDROMEJECT
+	CDROM_SET_OPTIONS	Set behavior options
+	CDROM_CLEAR_OPTIONS	Clear behavior options
+	CDROM_SELECT_SPEED	Set the CD-ROM speed
+	CDROM_SELECT_DISC	Select disc (for juke-boxes)
+	CDROM_MEDIA_CHANGED	Check is media changed 
+	CDROM_DRIVE_STATUS	Get tray position, etc.
+	CDROM_DISC_STATUS	Get disc type, etc.
+	CDROM_CHANGER_NSLOTS	Get number of slots
+	CDROM_LOCKDOOR		lock or unlock door
+	CDROM_DEBUG		Turn debug messages on/off
+	CDROM_GET_CAPABILITY	get capabilities
+	CDROMAUDIOBUFSIZ	set the audio buffer size
+	DVD_READ_STRUCT		Read structure
+	DVD_WRITE_STRUCT	Write structure
+	DVD_AUTH		Authentication
+	CDROM_SEND_PACKET	send a packet to the drive
+	CDROM_NEXT_WRITABLE	get next writable block
+	CDROM_LAST_WRITTEN	get last block written on disc
+
+
+The information that follows was determined from reading kernel source
+code.  It is likely that some corrections will be made over time.
+
+
+
+
+
+
+
+General:
+
+	Unless otherwise specified, all ioctl calls return 0 on success
+	and -1 with errno set to an appropriate value on error.
+
+	Unless otherwise specified, all ioctl calls return EFAULT on a
+	failed attempt to copy data to or from user address space.
+
+	Individual drivers may return error codes not listed here.
+
+	Unless otherwise specified, all data structures and constants
+	are defined in <linux/cdrom.h>
+
+
+
+
+CDROMPAUSE			Pause Audio Operation 
+
+	usage:
+
+	  ioctl(fd, CDROMPAUSE, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+CDROMRESUME			Resume paused Audio Operation
+
+	usage:
+
+	  ioctl(fd, CDROMRESUME, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+CDROMPLAYMSF			Play Audio MSF (struct cdrom_msf)
+
+	usage:
+
+	  struct cdrom_msf msf;
+	  ioctl(fd, CDROMPLAYMSF, &msf);
+
+	inputs:
+	  cdrom_msf structure, describing a segment of music to play
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+	notes:
+	  Segment is described as start and end times, where each time
+	  is described as minutes:seconds:frames.  A frame is 1/75 of
+	  a second.
+
+
+CDROMPLAYTRKIND			Play Audio Track/index (struct cdrom_ti)
+
+	usage:
+
+	  struct cdrom_ti ti;
+	  ioctl(fd, CDROMPLAYTRKIND, &ti);
+
+	inputs:
+	  cdrom_ti structure, describing a segment of music to play
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+	notes:
+	  Segment is described as start and end times, where each time
+	  is described as a track and an index.
+
+
+
+CDROMREADTOCHDR			Read TOC header (struct cdrom_tochdr)
+
+	usage:
+
+	  cdrom_tochdr header;
+	  ioctl(fd, CDROMREADTOCHDR, &header);
+
+	inputs:
+	  cdrom_tochdr structure
+
+	outputs:
+	  cdrom_tochdr structure
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+
+CDROMREADTOCENTRY		Read TOC entry (struct cdrom_tocentry)
+
+	usage:
+
+	  struct cdrom_tocentry entry;
+	  ioctl(fd, CDROMREADTOCENTRY, &entry);
+
+	inputs:
+	  cdrom_tocentry structure
+
+	outputs:
+	  cdrom_tocentry structure
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+	  EINVAL	entry.cdte_format not CDROM_MSF or CDROM_LBA
+
+	notes:
+	  MSF stands for minutes-seconds-frames
+	  LBA stands for logical block address
+
+
+
+CDROMSTOP			Stop the cdrom drive
+
+	usage:
+
+	  ioctl(fd, CDROMSTOP, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+CDROMSTART			Start the cdrom drive
+
+	usage:
+
+	  ioctl(fd, CDROMSTART, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+CDROMEJECT			Ejects the cdrom media
+
+	usage:
+
+	  ioctl(fd, CDROMEJECT, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not capable of ejecting
+	  EBUSY		other processes have drive open or door is locked
+
+
+
+CDROMCLOSETRAY			pendant of CDROMEJECT
+
+	usage:
+
+	  ioctl(fd, CDROMEJECT, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not capable of ejecting
+	  EBUSY		other processes have drive open or door is locked
+
+
+
+CDROMVOLCTRL			Control output volume (struct cdrom_volctrl)
+
+	usage:
+
+	  struct cdrom_volctrl volume;
+	  ioctl(fd, CDROMVOLCTRL, &volume);
+
+	inputs:
+	  cdrom_volctrl structure containing volumes for up to 4
+	  channels.
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+
+CDROMVOLREAD			Get the drive's volume setting 
+					  (struct cdrom_volctrl)
+
+	usage:
+
+	  struct cdrom_volctrl volume;
+	  ioctl(fd, CDROMVOLREAD, &volume);
+
+	inputs:		none
+
+	outputs:
+	  The current volume settings.
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+
+
+
+CDROMSUBCHNL			Read subchannel data (struct cdrom_subchnl)
+
+	usage:
+
+	  struct cdrom_subchnl q;
+	  ioctl(fd, CDROMSUBCHNL, &q);
+
+	inputs:
+	  cdrom_subchnl structure
+
+	outputs:
+	  cdrom_subchnl structure
+
+	error return:
+	  ENOSYS	cd drive not audio-capable.
+	  EINVAL	format not CDROM_MSF or CDROM_LBA
+
+	notes:
+	  Format is converted to CDROM_MSF on return
+
+
+
+CDROMREADRAW			read data in raw mode (2352 Bytes)
+					   (struct cdrom_read)
+
+	usage:
+
+	  union {
+	    struct cdrom_msf msf;		/* input */
+	    char buffer[CD_FRAMESIZE_RAW];	/* return */
+	  } arg;
+	  ioctl(fd, CDROMREADRAW, &arg);
+
+	inputs:
+	  cdrom_msf structure indicating an address to read.
+	  Only the start values are significant.
+
+	outputs:
+	  Data written to address provided by user.
+
+	error return:
+	  EINVAL	address less than 0, or msf less than 0:2:0
+	  ENOMEM	out of memory
+
+	notes:
+	  As of 2.6.8.1, comments in <linux/cdrom.h> indicate that this
+	  ioctl accepts a cdrom_read structure, but actual source code
+	  reads a cdrom_msf structure and writes a buffer of data to
+	  the same address.
+
+	  MSF values are converted to LBA values via this formula:
+
+	    lba = (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
+
+
+
+
+CDROMREADMODE1			Read CDROM mode 1 data (2048 Bytes)
+					   (struct cdrom_read)
+
+	notes:
+	  Identical to CDROMREADRAW except that block size is
+	  CD_FRAMESIZE (2048) bytes
+
+
+
+CDROMREADMODE2			Read CDROM mode 2 data (2336 Bytes) 
+					   (struct cdrom_read)
+
+	notes:
+	  Identical to CDROMREADRAW except that block size is
+	  CD_FRAMESIZE_RAW0 (2336) bytes
+
+
+
+CDROMREADAUDIO			(struct cdrom_read_audio)
+
+	usage:
+
+	  struct cdrom_read_audio ra;
+	  ioctl(fd, CDROMREADAUDIO, &ra);
+
+	inputs:
+	  cdrom_read_audio structure containing read start
+	  point and length
+
+	outputs:
+	  audio data, returned to buffer indicated by ra
+
+	error return:
+	  EINVAL	format not CDROM_MSF or CDROM_LBA
+	  EINVAL	nframes not in range [1 75]
+	  ENXIO		drive has no queue (probably means invalid fd)
+	  ENOMEM	out of memory
+
+
+CDROMEJECT_SW			enable(1)/disable(0) auto-ejecting
+
+	usage:
+
+	  int val;
+	  ioctl(fd, CDROMEJECT_SW, val);
+
+	inputs:
+	  Flag specifying auto-eject flag.
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	Drive is not capable of ejecting.
+	  EBUSY		Door is locked
+
+
+
+
+CDROMMULTISESSION		Obtain the start-of-last-session 
+				  address of multi session disks 
+				  (struct cdrom_multisession)
+	usage:
+
+	  struct cdrom_multisession ms_info;
+	  ioctl(fd, CDROMMULTISESSION, &ms_info);
+
+	inputs:
+	  cdrom_multisession structure containing desired
+	  format.
+
+	outputs:
+	  cdrom_multisession structure is filled with last_session
+	  information.
+
+	error return:
+	  EINVAL	format not CDROM_MSF or CDROM_LBA
+
+
+CDROM_GET_MCN			Obtain the "Universal Product Code" 
+				   if available (struct cdrom_mcn)
+
+	usage:
+
+	  struct cdrom_mcn mcn;
+	  ioctl(fd, CDROM_GET_MCN, &mcn);
+
+	inputs:		none
+
+	outputs:
+	  Universal Product Code
+
+	error return:
+	  ENOSYS	Drive is not capable of reading MCN data.
+
+	notes:
+	  Source code comments state:
+
+	    The following function is implemented, although very few
+	    audio discs give Universal Product Code information, which
+	    should just be the Medium Catalog Number on the box.  Note,
+	    that the way the code is written on the CD is /not/ uniform
+	    across all discs!
+
+
+
+
+CDROM_GET_UPC			CDROM_GET_MCN  (deprecated)
+
+	Not implemented, as of 2.6.8.1
+
+
+
+CDROMRESET			hard-reset the drive
+
+	usage:
+
+	  ioctl(fd, CDROMRESET, 0);
+
+	inputs:		none
+
+	outputs:	none
+
+	error return:
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  ENOSYS	Drive is not capable of resetting.
+
+
+
+
+CDROMREADCOOKED			read data in cooked mode
+
+	usage:
+
+	  u8 buffer[CD_FRAMESIZE]
+	  ioctl(fd, CDROMREADCOOKED, buffer);
+
+	inputs:		none
+
+	outputs:
+	  2048 bytes of data, "cooked" mode.
+
+	notes:
+	  Not implemented on all drives.
+
+
+
+
+CDROMREADALL			read all 2646 bytes
+
+	Same as CDROMREADCOOKED, but reads 2646 bytes.
+
+
+
+CDROMSEEK			seek msf address
+
+	usage:
+
+	  struct cdrom_msf msf;
+	  ioctl(fd, CDROMSEEK, &msf);
+
+	inputs:
+	  MSF address to seek to.
+
+	outputs:	none
+
+
+
+CDROMPLAYBLK			scsi-cd only, (struct cdrom_blk)
+
+	usage:
+
+	  struct cdrom_blk blk;
+	  ioctl(fd, CDROMPLAYBLK, &blk);
+
+	inputs:
+	  Region to play
+
+	outputs:	none
+
+
+
+CDROMGETSPINDOWN
+
+	usage:
+
+	  char spindown;
+	  ioctl(fd, CDROMGETSPINDOWN, &spindown);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current 4-bit spindown value.
+
+
+
+
+CDROMSETSPINDOWN
+
+	usage:
+
+	  char spindown
+	  ioctl(fd, CDROMSETSPINDOWN, &spindown);
+
+	inputs:
+	  4-bit value used to control spindown (TODO: more detail here)
+
+	outputs:	none
+
+
+
+
+
+CDROM_SET_OPTIONS		Set behavior options
+
+	usage:
+
+	  int options;
+	  ioctl(fd, CDROM_SET_OPTIONS, options);
+
+	inputs:
+	  New values for drive options.  The logical 'or' of:
+	    CDO_AUTO_CLOSE	close tray on first open
+	    CDO_AUTO_EJECT	open tray on last release
+	    CDO_USE_FFLAGS	use O_NONBLOCK information on open
+	    CDO_LOCK		lock tray on open files
+	    CDO_CHECK_TYPE	check type on open for data
+
+	outputs:
+	  Returns the resulting options settings in the
+	  ioctl return value.  Returns -1 on error.
+
+	error return:
+	  ENOSYS	selected option(s) not supported by drive.
+
+
+
+
+CDROM_CLEAR_OPTIONS		Clear behavior options
+
+	Same as CDROM_SET_OPTIONS, except that selected options are
+	turned off.
+
+
+
+CDROM_SELECT_SPEED		Set the CD-ROM speed
+
+	usage:
+
+	  int speed;
+	  ioctl(fd, CDROM_SELECT_SPEED, speed);
+
+	inputs:
+	  New drive speed.
+
+	outputs:	none
+
+	error return:
+	  ENOSYS	speed selection not supported by drive.
+
+
+
+CDROM_SELECT_DISC		Select disc (for juke-boxes)
+
+	usage:
+
+	  int disk;
+	  ioctl(fd, CDROM_SELECT_DISC, disk);
+
+	inputs:
+	  Disk to load into drive.
+
+	outputs:	none
+
+	error return:
+	  EINVAL	Disk number beyond capacity of drive
+
+
+
+CDROM_MEDIA_CHANGED		Check is media changed 
+
+	usage:
+
+	  int slot;
+	  ioctl(fd, CDROM_MEDIA_CHANGED, slot);
+
+	inputs:
+	  Slot number to be tested, always zero except for jukeboxes.
+	  May also be special values CDSL_NONE or CDSL_CURRENT
+
+	outputs:
+	  Ioctl return value is 0 or 1 depending on whether the media
+	  has been changed, or -1 on error.
+
+	error returns:
+	  ENOSYS	Drive can't detect media change
+	  EINVAL	Slot number beyond capacity of drive
+	  ENOMEM	Out of memory
+
+
+
+CDROM_DRIVE_STATUS		Get tray position, etc.
+
+	usage:
+
+	  int slot;
+	  ioctl(fd, CDROM_DRIVE_STATUS, slot);
+
+	inputs:
+	  Slot number to be tested, always zero except for jukeboxes.
+	  May also be special values CDSL_NONE or CDSL_CURRENT
+
+	outputs:
+	  Ioctl return value will be one of the following values
+	  from <linux/cdrom.h>:
+
+	    CDS_NO_INFO		Information not available.
+	    CDS_NO_DISC
+	    CDS_TRAY_OPEN
+	    CDS_DRIVE_NOT_READY
+	    CDS_DISC_OK
+	    -1			error
+
+	error returns:
+	  ENOSYS	Drive can't detect drive status
+	  EINVAL	Slot number beyond capacity of drive
+	  ENOMEM	Out of memory
+
+
+
+
+CDROM_DISC_STATUS		Get disc type, etc.
+
+	usage:
+
+	  ioctl(fd, CDROM_DISC_STATUS, 0);
+
+	inputs:		none
+
+	outputs:
+	  Ioctl return value will be one of the following values
+	  from <linux/cdrom.h>:
+	    CDS_NO_INFO
+	    CDS_AUDIO
+	    CDS_MIXED
+	    CDS_XA_2_2
+	    CDS_XA_2_1
+	    CDS_DATA_1
+
+	error returns:	none at present
+
+	notes:
+	  Source code comments state:
+
+	    Ok, this is where problems start.  The current interface for
+	    the CDROM_DISC_STATUS ioctl is flawed.  It makes the false
+	    assumption that CDs are all CDS_DATA_1 or all CDS_AUDIO, etc.
+	    Unfortunatly, while this is often the case, it is also
+	    very common for CDs to have some tracks with data, and some
+	    tracks with audio.	Just because I feel like it, I declare
+	    the following to be the best way to cope.  If the CD has
+	    ANY data tracks on it, it will be returned as a data CD.
+	    If it has any XA tracks, I will return it as that.	Now I
+	    could simplify this interface by combining these returns with
+	    the above, but this more clearly demonstrates the problem
+	    with the current interface.  Too bad this wasn't designed
+	    to use bitmasks...	       -Erik
+
+	    Well, now we have the option CDS_MIXED: a mixed-type CD.
+	    User level programmers might feel the ioctl is not very
+	    useful.
+			---david
+
+
+
+
+CDROM_CHANGER_NSLOTS		Get number of slots
+
+	usage:
+
+	  ioctl(fd, CDROM_CHANGER_NSLOTS, 0);
+
+	inputs:		none
+
+	outputs:
+	  The ioctl return value will be the number of slots in a
+	  CD changer.  Typically 1 for non-multi-disk devices.
+
+	error returns:	none
+
+
+
+CDROM_LOCKDOOR			lock or unlock door
+
+	usage:
+
+	  int lock;
+	  ioctl(fd, CDROM_LOCKDOOR, lock);
+
+	inputs:
+	  Door lock flag, 1=lock, 0=unlock
+
+	outputs:	none
+
+	error returns:
+	  EDRIVE_CANT_DO_THIS	Door lock function not supported.
+	  EBUSY			Attempt to unlock when multiple users
+	  			have the drive open and not CAP_SYS_ADMIN
+
+	notes:
+	  As of 2.6.8.1, the lock flag is a global lock, meaning that
+	  all CD drives will be locked or unlocked together.  This is
+	  probably a bug.
+
+	  The EDRIVE_CANT_DO_THIS value is defined in <linux/cdrom.h>
+	  and is currently (2.6.8.1) the same as EOPNOTSUPP
+
+
+
+CDROM_DEBUG			Turn debug messages on/off
+
+	usage:
+
+	  int debug;
+	  ioctl(fd, CDROM_DEBUG, debug);
+
+	inputs:
+	  Cdrom debug flag, 0=disable, 1=enable
+
+	outputs:
+	  The ioctl return value will be the new debug flag.
+
+	error return:
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+
+
+
+CDROM_GET_CAPABILITY		get capabilities
+
+	usage:
+
+	  ioctl(fd, CDROM_GET_CAPABILITY, 0);
+
+	inputs:		none
+
+	outputs:
+	  The ioctl return value is the current device capability
+	  flags.  See CDC_CLOSE_TRAY, CDC_OPEN_TRAY, etc.
+
+
+
+CDROMAUDIOBUFSIZ		set the audio buffer size
+
+	usage:
+
+	  int arg;
+	  ioctl(fd, CDROMAUDIOBUFSIZ, val);
+
+	inputs:
+	  New audio buffer size
+
+	outputs:
+	  The ioctl return value is the new audio buffer size, or -1
+	  on error.
+
+	error return:
+	  ENOSYS	Not supported by this driver.
+
+	notes:
+	  Not supported by all drivers.
+
+
+
+DVD_READ_STRUCT			Read structure
+
+	usage:
+
+	  dvd_struct s;
+	  ioctl(fd, DVD_READ_STRUCT, &s);
+
+	inputs:
+	  dvd_struct structure, containing:
+	    type		specifies the information desired, one of
+	    			DVD_STRUCT_PHYSICAL, DVD_STRUCT_COPYRIGHT,
+				DVD_STRUCT_DISCKEY, DVD_STRUCT_BCA,
+				DVD_STRUCT_MANUFACT
+	    physical.layer_num	desired layer, indexed from 0
+	    copyright.layer_num	desired layer, indexed from 0
+	    disckey.agid
+
+	outputs:
+	  dvd_struct structure, containing:
+	    physical		for type == DVD_STRUCT_PHYSICAL
+	    copyright		for type == DVD_STRUCT_COPYRIGHT
+	    disckey.value	for type == DVD_STRUCT_DISCKEY
+	    bca.{len,value}	for type == DVD_STRUCT_BCA
+	    manufact.{len,valu}	for type == DVD_STRUCT_MANUFACT
+
+	error returns:
+	  EINVAL	physical.layer_num exceeds number of layers
+	  EIO		Recieved invalid response from drive
+
+
+
+DVD_WRITE_STRUCT		Write structure
+
+	Not implemented, as of 2.6.8.1
+
+
+
+DVD_AUTH			Authentication
+
+	usage:
+
+	  dvd_authinfo ai;
+	  ioctl(fd, DVD_AUTH, &ai);
+
+	inputs:
+	  dvd_authinfo structure.  See <linux/cdrom.h>
+
+	outputs:
+	  dvd_authinfo structure.
+
+	error return:
+	  ENOTTY	ai.type not recognized.
+
+
+
+CDROM_SEND_PACKET		send a packet to the drive
+
+	usage:
+
+	  struct cdrom_generic_command cgc;
+	  ioctl(fd, CDROM_SEND_PACKET, &cgc);
+
+	inputs:
+	  cdrom_generic_command structure containing the packet to send.
+
+	outputs:	none
+	  cdrom_generic_command structure containing results.
+
+	error return:
+	  EIO		command failed.
+	  EPERM		Operation not permitted, either because a
+			write command was attempted on a drive which
+			is opened read-only, or because the command
+			requires CAP_SYS_RAWIO
+	  EINVAL	cgc.data_direction not set
+
+
+
+CDROM_NEXT_WRITABLE		get next writable block
+
+	usage:
+
+	  long next;
+	  ioctl(fd, CDROM_NEXT_WRITABLE, &next);
+
+	inputs:		none
+
+	outputs:
+	  The next writable block.
+
+
+
+CDROM_LAST_WRITTEN		get last block written on disc
+
+	usage:
+
+	  long last;
+	  ioctl(fd, CDROM_NEXT_WRITABLE, &last);
+
+	inputs:		none
+
+	outputs:
+	  The last block written on disc
+
+
diff -urpP linux.old/Documentation/ioctl/hdio.txt linux/Documentation/ioctl/hdio.txt
--- linux.old/Documentation/ioctl/hdio.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/ioctl/hdio.txt	2004-11-23 14:58:01.000000000 -0800
@@ -0,0 +1,949 @@
+		Summary of HDIO_ ioctl calls.
+		============================
+
+		Edward A. Falk <efalk@google.com>
+
+		November, 2004
+
+This document attempts to describe the ioctl(2) calls supported by
+the HD/IDE layer.  These are by-and-large implemented (as of Linux 2.6)
+in drivers/ide/ide.c and drivers/block/scsi_ioctl.c
+
+ioctl values are listed in <linux/hdreg.h>.  As of this writing, they
+are as follows:
+
+    ioctls that pass argument pointers to user space:
+
+	HDIO_GETGEO		get device geometry
+	HDIO_GET_UNMASKINTR	get current unmask setting
+	HDIO_GET_MULTCOUNT	get current IDE blockmode setting
+	HDIO_GET_QDMA		get use-qdma flag
+	HDIO_SET_XFER		set transfer rate via proc
+	HDIO_OBSOLETE_IDENTITY	OBSOLETE, DO NOT USE
+	HDIO_GET_KEEPSETTINGS	get keep-settings-on-reset flag
+	HDIO_GET_32BIT		get current io_32bit setting
+	HDIO_GET_NOWERR		get ignore-write-error flag
+	HDIO_GET_DMA		get use-dma flag
+	HDIO_GET_NICE		get nice flags
+	HDIO_GET_IDENTITY	get IDE identification info
+	HDIO_GET_WCACHE		get write cache mode on|off
+	HDIO_GET_ACOUSTIC	get acoustic value
+	HDIO_GET_ADDRESS       
+	HDIO_GET_BUSSTATE	get the bus state of the hwif
+	HDIO_TRISTATE_HWIF	execute a channel tristate
+	HDIO_DRIVE_RESET	execute a device reset
+	HDIO_DRIVE_TASKFILE	execute raw taskfile
+	HDIO_DRIVE_TASK		execute task and special drive command
+	HDIO_DRIVE_CMD		execute a special drive command
+	HDIO_DRIVE_CMD_AEB	HDIO_DRIVE_TASK
+
+    ioctls that pass non-pointer values:
+
+	HDIO_SET_MULTCOUNT	change IDE blockmode
+	HDIO_SET_UNMASKINTR	permit other irqs during I/O
+	HDIO_SET_KEEPSETTINGS	keep ioctl settings on reset
+	HDIO_SET_32BIT		change io_32bit flags
+	HDIO_SET_NOWERR		change ignore-write-error flag
+	HDIO_SET_DMA		change use-dma flag
+	HDIO_SET_PIO_MODE	reconfig interface to new speed
+	HDIO_SCAN_HWIF		register and (re)scan interface
+	HDIO_SET_NICE		set nice flags
+	HDIO_UNREGISTER_HWIF	unregister interface
+	HDIO_SET_WCACHE		change write cache enable-disable
+	HDIO_SET_ACOUSTIC	change acoustic behavior
+	HDIO_SET_BUSSTATE	set the bus state of the hwif
+	HDIO_SET_QDMA		change use-qdma flag
+	HDIO_SET_ADDRESS	change lba addressing modes
+
+	HDIO_SET_IDE_SCSI
+	HDIO_SET_SCSI_IDE
+
+
+The information that follows was determined from reading kernel source
+code.  It is likely that some corrections will be made over time.
+
+
+
+
+
+
+
+General:
+
+	Unless otherwise specified, all ioctl calls return 0 on success
+	and -1 with errno set to an appropriate value on error.
+
+	Unless otherwise specified, all ioctl calls return EFAULT on a
+	failed attempt to copy data to or from user address space.
+
+	Unless otherwise specified, all data structures and constants
+	are defined in <linux/hdreg.h>
+
+
+
+HDIO_GETGEO			get device geometry
+
+	usage:
+
+	  struct hd_geometry geom;
+	  ioctl(fd, HDIO_GETGEO, &geom);
+
+
+	inputs:		none
+
+	outputs:
+
+	  hd_geometry structure containing:
+
+	    heads	number of heads
+	    sectors	number of sectors/track
+	    cylinders	number of cylinders, mod 65536
+	    start	starting sector of this partition.
+
+
+	error returns:
+	  EINVAL	if the device is not a disk drive or floppy drive,
+	  		or if the user passes a null pointer
+
+
+	notes:
+
+	  Not particularly useful with modern disk drives, whose geometry
+	  is a polite fiction anyway.  Modern drives are addressed
+	  purely by sector number nowadays (lba addressing), and the
+	  drive geometry is an abstraction which is actually subject
+	  to change.  Currently (as of Nov 2004), the geometry values
+	  are the "bios" values -- presumably the values the drive had
+	  when Linux first booted.
+
+	  In addition, the cylinders field of the hd_geometry is an
+	  unsigned short, meaning that on most architectures, this
+	  ioctl will not return a meaningful value on drives with more
+	  than 65535 tracks.
+
+	  The start field is unsigned long, meaning that it will not
+	  contain a meaningful value for disks over 219 Gb in size.
+
+
+
+
+HDIO_GET_UNMASKINTR		get current unmask setting
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_UNMASKINTR, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the drive's current unmask setting
+
+
+
+HDIO_SET_UNMASKINTR		permit other irqs during I/O
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_SET_UNMASKINTR, val);
+
+	inputs:
+	  New value for unmask flag
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 1]
+	  EBUSY		Controller busy
+
+
+
+
+HDIO_GET_MULTCOUNT		get current IDE blockmode setting
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_MULTCOUNT, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current IDE block mode setting.  This
+	  controls how many sectors the drive will transfer per
+	  interrupt.
+
+
+
+HDIO_SET_MULTCOUNT		change IDE blockmode
+
+	usage:
+
+	  int val;
+	  ioctl(fd, HDIO_SET_MULTCOUNT, val);
+
+	inputs:
+	  New value for IDE block mode setting.  This controls how many
+	  sectors the drive will transfer per interrupt.
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range supported by disk.
+	  EBUSY		Controller busy or blockmode already set.
+	  EIO		Drive did not accept new block mode.
+
+	notes:
+
+	  Source code comments read:
+	  
+	    This is tightly woven into the driver->do_special can not
+	    touch.  DON'T do it again until a total personality rewrite
+	    is committed."
+
+	  If blockmode has already been set, this ioctl will fail with
+	  EBUSY
+
+
+
+HDIO_GET_QDMA			get use-qdma flag
+
+	Not implemented, as of 2.6.8.1
+
+
+
+HDIO_SET_XFER			set transfer rate via proc
+
+	Not implemented, as of 2.6.8.1
+
+
+
+HDIO_OBSOLETE_IDENTITY		OBSOLETE, DO NOT USE
+
+	Same as HDIO_GET_IDENTITY (see below), except that it only
+	returns the first 142 bytes of drive identity information.
+
+
+
+HDIO_GET_IDENTITY		get IDE identification info
+
+	usage:
+
+	  unsigned char identity[512];
+	  ioctl(fd, HDIO_GET_IDENTITY, identity);
+
+	inputs:		none
+
+	outputs:
+
+	  ATA drive identity information.  For full description, see
+	  the IDENTIFY DEVICE and IDENTIFY PACKET DEVICE commands in
+	  the ATA specification.
+
+	error returns:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  ENOMSG	IDENTIFY DEVICE information not available
+
+	notes:
+
+	  Returns information that was obtained when the drive was
+	  probed.  Some of this information is subject to change, and
+	  this ioctl does not re-probe the drive to update the
+	  information.
+
+	  This information is also available from /proc/ide/hdX/identify
+
+
+
+HDIO_GET_KEEPSETTINGS		get keep-settings-on-reset flag
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_KEEPSETTINGS, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current "keep settings" flag
+
+	notes:
+
+	  When set, indicates that kernel should restore settings
+	  after a drive reset.
+
+
+
+HDIO_SET_KEEPSETTINGS		keep ioctl settings on reset
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_SET_KEEPSETTINGS, val);
+
+	inputs:
+	  New value for keep_settings flag
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 1]
+	  EBUSY		Controller busy
+
+
+
+HDIO_GET_32BIT			get current io_32bit setting
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_32BIT, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current io_32bit setting
+
+	notes:
+
+	  0=16-bit, 1=32-bit, 2,3 = 32bit+sync
+
+
+
+HDIO_GET_NOWERR			get ignore-write-error flag
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_NOWERR, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current ignore-write-error flag
+
+
+
+HDIO_GET_DMA			get use-dma flag
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_DMA, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current use-dma flag
+
+
+
+HDIO_GET_NICE			get nice flags
+
+	usage:
+
+	  long nice;
+	  ioctl(fd, HDIO_GET_NICE, &nice);
+
+	inputs:		none
+
+	outputs:
+
+	  The drive's "nice" values.
+
+	notes:
+
+	  Per-drive flags which determine when the system will give more
+	  bandwidth to other devices sharing the same IDE bus.
+	  See <linux/hdreg.h>, near symbol IDE_NICE_DSC_OVERLAP.
+
+
+
+
+HDIO_SET_NICE			set nice flags
+
+	usage:
+
+	  int nice;
+	  ...
+	  ioctl(fd, HDIO_SET_NICE, nice);
+
+	inputs:
+	  args[0]	io address to probe
+	  args[1]	control address to probe
+	  args[2]	irq number
+
+	outputs:	none
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EPERM		Flags other than DSC_OVERLAP and NICE_1 set.
+	  EPERM		DSC_OVERLAP specified but not supported by drive
+
+	notes:
+
+	  This ioctl sets the DSC_OVERLAP and NICE_1 flags from values
+	  provided by the user.
+
+
+
+
+
+HDIO_GET_WCACHE			get write cache mode on|off
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_WCACHE, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current write cache mode
+
+
+
+HDIO_GET_ACOUSTIC		get acoustic value
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_ACOUSTIC, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current acoustic settings
+
+	notes:
+
+	  See HDIO_SET_ACOUSTIC
+
+
+
+HDIO_GET_ADDRESS       
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_GET_ADDRESS, &val);
+
+	inputs:		none
+
+	outputs:
+	  The value of the current addressing mode:
+	    0 = 28-bit
+	    1 = 48-bit
+	    2 = 48-bit doing 28-bit
+	    3 = 64-bit
+
+
+
+HDIO_GET_BUSSTATE		get the bus state of the hwif
+
+	usage:
+
+	  long state;
+	  ioctl(fd, HDIO_SCAN_HWIF, &state);
+
+	inputs:		none
+
+	outputs:
+	  Current power state of the IDE bus.  One of BUSSTATE_OFF,
+	  BUSSTATE_ON, or BUSSTATE_TRISTATE
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+
+
+
+
+HDIO_SET_BUSSTATE		set the bus state of the hwif
+
+	usage:
+
+	  int state;
+	  ...
+	  ioctl(fd, HDIO_SCAN_HWIF, state);
+
+	inputs:
+	  Desired IDE power state.  One of BUSSTATE_OFF, BUSSTATE_ON,
+	  or BUSSTATE_TRISTATE
+
+	outputs:	none
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  EOPNOTSUPP	Hardware interface does not support bus power control
+
+
+
+
+HDIO_TRISTATE_HWIF		execute a channel tristate
+
+	Not implemented, as of 2.6.8.1.  See HDIO_SET_BUSSTATE
+
+
+
+HDIO_DRIVE_RESET		execute a device reset
+
+	usage:
+
+	  int args[3]
+	  ...
+	  ioctl(fd, HDIO_DRIVE_RESET, args);
+
+	inputs:		none
+
+	outputs:	none
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+
+	notes:
+
+	  Aborts any current command, prevent anything else from being
+	  queued, execute a reset on the device, and issue BLKRRPART
+	  ioctl on the block device.
+
+	  Executes an ATAPI soft reset if applicable, otherwise
+	  executes an ATA soft reset on the controller.
+
+
+
+HDIO_DRIVE_TASKFILE		execute raw taskfile
+
+	Note:  If you don't have a copy of the ANSI ATA specification
+	handy, you should probably ignore this ioctl.
+
+	usage:
+
+	  struct {
+	    ide_task_request_t req_task;
+	    u8 outbuf[OUTPUT_SIZE];
+	    u8 inbuf[INPUT_SIZE];
+	  } task;
+	  memset(&task.req_task, 0, sizeof(task.req_task));
+	  task.req_task.out_size = sizeof(task.outbuf);
+	  task.req_task.in_size = sizeof(task.inbuf);
+	  ...
+	  ioctl(fd, HDIO_DRIVE_TASKFILE, &task);
+	  ...
+
+	inputs:
+
+	  (See below for details on memory area passed to ioctl.)
+
+	  io_ports[]	values to be written to taskfile registers
+	  hob_ports[]	values to be written to taskfile registers
+	  out_flags	flags indicating which registers are valid
+	  in_flags	flags indicating which registers should be returned
+	  data_phase	see below
+	  req_cmd	command type to be executed
+	  out_size	size of output buffer
+	  outbuf	buffer of data to be transmitted to disk
+	  inbuf		buffer of data to be received from disk
+
+	outputs:
+
+	  io_ports[]	values returned in the taskfile registers
+	  hob_ports[]	values returned in the taskfile registers
+	  out_flags	flags indicating which registers are valid
+	  in_flags	flags indicating which registers should be returned
+	  outbuf	buffer of data to be transmitted to disk
+	  inbuf		buffer of data to be received from disk
+
+	error returns:
+	  EACCES	CAP_SYS_ADMIN or CAP_SYS_RAWIO privelege not set.
+	  ENOMSG	Device is not a disk drive.
+	  ENOMEM	Unable to allocate memory for task
+	  EFAULT	req_cmd == TASKFILE_IN_OUT (not implemented as of 2.6.8)
+	  EPERM		req_cmd == TASKFILE_MULTI_OUT and drive
+	  		multi-count not yet set.
+
+
+	notes:
+
+	  Execute an ATA disk command directly by writing the "taskfile"
+	  registers of the drive.  Requires ADMIN and RAWIO access
+	  privileges.
+
+	  Extreme caution should be used with using this ioctl.  A
+	  mistake can easily corrupt data or hang the system.
+
+	  The argument to the ioctl is a pointer to a region of memory
+	  containing a ide_task_request_t structure, followed by an
+	  optional buffer of data to be transmitted to the drive,
+	  followed by an optional buffer to receive data from the drive.
+
+	  Command is passed to the disk drive via the ide_task_request_t
+	  structure, which contains these fields:
+
+	    io_ports[8]		values for the taskfile registers
+	    hob_ports[8]	high-order bytes, for extended commands
+	    out_flags		flags indicating which entries in the
+	    			io_ports[] and hob_ports[] arrays
+				contain valid values.
+	    in_flags		flags indicating which entries in the
+	    			io_ports[] and hob_ports[] arrays
+				are expected to contain valid values
+				on return.
+	    data_phase		See below
+	    req_cmd		Command type, see below
+	    out_size		output (user->drive) buffer size, bytes
+	    in_size		input (drive->user) buffer size, bytes
+
+	  Unused fields of io_ports[] and hob_ports[] should be set to
+	  zero.
+
+	  The data_phase field describes the data transfer to be
+	  performed.  Value is one of:
+
+	    TASKFILE_IN
+	    TASKFILE_MULTI_IN
+	    TASKFILE_OUT
+	    TASKFILE_MULTI_OUT
+	    TASKFILE_IN_OUT
+	    TASKFILE_IN_DMA
+	    TASKFILE_IN_DMAQ
+	    TASKFILE_OUT_DMA
+	    TASKFILE_OUT_DMAQ
+	    TASKFILE_P_IN
+	    TASKFILE_P_IN_DMA
+	    TASKFILE_P_IN_DMAQ
+	    TASKFILE_P_OUT
+	    TASKFILE_P_OUT_DMA
+	    TASKFILE_P_OUT_DMAQ
+
+	  The req_cmd field classifies the command type.  It may be
+	  one of:
+
+	    IDE_DRIVE_TASK_NO_DATA
+	    IDE_DRIVE_TASK_SET_XFER
+	    IDE_DRIVE_TASK_IN
+	    IDE_DRIVE_TASK_OUT
+	    IDE_DRIVE_TASK_RAW_WRITE
+
+	  Currently (2.6.8), both the input and output buffers are
+	  copied from the user and written back to the user, even when
+	  not used.
+
+
+
+
+
+
+HDIO_DRIVE_CMD			execute a special drive command
+
+	Note:  If you don't have a copy of the ANSI ATA specification
+	handy, you should probably ignore this ioctl.
+
+	usage:
+
+	  u8 args[4+XFER_SIZE];
+	  ...
+	  ioctl(fd, HDIO_DRIVE_CMD, args);
+
+	inputs:
+
+	  Taskfile register values:
+	    args[0]	COMMAND
+	    args[1]	SECTOR
+	    args[2]	FEATURE
+	    args[3]	NSECTOR
+
+	outputs:
+
+	  args[] buffer is filled with register values followed by any
+	  data returned by the disk.
+	    args[0]	status
+	    args[1]	error
+	    args[2]	NSECTOR
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  ENOMEM	Unable to allocate memory for task
+
+
+
+
+HDIO_DRIVE_TASK			execute task and special drive command
+
+	Note:  If you don't have a copy of the ANSI ATA specification
+	handy, you should probably ignore this ioctl.
+
+	usage:
+
+	  u8 args[7];
+	  ...
+	  ioctl(fd, HDIO_DRIVE_TASK, args);
+
+	inputs:
+
+	  Taskfile register values:
+	    args[0]	COMMAND
+	    args[1]	FEATURE
+	    args[2]	NSECTOR
+	    args[3]	SECTOR
+	    args[4]	LCYL
+	    args[5]	HCYL
+	    args[6]	SELECT
+
+	outputs:
+
+	  Taskfile register values:
+	    args[0]	status
+	    args[1]	error
+	    args[2]	NSECTOR
+	    args[3]	SECTOR
+	    args[4]	LCYL
+	    args[5]	HCYL
+	    args[6]	SELECT
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  ENOMEM	Unable to allocate memory for task
+
+
+
+
+HDIO_DRIVE_CMD_AEB		HDIO_DRIVE_TASK
+
+	Not implemented, as of 2.6.8.1
+
+
+
+HDIO_SET_32BIT			change io_32bit flags
+
+	usage:
+
+	  int val;
+	  ioctl(fd, HDIO_SET_32BIT, val);
+
+	inputs:
+	  New value for io_32bit flag
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 3]
+	  EBUSY		Controller busy
+
+
+
+
+HDIO_SET_NOWERR			change ignore-write-error flag
+
+	usage:
+
+	  int val;
+	  ioctl(fd, HDIO_SET_NOWERR, val);
+
+	inputs:
+	  New value for ignore-write-error flag.  Used for ignoring
+	  WRERR_STAT
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 1]
+	  EBUSY		Controller busy
+
+
+
+HDIO_SET_DMA			change use-dma flag
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_SET_DMA, val);
+
+	inputs:
+	  New value for use-dma flag
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 1]
+	  EBUSY		Controller busy
+
+
+
+HDIO_SET_PIO_MODE		reconfig interface to new speed
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_SET_PIO_MODE, val);
+
+	inputs:
+	  New interface speed.
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 255]
+	  EBUSY		Controller busy
+
+
+
+HDIO_SCAN_HWIF			register and (re)scan interface
+
+	usage:
+
+	  int args[3]
+	  ...
+	  ioctl(fd, HDIO_SCAN_HWIF, args);
+
+	inputs:
+	  args[0]	io address to probe
+	  args[1]	control address to probe
+	  args[2]	irq number
+
+	outputs:	none
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  EIO		Probe failed.
+
+	notes:
+
+	  This ioctl initializes the addresses and irq for a disk
+	  controller, probes for drives, and creates /proc/ide
+	  interfaces as appropiate.
+
+
+
+HDIO_UNREGISTER_HWIF		unregister interface
+
+	usage:
+
+	  int index;
+	  ioctl(fd, HDIO_UNREGISTER_HWIF, index);
+
+	inputs:
+	  index		index of hardware interface to unregister
+
+	outputs:	none
+
+	error returns:
+	  EACCES	Access denied:  requires CAP_SYS_RAWIO
+
+	notes:
+
+	  This ioctl removes a hardware interface from the kernel.
+
+	  Currently (2.6.8) this ioctl silently fails if any drive on
+	  the interface is busy.
+
+
+
+HDIO_SET_WCACHE			change write cache enable-disable
+
+	usage:
+
+	  int val;
+	  ioctl(fd, HDIO_SET_WCACHE, val);
+
+	inputs:
+	  New value for write cache enable
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 1]
+	  EBUSY		Controller busy
+
+
+
+HDIO_SET_ACOUSTIC		change acoustic behavior
+
+	usage:
+
+	  int val;
+	  ioctl(fd, HDIO_SET_ACOUSTIC, val);
+
+	inputs:
+	  New value for drive acoustic settings
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 254]
+	  EBUSY		Controller busy
+
+
+
+HDIO_SET_QDMA			change use-qdma flag
+
+	Not implemented, as of 2.6.8.1
+
+
+
+HDIO_SET_ADDRESS		change lba addressing modes
+
+	usage:
+
+	  int val;
+	  ioctl(fd, HDIO_SET_ADDRESS, val);
+
+	inputs:
+	  New value for addressing mode
+	    0 = 28-bit
+	    1 = 48-bit
+	    2 = 48-bit doing 28-bit
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 2]
+	  EBUSY		Controller busy
+	  EIO		Drive does not support lba48 mode.
+
+
+HDIO_SET_IDE_SCSI
+
+	usage:
+
+	  long val;
+	  ioctl(fd, HDIO_SET_IDE_SCSI, val);
+
+	inputs:
+	  New value for scsi emulation mode (?)
+
+	outputs:	none
+
+	error return:
+	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  EINVAL	value out of range [0 1]
+	  EBUSY		Controller busy
+
+
+
+HDIO_SET_SCSI_IDE
+
+	Not implemented, as of 2.6.8.1
+
+

--------------070905090208090703050603--
