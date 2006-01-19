Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWASC6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWASC6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWASC6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:58:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:11194 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161177AbWASC6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:58:30 -0500
Date: Wed, 18 Jan 2006 18:57:41 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119025741.GC15706@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137631411.4757.218.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 04:43:31PM -0800, Bryan O'Sullivan wrote:
>         Opening the /dev/ipath special file assigns an appropriate free
>         unit (chip) and port (context on a chip) to a user process.

Shouldn't you just open the proper chip device and port device itself?
That drops one ioctl.

>         Think of it as similar to /dev/ptmx for ttys, except there isn't
>         a devpts-like filesystem behind it.  Once a process has
>         opened /dev/ipath, it needs to find out which unit and port it
>         has opened, so that it can access other attributes in /sys.  To
>         do this, we provide a GETPORT ioctl.

>         USERINIT and BASEINFO work with mmap to set up direct access to
>         the hardware for user processes.  We intend to turn these into a
>         single ioctl, USERINIT.  This copies a substantial amount of
>         information to and from userspace.

Why not just use mmap?  What's the special needs?

>         RCVCTRL enables/disables receipt of packets.

sysfs file.

>         SET_PKEY sets a partition key, essentially telling hardware
>         which packets are interesting to userspace.

sysfs file.

>         UPDM_TID and FREE_TID are used for RDMA context management.

sysfs files.

>         WAIT waits for incoming packets, and can clearly be replaced by
>         file_ops->poll.

Use poll.

>         GETCOUNTERS, GETUNITCOUNTERS and GETSTATS can all be replaced by
>         files in sysfs.

good.

> For subnet management:
> 
>         GETLID, SET_LID, SET_MTU, SET_GUID, SET_MLID, GET_MLID,
>         GET_DEVSTATUS, GET_PORTINFO and GET_NODEINFO can all be replaced
>         by files in sysfs.
>         
>         SET_LINKSTATE changes the link state.
>         
>         SEND_SMA_PKT and RCV_SMA_PKT send and receive subnet management
>         packets.  I *think* they could be replaced by read and write
>         methods on a new special file, although the semantics aren't a
>         super-clean match.

Use netlink for subnet stuff.

> For diagnostics:
> 
>         DIAGENTER and DIAGLEAVE put the driver into and out of diag
>         mode.  These could be replaced by open/close of a special file.

Use debugfs.

>         DIAGREAD and DIAGWRITE perform direct accesses to the device's
>         PCI memory space.  I think these could be replaced by read and
>         write, but they are again subject to the make-coworker-barf
>         problem.

Use debugfs.

>         HTREAD and HTREAD perform direct accesses to the device's PCI
>         config space.  Same disagreement problem as DIAGREAD and
>         DIAGWRITE.

Use the pci sysfs config files, don't duplicate existing functionality.

>         SEND_DIAG_PKT can be replaced with whatever sends and receives
>         subnet management packets, as above.

netlink or debugfs.

Hope this helps,

greg k-h
