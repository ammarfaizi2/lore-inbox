Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRCHIlH>; Thu, 8 Mar 2001 03:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131294AbRCHIk5>; Thu, 8 Mar 2001 03:40:57 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:9006 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S131293AbRCHIks>;
	Thu, 8 Mar 2001 03:40:48 -0500
Message-ID: <3AA74566.2EC76FFA@vz.cit.alcatel.fr>
Date: Thu, 08 Mar 2001 09:40:06 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: cooker@linux-mandrake.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Cooker] help!  modprobe can't locate binfmt-0000 ?
In-Reply-To: <Pine.A41.4.10.10103071340430.90026-100000@acs5.acs.ucalgary.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Woods a écrit :

> >       I loaded the latest from sunsite.uio.no about 6:00 PM CST, then
> > tried to reboot.  I get the following message about 6 times, then
> > Aurora tries to start, then I get it like 4 more times, then the system
> > locks up.  The message :
> >
> > modprobe:  modprobe:  Can't locate module binfmt-0000
> >
> > What does this mean, and more important - how can I fix it?
> > Vinny
>
> You most likely have a binary program corrupted or file size 0.
>
> I had this problem with /sbin/ipchains somehow set to file size 0.
> Re-installing the proper RPM fixed the problem for me.
>

With the foolowing patch, I have identified the weird file:

diff -Bbu /src/linux/fs/exec.c.orig /src/linux/fs/exec.c
--- exec.c.orig Wed Mar  7 21:47:33 2001
+++ exec.c Wed Mar  7 21:47:20 2001
@@ -826,6 +826,7 @@
        printable(bprm->buf[2]) &&
        printable(bprm->buf[3]))
     break; /* -ENOEXEC */
+printk("execmod:%s\n",bprm->filename);
    sprintf(modname, "binfmt-%04x", *(unsigned short *)(&bprm->buf[2]));
    request_module(modname);
 #endif

And I got:
#Mar  7 21:40:56 bcv66vbb kernel: execmod:/etc/X11/xinit.d/msec
#Mar  7 21:40:56 bcv66vbb modprobe: modprobe: Can't locate module binfmt-0000

Could this patch, or a better one, testing the result of request_module
be included in the kernel source. modprobe message have not enough information

