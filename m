Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268821AbRG0KSB>; Fri, 27 Jul 2001 06:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268822AbRG0KRv>; Fri, 27 Jul 2001 06:17:51 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:44553 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268821AbRG0KRk>; Fri, 27 Jul 2001 06:17:40 -0400
Message-ID: <3B61414E.72F39AFF@zip.com.au>
Date: Fri, 27 Jul 2001 20:24:14 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Hunter <sean@dev.sportingbet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>,
		<3B5FC7FB.D5AF0932@zip.com.au>; from akpm@zip.com.au on Thu, Jul 26, 2001 at 05:34:19PM +1000 <20010727103221.F18669@dev.sportingbet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sean Hunter wrote:
> 
> Following the announcement on lkml, I have started using ext3 on one of my
> servers.  Since the server in question is a farily security-sensitive box, my
> /usr partition is mounted read only except when I remount rw to install
> packages.
> 
> I converted this partition to run ext3 with the mount options
> "nodev,ro,data=writeback,defaults" figuring that when I need to install new
> packages etc, that I could just mount rw as before and that metadata-only
> journalling would be ok for this partition as it really sees very little write
> activity.
> 
> When I try to remount it r/w I get a log message saying:
> Jul 27 09:54:29 henry kernel: EXT3-fs: cannot change data mode on remount
> 
> ...even if I give the full mount option list with the remount instruction.

hmm..  The mount option handling there is a bit bogus.

What we *should* do on remount is check that the requested
journalling mode is equal to the current mode.  ext3 won't
allow you to change the journalling mode on-the-fly.

So...  you will have to omit the `data=xxx' portion of the
mount options when remounting.  It's being invisibly added
by /bin/mount.

/bin/mount tries to be smart.  If, for example you have

	/dev/hdf12 /mnt/hdf12 ext3 noauto,ro,data=writeback 1

in /etc/fstab and then type

	mount /dev/hdf12 -o remount,rw

then /bin/mount runs off and looks up the fstab entry and
inserts the mount options.  However if you instead type

	mount /dev/hdf12 /mnt/hdf12 -o remount,rw          (1)

then /bin/mount does *not* look up the fstab entry, and
the remount succeeds.

ho-hum.  For the while you'll have to fiddle with the mount
usage to get things working right.   Equation (1) above will
work fine.  Or apply the appended patch.

> I can, however, remount it as ext2 read-write, but when I try to remount as
> ext3 (even read only) I get the same problem.

You can't switch between ext2 and ext3 with a remount - unmount
is needed.

> Wierdly, "mount" lists it as being still an ext3 partition even though it has
> been remounted as ext2.  I can't umount /usr because kjournald is currently
> listed as using the partition.

That sounds very weird.  Could you please describe the steps
you took to create this state?

Sometimes /etc/mtab gets out of sync - especially for the
root fs.  It's more reliable to look in /proc/mounts



Here's the fix for the data= handling on remount:



Index: fs/ext3/super.c
===================================================================
RCS file: /cvsroot/gkernel/ext3/fs/ext3/super.c,v
retrieving revision 1.31
diff -u -r1.31 super.c
--- fs/ext3/super.c	2001/07/19 14:43:08	1.31
+++ fs/ext3/super.c	2001/07/27 10:14:48
@@ -513,12 +513,6 @@
 
 			if (want_value(value, "data"))
 				return 0;
-			if (is_remount) {
-				printk ("EXT3-fs: cannot change data mode "
-						"on remount\n");
-				return 0;
-			}
-
 			if (!strcmp (value, "journal"))
 				data_opt = EXT3_MOUNT_JOURNAL_DATA;
 			else if (!strcmp (value, "ordered"))
@@ -529,9 +523,18 @@
 				printk ("EXT3-fs: Invalid data option: %s\n",
 					value);
 				return 0;
+			}
+			if (is_remount) {
+				if ((*mount_options & EXT3_MOUNT_DATA_FLAGS) !=
+							data_opt) {
+					printk("EXT3-fs: cannot change data "
+						"mode on remount\n");
+					return 0;
+				}
+			} else {
+				*mount_options &= ~EXT3_MOUNT_DATA_FLAGS;
+				*mount_options |= data_opt;
 			}
-			*mount_options &= ~EXT3_MOUNT_DATA_FLAGS;
-			*mount_options |= data_opt;
 		} else {
 			printk ("EXT3-fs: Unrecognized mount option %s\n",
 					this_char);
