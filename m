Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSJEPG2>; Sat, 5 Oct 2002 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbSJEPG2>; Sat, 5 Oct 2002 11:06:28 -0400
Received: from transport.cksoft.de ([62.111.66.27]:64528 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262365AbSJEPGN>; Sat, 5 Oct 2002 11:06:13 -0400
Date: Sat, 5 Oct 2002 15:10:35 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       <patch@zabbadoz.net>
Subject: Re: SCSI st tape wrong minor in 2.5.40 with devfs
In-Reply-To: <Pine.BSF.4.44.0210051255410.39858-100000@e0-0.zab2.int.zabbadoz.net>
Message-ID: <Pine.BSF.4.44.0210051338420.39858-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Bjoern A. Zeeb wrote:

Hi,

> On Sat, 5 Oct 2002, Kai Makisara wrote:
>
> > In the original location i did contain the device number but here it
> > contains 4 (from the latest loop). The fix seems to be to replace i by
> > dev_num but I have not yet tested it.
>
> Thought of s.th. like this but had no old version a hand ..
> I'll give it a look and if it seems ok, I'll give it a try and let you know ...

attached patch makes it work fine again and does no longer use the i which
is counted up to ST_NBR_PARTITIONS = 4, always resulting in a minor = ( n + ) 4
as you said.

bz@megablast:/dev/scsi/host0/bus0/target5/lun0> ls -l
total 0
crw-r-----    1 root     root      21,   3 Jan  1  1970 generic
crw-rw-rw-    1 root     root       9,   0 Jan  1  1970 mt
crw-rw-rw-    1 root     root       9,  96 Jan  1  1970 mta
crw-rw-rw-    1 root     root       9, 224 Jan  1  1970 mtan
crw-rw-rw-    1 root     root       9,  32 Jan  1  1970 mtl
crw-rw-rw-    1 root     root       9, 160 Jan  1  1970 mtln
crw-rw-rw-    1 root     root       9,  64 Jan  1  1970 mtm
crw-rw-rw-    1 root     root       9, 192 Jan  1  1970 mtmn
crw-rw-rw-    1 root     root       9, 128 Jan  1  1970 mtn

You may also fetch the file from
http://sources.zabbadoz.net/linux_kernel/linux-2.5.40-20021005-060333-scsi-st-minor.bkcset


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.716, 2002-10-05 14:36:56+00:00, bz@zabbadoz.net
  st.c:
    SCSI: fixed minor numbers in st.c for devfs & driverfs


 st.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Sat Oct  5 14:47:35 2002
+++ b/drivers/scsi/st.c	Sat Oct  5 14:47:35 2002
@@ -3832,14 +3832,14 @@
 	    tpnt->driverfs_dev_r[mode].parent = &SDp->sdev_driverfs_dev;
 	    tpnt->driverfs_dev_r[mode].bus = &scsi_driverfs_bus_type;
 	    tpnt->driverfs_dev_r[mode].driver_data =
-			(void *)(long)__mkdev(MAJOR_NR, i + (mode << 5));
+			(void *)(long)__mkdev(MAJOR_NR, dev_num + (mode << 5));
 	    device_register(&tpnt->driverfs_dev_r[mode]);
 	    device_create_file(&tpnt->driverfs_dev_r[mode],
 			       &dev_attr_type);
 	    device_create_file(&tpnt->driverfs_dev_r[mode], &dev_attr_kdev);
 	    tpnt->de_r[mode] =
 		devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
-				MAJOR_NR, i + (mode << 5),
+				MAJOR_NR, dev_num + (mode << 5),
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				&st_fops, NULL);
 	    /*  No-rewind entry  */
@@ -3851,7 +3851,7 @@
 	    tpnt->driverfs_dev_n[mode].parent= &SDp->sdev_driverfs_dev;
 	    tpnt->driverfs_dev_n[mode].bus = &scsi_driverfs_bus_type;
 	    tpnt->driverfs_dev_n[mode].driver_data =
-			(void *)(long)__mkdev(MAJOR_NR, i + (mode << 5) + 128);
+			(void *)(long)__mkdev(MAJOR_NR, dev_num + (mode << 5) + 128);
 	    device_register(&tpnt->driverfs_dev_n[mode]);
 	    device_create_file(&tpnt->driverfs_dev_n[mode],
 			       &dev_attr_type);
@@ -3859,7 +3859,7 @@
 			       &dev_attr_kdev);
 	    tpnt->de_n[mode] =
 		devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
-				MAJOR_NR, i + (mode << 5) + 128,
+				MAJOR_NR, dev_num + (mode << 5) + 128,
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				&st_fops, NULL);
 	}

===================================================================


This BitKeeper patch contains the following changesets:
1.716
## Wrapped with gzip_uu ##


begin 664 bkpatch10150
M'XL(`(?[GCT``[54[V_:,!#]'/\5)U6:8$!B.['S8V6BH]/6=5T1J)^1DS@E
M@B13'&B'\L?/D`K0*L:&MB32Q:>[YW?/3[Z`!R7+P`C7Z`(^%ZH*C+4(0Q$7
M:S.7E4Z.BT(GK:4J+55&5CCO+=)\^;S[Z5&3(5TW$E4T@Y4L56`0T]YEJA_?
M96",/WYZ^'HU1JC?A^%,Y(]R(BOH]U%5E"NQB-5`5+-%D9M5*7*5R4J849'5
MN]*:8DSURXAK8\9KPK'CUA&)"1$.D3&FCL>=/=JLR.1OL0C&#%/J8;^FE/L4
M70,Q7<(!4XM@"S,@3F#S@/$.Q@'&$*X'A\I`AT`/HP_P;P<8H@A494:!C@"3
MX>0F@"1]EC%D:5Z4D"^S4$L,:;XM@T3G8KE*%+R!N$RU_(E"MT")QUTTVDN-
M>G_Y((0%1N]/C-=LJ2P5J=3:$#H8T\'8K3FC#J\3+&(/2S=A293X0OPJYA&<
MS1D1F_G4KQGEF&W=\ZKTM(O.9(EN16K>B7FJ1"D&\V*AM5\J,TF/`6JBU";,
MMFNFEVQK*>H?.,H.F!]0_YBC'.@Y_\519_NHD?T>>N73]M.^&+T^@3/,=6U[
MMA8$W;Q$PS!:JR*-X6V[I6=^;$^GV5P3:MU=?;D?3[^-NQMZ4TT;.M#*BEC"
MY26P=OO=!LJA#=0V:BCC1%=WT\2<IFD;S]U?KPCU&A;\A07_0Q9-;W=_>48S
5&<W5,NO';NAZA,?H)ROJOBZ?!0``
`
end

-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

