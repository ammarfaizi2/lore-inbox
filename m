Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbTBYINQ>; Tue, 25 Feb 2003 03:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267835AbTBYINQ>; Tue, 25 Feb 2003 03:13:16 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:43464 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267808AbTBYINO>; Tue, 25 Feb 2003 03:13:14 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Oliver Neukum <oliver@neukum.name>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB speedtouch: better proc info
Date: Tue, 25 Feb 2003 09:22:35 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       chas williams <chas@locutus.cmf.nrl.navy.mil>
References: <200302241058.52073.baldrick@wanadoo.fr> <200302241143.20632.oliver@neukum.name>
In-Reply-To: <200302241143.20632.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302250922.35971.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 February 2003 11:43, Oliver Neukum wrote:
> Am Montag, 24. Februar 2003 10:58 schrieb Duncan Sands:
> > Output the correct device name, show the state of the device (for
> > debugging) and of the ADSL line (anyone want to write a graphical utility
> > to show this, like under windows?).  We no longer consult the usb_device
> > struct in udsl_atm_proc_read, so don't take a reference to it.  Against
> > Greg's current 2.5 USB tree.
>
> First of all, let me say that you're doing wonders with this driver.
> But this particular patch I don't like. It improves stuff that should
> be removed. More specifically:
>
> 1. Does anything prevent you from using the medium detection
> hooks the network layer provides?
> 2. What need is there to export manufacturer id and mac address
> again?
> 3. Doesn't the rest belong into sysfs rather than procfs?

[Note to Chas: the speedtouch is a USB/ATM modem.  The driver
lurks in drivers/usb/misc/speedtouch.c]

Hi Oliver, thanks for your comments.  While I agree with you in
principle, I disagree in practice.  The driver exports the following
information in /proc/net/atm/speedtch:

(1) name and location of the USB device
(2) MAC address (serial number)
(3) AAL5 transmission statistics
(4) Line status
(5) Modem status

(1) is needed in order to work out which modem corresponds to
which ATM device.  This should be dealt with using sysfs, however
the ATM layer has not yet been ported to sysfs.  Until it is, this
seems like the best way to export this information.

(2) and (3) are redundant - they are published by the ATM layer
in other proc files.  I thought about removing them, but decided
against it because (a) it can be convenient having everything in
one proc file, and (b) it is backwards compatible with the 2.4
out-of-kernel driver.  They could go.

You suggested (in a private mail) using netif_carrier_on/off to
export (4).  The ATM layer already has a method for reporting this,
and I use it: set the ATM_PHY_SIG_FOUND/LOST bits in
atm_dev->signal.  The problem is that the ATM layer doesn't do
anything with this info (like export it to user space).  So I think
it is fair enough to export it in the proc file while waiting for the
ATM layer to be fixed.

As for (5), this could be exported using sysfs.  Since it is a
USB matter, I guess I could do this now.  So this could also go.

All the best,

Duncan.
