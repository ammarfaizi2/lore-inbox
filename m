Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbTGHTKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267541AbTGHTKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:10:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20967 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267555AbTGHTJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:09:56 -0400
Message-ID: <3F0B1A04.FE76CA6C@us.ibm.com>
Date: Tue, 08 Jul 2003 12:22:44 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.net, davem@redhat.com,
       jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
References: <3F0AFFE6.E85FF283@us.ibm.com> <20030708105912.57015026.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Jim Keniston <jkenisto@us.ibm.com> wrote:
> >
> > The enclosed patches provide a mechanism for reporting error events
> > to user-mode applications via netlink.
> 
> Seems sane to me.
> 
> It needs to handle %z as well as %Z.

Yes, thanks.  I missed that change to vsnprintf().

> 
> The layout of `struct kern_log_entry' may be problematic.  Think of the
> situation where a 64-bit kernel constructs one of these and sends it up to
> 32-bit userspace.  Will the structure layout be the same under the 32-bit
> compiler as under the 64-bit one?

I think so.  Nothing is bigger than 4 bytes except log_facility[] (16-byte
array of char, which doesn't induce padding at all on i386).  But I will find a
64K/32U ppc machine and check that.

> 
> How do you actually intend to use this?

I envision it being used by a configuration/status-monitoring system that monitors
hotplug events, sysfs, etc. for configuration changes, and listens to the
proposed interface for error events.  Binary-only events (logged with evl_write())
would have to be interpreted based on knowledge existing entirely in user space (either
coded into the monitor program, or provided as supplementary information via a formatting
template or some such).  PRINTF-format events can carry and/or be supplemented with
similar info, but have the error message built in.

> Will it be by adding new
> evt_printf() calls to particular drivers, or replacing existing printk's or
> both?

There have been a variety of suggestions for how error reporting could be improved.
Two common ones are:
1. Leave printks alone, and log additional info in whatever format you want via netlink.
(E.g., Dave Miller recommended something like this.)  This proposal supports that.

2. Migrate from raw printks to "smarter" versions -- e.g., dev_printk and friends,
or the proposed netdev_printk.  Such macros now call just printk (after adding
relevant info), but could be modified to call evl_printk as well with the same args.

There are a zillion variations on this, of course...

> 
> Would it make sense for evt_printf() to fall back to printk() if nobody is
> listening to the log stream?

That certainly makes sense for evl_printf.  For evl_write, just do a hex dump or something.
So evlog.c would query kerror.c to see if anybody's listening.  Would kerror.c
consult nl_table[] directly, or is there an anybody_listening() function that
does this?

Jim
