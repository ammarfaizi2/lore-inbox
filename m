Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVKFEOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVKFEOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKFEOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:14:00 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:10389 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932268AbVKFEN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:13:59 -0500
Subject: Re: [PATCH 09/25] v4l: move ioctl32 handlers to drivers/media/
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20051105162714.261619000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162714.261619000@b551138y.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 06 Nov 2005 02:13:45 -0200
Message-Id: <1131250426.19680.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

Em Sáb, 2005-11-05 às 17:26 +0100, Arnd Bergmann escreveu:
> anexo Documento somente texto (compat_vidio.diff)
> This moves the 32 bit ioctl compatibility handlers for
> Video4Linux into a new file and adds explicit calls to them
> to each v4l device driver.

	Thanks for your patch, but IMHO, it should't be applied on mainstream.
It would be better if we apply it on V4L tree and do some work on it to
improve handling the compat stuff.
> 
> Unfortunately, there does not seem to be any code handling
> the v4l2 ioctls, so quite often the code goes through two
> separate conversions, first from 32 bit v4l to 64 bit v4l,
> and from there to 64 bit v4l2. My patch does not change
> that, so there is still much room for improvement.
	As you mentioned, some changes would be required to make it more
robust. Also, we are introducing some newer devices that would require
also conversion (already on -mm tree).
	On the other hand, compat_ioctl.c is not a good name, since there is
v4l1-compat.c, meant to handle compat ioctl between the old API and the
newer one.
> 
> Also, some drivers have additional ioctl numbers, for
> which the conversion should be handled internally to
> that driver.

	This is an interesting question: current version only handles V4L1
ioctls:

+#define VIDIOCGTUNER32         _IOWR('v',4, struct video_tuner32)
+#define VIDIOCSTUNER32         _IOW('v',5, struct video_tuner32)
+#define VIDIOCGWIN32           _IOR('v',9, struct video_window32)
+#define VIDIOCSWIN32           _IOW('v',10, struct video_window32)
+#define VIDIOCGFBUF32          _IOR('v',11, struct video_buffer32)
+#define VIDIOCSFBUF32          _IOW('v',12, struct video_buffer32)
+#define VIDIOCGFREQ32          _IOR('v',14, u32)
+#define VIDIOCSFREQ32          _IOW('v',15, u32)
+
	The intention is to depreciate V4L1 old api (from 2.4 series), in favor
of V4L2 API. The old API have several issues and doesn't support some
video standards variations used on several countries.

	Newer drivers (em28xx, cx88, saa7134), used by the modern boards don't
directly implement the old API anymore. All calls are directed to
v4l1-compat, that translates into V4L2 calls. We are also testing some
patches to use this way also for bttv drivers. The intention is to make
v4l1 obsolete and remove from kernel, maybe for 2.6.18 or 2.6.20.

	We should seriously check this patch, to see if it does make sense with
current implemented ioctls.
> 
> CC: mchehab@brturbo.com.br
> CC: video4linux-list@redhat.com
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Cheers, 
Mauro.

