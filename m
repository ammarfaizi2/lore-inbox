Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSBJDtj>; Sat, 9 Feb 2002 22:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289234AbSBJDt3>; Sat, 9 Feb 2002 22:49:29 -0500
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:2058
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id <S289236AbSBJDtM>; Sat, 9 Feb 2002 22:49:12 -0500
Message-ID: <3C65EFF4.2000906@alpha.dyndns.org>
Date: Sat, 09 Feb 2002 19:58:44 -0800
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: video4linux-list@redhat.com
CC: Kernel List <linux-kernel@vger.kernel.org>, kraxel@bytesex.org
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
In-Reply-To: <20020209194602.A23061@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

>It also provides a ioctl wrapper function which handles copying the
>ioctl args from/to userspace, so we have this at one place can drop all
>the copy_from/to_user calls within the v4l device driver ioctl handlers.
>

Excellent work. I have no complaints, just a few questions:

1. Would it be better to memset the temp buffer in video_generic_ioctl() 
rather than in the driver? I've seen so many drivers forget to do this, 
and it's a potential (albeit very small) security hole.

2. In skeleton_open(), couldn't the device_data lookup code be replaced 
with:

    struct video_device *vdev = video_devdata(file);
    struct device_data *dev = vdev->priv;

3. In skeleton_initdev(), shouldn't...

    dev->vdev = skeleton_template;

...be...

    memcpy(&dev->vdev, &skeleton_template, sizeof(skeleton_template);

4. Is it safe to keep even 128 bytes on the stack in 
video_generic_ioctl()? Consider that devices might spend a relatively 
long time blocking on VIDIOCSYNC. With 32 devices in use at once, you'd 
be coming dangerously close to a stack overflow. IMHO it would be better 
to only allocate as much as MCAPTURE and SYNC need, and fall back on 
kmalloc for the less time-critical ones (if necessary).

Other than that, I extremely happy with what you've done!

-- 
Mark McClelland
mmcclell@bigfoot.com



