Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbTAMFq5>; Mon, 13 Jan 2003 00:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268296AbTAMFq5>; Mon, 13 Jan 2003 00:46:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39172 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268295AbTAMFq4>;
	Mon, 13 Jan 2003 00:46:56 -0500
Date: Sun, 12 Jan 2003 21:55:52 -0800
From: Greg KH <greg@kroah.com>
To: Petr.Titera@whitesoft.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB
Message-ID: <20030113055552.GB3604@kroah.com>
References: <OF5C27F452.AC6AECA2-ONC1256CAC.0070FAA4@vgd.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5C27F452.AC6AECA2-ONC1256CAC.0070FAA4@vgd.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:44:42PM +0100, Petr.Titera@whitesoft.cz wrote:
> Hello all,
> 
>      I have problems with USB in recent kernels (tested on 2.5.56) and
> RedHat 8.0. Right after end of script  '/etc/rc.d/rc.sysinit' and before
> script '/etc/rc.d/rc' which runs after USB  daemon khubd gets some signal
> and ends. From this point USB does not work as as system does not get any
> plug events. If I disable USB at startup and load modules later, everything
> works.

Can you try this patch that I just added to the USB tree?  It seems to
work for me.

thanks,

greg k-h


# USB: Fix from Jeff and Pete to keep khubd from being able to be killed
#      by a signal

diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Sun Jan 12 22:03:13 2003
+++ b/drivers/usb/core/hub.c	Sun Jan 12 22:03:13 2003
@@ -1085,6 +1085,12 @@
 
 	daemonize();
 
+	/* keep others from killing us */
+	spin_lock_irq(&current->sig->siglock);
+	sigemptyset(&current->blocked);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sig->siglock);
+
 	/* Setup a nice name */
 	strcpy(current->comm, "khubd");
 
