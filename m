Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTFBUun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTFBUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:50:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56475 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263376AbTFBUuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:50:39 -0400
Date: Mon, 2 Jun 2003 16:03:47 -0500
Subject: [CHECKER][PATCH] radio-cadet.c bad copy_to_user
Content-Type: multipart/mixed; boundary=Apple-Mail-11--1028783457
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org, Junfeng Yang <yjf@stanford.edu>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
To: Fred Gleason <fredg@wava.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Message-Id: <B4215138-953D-11D7-A45B-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-11--1028783457
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	delsp=yes;
	charset=US-ASCII;
	format=flowed

The Stanford checker said:
---------------------------------------------------------
[BUG] pass kernel pointer into copy_*_user. bug is in VIDIOCGTUNER.  
Should
not call copy_to_user on arg since arg is already in kernel space.

/home/junfeng/linux-2.5.63/drivers/media/radio/radio- 
cadet.c:397:cadet_do_ioctl:
ERROR:TAINTED:397:397: dereferencing tainted ptr 'v' [Callstack: ]

	{
		case VIDIOCGCAP:
		{
			struct video_capability *v = arg;
			memset(v,0,sizeof(*v));

Error --->
			v->type=VID_TYPE_TUNER;
			v->channels=2;
			v->audios=1;
			strcpy(v->name, "ADS Cadet");
---------------------------------------------------------

As pointed out, 'v' is not tainted. The driver shouldn't be using  
copy_to_user() in cadet_do_ioctl() at all: cadet_do_ioctl() is being  
called by drivers/media/video/videodev.c:video_usercopy(), which has  
already copied the buffer 'arg' (aka 'v') into kernel space, and will  
copy it back after cadet_do_ioctl() returns. So all the direct 'v'  
accesses are correct.

-- 
Hollis Blanchard
IBM Linux Technology Center


--Apple-Mail-11--1028783457
Content-Disposition: attachment;
	filename=cadetradio-badcopy.txt
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="cadetradio-badcopy.txt"

===== drivers/media/radio/radio-cadet.c 1.13 vs edited =====
--- 1.13/drivers/media/radio/radio-cadet.c	Fri Apr  4 11:34:37 2003
+++ edited/drivers/media/radio/radio-cadet.c	Wed May 28 17:36:32 2003
@@ -389,9 +389,6 @@
 				        v->flags|=VIDEO_TUNER_STEREO_ON;
 			        }
 				v->flags|=cadet_getrds();
-			        if(copy_to_user(arg,&v, sizeof(v))) {
-				        return -EFAULT;
-			        }
 			        break;
 			        case 1:
 			        strcpy(v->name,"AM");
@@ -402,9 +399,6 @@
 			        v->mode=0;
 			        v->mode|=VIDEO_MODE_AUTO;
 			        v->signal=sigstrength;
-			        if(copy_to_user(arg,&v, sizeof(v))) {
-				        return -EFAULT;
-			        }
 			        break;
 			}
 			return 0;

--Apple-Mail-11--1028783457--

