Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWBVUkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWBVUkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWBVUkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:40:12 -0500
Received: from styx.suse.cz ([82.119.242.94]:11958 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751321AbWBVUkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:40:10 -0500
Date: Wed, 22 Feb 2006 21:40:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
Subject: Re: Suppressing softrepeat
Message-ID: <20060222204024.GA7477@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com> <20060221210800.GA12102@suse.cz> <20060222120047.4fd9051e.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222120047.4fd9051e.zaitcev@redhat.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:00:47PM -0800, Pete Zaitcev wrote:
> On Tue, 21 Feb 2006 22:08:00 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > A much simpler workaround for the DRAC3 is to set the softrepeat delay
> > to at least 750ms, using kbdrate(8), which will call the proper console
> > ioctl, resulting in updating the softrepeat parameters.
> > 
> > I prefer workarounds for problematic hardware done outside the kernel,
> > if possible.
> 
> I agree with the sentiment when posed in the abstract way, but let me
> tell you why this case is different.
> 
> Firstly, there's nothing "problematic" about this. It's just how it is.
> The only problematic thing here is our code. Currently, the situation is
> assymetric. It is possible to force softrepeat on, but not possible to
> force softrepeat off. Isn't it broken?
> 
> Secondly, 750ms may be not enough. Stuart is being shy here and posting
> explanations to Bugzilla for some reason.
> 
> Lastly, it's such a PITA to add these things into the userland, that
> it's completely impractical. Console is needed the most when things go
> wrong. In such case, that echo(1) may not be reached before the single
> user shell. And stuffing it into the initrd is for Linux weenies only,
> unless automated by mkinitrd.
> 
> I think you're being unreasonable here. I am not asking for NFS root
> or IP autoconfiguration and sort of complicated process which ought to
> be done in userland indeed.
 
I'm definitely not intending to be unreasonable, and I understand your
need to have the keyboard working all the way from the grub/lilo prompt.

I just don't like adding more module options to one that already has so
many it's hard to understand what they're used for.

How about simply this patch instead?

Setting autorepeat will not be possible on 'dumb' keyboards anymore by
default, but since these usually are special forms of hardware anyway,
like the DRAC3, this shouldn't be an issue for most users. Using
'softrepeat' on these keyboards will restore the behavior for users that
need it.

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -863,9 +863,6 @@ static int atkbd_connect(struct serio *s
 	atkbd->softrepeat = atkbd_softrepeat;
 	atkbd->scroll = atkbd_scroll;
 
-	if (!atkbd->write)
-		atkbd->softrepeat = 1;
-
 	if (atkbd->softrepeat)
 		atkbd->softraw = 1;

-- 
Vojtech Pavlik
Director SuSE Labs
