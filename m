Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269134AbRHCO0x>; Fri, 3 Aug 2001 10:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269386AbRHCO0n>; Fri, 3 Aug 2001 10:26:43 -0400
Received: from [47.129.117.131] ([47.129.117.131]:43918 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S269134AbRHCO00>; Fri, 3 Aug 2001 10:26:26 -0400
Message-ID: <3B6AB4A4.912154F4@nortelnetworks.com>
Date: Fri, 03 Aug 2001 10:26:44 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ramdisk as root filesystem seems to cause ethernet carrier errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a Motorola G4-based compact PCI card with dual DEC21143-based ethernet
interfaces using the tulip driver.  We're running a somewhat patched 2.2.17
kernel. The normal method of booting this card is to tftp a kernel&ramdisk image
(about 10MB or so compressed) from a bootp server.  The ramdisk then becomes the
root filesystem, and one of the ethernet links is configured based on
information from the bootp server.  The second ethernet link is configured later
based on the configuration of the first one.

We've been using this setup for some months now, but recently someone was doing
some bandwidth testing comparing the speed of the two links, and he saw that
eth1 was substantially slower than eth0.  Checking the output of ifconfig, he
saw a very large number of carrier errors.  Further checking showed that there
was a carrier error for every packet sent out that link.

Attempting to isolate the problem, we found that if we changed the init scripts
to configure eth1 at boot, then the problem occurred on eth0.  We then made an
exact copy of the contents of the ramdisk filesystem, booted the exact same
kernel&ramdisk image, and overrode the boot args to force it to boot with the
filesystem copy as nfs-mounted root.  The problem went away.  We then tried
booting with nfs and mounting the same ramdisk image and then configuring the
second interface.  No problems.

What it looks like is that somehow simply having a ramdisk as root is causing
either errors or detection of errors on whichever ethernet link is not
configured by the system at boot time.  Interestingly, the vast majority of the
packets are actually getting through--we're seeing about a tenth of a percent
packet loss, but every packet sent generates an error.

Does anyone have any ideas what could be causing this?  We've tried making a
number of different ramdisks of various sizes, but it doesn't seem to make any
difference.  The bootloader code has been patched to allow for ramdisks of up to
32MB rather than the default 8MB, and it doesn't look like anything is getting
trampled at boot.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
