Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137127AbRAHHiN>; Mon, 8 Jan 2001 02:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137125AbRAHHiD>; Mon, 8 Jan 2001 02:38:03 -0500
Received: from juice.serc.nl ([192.87.7.3]:13300 "EHLO juice.serc.nl")
	by vger.kernel.org with ESMTP id <S136990AbRAHHhu>;
	Mon, 8 Jan 2001 02:37:50 -0500
From: Willem Dekker <dekker@serc.nl>
Message-Id: <200101080735.IAA14322@juice.serc.nl>
Subject: [PATCH] wrong stat of NTFS volume in linux-kernel 2.4.0
To: aia21@cus.cam.ac.uk
Date: Mon, 8 Jan 2001 08:35:07 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested the 2.4.0 kernel and it reported a wrong volume size for 
ntfs partitions. The size of the partition (as reported by df -k) was
a factor of 8 too high. After some searching I found that 
super.c in /usr/src/linux/fs/ntfs was changed. In my previous kernel 
2.2.16 a division by the number of blocks in a cluster  was made although 
it included a remark about the 64 bit division routine, and thus used only a
32 bit division. 

In the latest kernel (2.4.0) the division is completly removed, and thus the
volume size is incorrect. 
I included a patch for the situation. This routine presupposes that the 
number of blocks in a cluster is always a power of 2, and uses right shifts.
As far as I know all NTFS cluster sizes are a power of two, which is confirmed
by the options of the format command in NT and some knowledgebase articles
of Microsoft. If not an message will appear in the syslog. (printk)

Willem Dekker


Patch to adapt super.c of the ntfs filesystem. On a stock linux
2.4.0 kernel. 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- fs/ntfs/super.orig	Tue Nov  7 20:22:35 2000
+++ fs/ntfs/super.c	Sun Jan  7 22:34:43 2001
@@ -300,6 +300,82 @@
 	return 0;
 }
 
+static ntfs_u64 div_by_power_of_2(ntfs_u64 numerator, int denominator) 
+{
+	switch(denominator) {
+		case 0 : 
+			printk("Division by zero error at div_by_power_of_2");
+			return 0;
+		case 1 :
+			return numerator ;
+		case 2 :
+			return numerator >> 1;
+		case 4 :
+			return numerator >> 2;
+		case 8 :
+			return numerator >> 3;
+		case 16 :
+			return numerator >> 4;
+		case 32 :
+			return numerator >> 5;
+		case 64 :
+			return numerator >> 6;
+		case 128 :
+			return numerator >> 7;
+		case 256 :
+			return numerator >> 8;
+		case 512 :
+			return numerator >> 9;
+		case 1024 :
+			return numerator >> 10;
+		case 2048 :
+			return numerator >> 11;
+		case 4096 :
+			return numerator >> 12;
+		case 8192 :
+			return numerator >> 13;
+		case 16384 :
+			return numerator >> 14;
+		case 32768 :
+			return numerator >> 15;
+		case 65536 :
+			return numerator >> 16;
+		case 131072 :
+			return numerator >> 17;
+		case 262144 :
+			return numerator >> 18;
+		case 524288 :
+			return numerator >> 19;
+		case 1048576 :
+			return numerator >> 20;
+		case 2097152 :
+			return numerator >> 21;
+		case 4194304 :
+			return numerator >> 22;
+		case 8388608 :
+			return numerator >> 23;
+		case 16777216 :
+			return numerator >> 24;
+		case 33554432 :
+			return numerator >> 25;
+		case 67108864 :
+			return numerator >> 26;
+		case 134217728 :
+			return numerator >> 27;
+		case 268435456 :
+			return numerator >> 28;
+		case 536870912 :
+			return numerator >> 29;
+		case 1073741824 :
+			return numerator >> 30;
+		case 2147483648U :
+			return numerator >> 31;
+		default : 
+			printk("Not dividing by power of 2 in div_by_power_of_2!!");
+			return 0;
+	}
+	return 0;
+}
 /*
  * Writes the volume size into vol_size. Returns 0 if successful
  * or error.
@@ -323,6 +399,7 @@
 	io.size=vol->clustersize;
 	ntfs_getput_clusters(vol,0,0,&io);
 	*vol_size = NTFS_GETU64(cluster0+0x28);
+        *vol_size = div_by_power_of_2(*vol_size,(vol->clusterfactor));
 	ntfs_free(cluster0);
 	return 0;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
