Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTDJRxj (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTDJRxj (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:53:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55784 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264118AbTDJRxf (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:53:35 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Isn't sd_major() broken ?
Date: Thu, 10 Apr 2003 10:01:44 -0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_WE35UDLQRP2F7W0TSKLT"
Message-Id: <200304101101.44493.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_WE35UDLQRP2F7W0TSKLT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am little confused about the correctness of sd_major() in drivers/scsi/=
sd.c.

static int sd_major(int major_idx)
{
        switch (major_idx) {
        case 0:
                return SCSI_DISK0_MAJOR;
        case 1 ... 7:
                return SCSI_DISK1_MAJOR + major_idx - 1;
        case 8 ... 15:
                return SCSI_DISK8_MAJOR + major_idx;
        default:
                BUG();
                return 0;       /* shut up gcc */
        }
}

So, if major_idx =3D 8, It returns 143.=20
But according to major.h, scsi has 128-135 reserved
majors. But it is registering 136 - 143 as its majors.

#define SCSI_DISK8_MAJOR        128
#define SCSI_DISK9_MAJOR        129
#define SCSI_DISK10_MAJOR       130
#define SCSI_DISK11_MAJOR       131
#define SCSI_DISK12_MAJOR       132
#define SCSI_DISK13_MAJOR       133
#define SCSI_DISK14_MAJOR       134
#define SCSI_DISK15_MAJOR       135

Isn't sd_major() broken ? Here is the patch to fix it.

Thanks,
Badari

# cat /proc/devices
=2E..
Block devices:
  2 fd
  3 ide0
  8 sd
 11 sr
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
136 sd
137 sd
138 sd
139 sd
140 sd
141 sd
142 sd
143 sd

--------------Boundary-00=_WE35UDLQRP2F7W0TSKLT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="major"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="major"

--- drivers/scsi/sd.c.org	Wed Apr  9 13:12:38 2003
+++ drivers/scsi/sd.c	Thu Apr 10 11:01:45 2003
@@ -123,7 +123,7 @@ static int sd_major(int major_idx)
 	case 1 ... 7:
 		return SCSI_DISK1_MAJOR + major_idx - 1;
 	case 8 ... 15:
-		return SCSI_DISK8_MAJOR + major_idx;
+		return SCSI_DISK8_MAJOR + major_idx - 8;
 	default:
 		BUG();
 		return 0;	/* shut up gcc */

--------------Boundary-00=_WE35UDLQRP2F7W0TSKLT--

