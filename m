Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966618AbWKTUqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966618AbWKTUqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966582AbWKTUqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:46:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:24025 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S966618AbWKTUqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:46:22 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <456213F2.8070805@s5r6.in-berlin.de>
Date: Mon, 20 Nov 2006 21:45:38 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe ohci1394"
References: <Pine.LNX.4.44L0.0611201425380.7569-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611201425380.7569-100000@iolanthe.rowland.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Wait a minute.  Above you agreed that the problem was caused by knodemgrd 
> attempting to rescan the host's _parent_.  So which is the focus of the 
> deadlock: the host or its parent?

The parent of the hpsb_host.

ohci1394 works on a pci_dev which contains a dev, let's call it A.

ieee1394 has a hpsb_host which contains a dev, let's call it B. B's
parent is A. Then there is one or more node_entry with dev C whose
parent is B, end unit_directory with dev D whose parent is C.

The bus of devices B, C, D is set to be ieee1394_bus_type, and that's
what knodemgrd is scanning.

knodemgrd blocks on the semaphore of the parent of B because
driver_detach took the semaphore of A (and of the parent of A if there
is one).

[...]
> If I understand all this, you've got an hpsb_host, directly below which 
> are one or more node_entry's, below each of which may be some 
> unit_directory's.  Right?

Right.

> But how is this relevant if the problem is caused by knodemgrd trying to 
> rescan the hpsb_host's parent?

It's rescanning just the hpsb_host, but you surely got the picture now.

> Is the problem caused by the fact that some of these struct device's 
> aren't bound to a driver?  Remember, bus_rescan_devices() will skip over 
> anything that already has a driver.  Could you solve your problem by 
> adding a do_nothing driver that would bind to these otherwise unused 
> devices?

Excellently, that's what I will try in a minute. It is surely intended
that the hpsb_host can get a driver bound too, but as I mentioned, we
don't have a driver which needs this capability and I don't foresee any
such driver.

Thanks for the directions.
-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/
