Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbTAMH7J>; Mon, 13 Jan 2003 02:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAMH7J>; Mon, 13 Jan 2003 02:59:09 -0500
Received: from [212.27.202.178] ([212.27.202.178]:11140 "EHLO sakal.vgd.cz")
	by vger.kernel.org with ESMTP id <S267144AbTAMH7H>;
	Mon, 13 Jan 2003 02:59:07 -0500
Subject: Re: Problems with USB
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF08F436B6.5ED0DD79-ONC1256CAD.002CEDA7-C1256CAD.002CABBA@vgd.cz>
From: Petr.Titera@whitesoft.cz
Date: Mon, 13 Jan 2003 09:13:44 +0100
X-MIMETrack: Serialize by Router on Sakal/SRV/SOCO/CZ(Release 5.0.8 |June 18, 2001) at
 13.01.2003 09:13:48
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

     yes it look that this patch can work. But who send that signal. I
tried to hack kernel to print signal number and it looks, that khubd gets
SIGHUP.

Petr Titera
petr.titera@whitesoft.cz



                                                                                            
                    Greg KH                                                                 
                    <greg@kroah.co       To:     Petr.Titera@whitesoft.cz                   
                    m>                   cc:     linux-kernel@vger.kernel.org               
                                         Fax to:                                            
                    13.01.2003           Subject:     Re: Problems with USB                 
                    06:55                                                                   
                                                                                            
                                                                                            




On Sun, Jan 12, 2003 at 09:44:42PM +0100, Petr.Titera@whitesoft.cz wrote:
> Hello all,
>
>      I have problems with USB in recent kernels (tested on 2.5.56) and
> RedHat 8.0. Right after end of script  '/etc/rc.d/rc.sysinit' and before
> script '/etc/rc.d/rc' which runs after USB  daemon khubd gets some signal
> and ends. From this point USB does not work as as system does not get any
> plug events. If I disable USB at startup and load modules later,
everything
> works.

Can you try this patch that I just added to the USB tree?  It seems to
work for me.

thanks,

greg k-h


# USB: Fix from Jeff and Pete to keep khubd from being able to be killed
#      by a signal

diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c  Sun Jan 12 22:03:13 2003
+++ b/drivers/usb/core/hub.c  Sun Jan 12 22:03:13 2003
@@ -1085,6 +1085,12 @@

     daemonize();

+    /* keep others from killing us */
+    spin_lock_irq(&current->sig->siglock);
+    sigemptyset(&current->blocked);
+    recalc_sigpending();
+    spin_unlock_irq(&current->sig->siglock);
+
     /* Setup a nice name */
     strcpy(current->comm, "khubd");




