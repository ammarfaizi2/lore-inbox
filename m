Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWJKVqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWJKVqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWJKVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:46:17 -0400
Received: from vena.lwn.net ([206.168.112.25]:61082 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1422658AbWJKVqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:46:15 -0400
To: Greg KH <gregkh@suse.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mchehab@infradead.org,
       linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch 48/67] Fix VIDIOC_ENUMSTD bug 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 11 Oct 2006 14:07:44 PDT."
             <20061011210744.GW16627@kroah.com> 
Date: Wed, 11 Oct 2006 15:46:15 -0600
Message-ID: <10090.1160603175@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So any application which passes in index=0 gets EINVAL right off the bat
> - and, in fact, this is what happens to mplayer.  So I think the
> following patch is called for, and maybe even appropriate for a 2.6.18.x
> stable release.

The fix is worth having, though I guess I'm no longer 100% sure it's
necessary for -stable, since I don't think anything in-tree other than
vivi uses this interface in 2.6.18.  If you are going to include it,
though, it makes sense to put in Sascha's fix too - both are needed to
make the new v4l2 ioctl() interface operate as advertised.

jon


From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] copy-paste bug in videodev.c
Date: Mon, 11 Sep 2006 10:50:55 +0200
To: video4linux-list@redhat.com

This patch fixes a copy-paste bug in videodev.c where the vidioc_qbuf()
function gets called for the dqbuf ioctl.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/drivers/media/video/videodev.c
b/drivers/media/video/videodev.c
index 88bf2af..8abee33 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -739,13 +739,13 @@ static int __video_do_ioctl(struct inode
 	case VIDIOC_DQBUF:
 	{
 		struct v4l2_buffer *p=arg;
-		if (!vfd->vidioc_qbuf)
+		if (!vfd->vidioc_dqbuf)
 			break;
 		ret = check_fmt (vfd, p->type);
 		if (ret)
 			break;
 
-		ret=vfd->vidioc_qbuf(file, fh, p);
+		ret=vfd->vidioc_dqbuf(file, fh, p);
 		if (!ret)
 			dbgbuf(cmd,vfd,p);
 		break;


-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list

