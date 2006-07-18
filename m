Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWGRDE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWGRDE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWGRDE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:04:26 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:62444 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932066AbWGRDEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:04:25 -0400
Message-ID: <44BC4F83.6060108@linuxtv.org>
Date: Mon, 17 Jul 2006 23:03:31 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Axel Thimm <Axel.Thimm@atrpms.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: bttv-driver.c:3964: error: void value not ignored as it ought
 to be
References: <20060717124505.GD7281@neu.nirvana> <44BBEAB0.3080105@linuxtv.org>	<29495f1d0607171355s1858f109xab02c7cc437f180c@mail.gmail.com> <44BC015A.5090104@linuxtv.org>
In-Reply-To: <44BC015A.5090104@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:
> Nish Aravamudan wrote:
>> On 7/17/06, Michael Krufky <mkrufky@linuxtv.org> wrote:
>>> Hmmm... This was caused by the "Check all __must_check warnings in
>>> bttv." patch from Randy Dunlap (cc's from original thread added)
>>>
>>> I am aware that this was done for various reasons of sanity checking,
>>> however, we cannot check the return value of a void ;-)
>> For the sanity checking, I don't think video_device_create_file()
>> should be a void function. It probably should return
>> class_device_create_file()'s return value, no? As it can fail...
>>
> 
> You are correct... I was merely pointing out the error, but now I see it
> runs deeper than I had thought.  I will fix both
> video_device_create_file and video_device_remove_file to return the
> class_device_foo return values, then I'll push it over to Mauro.

I was in a rush when I wrote that, and I wasn't thinking. 
video_device_remove_file stays as a void.

Anyway, here is the fix.  This is already in my tree ( 
http://linuxtv.org/hg/~mkrufky/v4l-dvb ) but split into separate patches.

no s-o-b needed for now -- this will come up through Mauro.

diff -upr master/linux/drivers/media/video/bt8xx/bttv-driver.c 
v4l-dvb/linux/drivers/media/video/bt8xx/bttv-driver.c
--- master/linux/drivers/media/video/bt8xx/bttv-driver.c 
2006-07-17 22:57:05.000000000 -0400
+++ v4l-dvb/linux/drivers/media/video/bt8xx/bttv-driver.c 
2006-07-17 21:55:54.000000000 -0400
@@ -3942,10 +3942,6 @@ static void bttv_unregister_video(struct
  /* register video4linux devices */
  static int __devinit bttv_register_video(struct bttv *btv)
  {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,17)
-       int ret;
-#endif
-
         if (no_overlay <= 0) {
                 bttv_video_template.type |= VID_TYPE_OVERLAY;
         } else {
@@ -3960,17 +3956,10 @@ static int __devinit bttv_register_video
                 goto err;
         printk(KERN_INFO "bttv%d: registered device video%d\n",
                btv->c.nr,btv->video_dev->minor & 0x1f);
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,17)
-       ret = video_device_create_file(btv->video_dev, 
&class_device_attr_card);
-       if (ret < 0)
-               printk(KERN_WARNING "bttv: video_device_create_file error: "
-                       "%d\n", ret);
-#else
  #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)

         video_device_create_file(btv->video_dev, &class_device_attr_card);
  #endif
-#endif

         /* vbi */
         btv->vbi_dev = vdev_init(btv, &bttv_vbi_template, "vbi");
diff -upr master/linux/include/media/v4l2-dev.h 
v4l-dvb/linux/include/media/v4l2-dev.h
--- master/linux/include/media/v4l2-dev.h       2006-07-17 
22:57:06.000000000 -0400
+++ v4l-dvb/linux/include/media/v4l2-dev.h      2006-07-17 
22:34:32.000000000 -0400
@@ -376,11 +376,14 @@ extern struct video_device* video_devdat

  #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)
  #define to_video_device(cd) container_of(cd, struct video_device, 
class_dev)
-static inline void
+static inline int
  video_device_create_file(struct video_device *vfd,
                          struct class_device_attribute *attr)
  {
-       class_device_create_file(&vfd->class_dev, attr);
+       int ret = class_device_create_file(&vfd->class_dev, attr);
+       if (ret < 0)
+               printk(KERN_WARNING "%s error: %d\n", __FUNCTION__, ret);
+       return ret;
  }
  static inline void
  video_device_remove_file(struct video_device *vfd,



