Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSGYS7c>; Thu, 25 Jul 2002 14:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSGYS7c>; Thu, 25 Jul 2002 14:59:32 -0400
Received: from smtp3.hushmail.com ([64.40.111.33]:31246 "EHLO
	smtp3.hushmail.com") by vger.kernel.org with ESMTP
	id <S315454AbSGYS7a>; Thu, 25 Jul 2002 14:59:30 -0400
Message-Id: <200207251902.g6PJ2bc01956@mailserver4.hushmail.com>
From: silvio.cesare@hushmail.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 bugs
Date: Thu, 25 Jul 2002 12:02:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.18

below are a few bugs leading to reading kernel memory using some of the usb
drivers.

--
Silvio

--

drivers/usb/se401.h

struct usb_se401 {

[ skip ]

        int *width;
        int *height;
        int cwidth;             /* current width */
        int cheight;            /* current height */

every integer in this structure (and .h) is signed, irrespective of its
usage. the char pointers are unsigned in places though.

:(

./drivers/usb/se401.c

static int se401_set_size(struct usb_se401 *se401, int width, int height)
{
        int wasstreaming=se401->streaming;
        /* Check to see if we need to change */
        if (se401->cwidth==width && se401->cheight==height)
                return 0;

        /* Check for a valid mode */
        if (!width || !height)
                return 1;
        if ((width & 1) || (height & 1))
                return 1;
        if (width>se401->width[se401->sizes-1])
                return 1;
        if (height>se401->height[se401->sizes-1])
                return 1;

        /* Stop a current stream and start it again at the new size */
        if (wasstreaming)
                se401_stop_stream(se401);
        se401->cwidth=width;
        se401->cheight=height;

width / height can be modified (to a negative for instance) - something
might break though with this though --> (will check more later).

static long se401_read(struct video_device *dev, char *buf, unsigned long count, int noblock)
{
        int realcount=count, ret=0;
        struct usb_se401 *se401 = (struct usb_se401 *)dev;

        if (se401->dev == NULL)
                return -EIO;
        if (realcount > se401->cwidth*se401->cheight*3)
                realcount=se401->cwidth*se401->cheight*3;

[ skip ]

        if (copy_to_user(buf, se401->frame[0].data, realcount))
                return -EFAULT;
 
sign and overflow problem, leading to unbounded copy_to_user.

--

./drivers/usb/usbvideo.c

long usbvideo_v4l_read(struct video_device *dev, char *buf, unsigned long count, int noblock)
{

[ skip ]

        /*
         * Copy bytes to user space. We allow for partial reads, which
         * means that the user application can request read less than
         * the full frame size. It is up to the application to issue
         * subsequent calls until entire frame is read.
         *
         * First things first, make sure we don't copy more than we
         * have - even if the application wants more. That would be
         * a big security embarassment!
         */
        if ((count + frame->seqRead_Index) > frame->seqRead_Length)
                count = frame->seqRead_Length - frame->seqRead_Index;

        /*
         * Copy requested amount of data to user space. We start
         * copying from the position where we last left it, which
         * will be zero for a new frame (not read before).
         */
        if (copy_to_user(buf, frame->data + frame->seqRead_Index, count)) {
                count = -EFAULT;
                goto read_done;
        }

count + frame->seqRead_Index can integer overflow and then buffer overflow
in copy_to_user.

--

./drivers/usb/vicam.c


static int vicam_init(struct usb_vicam *vicam)
{
        int width[] = {128, 256, 512};
        int height[] = {122, 242, 242};

        dbg("vicam_init");
        buf = kmalloc(0x1e480, GFP_KERNEL);
        buf2 = kmalloc(0x1e480, GFP_KERNEL);

static long vicam_v4l_read(struct video_device *vdev, char *user_buf, unsigned long buflen, int noblock)
{
        //struct usb_vicam *vicam = (struct usb_vicam *)vdev;

        dbg("vicam_v4l_read(%ld)", buflen);

        if (!vdev || !buf)
                return -EFAULT;

        if (copy_to_user(user_buf, buf2, buflen))
                return -EFAULT;
        return buflen;
}

is this crazy? i was thinking this was impossible (ie, upper layer checking
for it), but other drivers have explicit checks..

am i crazy here? (i still think i am).  

         * First things first, make sure we don't copy more than we
         * have - even if the application wants more. That would be
         * a big security embarassment!
         */

from the other sources above ;-) (which has an integer and sign overflows)

--

./net/x25/af_x25.c


        len = min_t(unsigned int, len, sizeof(int));

        if (len < 0)
                return -EINVAL;

the len < 0 check is always false.

^^ silly pedant that i am.

--
Silvio

Communicate in total privacy.
Get your free encrypted email at https://www.hushmail.com/?l=2

Looking for a good deal on a domain name? http://www.hush.com/partners/offers.cgi?id=domainpeople

