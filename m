Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSRyy>; Sun, 19 Nov 2000 12:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQKSRyp>; Sun, 19 Nov 2000 12:54:45 -0500
Received: from hera.cwi.nl ([192.16.191.1]:63431 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129136AbQKSRye>;
	Sun, 19 Nov 2000 12:54:34 -0500
Date: Sun, 19 Nov 2000 18:24:31 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Taisuke Yamada <tai@imasy.or.jp>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old BIOS
Message-ID: <20001119182431.A1226@veritas.com>
In-Reply-To: <200011181930.eAIJUYA01883@research.imasy.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011181930.eAIJUYA01883@research.imasy.or.jp>; from tai@imasy.or.jp on Sun, Nov 19, 2000 at 04:30:34AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 04:30:34AM +0900, Taisuke Yamada wrote:

> Earlier this month, I had sent in a patch to 2.2.18pre17 (with
> IDE-patch from http://www.linux-ide.org/ applied) to add support
> for IDE disk larger than 32GB, even if the disk required "clipping"
> to reduce apparent disk size due to BIOS limitation.
> 
> BIOS known to have this limitation is Award 4.51 (and before) and
> it seems many mainboards with not-so-great vendor support still use it.
> 
> Now I'm moving to 2.4-based system, and so ported the patch to
> 2.4-test10. It also applies cleanly to 2.4-test11.
> 
> With this patch, you will be able to use disk capacity above
> 32GB (or 2GB/8GB depending on how clipping take effect), and
> still be able to boot off from the disk because you can leave
> the "clipping" turned on.

Hi Taisuke,

I suppose you know that no kernel patch is required
(since setmax.c does the same from user space).
Did you try setmax?
I would like to see the results - am still in the information
gathering stage - I have two largish Maxtor disks myself, one
40 GB and one 60 GB, and their behaviour is different, so
to me it seems a bit too early to come with kernel patches.

I think I already sent you setmax.c, but in case my memory
is confused let me include it here again. This is for 2.4.

Andries

-----
/* setmax.c - aeb, 000326 */
#include <stdio.h>
#include <fcntl.h>
#include <getopt.h>
#include <linux/hdreg.h>

#ifndef HDIO_DRIVE_CMD_AEB
#define HDIO_DRIVE_CMD_AEB	0x031e
#endif

#define INITIALIZE_DRIVE_PARAMETERS 0x91
#define READ_NATIVE_MAX_ADDRESS 0xf8
#define CHECK_POWER_MODE	0xe5
#define SET_MAX			0xf9

#define LBA	0x40
#define VV	1		/* if set in sectorct then NOT volatile */

struct idecmdin {
	unsigned char cmd;
	unsigned char feature;
	unsigned char nsect;
	unsigned char sect, lcyl, hcyl;
	unsigned char select;
};

struct idecmdout {
	unsigned char status;
	unsigned char error;
	unsigned char nsect;
	unsigned char sect, lcyl, hcyl;
	unsigned char select;
};

unsigned int
tolba(unsigned char *args) {
	return ((args[6] & 0xf) << 24) + (args[5] << 16) + (args[4] << 8) + args[3];
}

void
fromlba(unsigned char *args, unsigned int lba) {
	args[3] = (lba & 0xff);
	lba >>= 8;
	args[4] = (lba & 0xff);
	lba >>= 8;
	args[5] = (lba & 0xff);
	lba >>= 8;
	args[6] = (args[6] & 0xf0) | (lba & 0xf);
}

int
get_identity(int fd) {
	unsigned char args[4+512] = {WIN_IDENTIFY,0,0,1,};
	struct hd_driveid *id = (struct hd_driveid *)&args[4];

	if (ioctl(fd, HDIO_DRIVE_CMD, &args)) {
		perror("HDIO_DRIVE_CMD");
		fprintf(stderr,
			"WIN_IDENTIFY failed - trying WIN_PIDENTIFY\n");
		args[0] = WIN_PIDENTIFY;
		if (ioctl(fd, HDIO_DRIVE_CMD, &args)) {
			perror("HDIO_DRIVE_CMD");
			fprintf(stderr,
			       "WIN_PIDENTIFY also failed - giving up\n");
			exit(1);
		}
	}

	printf("lba capacity: %d sectors (%lld bytes)\n",
	       id->lba_capacity,
	       (long long) id->lba_capacity * 512);
}

/*
 * result: in LBA mode precisely what is expected
 *         in CHS mode the correct H and S, and C mod 65536.
 */
unsigned int
get_native_max(int fd, int slave) {
	unsigned char args[7];
	int i, max;

	for (i=0; i<7; i++)
		args[i] = 0;
	args[0] = READ_NATIVE_MAX_ADDRESS;
	args[6] = (slave ? 0x10 : 0) | LBA;
	if (ioctl(fd, HDIO_DRIVE_CMD_AEB, &args)) {
		perror("HDIO_DRIVE_CMD_AEB failed READ_NATIVE_MAX_ADDRESS");
		for (i=0; i<7; i++)
			printf("%d = 0x%x\n", args[i], args[i]);
		exit(1);
	}
	return tolba(args);
}

/*
 * SET_MAX_ADDRESS requires immediately preceding READ_NATIVE_MAX_ADDRESS
 *
 * Results: this fails for delta <= 254, succeeds for delta >= 255.
 * So, in order to get the last 255*512=130560 bytes back one has to reboot.
 * Side effect: reset to CurCHS=16383/16/63, CurSects=16514064.
 */
void
set_max_address(int fd, int slave, int delta) {
	unsigned char args[7];
	int i, nativemax;

	nativemax = get_native_max(fd, slave);
	printf("nativemax=%d (0x%x)\n", nativemax, nativemax);

	for (i=0; i<7; i++)
		args[i] = 0;
	args[0] = SET_MAX;
	args[1] = 0;
	fromlba(args, nativemax-delta);
	args[6] |= LBA;

	if (ioctl(fd, HDIO_DRIVE_CMD_AEB, &args)) {
		perror("HDIO_DRIVE_CMD_AEB failed SET_MAX");
		for (i=0; i<7; i++)
			printf("%d = 0x%x\n", args[i], args[i]);
		exit(1);
	}
}

static char short_opts[] = "d:";
static const struct option long_opts[] = {
	{ "delta",	required_argument,	NULL,	'd' },
        { NULL, 0, NULL, 0 }
};

static char *usage_txt =
"Call: setmax [-d D] DEVICE\n"
"\n"
"The call  \"setmax --delta D DEVICE\"  will do a SET_MAX command\n"
"to set the maximum accessible sector number D sectors\n"
"below end-of-disk.\n"
"\n"
"The call  \"setmax DEVICE\"  will do a READ_NATIVE_MAX_ADDRESS\n"
"command, and report the maximum accessible sector number.\n"
"\n"
"This is IDE-only. Probably DEVICE is /dev/hdx for some x.\n\n";

main(int argc, char **argv){
	int fd, c;
	int delta;

	/* If you modify device, also update slave, if necessary. */
	/* master: hda, hdc, hde; slave: hdb, hdd, hdf */
	char *device = NULL;	/* e.g. "/dev/hda" */
	int slave = 0;

	delta = -1;
	while ((c = getopt_long (argc, argv, short_opts, long_opts, NULL)) != -1) {
		switch(c) {
		case 'd':
			delta = atoi(optarg);
			break;
		case '?':
		default:
			fprintf(stderr, "unknown option\n");
			fprintf(stderr, usage_txt);
			exit(1);
		}
	}

	if (optind < argc)
		device = argv[optind];
	if (!device) {
		fprintf(stderr, "no device specified - "
			"use e.g. \"setmax /dev/hdb\"\n");
		fprintf(stderr, usage_txt);
		exit(1);
	}
	printf("Using device %s\n", device);

	fd = open(device, O_RDONLY);
	if (fd == -1) {
		perror("open");
		exit(1);
	}

	if (delta != -1) {
		printf("setting delta=%d\n", delta);
		set_max_address(fd, slave, delta);
	} else {
		int mad = get_native_max(fd, slave);
		long long bytes = (long long) (mad+1) * 512;
		int hMB = (bytes+50000000)/100000000;

		printf("native max address: %d\n", mad);
		printf("that is %lld bytes, %d.%d GB\n",
		       bytes, hMB/10, hMB%10);
	}
	get_identity(fd);

	return 0;
}

/* READ_NATIVE_MAX_ADDRESS:
 Inputs:
	features, sectorct, sectornr, cyllow, cylhi: NA
	device/head: 8 bits: obs LBA obs DEV na na na na
	command: F8
 Outputs:
 	error: 8 bits: na na na na na ABRT na na
 	sectorct: NA
	sectornr, cyllo, cylhi: native max address
	device/head: 8 bits: obs na obs DEV; 4bits native max address
	status: BSY DRDY DF na DRQ na na ERR  [010x0xx0]

SET_MAX_ADDRESS (obsolete?):
 Error: ABRT=4: command not supported, max requested exceeds
 	device capacity, CYL > 16383, command not preceded by
	READ_NATIVE_MAX_ADDRESS.
	Also error if the device is in Set_Max_Locked or Set_Max_Frozen state.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
