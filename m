Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSIXFvp>; Tue, 24 Sep 2002 01:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbSIXFvp>; Tue, 24 Sep 2002 01:51:45 -0400
Received: from dp.samba.org ([66.70.73.150]:22945 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261575AbSIXFvo>;
	Tue, 24 Sep 2002 01:51:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38) 
In-reply-to: Your message of "Mon, 23 Sep 2002 22:40:41 -0400."
             <3D8FD0A9.1010906@pobox.com> 
Date: Tue, 24 Sep 2002 15:55:42 +1000
Message-Id: <20020924055657.C968F2C0A6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D8FD0A9.1010906@pobox.com> you write:
> > @@ -325,7 +326,8 @@
> >  	while(inb(cmd_ioaddr) && --wait >= 0);
> >  #ifndef final_version
> >  	if (wait < 0)
> > -		printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
> > +		problem(LOG_ALERT, "eepro100: wait_for_cmd_done timeout!",
> > +				detail(ioaddr, "%lx", cmd_ioaddr));
> 
> bloat, the ioaddr can easily be deduced

No!  That's *exactly* the problem: you see:
	eepro100: wait_for_cmd_done timeout!

in your logs, now *which* of the 5 eepro100 cards was it?

wait_for_cmd_done(long cmd_ioaddr) should take a 'struct net_device *'
and use net_problem, then no details needed.

> > +	pci_introduce(pdev);
> 
> bloat, we don't need foo_introduce() functions for every subsystem, when 
> every subsystem always has an attach-new-device function.

Yes, this should be moved up into the generic pci/networking code, but I
guess they wanted a self-contained example.

> > -		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
> > +		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO regio
n");
> 
> bloat, no advantage over printk

Now, which of those 5 cards was it again?

> > -			printk(KERN_WARNING "%s: Invalid EEPROM checksum %#4.4x
, "
> > -				   "check settings before activating this devic
e!\n",
> > -				   dev->name, sum);
> > +			net_pci_problem(LOG_WARNING, dev, pdev, "Invalid EEPROM
 checksum, "
> > +				   "check settings before activating this devic
e!",
> 
> > +				   detail(checksum, "%#4.4x", sum));
> 
> bloat, checksum is purely informational, and can be obtained through 
> other means

It's a direct translation from the printk ferchissakes!

> likewise
> 
> etcetera...

Exactly.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
