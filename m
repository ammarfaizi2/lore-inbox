Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTGXCJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 22:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTGXCJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 22:09:43 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:51068 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263152AbTGXCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 22:09:40 -0400
Date: Wed, 23 Jul 2003 22:24:59 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp64-178.boston.redhat.com
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4 and 2.4.22-pre7
In-Reply-To: <3F1E2B94.5010602@gibraltar.at>
Message-ID: <Pine.LNX.4.44.0307232136370.8637-100000@dhcp64-178.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jul 2003, Rene Mayrhofer wrote:

> Alan Cox wrote:
> > On Maw, 2003-07-22 at 23:14, Mika Penttilä wrote:
> > 
> >>/sbin/init used to start up with files->count > 1 and does 
> >>close(0);close(1);close(2); -> kernel thread fds close.
> >>
> >>Now with unshare_files() and init's files->count ==1 the kernel threads  
> >>/dev/console fds remain open. But one could ask of course so what :)
> The problem with this behaviour is that the old root fs can not be 
> unmounted in this case, which basically means that the machine will be 
> unable to switch off its harddisk. And that, at least in my case, is 
> annoying :)
> 
> 
> > In other words the kernel side got caught out because it assumed 
> > the bogus thread behaviour and needs some close() calls adding. That
> > would make sense.
> I have to admin that I don't really know the internals and thus don't 
> completely understand. What would need to be done to fix it ? Change 
> init's re-exec routines ?

right. so the semantics of how file tables are shared has changed a bit. I
would think that for at least 'init', it'd be nice to preserve the
original behavior, for situations such as you described. Something like
the following would probably work, although i havent' tried the test
script.

--- linux/kernel/fork.c.orig  2003-07-23 21:34:59.000000000 -0400
+++ linux/kernel/fork.c       2003-07-23 21:35:45.000000000 -0400
@@ -558,7 +558,7 @@ int unshare_files(void)
 
        /* This can race but the race causes us to copy when we don't
           need to and drop the copy */
-       if(atomic_read(&files->count) == 1)
+       if(atomic_read(&files->count) == 1 || (current->pid == 1))
        {
                atomic_inc(&files->count);
                return 0;
   

