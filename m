Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161467AbWJKVTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbWJKVTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbWJKVTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:19:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:21922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161420AbWJKVIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:07 -0400
Date: Wed, 11 Oct 2006 14:07:44 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mchehab@infradead.org,
       Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 48/67] Fix VIDIOC_ENUMSTD bug
Message-ID: <20061011210744.GW16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-vidioc_enumstd-bug.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jonathan Corbet <corbet-v4l@lwn.net>

The v4l2 API documentation for VIDIOC_ENUMSTD says:

	To enumerate all standards applications shall begin at index
	zero, incrementing by one until the driver returns EINVAL.

The actual code, however, tests the index this way:

               if (index<=0 || index >= vfd->tvnormsize) {
                        ret=-EINVAL;

So any application which passes in index=0 gets EINVAL right off the bat
- and, in fact, this is what happens to mplayer.  So I think the
following patch is called for, and maybe even appropriate for a 2.6.18.x
stable release.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/media/video/videodev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/media/video/videodev.c
+++ linux-2.6.18/drivers/media/video/videodev.c
@@ -836,7 +836,7 @@ static int __video_do_ioctl(struct inode
 			break;
 		}
 
-		if (index<=0 || index >= vfd->tvnormsize) {
+		if (index < 0 || index >= vfd->tvnormsize) {
 			ret=-EINVAL;
 			break;
 		}

--
