Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUKVXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUKVXHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUKVXHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:07:09 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:42756 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262110AbUKVXFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:05:47 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
	<20041122714.9zlcKGKvXlpga8EP@topspin.com>
	<20041122225033.GD15634@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 15:05:40 -0800
In-Reply-To: <20041122225033.GD15634@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 14:50:33 -0800")
Message-ID: <52oehpbi2j.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 23:05:45.0741 (UTC) FILETIME=[CC55BBD0:01C4D0E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >> Add a driver that provides a character special device for each
    >> InfiniBand port.  This device allows userspace to send and
    >> receive MADs via write() and read() (with some control
    >> operations implemented as ioctls).

    Greg> Do you really need these ioctls?

    Greg> This could be in a sysfs file, right?

The API version definitely can be, good point.

    Greg> You are letting any user, with any privilege register or
    Greg> unregister an "agent"?

They have to be able to open the device node.  We could add a check
that they have it open for writing but there's not really much point
in opening this device read-only.

    Greg> And shouldn't you lock your list of agent ids when adding or
    Greg> removing one, or are you relying on the BKL of the ioctl
    Greg> call?  If so, please document this.

Each file has an "agent_mutex" rwsem that protects this... the global
list of agents handled by the lower level API is protected by its own locking.

    Greg> Also, these "agents" seem to be a type of filter, right?  Is
    Greg> there no other way to implement this than an ioctl?

ioctl seems to be the least bad way to me.  This really feels like a
legitimate use of ioctl to me -- we use read/write to handle passing
data through our file descriptor, and ioctl for control of the
properties of the descriptor.

What would you suggest as an ioctl replacement?

Thanks,
 Roland
