Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWANXBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWANXBc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWANXBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 18:01:31 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:8599 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751510AbWANXBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 18:01:31 -0500
Message-ID: <43C982C0.1070605@cfl.rr.com>
Date: Sat, 14 Jan 2006 18:01:20 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com> <43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com>
In-Reply-To: <m3hd861o2r.fsf@telia.com>
Content-Type: multipart/mixed;
 boundary="------------050400090208080905090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400090208080905090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Osterlund wrote:
  > OK, so it appears you can make packets bigger than 64KB. Can I please
> have those patches so I can test this myself.
> 
> 

Sure, patches attached.

patch-6 is the one you are interested in for the different sizes, but I 
find the other two to be handy as well. patch-7 goes with the previous 
kernel udf patch I originally posted to fix permissions problems, and 
patch-8 adds a single parameter form to pktsetup for it to auto assign 
the new pktcdvd device and print it's minor number, rather than create a 
named devnode.  This is to facilitate hald auto configuring cdrw drives 
for packet writing, and let udev handle the creation of the devnode.

Don't forget to apply the kernel patch so you can actually write to the 
disc when you format it with >64 KB packets.


--------------050400090208080905090302
Content-Type: text/x-patch;
 name="patch-6-nondefault-packet-size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-6-nondefault-packet-size.diff"

This patch fixes several assumptions in cdrwtool about the
packet size being 32 sectors which caused breakage when
the -z option was used to change the packet size.  Also
documented the -z option in the cdrwtool man page.  

 - Phillip Susi <psusi@cfl.rr.com>

diff -ru udftools-1.0.0b3.orig/cdrwtool/cdrwtool.h udftools-1.0.0b3/cdrwtool/cdrwtool.h
--- udftools-1.0.0b3.orig/cdrwtool/cdrwtool.h	2002-11-26 02:18:50.000000000 -0500
+++ udftools-1.0.0b3/cdrwtool/cdrwtool.h	2006-01-03 21:02:25.000000000 -0500
@@ -89,6 +89,7 @@
 	unsigned int	close_track;
 	unsigned int	close_session;
 	struct udf_disc	udf_disc;
+	int fd;
 };
 
 #ifndef be16_to_cpu
