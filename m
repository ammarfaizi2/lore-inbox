Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVHNO7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVHNO7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 10:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVHNO7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 10:59:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40577 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932537AbVHNO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 10:59:51 -0400
Date: Sun, 14 Aug 2005 16:02:31 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: James.Smart@Emulex.Com, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <20050813213955.GB19235@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050813213955.GB19235@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2005 at 02:39:56PM -0700, Greg KH wrote:
> Heh, I already have a patch like this pending for 2.6.14 at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/driver-link-device-and-class.patch

Last time I tried to do something like this, it fell over with
multi-function serial ports.  Look at this example:

# ls -l /sys/class/tty/ttyS*/device | cut -c40-
/sys/class/tty/ttyS0/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
/sys/class/tty/ttyS1/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
/sys/class/tty/ttyS2/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
/sys/class/tty/ttyS3/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0
/sys/class/tty/ttyS4/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0

Adding the reverse links gets you three links in the 0000:00:04.0
directory all called 'tty' (or 'class:tty', whatever), each pointing to
a different place.  This doesn't happen for scsi devices as the class is
attached to the scsi_dev, not the pci_dev.  I think the tty subsystem
needs to be modified to add tty_devs as subdevices of the pci_dev.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
