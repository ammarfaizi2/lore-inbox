Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWBJIB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWBJIB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWBJIB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:01:26 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:50139 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751179AbWBJIBZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:01:25 -0500
From: Luke-Jr <luke@dashjr.org>
To: linux-kernel@vger.kernel.org
Subject: Firmware Flashing (Was: CD writing in future Linux (stirring up a hornets' nest))
Date: Fri, 10 Feb 2006 08:01:20 +0000
User-Agent: KMail/1.9
Cc: Zoltan Boszormenyi <zboszor@freemail.hu>
References: <43EB7E28.2030208@freemail.hu>
In-Reply-To: <43EB7E28.2030208@freemail.hu>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602100801.23404.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 17:38, Zoltan Boszormenyi wrote:
> For those who don't know, there even exists a firmware updater for Pioneer
> DVD+-RW drives that work on Linux with /dev entries, on a live system,
> without the need for a reboot... http://lasvegas.rpc1.org/
> Look, Jörg, they don't need HOST/TARGET/LUN triplets for this task!

On the topic of firmware updating, I also have a project for a 
firmware-flashing API that supports both BTC and BenQ DVD burners (in theory, 
anyway-- it's 100% untested at this point). It uses libscg (indirectly, 
though calls to fwscsi_*) to access the devices, but uses regular old /dev 
device names (or the SCSI number things). If anyone wants a snapshot (or CVS 
access, to contribute), let me know and I'll post it in my public_html...

Current plugins:
	Image formats: CVT, Intel HEX, and BenQ EXE
	User interfaces: 'fwflash' (commandline)
	Devices:
		DVD+-RW: BTC and BenQ

Build output:
	lib/libfwflash.so
	lib/libfwflashscsi.so
	lib/fwflash/device/dvdrw_benq.so
	lib/fwflash/device/dvdrw_btc.so
	lib/fwflash/imgfmt/benq_exe.so
	lib/fwflash/imgfmt/cvt.so
	lib/fwflash/imgfmt/intel_hex.so
	bin/fwflash

Current API (unstable):
--- core.h ---
extern const char * fwflash_get_error ();
extern void fwflash_error (const char *fmt, ...);
extern void fwflash_warn (const char *fmt, ...);
extern void fwflash_checksum (const unsigned char *data, size_t size, const 
char **wanted, void *output);
extern void fwflash_checksum_one (const unsigned char *data, size_t size, 
const char *wanted, void *output);
extern int fwflash_flash (hdevice, himage);
extern hdevice fwflash_device_open (const char *);
extern const char * fwflash_device_name (hdevice);
extern const char * fwflash_device_id (hdevice);
extern const char * fwflash_device_protocol_name (hdevice);
extern const char * fwflash_device_firmware_id (hdevice);
extern himage fwflash_image_open (const char *);
extern const char * fwflash_image_name (himage);
extern const char * fwflash_image_format_name (himage);
extern const char * fwflash_image_echksum (himage);
extern const char * fwflash_image_achksum (himage);
extern int fwflash_image_verify_chksum (himage);
extern const char * fwflash_image_firmware_id (himage);
extern const char * fwflash_image_device_id (himage);
extern size_t fwflash_image_data_size (himage);
extern const char * fwflash_image_data (himage);
--- device.h ---
extern const char * fwdevice_protocol_name ();
extern void * fwdevice_load_file (FILE *);
extern void * fwdevice_load_filename (const char *);
extern const char * fwdevice_name (void *);
extern const char * fwdevice_id (void *);
extern const char * fwdevice_firmware_id (void *);
extern int fwdevice_flash_image (void *h, himage img);
--- imgfmt.h ---
extern const char * fwimage_format_name ();
extern void * fwimage_load_file (FILE *);
extern void * fwimage_load_filename (const char *);
extern const char * fwimage_name (void *);
extern const char * fwimage_echksum (void *);
extern const char * fwimage_achksum (void *);
extern int fwimage_verify_chksum (void *);
extern const char * fwimage_firmware_id (void *);
extern const char * fwimage_device_id (void *);
extern size_t fwimage_data_size (void *);
extern const char * fwimage_data (void *);
--- scsi.h ---
extern void * fwscsi_open_filename (const char *fn);
extern void * fwscsi_open_scsidev (int bus, int target, int lun);
extern void fwscsi_cmd_setbyte (void *h, int i, char v);
extern void fwscsi_cmd_setcdb (void *h, char *data, size_t len);
extern int fwscsi_exec_command (void *h, const char *flags, char *buf, int 
bufsize);