diff -ru udftools-1.0.0b3.orig/cdrwtool/defaults.c udftools-1.0.0b3/cdrwtool/defaults.c
diff -ru udftools-1.0.0b3.orig/cdrwtool/main.c udftools-1.0.0b3/cdrwtool/main.c
--- udftools-1.0.0b3.orig/cdrwtool/main.c	2004-02-22 22:33:11.000000000 -0500
+++ udftools-1.0.0b3/cdrwtool/main.c	2006-01-03 21:18:47.000000000 -0500
@@ -41,14 +41,15 @@
 {
 	static char *buffer = NULL;
 	static int bufferlen = 0, lastpacket = -1;
-	int fd = *(int *)disc->write_data;
+	struct cdrw_disc *cdisc = (struct cdrw_disc *)disc->write_data;
+	int fd = cdisc->fd;
 	int offset, packet;
 	struct udf_desc *desc;
 	struct udf_data *data;
 
 	if (buffer == NULL)
 	{
-		bufferlen = disc->blocksize * 32;
+		bufferlen = disc->blocksize * cdisc->packet_size;
 		buffer = calloc(bufferlen, 1);
 	}
 
@@ -56,7 +57,7 @@
 	{
 		if (lastpacket != -1)
 		{
-			if (write_blocks(fd, buffer, lastpacket * 32, 32) < 0)
+			if (write_blocks(fd, buffer, lastpacket * cdisc->packet_size, cdisc->packet_size) < 0)
 				return -1;
 		}
 	}
@@ -65,21 +66,21 @@
 		desc = ext->head;
 		while (desc != NULL)
 		{
-			packet = (uint64_t)(ext->start + desc->offset) / 32;
+			packet = (uint64_t)(ext->start + desc->offset) / cdisc->packet_size;
 			if (lastpacket != -1 && packet != lastpacket)
 			{
-				if (write_blocks(fd, buffer, lastpacket * 32, 32) < 0)
+				if (write_blocks(fd, buffer, lastpacket * cdisc->packet_size, cdisc->packet_size) < 0)
 					return -1;
 				memset(buffer, 0x00, bufferlen);
 			}
 			data = desc->data;
-			offset = ((uint64_t)(ext->start + desc->offset) - (packet * 32)) << disc->blocksize_bits;
+			offset = ((uint64_t)(ext->start + desc->offset) - (packet * cdisc->packet_size)) << disc->blocksize_bits;
 			while (data != NULL)
 			{
 				if (data->length + offset > bufferlen)
 				{
 					memcpy(buffer + offset, data->buffer, bufferlen - offset);
-					if (write_blocks(fd, buffer, packet * 32, 32) < 0)
+					if (write_blocks(fd, buffer, packet * cdisc->packet_size, cdisc->packet_size) < 0)
 						return -1;
 					memset(buffer, 0x00, bufferlen);
 					lastpacket = ++ packet;
@@ -94,9 +95,9 @@
 					offset += data->length;
 				}
 
-				if (offset == disc->blocksize * 32)
+				if (offset == disc->blocksize * cdisc->packet_size)
 				{
-					if (write_blocks(fd, buffer, packet * 32, 32) < 0)
+					if (write_blocks(fd, buffer, packet * cdisc->packet_size, cdisc->packet_size) < 0)
 						return -1;
 					memset(buffer, 0x00, bufferlen);
 					lastpacket = -1;
@@ -248,7 +249,8 @@
 		return fd;
 	}
 	disc.udf_disc.write = write_func;
-	disc.udf_disc.write_data = &fd;
+	disc.fd = fd;
+	disc.udf_disc.write_data = &disc;
 
 	if ((ret = cdrom_open_check(fd)))
 	{
diff -ru udftools-1.0.0b3.orig/debian/changelog udftools-1.0.0b3/debian/changelog
diff -ru udftools-1.0.0b3.orig/doc/cdrwtool.1 udftools-1.0.0b3/doc/cdrwtool.1
--- udftools-1.0.0b3.orig/doc/cdrwtool.1	2002-11-26 02:18:51.000000000 -0500
+++ udftools-1.0.0b3/doc/cdrwtool.1	2006-01-03 21:26:00.000000000 -0500
@@ -127,6 +127,10 @@
 variable and fixed packet sizes respectively.
 .IP "\fB\-o \fIoffset\fP"
 Set write offset.
+.IP "\fB\-z \fIsize\fP"
+Set packet length in sectors ( default = 32 ).  Longer packets allow for
+more usable space on the disc, but may slow down access to smaller files.  
+Switching from 32 to 128 on a 700 MB cdrw gives about 100 MB more usable space.
 
 .SH AUTHORS
 .nf
diff -ru udftools-1.0.0b3.orig/mkudffs/defaults.c udftools-1.0.0b3/mkudffs/defaults.c

--------------050400090208080905090302
Content-Type: text/x-patch;
 name="patch-7-nobody-default.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-7-nobody-default.diff"

This patch changes the default owning uid/gid for files
created by cdrwtool and mkudffs ( basically the root
and lost+found directories ) from 0 to -1.  This allows
the udf filesystem driver to obey the uid/gid mount
options.  When the FSD sees a -1, if the uid/gid mount
options were specified, it replaces the -1 with those
values.  

I also patched the FSD ( not in this patch )
to write a -1 if the owner matches the mount option
(previously it wrote a 0 instead, so files would
spontaniously change ownership when unmounted/mounted
to root if they were owned by the uid specified in
the mount options ).  This allows sane application
of the mount options to allow a non root user, or even
different users, possibly on different machines,  to use
the disc.  

 - Phillip Susi <psusi@cfl.rr.com>

diff -ru udftools-1.0.0b3.orig/cdrwtool/defaults.c udftools-1.0.0b3/cdrwtool/defaults.c
--- udftools-1.0.0b3.orig/cdrwtool/defaults.c	2002-11-26 02:18:50.000000000 -0500
+++ udftools-1.0.0b3/cdrwtool/defaults.c	2006-01-03 23:19:49.000000000 -0500
@@ -443,6 +443,8 @@
 			UDF_OS_ID_LINUX,
 		},
 	},
+	uid : -1,
+	gid : -1,
 };
 
 struct extendedFileEntry default_efe =
@@ -476,4 +478,6 @@
 			UDF_OS_ID_LINUX,
 		},
 	},
+	uid : -1,
+	gid : -1,
 };
diff -ru udftools-1.0.0b3.orig/cdrwtool/main.c udftools-1.0.0b3/cdrwtool/main.c
diff -ru udftools-1.0.0b3.orig/debian/changelog udftools-1.0.0b3/debian/changelog
diff -ru udftools-1.0.0b3.orig/doc/cdrwtool.1 udftools-1.0.0b3/doc/cdrwtool.1
diff -ru udftools-1.0.0b3.orig/mkudffs/defaults.c udftools-1.0.0b3/mkudffs/defaults.c
--- udftools-1.0.0b3.orig/mkudffs/defaults.c	2002-11-26 02:18:51.000000000 -0500
+++ udftools-1.0.0b3/mkudffs/defaults.c	2006-01-03 23:20:11.000000000 -0500
@@ -450,6 +450,8 @@
 			UDF_OS_ID_LINUX,
 		},
 	},
+	uid : -1,
+	gid : -1,
 };
 
 struct extendedFileEntry default_efe =
@@ -483,4 +485,6 @@
 			UDF_OS_ID_LINUX,
 		},
 	},
+	uid : -1,
+	gid : -1,
 };

--------------050400090208080905090302
Content-Type: text/x-patch;
 name="patch-8-pktsetup-plugdev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-8-pktsetup-plugdev.diff"

This patch adds a new single parameter form to pktsetup.  
This new form takes only the name of the cdrom device to
bind to, and will bind the next unused pktcdvd minor
device to it, and print that device number to stdout.  

 - Phillip Susi <psusi@cfl.rr.com>

