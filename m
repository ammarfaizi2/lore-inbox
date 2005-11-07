Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVKGKQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVKGKQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVKGKQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:16:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:59639 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964811AbVKGKQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:16:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: [PATCH 09/25] v4l: move ioctl32 handlers to drivers/media/
Date: Mon, 7 Nov 2005 11:17:48 +0100
User-Agent: KMail/1.7.2
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162714.261619000@b551138y.boeblingen.de.ibm.com> <1131250426.19680.29.camel@localhost>
In-Reply-To: <1131250426.19680.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511071117.50613.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 06 November 2005 05:13, Mauro Carvalho Chehab wrote:
> Em Sáb, 2005-11-05 às 17:26 +0100, Arnd Bergmann escreveu:
> > anexo Documento somente texto (compat_vidio.diff)
> > This moves the 32 bit ioctl compatibility handlers for
> > Video4Linux into a new file and adds explicit calls to them
> > to each v4l device driver.
> 
> 	Thanks for your patch, but IMHO, it should't be applied on mainstream.
> It would be better if we apply it on V4L tree and do some work on it to
> improve handling the compat stuff.

Sure, that sounds reasonable.

> > Unfortunately, there does not seem to be any code handling
> > the v4l2 ioctls, so quite often the code goes through two
> > separate conversions, first from 32 bit v4l to 64 bit v4l,
> > and from there to 64 bit v4l2. My patch does not change
> > that, so there is still much room for improvement.
> 	As you mentioned, some changes would be required to make it more
> robust. Also, we are introducing some newer devices that would require
> also conversion (already on -mm tree).
> 	On the other hand, compat_ioctl.c is not a good name, since there is
> v4l1-compat.c, meant to handle compat ioctl between the old API and the
> newer one.

Yes, I noticed that. The problem is that compat_ioctl is the conventional
name for 32 bit compatibility ioctl handlers in many other places, so
is was already confusing before my patch.

Maybe it makes sense to name the new file ioctl32 instead, as that is
also used in other places.

> > Also, some drivers have additional ioctl numbers, for
> > which the conversion should be handled internally to
> > that driver.
> 
> 	This is an interesting question: current version only handles V4L1
> ioctls:
> 
> +#define VIDIOCGTUNER32         _IOWR('v',4, struct video_tuner32)
> +#define VIDIOCSTUNER32         _IOW('v',5, struct video_tuner32)
> +#define VIDIOCGWIN32           _IOR('v',9, struct video_window32)
> +#define VIDIOCSWIN32           _IOW('v',10, struct video_window32)
> +#define VIDIOCGFBUF32          _IOR('v',11, struct video_buffer32)
> +#define VIDIOCSFBUF32          _IOW('v',12, struct video_buffer32)
> +#define VIDIOCGFREQ32          _IOR('v',14, u32)
> +#define VIDIOCSFREQ32          _IOW('v',15, u32)
> +
> 	The intention is to depreciate V4L1 old api (from 2.4 series), in favor
> of V4L2 API. The old API have several issues and doesn't support some
> video standards variations used on several countries.

You should really do that only after the V4L2 ioctl32 conversion has been
added. I'm personally watching TV going through both ioctl conversion layers
(xawtv finds 32 bit V4L2 is not implemented, falls back to 32 bit V4L1, that
is converted in the kernel to 64 bit V4L1 and then to 64 bit V4L2 when it
reaches the driver).

> 	Newer drivers (em28xx, cx88, saa7134), used by the modern boards don't
> directly implement the old API anymore. All calls are directed to
> v4l1-compat, that translates into V4L2 calls. We are also testing some
> patches to use this way also for bttv drivers. The intention is to make
> v4l1 obsolete and remove from kernel, maybe for 2.6.18 or 2.6.20.
> 
> 	We should seriously check this patch, to see if it does make sense with
> current implemented ioctls.

Note that my patch does not change any behavior relative to 2.6.14 vanilla, it
just moves the conversion handlers to a different place.

	Arnd <><
