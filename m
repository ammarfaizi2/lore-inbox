Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285055AbRL0GPU>; Thu, 27 Dec 2001 01:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRL0GPL>; Thu, 27 Dec 2001 01:15:11 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:16400 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285055AbRL0GOx>;
	Thu, 27 Dec 2001 01:14:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Niels Kristian Bech Jensen <nkbj@image.dk>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1 
In-Reply-To: Your message of "Thu, 27 Dec 2001 07:05:06 BST."
             <Pine.LNX.4.33.0112270704240.14041-100000@helium.nkbj.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 17:14:39 +1100
Message-ID: <12760.1009433679@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001 07:05:06 +0100 (CET), 
Niels Kristian Bech Jensen <nkbj@image.dk> wrote:
>On Thu, 27 Dec 2001, Keith Owens wrote:
>> You have to select CONFIG_FB_SIS as well.  This is a deficency in CML1
>> that is difficult to fix, there are cross directory dependencies.
>> 
>This workaround seems to work (I know it's ugly):
>
>--- linux-2.4.18-pre1/drivers/char/drm/Config.in	Sat Dec 22 07:20:44 2001
>+++ linux/drivers/char/drm/Config.in	Thu Dec 27 06:51:19 2001
>@@ -14,4 +14,7 @@
>     dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP
>     dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
>     dep_tristate '  SiS' CONFIG_DRM_SIS $CONFIG_AGP
>+    if [ "$CONFIG_DRM_SIS" != "n" ]; then
>+        define_bool CONFIG_FB_SIS y
>+    fi
> fi
>--- linux-2.4.18-pre1/drivers/video/Config.in	Fri Nov 23 07:41:27 2001
>+++ linux/drivers/video/Config.in	Thu Dec 27 06:30:32 2001
>@@ -139,6 +139,9 @@
>  	 tristate '  ATI Radeon display support (EXPERIMENTAL)' CONFIG_FB_RADEON
> 	 tristate '  ATI Rage128 display support (EXPERIMENTAL)' CONFIG_FB_ATY128
> 	 tristate '  SIS acceleration (EXPERIMENTAL)' CONFIG_FB_SIS
>+	 if [ "$CONFIG_DRM_SIS" != "n" -a "$CONFIG_FB_SIS" != "y" ]; then
>+	    define_bool CONFIG_FB_SIS y
>+	 fi
> 	 if [ "$CONFIG_FB_SIS" != "n" ]; then
> 	    bool '    SIS 630/540/730 support' CONFIG_FB_SIS_300
> 	    bool '    SIS 315H/315 support' CONFIG_FB_SIS_315

Breaks with CONFIG_FB=n.  You are setting CONFIG_FB_SIS=y when the
overall FB system may be disabled, that will not work.

The problem is that DRM_SIS should only be visible when FB=y,
EXPERIMENTAL=y, PCI=y and FB_SIS=y.  But the FB stuff is in
drivers/video which is read after drivers/char.  Easy to do in CML2,
almost impossible in CML1.

