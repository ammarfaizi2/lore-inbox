Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVAEPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVAEPld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVAEPjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:39:46 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:33117 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262085AbVAEPZS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:25:18 -0500
Date: Wed, 5 Jan 2005 17:25:11 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Arnd Bergmann <arnd@arndb.de>
Cc: discuss@x86-64.org, Chris Wedgwood <cw@f00f.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, gordon.jin@intel.com
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioct l32 revisited.
Message-ID: <20050105152511.GB19758@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200412262349.24856.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200412262349.24856.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Arnd Bergmann (arnd@arndb.de) "Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioct l32 revisited.":
> On Sünndag 26 Dezember 2004 23:26, Chris Wedgwood wrote:
> > > It's an internal error code as Arnd pointed out.
> > 
> > can we be sure this will never escape to userspace? i can think of
> > somewhere else we already do this (EFSCORRUPTED) and it does (somewhat
> > deliberately escape to userspace) and this causes confusion from time
> > to time when applications see 'errno == 990'
> 
> It's safe for the compat ioctl case. If someone wants to use the
> same function for the compat and native handler, it would be a bug
> to return -ENOIOCTLCMD from that handler with the current code.
> 
> To work around this, we could either convert -ENOIOCTLCMD to -EINVAL
> when returning from sys_ioctl(). Or we could WARN_ON(err ==
> -ENOIOCTLCMD)
> for the native path in order to make the intention clear.
> 
>  Arnd <><

You mean like this?

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
--- linux-2.6.10/fs/ioctl.c.ok  2005-01-05 21:13:46.165718632 +0200
+++ linux-2.6.10/fs/ioctl.c     2005-01-05 21:14:09.341195424 +0200
@@ -162,7 +162,7 @@ asmlinkage long sys_ioctl(unsigned int f
 out:
        fput_light(filp, fput_needed);
 out2:
-       return error;
+       return error==-ENOIOCTLCMD?-ENOTTY:error;
 }

 /*
--- linux-2.6.10/fs/compat.c.ok 2005-01-05 21:15:34.221291688 +0200
+++ linux-2.6.10/fs/compat.c    2005-01-05 21:16:04.922624376 +0200
@@ -476,7 +476,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 out:
        fput_light(filp, fput_needed);
 out2:
-       return error;
+       return error==-ENOIOCTLCMD?-ENOTTY:error;
 }

 static int get_compat_flock(struct flock *kfl, struct compat_flock __user *ufl)
