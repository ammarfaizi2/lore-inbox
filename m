Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSJPEYB>; Wed, 16 Oct 2002 00:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSJPEYB>; Wed, 16 Oct 2002 00:24:01 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:58244
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264842AbSJPEYA>; Wed, 16 Oct 2002 00:24:00 -0400
Date: Wed, 16 Oct 2002 00:16:47 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: sfrench@us.ibm.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] CIFS copy_*_user 
Message-ID: <Pine.LNX.4.44.0210160015290.1460-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.43/fs/cifs/cifssmb.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.43/fs/cifs/cifssmb.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cifssmb.c
--- linux-2.5.43/fs/cifs/cifssmb.c	16 Oct 2002 03:46:04 -0000	1.1.1.1
+++ linux-2.5.43/fs/cifs/cifssmb.c	16 Oct 2002 04:12:41 -0000
@@ -505,7 +505,8 @@
 			pReadData =
 			    (char *) (&pSMBr->hdr.Protocol) +
 			    le16_to_cpu(pSMBr->DataOffset);
-			copy_to_user(buf, pReadData, pSMBr->DataLength);
+			if (copy_to_user(buf, pReadData, pSMBr->DataLength))
+				rc = -EFAULT;
 		}
 	}
 
@@ -544,8 +545,10 @@
 	pSMB->DataLengthHigh = 0;
 	pSMB->DataOffset =
 	    cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
-	copy_from_user(pSMB->Data, buf, pSMB->DataLengthLow);
-
+	if (copy_from_user(pSMB->Data, buf, pSMB->DataLengthLow)) {
+		rc = -EFAULT;
+		goto exit_release;
+	}
 	pSMB->ByteCount += pSMB->DataLengthLow + 1 /* pad */ ;
 	pSMB->DataLengthLow = cpu_to_le16(pSMB->DataLengthLow);
 	pSMB->hdr.smb_buf_length += pSMB->ByteCount;
@@ -559,6 +562,7 @@
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
+exit_release:
 	if (pSMB)
 		buf_release(pSMB);
 

-- 
function.linuxpower.ca

