Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUF1G2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUF1G2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 02:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUF1G2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 02:28:09 -0400
Received: from bay14-f34.bay14.hotmail.com ([64.4.49.34]:38669 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264677AbUF1G2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 02:28:00 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [qwejohn@hotmail.com]
From: "John Que" <qwejohn@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: usb_set_interface and alternate setting 
Date: Mon, 28 Jun 2004 09:27:59 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F34N1Xh2RtDQG0001ab2a@hotmail.com>
X-OriginalArrivalTime: 28 Jun 2004 06:28:00.0047 (UTC) FILETIME=[0EE083F0:01C45CD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I work with a logitech 4000 pro WebCam with the pwc driver;
I run it on RH9 linux with 2.4.20-8 kernel.

The driver is part of the linux kernel 2.4.20-8.  (and also above , of 
course).

Now , in  pwc_isoc_init() method  (in pwc-if.c)
there is the following call:
ret = usb_set_interface(pdev->udev, 0, pdev->valternate);

By debugging I saw that it uses alternate setting 2 (pdev->valternate=2).

Now , according to the next Linux Device Driver website , this is the
descriptor for that webcam: (and I verified it by cat /proc/bus/usb/devices)

http://www.qbik.ch/usb/devices/showdescr.php?id=2515

Now , I had tried to use a different alternate setting,1, for which
the Maximum Packet Size (MxPS) is 196.

So I set pdev->valternate to 1 in the beginning of the pwc_isoc_init().

the return value form usb_set_interface() is 0 ; this means success.

I also saw the the return value from usb_maxpacket is 196, which is indeed 
the
max packet size of alternate setting 1.


However, when I try to use a utility like ffmpeg to grab a video sequence it
fails immeditately in the beginning : it simply hangs
in the  pwc_video_ioctl() method. (in the case VIDIOCSYNC: )

I don't understand why; though I added printk() calls almost
everywhere in that case sentence of this pwc_video_ioctl()
it does not reach them ; it simply hangs.

My question is :
Given that descriptor - is it possible and correct to change alternate 
setting like I do ?
Or should I do something else?

Is it OK that the number of endpoint remains 5 in both cases
(when using altenate setting 2,which is the default,and when using
alternate setting 1 ?)

Any help will be appreciated.

The kernel log I got when running the ffmpeg util is below:
(I added some printing info where I thought it can give some hint):

[pwc-if.c] in pwc_isoc_init
[pwc-if.c] in pdev->vendpoint = 5
[pwc-if.c] setting pdev->vmax_packet_size to  196
[pwc-if.c] usb_set_interface ret= 0
[pwc-if.c] pipe size is 164736
[pwc-if.c] epmaxpacketout= 0
epmaxpacketin 196
usb_pipeendpoint 5
[pwc-if.c] pipeout 0
[pwc-if.c] usb_maxpacket returns  196
[pwc-if.c] pipe size is 164736
[pwc-if.c] epmaxpacketout= 0
[pwc-if.c] epmaxpacketin 196
[pwc-if.c] usb_pipeendpoint 5
[pwc-if.c] pipeout 0
[pwc-if.c] usb_maxpacket returns  196
[pwc-if.c]  finished pwc_isoc_init()
[pwc-if.c] finished pwc_video_open
[pwc-if.c] pwc_video_ioctl

[pwc-if.c] case VIDIOCMCAPTURE:
VIDIOCMCAPTURE: 352x288, frame 0, format 15
[pwc-if.c] before pwc_try_video_mode :
pwc Video mode SIF@10 fps is only supported with the decompressor module 
(pwcx).
in pwc_isoc_init
in pdev->vendpoint = 5
[pwc-if.c] setting pdev->vmax_packet_size to  196
[pwc-if.c] usb_set_interface ret= 0
[pwc-if.c] pipe size is 164736
[pwc-if.c] epmaxpacketout= 0
[pwc-if.c] epmaxpacketin 196
[pwc-if.c] usb_pipeendpoint 5
[pwc-if.c] pipeout 0
[pwc-if.c] usb_maxpacket returns  196
[pwc-if.c] pipe size is 164736
[pwc-if.c] epmaxpacketout= 0
[pwc-if.c] epmaxpacketin 196
[pwc-if.c] usb_pipeendpoint 5
[pwc-if.c] pipeout 0
[pwc-if.c] usb_maxpacket returns  196
[pwc-if.c]  finished pwc_isoc_init()
[pwc-if.c] after pwc_try_video_mode :
[pwc-if.c] VIDIOCMCAPTURE done :
[pwc-if.c] pwc_video_ioctl
[pwc-if.c] case VIDIOCMCAPTURE:
VIDIOCMCAPTURE: 352x288, frame 1, format 15
[pwc-if.c] VIDIOCMCAPTURE done :
[pwc-if.c] pwc_video_ioctl
[pwc-if.c] case VIDIOCSYNC:

regards,
John

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

