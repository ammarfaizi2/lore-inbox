Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291000AbSBLM3O>; Tue, 12 Feb 2002 07:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291005AbSBLM2z>; Tue, 12 Feb 2002 07:28:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:21257 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291000AbSBLM2u>; Tue, 12 Feb 2002 07:28:50 -0500
Date: Tue, 12 Feb 2002 13:28:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020212132846.A7966@suse.cz>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C68F3F3.8030709@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Feb 12, 2002 at 11:52:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2002 at 11:52:35AM +0100, Martin Dalecki wrote:

> >This is slightly longer but also simple cleanup. It kills code
> >duplication and removes unneccessary assignments/casts. Please apply,

> If you are already at it, I would like to ask to you consider seriously 
> the removal of the
> following entries in the ide drivers /proc control files:
> 
>     ide_add_setting(drive,    "breada_readahead",    ...         1,    
> 2,    &read_ahead[major],        NULL);
>     ide_add_setting(drive,    "file_readahead",   ...    
> &max_readahead[major][minor],    NULL);
> 
> Those calls can be found in ide-cd.c, ide-disk,c and ide-floppy.c
> 
> The first does control an array of values, which doesn't make sense in 
> first place. I.e. changing it doesn't
> change ANY behaviour of the kernel.

Actually HFS uses it ...

> The second of them is trying to control a file-system level constant
> inside the actual block device driver. This is a blatant violation of
> the layering principle in software design, and should go as soon as
> possible.

Yes. But still block device drivers allocate the array ...

Patch attached.

-- 
Vojtech Pavlik
SuSE Labs

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-clean-readahead.diff"

diff -urN linux-2.5.4/drivers/ide/ide-cd.c linux-2.5.4-ideclean/drivers/ide/ide-cd.c
--- linux-2.5.4/drivers/ide/ide-cd.c	Thu Jan 31 16:45:20 2002
+++ linux-2.5.4-ideclean/drivers/ide/ide-cd.c	Tue Feb 12 12:34:48 2002
@@ -2662,8 +2662,6 @@
 	int major = HWIF(drive)->major;
 	int minor = drive->select.b.unit << PARTN_BITS;
 
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW, BLKRAGET, BLKRASET, TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW, BLKFRAGET, BLKFRASET, TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
 }
 
diff -urN linux-2.5.4/drivers/ide/ide-disk.c linux-2.5.4-ideclean/drivers/ide/ide-disk.c
--- linux-2.5.4/drivers/ide/ide-disk.c	Tue Feb 12 12:22:53 2002
+++ linux-2.5.4-ideclean/drivers/ide/ide-disk.c	Tue Feb 12 12:34:09 2002
@@ -916,8 +916,6 @@
 	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	1,	&read_ahead[major],		NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	4096,			PAGE_SIZE,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
 	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
diff -urN linux-2.5.4/drivers/ide/ide-floppy.c linux-2.5.4-ideclean/drivers/ide/ide-floppy.c
--- linux-2.5.4/drivers/ide/ide-floppy.c	Thu Jan 31 16:45:20 2002
+++ linux-2.5.4-ideclean/drivers/ide/ide-floppy.c	Tue Feb 12 12:34:15 2002
@@ -1968,8 +1968,6 @@
 	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 
 }
 

--3V7upXqbjpZ4EhLz--
