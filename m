Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTAJJrT>; Fri, 10 Jan 2003 04:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTAJJrT>; Fri, 10 Jan 2003 04:47:19 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:63886 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S264822AbTAJJrR>; Fri, 10 Jan 2003 04:47:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Francis Verscheure <fverscheure@wanadoo.fr>
Reply-To: fverscheure@wanadoo.fr
Organization: =?iso8859-15?q?Ing=E9nieur?= Conseil
To: linux-kernel@vger.kernel.org
Subject: Problem in IDE Disks cache handling in kernel 2.4.XX
Date: Fri, 10 Jan 2003 10:54:53 +0100
X-Mailer: KMail [version 1.3.2]
Cc: marcelo@conectiva.com.br
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030110095558.E144CFF11@postfix4-1.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello to everybody  and a Happy New Year.
Thanks a lot for all the great job you are all doing.

Having EXT2 file system corruption after suspend on a notebook I investigate 
kernel code and it seems to me that IDE Disk cache handling is wrong in 
kernel 2.4.XX.

Sources extracts are from kernel 2.4.20.

If you look at  struct hd_driveid  in hdreg.h you will find :

unsigned short  command_set_1;	/* (word 82) supported
	 *  6:	look-ahead
	 *  5:	write cache			==== this means the Disk has a disk cache =====

unsigned short  command_set_2;	/* (word 83)
	 * 13:	FLUSH CACHE EXT		==== Those fields were RESERVED in ATA/ATAPI 5 
	 * 12:	FLUSH CACHE			==== and are used ONLY in ATA/ATAPI 6 ====
	 * 10:	48-bit Address Feature Set

unsigned short  cfs_enable_1;	/* (word 85)
	 *  6:	look-ahead
	 *  5:	write cache			==== this means the Disk cache is enabled or disabled
					 */
unsigned short  cfs_enable_2;	/* (word 86)
	 * 13:	FLUSH CACHE EXT		==== Those fields were RESERVED in ATA/ATAPI 5
	 * 12:	FLUSH CACHE			==== and are used ONLY in ATA/ATAPI 6 ====
	 * 10:	48-bit Address Feature Set

In ide-disk.c you have

static int write_cache (ide_drive_t *drive, int arg)
{
	struct hd_drive_task_hdr taskfile;
	struct hd_drive_hob_hdr hobfile;
	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
	taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
	taskfile.command	= WIN_SETFEATURES;

	if (!(drive->id->cfs_enable_2 & 0x3000))	<==== WRONG ! ONLY FOR ATA/ATAPI 6
		return 1;

	(void) ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
	drive->wcache = arg;
	return 0;
}


In fact for ATA/ATAPI 5 cfs_enable_2  has no meaning.  The fields to test are 
write cache bits in command_set_1 and cfs_enable_1.
And in both cases the FLUSH CACHE command ALWAYS EXISTS !
The test of cfs_enable_2 must only be used for ATA/ATAPI 6 drives to use 
FLUSH CACHE or FLUSH CACHE EXT in case of 48 bit addressing mode.

And it seems to me that when an IDE drive has a cache enabled wcache must be 
initialized to say so ? Or you have to do a STANDY or SLEEP before APM 
suspend or power off to be sure that the cache has been written to the disk.

I had a look at patch 2.4.21pre3 and the code looks the same.

And by the way how are powered off the IDE drives ?
Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before powering off the 
drive with cache enabled or you will enjoy lost data.

I am not on the list so thank you to CC me.

Best regards to all.

Francis Verscheure

