Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbTD1S7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTD1S7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:59:31 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:9376 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261253AbTD1S72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:59:28 -0400
Date: Mon, 28 Apr 2003 12:11:37 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 8 potential user-pointer errors that allow arbitrary
 writes to kernel
In-Reply-To: <1051534156.16805.13.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.44.0304281206330.19401-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot for the confirmations!

-Junfeng

On 28 Apr 2003, Alan Cox wrote:

> On Llu, 2003-04-28 at 07:50, Junfeng Yang wrote:
> > /home/junfeng/linux-tainted/drivers/usb/media/vicam.c:617:vicam_ioctl:
> > ERROR:TAINTED:617:617: dereferencing tainted ptr 'vp' [Callstack:
> > /home/junfeng/linux-tainted/drivers/scsi/sg.c:1002:vicam_ioctl((tainted
> > 3))]
> >
> > 			struct video_picture *vp = (struct video_picture
> > *) arg;
> >
> > 			DBG("VIDIOCSPICT depth = %d, pal = %d\n",
> > vp->depth,
> > 			    vp->palette);
> >
> >
> > Error --->
>
> Correct report. Fixed in 2.4.21-ac now
>
> > /home/junfeng/linux-tainted/drivers/video/sis/sis_main.c:2476:sisfb_ioctl:
> > ERROR:TAINTED:2476:2476: dereferencing tainted ptr 'x' [Callstack:
> > /home/junfeng/linux-tainted/drivers/video/sstfb.c:808:sisfb_ioctl((tainted
> > 3))]
> >
>
> Correct - already fixed in 2.4.21-ac
>
> > ---------------------------------------------------------
> > [BUG] can write to anywhere in kernel. do_read is assigned to
> > file_operations.read, which can take tainted inputs. even the parm itself
> > has a name pUserBuffer
> >
> > /home/junfeng/linux-tainted/drivers/isdn/eicon/linchr.c:166:do_read:
> > ERROR:TAINTED:166:166: passing tainted ptr 'pClientLogBuffer' to
> > __constant_memcpy [Callstack:
> > /home/junfeng/linux-tainted/drivers/scsi/sg.c:362:do_read((tainted 1))]
> >
> >
> > 	pHeadItem = (klog_t *) DivasLogFifoRead();
> >
> Correct - fixed in 2.4.21-ac now
>
> > [BUG] can write to anywhere in kernel. in the same subdir,
> > midi_synth.c:midi_synth_ioctl does __copy_to_user(not copy_to_user?). it
> > could be that there are some assumptions about the devices.
> >
> > /home/junfeng/linux-tainted/sound/oss/mpu401.c:792:mpu_synth_ioctl:
> > ERROR:TAINTED:792:792: passing tainted ptr 'arg' to __constant_memcpy
> > [Callstack:
> > /home/junfeng/linux-tainted/sound/oss/midi_synth.c:270:mpu_synth_ioctl((tainted
> > 2))]
>
> The verify is done in soundcard.c
> Fixed mpu_synth_ioctl in 2.4.21-ac
>
> > [BUG] can write to anywhere in kernel. mdc800_device_read is assigned to
> > file_operations.read, which can take tainted inputs
> >
> > /home/junfeng/linux-tainted/drivers/usb/image/mdc800.c:750:mdc800_device_read:
> > ERROR:TAINTED:750:750: passing tainted ptr 'ptr' to __memcpy [Callstack:
> > /home/junfeng/linux-tainted/drivers/scsi/sg.c:362:mdc800_device_read((tainted
> > 1))]
>
> Correct. Fixed in 2.4.21-ac
>
>
> > [BUG] can write to anywhere in kernel. file_operations.write
> >
> > /home/junfeng/linux-tainted/drivers/usb/image/mdc800.c:805:mdc800_device_write:
> > ERROR:TAINTED:805:805: dereferencing tainted ptr 'buf + i' [Callstack:
> > /home/junfeng/linux-tainted/drivers/media/dvb/av7110/av7110.c:3858:mdc800_device_write((tainted
> > 1))]
>
> Correct, fixed in 2.4.21-ac
>
>
> > [BUG] can write to anywhere in kernel. awe_ioctl is assigned to
> > file_operations.ioctl
> >
> > /home/junfeng/linux-tainted/sound/oss/awe_wave.c:2049:awe_ioctl:
> > ERROR:TAINTED:2049:2049: passing tainted ptr 'arg' to __constant_memcpy
> > [Callstack:
> > /home/junfeng/linux-tainted/sound/oss/midi_synth.c:270:awe_ioctl((tainted
> > 2))]
> >
> > 	case SNDCTL_SYNTH_INFO:
> > 		if (playing_mode == AWE_PLAY_DIRECT)
> > 			awe_info.nr_voices = awe_max_voices;
> > 		else
> > 			awe_info.nr_voices = AWE_MAX_CHANNELS;
> >
> > Error --->
> > 		memcpy((char*)arg, &awe_info, sizeof(awe_info));
>
> Already fixed in 2.4, but correct report
>

