Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRCSUwO>; Mon, 19 Mar 2001 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRCSUvz>; Mon, 19 Mar 2001 15:51:55 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:11225 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131630AbRCSUvw>; Mon, 19 Mar 2001 15:51:52 -0500
Date: Mon, 19 Mar 2001 15:50:56 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: USB Mouse Problem in 2.4 Kernels - 2.2.18 Works Fine
Message-ID: <20010319155056.C23687@devserv.devel.redhat.com>
In-Reply-To: <20010317221129.A15218@devserv.devel.redhat.com> <200103181152.f2IBqLV06565@mail.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103181152.f2IBqLV06565@mail.redhat.com>; from aleidenf@bigpond.net.au on Sun, Mar 18, 2001 at 10:50:32PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andree Leidenfrost <aleidenf@bigpond.net.au>
> To: Pete Zaitcev <zaitcev@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Date: 18 Mar 2001 22:50:32 +1100
> 
> > > I am experiencing problems with a USB mouse: The machine boots, X 
> > > starts, I log on, everything works as expected. When I restart X or just 
> > > change to an alpha terminal and back to x the mouse does not work any 
> > > more.  [...]
> > > Hardware is an ASUS K7V motherboard (VIA chip set), [...]
> > > T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#= 5 Spd=1.5 MxCh= 0 

> > Unfortunately, I do not have a hardware that exibits this.
> > If would be invaluable someone enabled
> > dbg() in devices/usb/hub.c only, [...]

> > ....................  [cable pulled, putting it back]
> > hub.c: port 1 connection change
> > hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
> > hub.c: port 1, portstatus 100, change 0, 12 Mb/s
> > hub.c: port 1 of hub 1 not enabled, trying reset again...

> Here is the output of a 2.2.18 kernel with the above patch:
> 
> ....................  [cable pulled, putting it back]
> Mar 18 22:41:53 aurich kernel: hub.c: port 3 connection change
> Mar 18 22:41:53 aurich kernel: hub.c: portstatus 301, change 1, 1.5 Mb/s
> Mar 18 22:41:54 aurich kernel: hub.c: portstatus 303, change 10, 1.5 Mb/s

The following patch reverts the code path to that of 2.2 and fixes
the condition on the Andree's box:

--- linux-2.4.2-0.1.19/drivers/usb/hub.c	Tue Mar 13 12:04:05 2001
+++ linux-2.4.2-0.1.19-p3/drivers/usb/hub.c	Mon Mar 19 12:03:42 2001
@@ -583,6 +583,12 @@
 		return;
 	}
 
+	/* zaitcev RHbug #23670 - 1.5Mb/s mice die when switching VCs */
+	if (portstatus & USB_PORT_STAT_LOW_SPEED) {
+		wait_ms(400);
+		delay = HUB_LONG_RESET_TIME;
+	}
+
 	down(&usb_address0_sem);
 
 	tempstr = kmalloc(1024, GFP_KERNEL);

I asked USB maintainers to consider it.

-- Pete
