Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUKVXWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUKVXWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUKVXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:20:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:9734 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261224AbUKVXSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:18:13 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
X-Message-Flag: Warning: May contain useful information
References: <20041122713.FnSlYodJYum7s82D@topspin.com>
	<20041122714.nKCPmH9LMhT0X7WE@topspin.com>
	<20041122223432.GC15634@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 15:18:07 -0800
In-Reply-To: <20041122223432.GC15634@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 14:34:32 -0800")
Message-ID: <52k6sdbhhs.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][8/12] Add IPoIB (IP-over-InfiniBand) driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 23:18:12.0882 (UTC) FILETIME=[89AA6720:01C4D0E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> What's wrong with using the dev_printk() and friends instead
    Greg> of your own?

dev_printk expects a struct device, not a net_device.

    Greg> And why cast a pointer in a macro, don't you know the type
    Greg> of it anyway?

this lets us pass in the return value of netdev_priv() directly
without having to have the cast in the code that uses the macro.

    Greg> You're using a separate filesystem to export debug data?
    Greg> I'm all for new virtual filesystems, but why not just use
    Greg> sysfs for this?  What are you doing in here that you can't
    Greg> do with another mechanism (netlink, sysfs, sockets, relayfs,
    Greg> etc.)?

For each multicast group, we want to export the GID, how long it's
been around, whether our join has completed and whether it's
send-only.  It wouldn't be too bad to create a kobject with all those
attributes but getting the info from so many little files is a little
bit of a pain, and so is dealing with kobject lifetime rules.  It's
even worse with netlink since then a new tool is required.  (AFAIK
relayfs isn't in Linus's kernel).

It's nice to be able to tell someone to just mount ipoib_debugfs and
send the contents of debugfs/ib0_mcg.

The actual filesystem stuff is pretty trivial using everything libfs
provides for us now...

    Greg> Why not just use 2 different debug variables for this?

No real reason... I'll fix it up.

    >> + +int mcast_debug_level;

    Greg> Global?

Good point, I'll move it into ipoib_multicast.c.

 - R.
