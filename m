Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSIXIbZ>; Tue, 24 Sep 2002 04:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSIXIbY>; Tue, 24 Sep 2002 04:31:24 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:23565 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S261613AbSIXIbW>;
	Tue, 24 Sep 2002 04:31:22 -0400
Message-ID: <20020924123629.C29052@castle.nmd.msu.ru>
Date: Tue, 24 Sep 2002 12:36:29 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux \(Keith Mitchell\)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: README 1ST - New problem logging macros (2.5.38)
References: <3D8FC601.80BAC684@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3D8FC601.80BAC684@us.ibm.com>; from "Larry Kessler" on Mon, Sep 23, 2002 at 06:55:13PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My $0.02.

I understand some of the reasons why certain logging standardization
is helpful.

An example: an administrator is mainly interested in problems with the disks.
Can anyone write, say, a regular expression matching printk messages related
to disks with very low false positive and false negative levels?
I can't.

The current Larry's proposal has a disadvantage of being so big.
Anyone will have a strong internal opposition to the need to learn this
interface for just a simple logging.

Second.  One of the most important things is handling of log messages
split over multiple printk and, possibly, multiple lines.
Larry seemed to omit the most interesting place in eepro100 driver:
speedo_show_state()  :-)

Any logging infrastructure not being able to deal with places like
speedo_show_state() is only half-useful, unfortunately.
The user-level log management system should be notified that
such a dump is just a single (long) piece of information, consisting of
multiple lines.

I would think about an interface looking like:
	log_piece_start_netdev(dev);
        printk(KERN_WARNING "%s: Transmit timed out: status %4.4x "
                  " %4.4x at %d/%d command %8.8x.\n",
                   dev->name, status, inw(ioaddr + SCBCmd),
                   sp->dirty_tx, sp->cur_tx,
                   sp->tx_ring[sp->dirty_tx % TX_RING_SIZE].status);
        speedo_show_state(dev);
	log_piece_end_netdev(dev);
It is simple and not intrusive, allowing to keep most of the code as it is
(or as driver author prefers).

On top of that simple interface, you can have whatever complex infrastructure
you want, gradually bringing the code to something like
	log_piece_start_netdev(dev);
	log_severity(LOG_WARNING);
	log_netdev_attrib(LOG_NETDEV_TRANSMIT);
        printk(KERN_WARNING "%s: Transmit timed out: status %4.4x "
                  " %4.4x at %d/%d command %8.8x.\n",
                   dev->name, status, inw(ioaddr + SCBCmd),
                   sp->dirty_tx, sp->cur_tx,
                   sp->tx_ring[sp->dirty_tx % TX_RING_SIZE].status);
	log_severity(LOG_DEBUG);
        speedo_show_state(dev);
	log_piece_end_netdev(dev);
or whatever you consider nice and useful.

Best regards
		Andrey

P.S. of course, wait_for_cmd_done should have net_device as an argument,
and any logging infrastructure can't help there :-)
