Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130192AbQLIKXI>; Sat, 9 Dec 2000 05:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130387AbQLIKXB>; Sat, 9 Dec 2000 05:23:01 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:56336 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S130192AbQLIKWn>;
	Sat, 9 Dec 2000 05:22:43 -0500
Date: Sat, 9 Dec 2000 11:50:59 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Big IDE HD unclipping and IBM drive [solved]
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>
Message-ID: <Pine.LNX.4.21_heb2.09.0012091138590.631-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, thanks to Andries Brouwer, who pointed me to IBM's dtla_spw.pdf, I
solved the problem:

The kernel (2.2.18-pre25 + ide.2.2.18-24.all.20001204.patch.bz2) already 
has support for unclipping. The problem is that the IBM drive does not
work with the method used when clipped with the jumper. The solution is
to use software clipping. IBM suggest to do that with their program that
requires windows, 1.44 floppy drive and a BIOS that can boot with the
drive. All three are unavailable for me.

Instead, I use the attached program, which is a modification of setmax,
to clip the drive. This requires only a working linux system where an
extra IDE drive can be attached. I attached the drive to such a system,
and ran ./ibmsetmax -m 66055248 (32GB). From then on, the drive is
clipped, so award bios can boot with it, but it returns the correct
value to READ_NATIVE_MAX, so the kernel unclipping procedure works.

Thanks to Andries and Andre for their help, and I hope this helps others
who want to use large disks with old bios.


-- 
Matan Ziv-Av.                         matan@svgalib.org

/* ibmsetmax.c - */
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
        args[2] = 1; /* non-volatile */
	fromlba(args, delta-1);
	args[6] |= LBA;

	if (ioctl(fd, HDIO_DRIVE_CMD_AEB, &args)) {
		perror("HDIO_DRIVE_CMD_AEB failed SET_MAX");
		for (i=0; i<7; i++)
			printf("%d = 0x%x\n", args[i], args[i]);
		exit(1);
	}
}

static char short_opts[] = "m:";
static const struct option long_opts[] = {
	{ "max",	required_argument,	NULL,	'd' },
        { NULL, 0, NULL, 0 }
};

static char *usage_txt =
"Call: ibmsetmax [-m D] DEVICE\n"
"\n"
"The call  \"ibmsetmax -m D DEVICE\"  will do a SET_MAX command\n"
"to set the non-volatile maximum accessible sector number D sectors.\n"
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
		case 'm':
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
