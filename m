Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWCTVn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWCTVn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWCTVn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:43:28 -0500
Received: from xenotime.net ([66.160.160.81]:28639 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964988AbWCTVn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:43:27 -0500
Date: Mon, 20 Mar 2006 13:45:33 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: dreiners@iastate.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
Message-Id: <20060320134533.febb0155.rdunlap@xenotime.net>
In-Reply-To: <1142890822.5007.18.camel@localhost.localdomain>
References: <1142890822.5007.18.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 15:40:22 -0600 Dirk Reiners wrote:

> 
> 	Hi everybody,
> 
> while trying to back up a couple Linux directories to a FAT disk I ran
> into a weird situation: I can't create a file called aux.h on the FAT
> system! 
> 
> Here's how to reproduce it:
> 
> cd /tmp
> dd if=/dev/zero of=vfat_img bs=1M count=1
> /sbin/losetup /dev/loop7 vfat_img
> /sbin/mkfs.vfat /dev/loop7
> mkdir vfat_mnt
> mount -t vfat /dev/loop7 vfat_mnt
> touch vfat_mnt/auy.h
> touch vfat_mnt/aux.h
> 
> auy.h is happily created, aux.h gives "touch: setting times of
> `vfat_mnt/aux.h': No such file or directory", and no file is created.
> This happened to me on the system described below, but I could reproduce
> the same behavior on a system booted from RHEL4 CDs, an old Knoppix
> (3.4), and friends could reproduce it on other systems, too, so it
> doesn't seem to be very related to a specific version.
> 
> As a workaround I tar/bzipped my dirs, but that behavior seems very
> unusual and doesn't inspire a lot of confidence in vfat... What am I
> missing here?

"AUX" is (was) a reserved "filename" in DOS.  The Linux MS-DOS
filesystem preserves (protects) that.  The extension part does not
matter; it only checks the first 8 characters of the filename.
You'll need to use a different filesystem or filename...


fs/msdos/namei.c:

		for (reserved = reserved_names; *reserved; reserved++)
			if (!strncmp(res, *reserved, 8))
				return -EINVAL;

/* MS-DOS "device special files" */
static const unsigned char *reserved_names[] = {
	"CON     ", "PRN     ", "NUL     ", "AUX     ",
	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
	NULL
};


---
~Randy
