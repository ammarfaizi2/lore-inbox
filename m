Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUDOKEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDOKEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:04:51 -0400
Received: from paja.kn.vutbr.cz ([147.229.191.135]:50444 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261170AbUDOKEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:04:47 -0400
Message-ID: <407E5E2B.2020700@stud.feec.vutbr.cz>
Date: Thu, 15 Apr 2004 12:04:27 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [SECURITY] CAN-2004-0075
References: <20040414171147.GB23419@redhat.com> <200404142230.33553@WOLK> <20040414212724.GA24809@kroah.com>
In-Reply-To: <20040414212724.GA24809@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------080307060507060206080005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307060507060206080005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Wed, Apr 14, 2004 at 10:30:33PM +0200, Marc-Christian Petersen wrote:
>>Okay, now while we are at fixing security holes, is there any chance we 
>>can _finally_ get the attached patch in?
>>
>>The Vicam USB driver in all Linux Kernels 2.6 mainline does not use the 
>>copy_from_user function when copying data from userspace to kernel space, 
>>which crosses security boundaries and allows local users to cause a denial
>>of service.
>>
>>Already ACKed by Greg. Only complaint was inproper coding style which is done 
>>with attached patch ;)
> 
> 
> Eeek, I thought this one was already in the tree, very sorry about that.
> 
> I'm applying it now and will send it to Linus in a bit.
> 

The patch broke compilation with VICAM_DEBUG on.
There is also another copy_from_user missing in case VIDIOCSPICT.
I'm attaching a patch.

Michal Schmidt

--------------080307060507060206080005
Content-Type: text/plain;
 name="vicam-ioctl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vicam-ioctl.diff"

--- linux-2.6.6-rc1/drivers/usb/media/vicam.c	2004-04-15 11:18:18.000000000 +0200
+++ linux-2.6.6-rc1-mich/drivers/usb/media/vicam.c	2004-04-15 11:50:02.791604312 +0200
@@ -612,15 +612,20 @@ vicam_ioctl(struct inode *inode, struct 
 
 	case VIDIOCSPICT:
 		{
-			struct video_picture *vp = (struct video_picture *) arg;
-
-			DBG("VIDIOCSPICT depth = %d, pal = %d\n", vp->depth,
-			    vp->palette);
+			struct video_picture vp;
+			
+			if (copy_from_user(&vp, arg, sizeof(vp))) {
+				retval = -EFAULT;
+				break;
+			}
+			
+			DBG("VIDIOCSPICT depth = %d, pal = %d\n", vp.depth,
+			    vp.palette);
 
-			cam->gain = vp->brightness >> 8;
+			cam->gain = vp.brightness >> 8;
 
-			if (vp->depth != 24
-			    || vp->palette != VIDEO_PALETTE_RGB24)
+			if (vp.depth != 24
+			    || vp.palette != VIDEO_PALETTE_RGB24)
 				retval = -EINVAL;
 
 			break;
@@ -660,7 +665,7 @@ vicam_ioctl(struct inode *inode, struct 
 				break;
 			}
 
-			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
+			DBG("VIDIOCSWIN %d x %d\n", vw.width, vw.height);
 			
 			if ( vw.width != 320 || vw.height != 240 )
 				retval = -EFAULT;

--------------080307060507060206080005--
