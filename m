Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262077AbSI3QGO>; Mon, 30 Sep 2002 12:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262117AbSI3QGN>; Mon, 30 Sep 2002 12:06:13 -0400
Received: from ns.suse.de ([213.95.15.193]:18180 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262077AbSI3QGL>;
	Mon, 30 Sep 2002 12:06:11 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: keyboard/mouse driver in 2.5 broken was Re: v2.6 vs v3.0
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com.suse.lists.linux.kernel> <200209290716.g8T7GNwf000562@darkstar.example.net.suse.lists.linux.kernel> <20020929091229.GA1014@suse.de.suse.lists.linux.kernel> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20020929153817.GC1014@suse.de.suse.lists.linux.kernel> <20020930153319.GA18695@ravel.coda.cs.cmu.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Sep 2002 18:11:36 +0200
In-Reply-To: Jan Harkes's message of "30 Sep 2002 17:38:00 +0200"
Message-ID: <p73zntzqwxz.fsf_-_@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> On Sun, Sep 29, 2002 at 05:38:17PM +0200, Jens Axboe wrote:
> > On Sun, Sep 29 2002, Alan Cox wrote:
> > > Most of my boxes won't even run a 2.5 tree yet. I'm sure its hardly
> > > unique. Middle of November we may begin to find out how solid the core
> > > code actually is, as drivers get fixed up and also in the other
> > > direction as we eliminate numerous crashes caused by "fixed in 2.4" bugs
> > 
> > Well why don't they run with 2.5?
> > 
> > Alan, I think you are a pessimist painting a much bleaker picture of 2.5
> > than it deserves. Sure lots of drivers may be broken still, I would be
> > naive if I thought that this is all changed in time for oct 31. Most of
> > these will not be fixed until people actually _use_ 2.5 (or 3.0-pre, or
> > whatever it will be called), and that will not happen until Linus
> > actually releases a -rc or similar. And so the fsck what? Noone expects
> > 2.6-pre/3.0-pre to be perfect.
> 
> Ok, after losing a disk in the early 2.5 series, and not being able to
> compile pretty much any kernel since 2.5.33, I decided to give 2.5.39 a
> try last weekend.
> 
> Built kernel, rebooted, almost seems to get stuch during the ide-probing
> (10 seconds wait is a conservative estimate), but it came up in single
> user. Checking for errors in /proc/kmsg, nothing. Great reboot
> multiuser start X open a window lose all access to my keyboard. Completely
> log in remotely with ssh, hmm kernel errors about unknown scancodes.

I have a similar problem. The 2.5 keyboard/psmouse driver does not work
at all with my KVM. It's a bit unusual combination in that I run an 
Intellimouse on it and the KVM doesn't let all Intellimouse extensions
through, but it is still autodetected as that. Normally (xfree86, 2.4 gpm,
other OS) it works fine when just setting PS/2 mouse maually. Even when I 
hack the kernel to force PS/2 instead of the IMPS/2 then I just get 
endless "psmouse: lost synchronization .." messages.

When I don't use the mouse and just use the keyboard it usually
works fine some time, but then eventually when doing more keyboard work
(e.g. editing a file on the console) the keyboard locks up 
again with the mouse driver complaining about 'lost sychronization' 

I guess it's needed now to use USB keyboard/mouse with 2.5 :-(

-Andi

This is the patch to force a particular mouse type, also adds some debugging
for this case. The lost byte is always a '0'

--- linux/drivers/input/mouse/psmouse.c-o	2002-09-01 00:14:40.000000000 +0200
+++ linux/drivers/input/mouse/psmouse.c	2002-09-27 03:45:55.000000000 +0200
@@ -65,6 +65,8 @@
 #define PSMOUSE_IMPS	5
 #define PSMOUSE_IMEX	6
 
+static int mousetype = -1; 
+
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2" };
 
 /*
@@ -191,7 +193,11 @@
 	}
 
 	if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/20)) {
+		int i; 
+
 		printk(KERN_WARNING "psmouse.c: Lost synchronization, throwing %d bytes away.\n", psmouse->pktcnt);
+		for (i = 0; i < psmouse->pktcnt; i++) 
+			printk("%02x ", psmouse->cmdbuf[i]); 
 		psmouse->pktcnt = 0;
 	}
 	
@@ -459,6 +465,8 @@
 {
 	unsigned char param[2];
 
+	if (mousetype != -1) 
+		return mousetype; 
 /*
  * First, we check if it's a mouse. It should send 0x00 or 0x03
  * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
@@ -604,6 +612,15 @@
 	psmouse_initialize(psmouse);
 }
 
+static int set_mousetype(char *opt) 
+{ 
+	int arg;
+	if (get_option(&opt,&arg)) 
+		mousetype = arg; 
+} 
+
+__setup("mouse=", set_mousetype);
+
 static struct serio_dev psmouse_dev = {
 	.interrupt =	psmouse_interrupt,
 	.connect =	psmouse_connect,





