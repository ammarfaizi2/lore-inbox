Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUCOTHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCOTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:07:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39381 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262703AbUCOTGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:06:38 -0500
Date: Mon, 15 Mar 2004 14:06:30 -0500 (EST)
From: Matthew Galgoci <mgalgoci@redhat.com>
X-X-Sender: mgalgoci@lacrosse.corp.redhat.com
To: Pavel Machek <pavel@ucw.cz>, <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atkbd shaddup
In-Reply-To: <20040315183541.GB258@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0403151404190.26525-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here is the revised patch based on Pavel's feedback:


--- linux-2.6.4/drivers/input/keyboard/atkbd.c.orig	2004-03-15 12:40:01.578423740 -0500
+++ linux-2.6.4/drivers/input/keyboard/atkbd.c	2004-03-15 12:45:02.545009523 -0500
@@ -197,7 +197,7 @@
 
 #if !defined(__i386__) && !defined (__x86_64__)
 	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
-		printk("atkbd.c: frame/parity error: %02x\n", flags);
+		printk(KERN_WARNING "atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
 		atkbd->resend = 1;
 		goto out;
@@ -258,7 +258,7 @@
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
-			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+			printk(KERN_INFO "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
 	}
 

If there are no more objections, please apply.

Regards,

Matthew Galgoci


On Mon, 15 Mar 2004, Pavel Machek wrote:

> > Hi,
> > 
> > Pavel, how is this:
> > 
> > --- linux-2.6.4/drivers/input/keyboard/atkbd.c.orig	2004-03-15 12:40:01.578423740 -0500
> > +++ linux-2.6.4/drivers/input/keyboard/atkbd.c	2004-03-15 12:45:02.545009523 -0500
> > @@ -197,7 +197,7 @@
> >  
> >  #if !defined(__i386__) && !defined (__x86_64__)
> >  	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
> > -		printk("atkbd.c: frame/parity error: %02x\n", flags);
> > +		printk(KERN_WARNING "atkbd.c: frame/parity error: %02x\n", flags);
> >  		serio_write(serio, ATKBD_CMD_RESEND);
> >  		atkbd->resend = 1;
> >  		goto out;
> 
> Ok.
> 
> > @@ -258,7 +258,7 @@
> >  			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
> >  			goto out;
> >  		case ATKBD_RET_ERR:
> > -			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
> > +			printk(KERN_INFO "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
> >  			goto out;
> >  	}
> >  
> 
> Ok.
> 
> > @@ -274,15 +274,15 @@
> >  		case ATKBD_KEY_NULL:
> >  			break;
> >  		case ATKBD_KEY_UNKNOWN:
> > -			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
> > +			printk(KERN_INFO "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
> >  				atkbd->release ? "released" : "pressed",
> >  				atkbd->translated ? "translated" : "raw", 
> >  				atkbd->set, code, serio->phys);
> >  			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
> > -				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access"
> > +				printk(KERN_INFO "atkbd.c: This is an XFree86 bug. It shouldn't access"
> >  					" hardware directly.\n");
> >  			else
> > -				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
> > +				printk(KERN_INFO "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
> >  			break;
> 
> I'd leave those at WARNING level.
> 
> >  		default:
> >  			value = atkbd->release ? 0 :
> > @@ -496,8 +496,8 @@
> >  	atkbd->id = (param[0] << 8) | param[1];
> >  
> >  	if (atkbd->id == 0xaca1 && atkbd->translated) {
> > -		printk(KERN_ERR "atkbd.c: NCD terminal keyboards are only supported on non-translating\n");
> > -		printk(KERN_ERR "atkbd.c: controllers. Use i8042.direct=1 to disable translation.\n");
> > +		printk(KERN_WARNING "atkbd.c: NCD terminal keyboards are only supported on non-translating\n");
> > +		printk(KERN_WARNING "atkbd.c: controllers. Use i8042.direct=1 to disable translation.\n");
> >  		return -1;
> >  	}
> >  
> 
> This is hard error. Leave it as such.
> 
> > @@ -588,7 +588,7 @@
> >   */
> >  
> >  	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE)) {
> > -		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
> > +		printk(KERN_WARNING "atkbd.c: Failed to enable keyboard on %s\n",
> >  			atkbd->serio->phys);
> >  		return -1;
> >  	}
> 
> Same here.
> 
> > @@ -744,7 +744,7 @@
> >  	int i;
> >  
> >          if (!dev) {
> > -                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
> > +                printk(KERN_WARNING "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
> >                  return -1;
> >          }
> > 
> 
> I do not know about this one....
> 
> 									Pavel
> 
> 

-- 
Matthew Galgoci
System Administrator
Red Hat, Inc
919.754.3700 x44155

