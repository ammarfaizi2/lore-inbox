Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUDNUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDNUb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:31:59 -0400
Received: from [62.241.33.80] ([62.241.33.80]:64529 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261724AbUDNUba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:31:30 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: [SECURITY] CAN-2004-0075 (was: Re: [SECURITY] CAN-2004-0109 isofs fix.)
Date: Wed, 14 Apr 2004 22:30:33 +0200
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com
References: <20040414171147.GB23419@redhat.com>
In-Reply-To: <20040414171147.GB23419@redhat.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404142230.33553@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p9ZfAk95xdGHrzs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_p9ZfAk95xdGHrzs
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 April 2004 19:11, Dave Jones wrote:

Hi,

> Merged in 2.4, and various vendor kernels today..

Okay, now while we are at fixing security holes, is there any chance we 
can _finally_ get the attached patch in?

The Vicam USB driver in all Linux Kernels 2.6 mainline does not use the 
copy_from_user function when copying data from userspace to kernel space, 
which crosses security boundaries and allows local users to cause a denial
of service.

Already ACKed by Greg. Only complaint was inproper coding style which is done 
with attached patch ;)

ciao, Marc



--Boundary-00=_p9ZfAk95xdGHrzs
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="8009_CAN-2004-0075-usb-vicam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="8009_CAN-2004-0075-usb-vicam.patch"

diff -urN a/drivers/usb/media/vicam.c b/drivers/usb/media/vicam.c
--- a/drivers/usb/media/vicam.c	2003-11-28 10:26:20.000000000 +0100
+++ b/drivers/usb/media/vicam.c	2004-01-15 12:10:23.000000000 +0100
@@ -653,12 +653,18 @@
 	case VIDIOCSWIN:
 		{
 
-			struct video_window *vw = (struct video_window *) arg;
-			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
+			struct video_window vw;
 
-			if ( vw->width != 320 || vw->height != 240 )
+			if (copy_from_user(&vw, arg, sizeof(vw))) {
 				retval = -EFAULT;
+				break;
+			}
+
+			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
 			
+			if ( vw.width != 320 || vw.height != 240 )
+				retval = -EFAULT;
+
 			break;
 		}
 

--Boundary-00=_p9ZfAk95xdGHrzs--

