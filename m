Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVBWLDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVBWLDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVBWLDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:03:50 -0500
Received: from zamok.crans.org ([138.231.136.6]:32428 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261456AbVBWLDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:03:45 -0500
From: Mathieu Segaud <Mathieu.Segaud@crans.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
References: <20050223014233.6710fd73.akpm@osdl.org>
Date: Wed, 23 Feb 2005 12:03:43 +0100
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 23 Feb 2005 01:42:33 -0800")
Message-ID: <87psyredww.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@osdl.org> disait derni=C3=A8rement que :

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/=
2.6.11-rc4-mm1/
>
>
> - Various fixes and updates all over the place.  Things seem to have slow=
ed
>   down a bit.
>
> - Last, final, ultimate call: if anyone has patches in here which are 2.6=
.11
>   material, please tell me.
>
>
>
> Changes since 2.6.11-rc3-mm1:

[snip]

> +inotify.patch
>
>  Not sure if this is the latest version.

it is the latest Robert Love posted against -mm kernels, but in
inotify_ignore():

static int inotify_ignore(struct inotify_device *dev, s32 wd)
{
	struct inotify_watch *watch;
	int ret =3D 0;

	spin_lock(&dev->lock);
	watch =3D dev_find_wd(dev, wd);
	spin_unlock(&dev->lock); <------------- lock is released, but
	if (!watch) {
		ret =3D -EINVAL;
		goto out;
	}
	__remove_watch(watch, dev); <---------- must be called with lock held

out:
	spin_unlock(&dev->lock); <------------- anyway, lock is=20
	return ret;                             released and sub_preempt_count
}                                               BUG's on SMP and PREEMPT


__remove_watch() must be called with ->lock held on dev.
Anyway, ->lock is released after label out.

Signed-off-by: Mathieu Segaud <matt@minas-morgul.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=fix-double-spin_unlock-in-inotify_ignore.patch

--- a/drivers/char/inotify.c	2005-02-23 11:55:21.321385752 +0100
+++ b/drivers/char/inotify.c	2005-02-23 11:55:29.772101048 +0100
@@ -952,7 +952,7 @@
 
 	spin_lock(&dev->lock);
 	watch = dev_find_wd(dev, wd);
-	spin_unlock(&dev->lock);
+
 	if (!watch) {
 		ret = -EINVAL;
 		goto out;

--=-=-=



-- 
> Can you explain this behaviour?

Yes
--
Alan

[Oh wait you want to know why...]

	- Alan Cox on linux-kernel

--=-=-=--
