Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUJRSGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUJRSGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJRSGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:06:32 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:12046 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S267254AbUJRSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:05:52 -0400
Date: Mon, 18 Oct 2004 19:00:52 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: PATCH re SunOS and Solaris Partitions (fwd)
Message-ID: <Pine.LNX.4.10.10410181900150.29938-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Opps. Sorry, I did not get to the bottom of the list of things to do so   
submit a patch.

---------- Forwarded message ----------
Date: Sun, 17 Oct 2004 21:41:06 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: aeb@cwi.nl
Subject: SunOS and Solaris Partitions

Hi Andries,

I am in the process of trying to get a linux kernel up and running on one
of my sparc systems. Because of some comments I noticed on the web, I
compared the Linux source files with the related information from the
SunOS 4.1, 4.1.3 and Solaris 2.1 header files I have and found some
discrepencies. The patch below sorts out a posible problem relating to the
SunOS 4.1/4.1.3 disk lables and may fix a problem for x86 based systems as
well, altow the comments in the patch should be read first as it may just 
open up a can or worms.

Regards
	Mark Fortescue

##############################################################################
#
# Mark Fortescue (mark@mtfhpc.demon.co.uk) Kernel Updates, 16th Oct 2004.
#
# (from 2.6.8.1 with patch-2.6.9-rc2 and patch-2.6.9-rc2-bk6 applied.)
#
# SunOS 4.1, 4.1.3 and Solaris 2.1 (SunOS 5.1) Partitions.
#
# The VTOC structure was introduced post SunOS 4.1.3 and as a result
# is not supported by my two SunOS sparc systems. The patch
# adds a validation check to the code based on the information found in
# the Solaris 2.1 and SunOS 4.1/4.1.3 header files and some BSD ufs fsck
# source files.
#
# genhd.h apears to have an error in it as according to the Solaris 2.1
# header files, the x86 platform has 16 slices not 8.
#
# I to not have a Solaris 2.1 system any longer, only the man pages,
# the header files and the libraries. (I used them to get gcc onto
# a x86 Solaris system and have never deleted them.)
#
# I will need the SunOS changes as my sparc kernel will
# share its disk with SunOS 4.1 (when I get the kernel to boot).
#
# These changes are un-tested but should not break anything unless
# Sun have multiple definitions for how many slices an x86 Solaris
# system has.
#
##############################################################################
diff -ru linux-2.6.8.1/fs/partitions/sun.c linux-2.6.8.1-p02/fs/partitions/sun.c
--- linux-2.6.8.1/fs/partitions/sun.c	Sat Aug 14 11:56:15 2004
+++ linux-2.6.8.1-p02/fs/partitions/sun.c	Fri Oct 15 11:46:55 2004
@@ -18,29 +18,39 @@ int sun_partition(struct parsed_partitio
 	Sector sect;
 	struct sun_disklabel {
 		unsigned char info[128];   /* Informative text string */
-		unsigned char spare0[14];
-		struct sun_info {
-			unsigned char spare1;
-			unsigned char id;
-			unsigned char spare2;
-			unsigned char flags;
-		} infos[8];
-		unsigned char spare[246];  /* Boot information etc. */
-		unsigned short rspeed;     /* Disk rotational speed */
-		unsigned short pcylcount;  /* Physical cylinder count */
-		unsigned short sparecyl;   /* extra sects per cylinder */
-		unsigned char spare2[4];   /* More magic... */
-		unsigned short ilfact;     /* Interleave factor */
-		unsigned short ncyl;       /* Data cylinder count */
-		unsigned short nacyl;      /* Alt. cylinder count */
-		unsigned short ntrks;      /* Tracks per cylinder */
-		unsigned short nsect;      /* Sectors per track */
-		unsigned char spare3[4];   /* Even more magic... */
+	        struct sun_vtoc {               /* Solaris 2: */
+		    __u32          version;     /* Layout version        */
+		    char           volume[8];   /* Volume name           */
+		    unsigned short nparts;      /* Number of partitions  */
+		    struct sun_info {           /* Partition hdrs, sec 2 */
+			unsigned short id;
+			unsigned short flags;
+		    } infos[8];
+		    __u32          bootinfo[3];  /* Info needed by mboot  */
+		    __u32          sanity;       /* To verify vtoc sanity */
+		    __u32          reserved[10]; /* Free space            */
+		    __u32          timestamp[8]; /* Partition timestamp   */
+		} vtoc;
+                __u32          write_reinstruct; /* Solaris 2: # sectors to skip, writes */
+	        __u32          read_reinstruct;  /* Solaris 2: # sectors to skip, reads  */
+		unsigned char  spare[150]; /* Padding                    */
+		unsigned short rspeed;     /* Disk rotational speed      */
+		unsigned short pcylcount;  /* Physical cylinder count    */
+		unsigned short sparecyl;   /* extra sects per cylinder   */
+		unsigned short obs1;       /* gap1                       */
+		unsigned short obs2;       /* gap2                       */
+		unsigned short ilfact;     /* Interleave factor          */
+		unsigned short ncyl;       /* Data cylinder count        */
+		unsigned short nacyl;      /* Alt. cylinder count        */
+		unsigned short ntrks;      /* Tracks per cylinder        */
+		unsigned short nsect;      /* Sectors per track          */
+		unsigned short obs3;       /* bhead - Label head offset  */
+		unsigned short obs4;       /* ppart - Physical Partition */
 		struct sun_partition {
 			__u32 start_cylinder;
 			__u32 num_sectors;
 		} partitions[8];
-		unsigned short magic;      /* Magic number */
+		unsigned short magic;      /* Magic number         */
 		unsigned short csum;       /* Label xor'd checksum */
 	} * label;		
 	struct sun_partition *p;
@@ -79,7 +89,9 @@ int sun_partition(struct parsed_partitio
 		num_sectors = be32_to_cpu(p->num_sectors);
 		if (num_sectors) {
 			put_partition(state, slot, st_sector, num_sectors);
-			if (label->infos[i].id == LINUX_RAID_PARTITION)
+			/* Need to validate the VTOC before we use it */
+			if ((be32_to_cpu(label->vtoc.sanity) == SUN_VTOC_SANITY) &&
+			    (be16_to_cpu(label->vtoc.infos[i].id) == LINUX_RAID_PARTITION))
 				state->parts[slot].flags = 1;
 		}
 		slot++;
diff -ru linux-2.6.8.1/fs/partitions/sun.h linux-2.6.8.1-p02/fs/partitions/sun.h
--- linux-2.6.8.1/fs/partitions/sun.h	Sat Aug 14 11:55:20 2004
+++ linux-2.6.8.1-p02/fs/partitions/sun.h	Fri Oct 15 11:43:37 2004
@@ -3,5 +3,6 @@
  */
 
 #define SUN_LABEL_MAGIC          0xDABE
+#define SUN_VTOC_SANITY          0x600DDEEE
 
 int sun_partition(struct parsed_partitions *state, struct block_device *bdev);
##############################################################################
#
# Solaris 2.1 x86 has 16 slices, not 8. Ideally, check with Sun.
#
##############################################################################
diff -ru linux-2.6.8.1/include/linux/genhd.h linux-2.6.8.1-p02/include/linux/genhd.h
--- linux-2.6.8.1/include/linux/genhd.h	Fri Oct 15 21:19:59 2004
+++ linux-2.6.8.1-p02/include/linux/genhd.h	Fri Oct 15 11:18:28 2004
@@ -214,7 +214,7 @@ static inline void set_capacity(struct g
 
 #ifdef CONFIG_SOLARIS_X86_PARTITION
 
-#define SOLARIS_X86_NUMSLICE	8
+#define SOLARIS_X86_NUMSLICE	16
 #define SOLARIS_X86_VTOC_SANE	(0x600DDEEEUL)
 
 struct solaris_x86_slice {
----------------------------------------------------------------------------


