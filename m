Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTIRXM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbTIRXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:12:27 -0400
Received: from [193.138.115.2] ([193.138.115.2]:11276 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262015AbTIRXMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:12:24 -0400
Date: Fri, 19 Sep 2003 01:10:40 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: netpoll/netconsole minor tweaks
In-Reply-To: <1063919555.16536.5.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0309190103240.10809@jju_lnx.backbone.dif.dk>
References: <20030917112447.A24623@osdlab.pdx.osdl.net> 
 <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk> 
 <20030918094832.A16499@osdlab.pdx.osdl.net> <1063919555.16536.5.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Sep 2003, Alan Cox wrote:

> On Iau, 2003-09-18 at 17:48, Chris Wright wrote:
> > > <pedant>
> > > should be cpu_relax();
> > > </pedant>
> >
> > Hrm, there's many spots that aren't using it.  What's the benefit, less
> > power consumption?  Is it worth a patch to convert other things over?
>
> It speeds up hyperthreading CPUs by letting them know that this
> paticular thread is waiting for stuff (sched_yield for silicon)
>

Does that mean that it would be benneficial to do something like this in
for example eepro100.c ??

diff -up linux-2.6.0-test5-orig/drivers/net/eepro100.c
linux-2.6.0-test5/drivers/net/eepro100.c
--- linux-2.6.0-test5-orig/drivers/net/eepro100.c       2003-09-08 21:50:09.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/eepro100.c    2003-09-19 01:03:19.000000000 +0200
@@ -913,9 +913,11 @@ static void do_slow_command(struct net_d

        for (wait = 0; wait <= 100; wait++)
                if (inb(cmd_ioaddr) == 0) return;
-       for (; wait <= 20000; wait++)
+       for (; wait <= 20000; wait++) {
                if (inb(cmd_ioaddr) == 0) return;
                else udelay(1);
+               cpu_relax();
+       }
        printk(KERN_ERR "Command %4.4x was not accepted after %d polls!"
               "  Current status %8.8x.\n",
               cmd, wait, inl(dev->base_addr + SCBStatus));



or maybe even take it to the extreme like


diff -up linux-2.6.0-test5-orig/drivers/net/eepro100.c
linux-2.6.0-test5/drivers/net/eepro100.c
--- linux-2.6.0-test5-orig/drivers/net/eepro100.c       2003-09-08 21:50:09.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/eepro100.c    2003-09-19 01:07:50.000000000 +0200
@@ -902,20 +902,25 @@ static void do_slow_command(struct net_d
 {
        long cmd_ioaddr = dev->base_addr + SCBCmd;
        int wait = 0;
-       do
+       do {
                if (inb(cmd_ioaddr) == 0) break;
-       while(++wait <= 200);
+               cpu_relax();
+       } while(++wait <= 200);
        if (wait > 100)
                printk(KERN_ERR "Command %4.4x never accepted (%d
polls)!\n",
                       inb(cmd_ioaddr), wait);

        outb(cmd, cmd_ioaddr);

-       for (wait = 0; wait <= 100; wait++)
+       for (wait = 0; wait <= 100; wait++) {
                if (inb(cmd_ioaddr) == 0) return;
-       for (; wait <= 20000; wait++)
+               cpu_relax();
+       }
+       for (; wait <= 20000; wait++) {
                if (inb(cmd_ioaddr) == 0) return;
                else udelay(1);
+               cpu_relax();
+       }
        printk(KERN_ERR "Command %4.4x was not accepted after %d polls!"
               "  Current status %8.8x.\n",
               cmd, wait, inl(dev->base_addr + SCBStatus));


How short/long waits are we talking about before it is benneficial to be
calling cpu_relax() ?


Kind regards,

Jesper Juhl <jju@dif.dk>
