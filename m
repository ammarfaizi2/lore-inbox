Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTAJNVq>; Fri, 10 Jan 2003 08:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTAJNVq>; Fri, 10 Jan 2003 08:21:46 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:26791 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S265037AbTAJNVp>; Fri, 10 Jan 2003 08:21:45 -0500
Date: Fri, 10 Jan 2003 14:30:28 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030110133028.GB12071@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com> <20030110094504.GM25979@charite.de> <1042200029.28469.55.camel@irongate.swansea.linux.org.uk> <20030110111547.GB18007@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110111547.GB18007@charite.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> * Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > On Fri, 2003-01-10 at 09:45, Ralf Hildebrandt wrote:
> > > I got an oops with that kernel on two different machines:
> > 
> > Can you build the kernel with the patch to mm/shmem.c reverted and
> > see if that fixes your crash ?
> 
> Well, yes. Should I remove all changes to "mm/shmem.c" that are done
> from the ac2 patch?

Backing out of mm/shmem.c makess thee bug disappear. Unfortunately I
fforgot to applyy the keyboard pacth forr my Toshiba laptop, so I get
duplicate letters when typingg real fasst (as you caan  see!)

The keyboard paccth:
--- drivers/char/keyboard.c.orig        2003-01-10 12:20:18.000000000 +0100
+++ drivers/char/keyboard.c     2003-01-10 14:28:24.000000000 +0100
@@ -95,6 +95,7 @@
 static struct tty_struct **ttytab;
 static struct kbd_struct * kbd = kbd_table;
 static struct tty_struct * tty;
+static unsigned char prev_scancode;

 void compute_shiftstate(void);

@@ -214,7 +215,16 @@
        }
        kbd = kbd_table + fg_console;
        if ((raw_mode = (kbd->kbdmode == VC_RAW))) {
-               put_queue(scancode | up_flag);
+               /* put_queue(scancode | up_flag); */
+               /* The following 'if' is a workaround for hardware *
+                *  which sometimes send the key release event twice */
+                unsigned char next_scancode = scancode|up_flag;
+                if (up_flag && next_scancode==prev_scancode) {
+                   /* unexpected 2nd release event */
+                } else {
+                   prev_scancode=next_scancode;
+                   put_queue(next_scancode);
+                }
                /* we do not return yet, because we want to maintain
                   the key_down array, so that we have the correct
                   values when finishing RAW mode or when changing VT's */

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Okay, so I have this coworker who believes that NT is God's Gift to Sysadmins. 
There are lots of weird gods around, aren't they? 
Yeah, he means Cthulu. That's the kind of OS he/she/it'd give as a gift. 