diff -ru udftools-1.0.0b3.orig/doc/pktsetup.8 udftools-1.0.0b3/doc/pktsetup.8
--- udftools-1.0.0b3.orig/doc/pktsetup.8	2006-01-08 18:08:04.000000000 -0500
+++ udftools-1.0.0b3/doc/pktsetup.8	2006-01-08 18:58:59.000000000 -0500
@@ -37,14 +37,32 @@
 .B pktsetup
 .B \-d
 .I packet_device
+.br
+.B pktsetup
+.I /dev/cdrom
 .ad b
 .SH DESCRIPTION
-.B Pktsetup
+.B \fBpktsetup\fP
 is used to associate packet devices with CD or DVD block devices,
 so that the packet device can then be mounted and potentially
 used as a read/write filesystem. This requires kernel support for
 the packet device, and the UDF filesystem.
 .PP
+To old style to set up a device is:
+.IP
+\fBpktsetup \fI/dev/pktcdvd/pktcdvd0 /dev/cdrom\fP
+.PP
+This usage will create the devnode \fI/dev/pktcdvd/pktcdvd0\fP
+and bind it to \fI/dev/cdrom\fP.  
+.PP
+The new form is:
+.IP
+\fBpktsetup \fI/dev/cdrom\fP
+.PP
+This form will bind the next availible pkcdvd minor device to
+\fI/dev/cdrom\fP and print the device number to stdout.  No device
+node will be created, that job is left up to udev.  
+.PP
 See /usr/share/doc/udftools/README.Debian for more information.
 .UE
 
@@ -55,7 +73,9 @@
 .SH OPTIONS
 .IP "\fB\-d \fIpacket-device\fP"
 Delete the association between the specified \fIpacket-device\fP
-and its block device.
+and its block device.  The device may either be of the form
+\fI/dev/pktcdvd/pktcdvd0\fP or \fI252:0\fP.
+
 
 .SH EXAMPLE
 The following commands provide an example of using the
@@ -74,7 +94,7 @@
 
 .SH FILES
 .nf
-/dev/pktcdvd0,/dev/pktcdvd1,...  CD/DVD packet devices (block major=97)
+/dev/pktcdvd0,/dev/pktcdvd1,...  CD/DVD packet devices (block major=252)
 .fi
 
 .SH AUTHOR
diff -ru udftools-1.0.0b3.orig/pktsetup/pktsetup.c udftools-1.0.0b3/pktsetup/pktsetup.c
--- udftools-1.0.0b3.orig/pktsetup/pktsetup.c	2006-01-08 18:08:03.000000000 -0500
+++ udftools-1.0.0b3/pktsetup/pktsetup.c	2006-01-08 18:34:58.000000000 -0500
@@ -125,6 +125,8 @@
 	printf("  pktsetup -d dev_name               tear down device\n");
 	printf("  pktsetup -d major:minor            tear down device\n");
 	printf("  pktsetup -s                        show device mappings\n");
+	printf("And in this version:\n");
+	printf("  pktsetup /dev/cdrom                setup device\n");
 	return 1;
 }
 
@@ -245,7 +247,7 @@
 		c.command = PKT_CTRL_CMD_SETUP;
 		c.dev = stat_buf.st_rdev;
 
-		if (remove_stale_dev_node(ctl_fd, pkt_device) != 0) {
+		if (pkt_device && remove_stale_dev_node(ctl_fd, pkt_device) != 0) {
 			fprintf(stderr, "Device node '%s' already in use\n", pkt_device);
 			goto out_close;
 		}
@@ -253,7 +255,10 @@
 			perror("ioctl");
 			goto out_close;
 		}
-		mknod(pkt_dev_name(pkt_device), S_IFBLK | 0640, c.pkt_dev);
+		if( pkt_device )
+		  mknod(pkt_dev_name(pkt_device), S_IFBLK | 0640, c.pkt_dev);
+		else
+		  printf("Assigned device number %d:%d\n", MAJOR(c.pkt_dev), MINOR(c.pkt_dev) );
 	} else {
 		int major, minor, remove_node;
 
@@ -322,9 +327,6 @@
 	char *pkt_device;
 	char *device;
 
-	if (argc == 1)
-		return usage();
-
 	while ((c = getopt(argc, argv, "ds?")) != EOF) {
 		switch (c) {
 			case 'd':
@@ -337,11 +339,15 @@
 				return usage();
 		}
 	}
-	pkt_device = argv[optind];
-	device = argv[optind + 1];
-	if (strchr(pkt_device, '/'))
-		setup_dev(pkt_device, device, rem);
-	else
-		setup_dev_chardev(pkt_device, device, rem);
-	return 0;
+	if( argc == 2 )
+	    setup_dev_chardev(NULL, argv[1], 0 );
+	else {
+	  pkt_device = argv[optind];
+	  device = argv[optind + 1];
+	  if (strchr(pkt_device, '/'))
+	    setup_dev(pkt_device, device, rem);
+	  else
+	    setup_dev_chardev(pkt_device, device, rem);
+	  return 0;
+	}
 }

--------------050400090208080905090302--
