Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbQKOWUh>; Wed, 15 Nov 2000 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQKOWU0>; Wed, 15 Nov 2000 17:20:26 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:23562 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129190AbQKOWUI>; Wed, 15 Nov 2000 17:20:08 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter Samuelson <peter@cadcamlab.org>
Date: Thu, 16 Nov 2000 08:49:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14867.1228.503272.946882@notabene.cse.unsw.edu.au>
Cc: Ian Grant <Ian.Grant@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
        mingo@elte.hu, linux-raid@vger.kernel.org
Subject: Re: RAID modules and CONFIG_AUTODETECT_RAID 
In-Reply-To: message from Peter Samuelson on Wednesday November 15
In-Reply-To: <20001115030752.K18203@wire.cadcamlab.org>
	<E13vz1D-0001zr-00@wisbech.cl.cam.ac.uk>
	<14866.23888.398397.534911@wire.cadcamlab.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 15, peter@cadcamlab.org wrote:
> 
> [Ian Grant <Ian.Grant@cl.cam.ac.uk>]
> > Of course we need an initrd with the raid modules on it before we can
> > boot from a RAID root partition.
> 
> raidtools can't run from an initrd?
> 
> Peter

There is a realy issue here.
raidstart currently does not reliably start an array in the face of
drive failure or device renaming.  So it could be used in an initrd
setup, but it might not be as reliable as autodetect.

2.4 has appropriate ioctls to allow for a more reliable raidstart, but
that raidstart hasn't been written yet.  I have some patches for the
standard raidstart that improve the situation a bit, but I would
prefer a very different looking config file.

So while I would prefer that autodetection were done by user-space,
especially if initrd were being used, I can see that that isn't going
to happen just now, and that it shouldn't be too hard to do in the
kernel, and it is not really unreasonable to do it there.

Ian, could you please try the attached patch?
It looks ok to me, and compiles, but I am not in a good position to
test it at the moment.
Hopefully it will do an auto-detect when you load md.o, and will
automatically load raidX.o as required.

Let me know how it goes, and if there are no problems I will see what
Linus thinks of it.

NeilBrown



--- ./drivers/md/md.c	2000/11/14 21:36:22	1.2
+++ ./drivers/md/md.c	2000/11/15 21:46:28	1.3
@@ -3806,7 +3806,11 @@
 #ifdef MODULE
 int init_module (void)
 {
-	return md_init();
+	int rv = md_init();
+#ifdef CONFIG_AUTODETECT_RAID
+	if (rv==0) rv=md_run_setup();
+#endif
+	return rv; 
 }
 
 static void free_device_names(void)
--- ./drivers/md/Config.in	2000/11/15 20:51:53	1.1
+++ ./drivers/md/Config.in	2000/11/15 21:46:29	1.2
@@ -13,6 +13,8 @@
 dep_tristate '  RAID-4/RAID-5 mode' CONFIG_MD_RAID5 $CONFIG_BLK_DEV_MD
 if [ "$CONFIG_MD_LINEAR" = "y" -o "$CONFIG_MD_RAID0" = "y" -o "$CONFIG_MD_RAID1" = "y" -o "$CONFIG_MD_RAID5" = "y" ]; then
         bool '  Boot support' CONFIG_MD_BOOT
+fi
+if [ "$CONFIG_MD_LINEAR" = "y" -o "$CONFIG_MD_RAID0" = "y" -o "$CONFIG_MD_RAID1" = "y" -o "$CONFIG_MD_RAID5" = "y" -o "$CONFIG_BLK_DEV_MD" = "m" ]; then
         bool '  Auto Detect support' CONFIG_AUTODETECT_RAID
 fi
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
