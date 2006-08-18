Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWHRTod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHRTod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHRToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:44:32 -0400
Received: from smtp7.libero.it ([193.70.192.90]:35461 "EHLO smtp7.libero.it")
	by vger.kernel.org with ESMTP id S932173AbWHRTob convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:44:31 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Duncan Sands" <baldrick@free.fr>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>,
       <usbatm@lists.infradead.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: R: [PATCH 06/13] USBATM: shutdown open connections when disconnected
Date: Fri, 18 Aug 2006 21:40:23 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDMELKFNAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200601131005.15690.baldrick@free.fr>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Messaggio originale-----
> Da: usbatm-bounces@lists.infradead.org
> [mailto:usbatm-bounces@lists.infradead.org]Per conto di Duncan Sands
> Inviato: venerdì 13 gennaio 2006 10.05
> A: Greg KH
> Cc: linux-kernel@vger.kernel.org;
> linux-atm-general@lists.sourceforge.net; usbatm@lists.infradead.org;
> linux-usb-devel@lists.sourceforge.net
> Oggetto: [PATCH 06/13] USBATM: shutdown open connections when
> disconnected
> 
> 
> This patch causes vcc_release_async to be applied to any open
> vcc's when the modem is disconnected.  This signals a socket
> shutdown, letting the socket user know that the game is up.
> I wrote this patch because of reports that pppd would keep
> connections open forever when the modem is disconnected.
> This patch does not fix that problem, but it's a step in the
> right direction.  It doesn't help because the pppoatm module
> doesn't yet monitor state changes on the ATM socket, so simply
> never realises that the ATM connection has gone down (meaning
> it doesn't tell the ppp layer).  But at least there is a socket
> state change now.

> Unfortunately this patch may create problems
> for those rare users like me who use routed IP or some other
> non-ppp connection method that goes via the ATM ARP daemon: the
> daemon is buggy, and with this patch will crash when the modem
> is disconnected.  Users with a buggy atmarpd can simply restart
> it after disconnecting the modem.

The problem is not only atmarpd, but also atmarp: it fails when establishing a PVC on a 'disconnected' VC, ie: a VC on and ADSL modem which didn't yet reach showtime.

CLIP and other protocols-over-ATM are designed to be connectionless. Thereby, you setup a CLIP connection, probably at systems startup, and forget about it: if a carrier is available, cells are exchanged, otherwise both parties discard outgoing cells. The connectionless design is one of the pros of CLIP with respect to, in example, PPPoA. It is not a con.

With this patch, the CLIP protocol becomes susceptible to connection status: it fails during setup if the ADSL modem is not yet at showtime (and who knows how long it will take to get it) and may discard the VC when the carrier happens to get lost after CLIP is started.

To my knowledge, no other ATM interface driver under Linux does reject a vcc open or a send due to the state of the physical carrier. Also note that there is not a per-interface instance of atmarpd and friends: they are scheduled systemwide and they may work at once on more interfaces. Making them die causes troubles not only to the outstanding network activity of the disconnected ADSL, but also to the one on other ATM interfaces.

pppd is designed to work both with connectionless (a cross-wire cable or an ATM VC) and connection-oriented carriers (a voice or ISDN modem): enabling its lcp echo feature usually is enough in order to detect a lost carrier. Out-of-sync peers state should be also detected. If it doesn't, it's pppd failure.

In summary, I'm not shure that the new USBATM behaviour is compatible with the (at least de-facto) actual standard of the Linux ATM stack. I'm not even shure that's compatible with ATM blueprints.

I'm however pretty shure that, when there is a patch that may impair and/or be incompatible with current software, the Linux end-user had always been provided with an option to disable the new feature and continue working the way it was used to.

I need that option.

Regards,

	giampaolo

> 
> Signed-off-by: Duncan Sands <baldrick@free.fr>
> 

