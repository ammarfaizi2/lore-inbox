Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUGXAEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUGXAEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268190AbUGXAEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 20:04:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:4310 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264640AbUGXAEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 20:04:42 -0400
Date: Fri, 23 Jul 2004 20:03:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-Id: <20040723200335.521fe42a.akpm@osdl.org>
In-Reply-To: <1090604517.13415.0.camel@lucy>
References: <1090604517.13415.0.camel@lucy>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@ximian.com> wrote:
>
> Andrew, et al,
> 
> OK, Kernel Summit and my OLS talk are over, so here are the goods.
> 
> Following patch implements the kernel events layer, which is a simple
> wrapper around netlink to allow asynchronous communication from the
> kernel to user-space of events, errors, logging, and so on.
> 
> Current intention is to hook the kernel via this interface into D-BUS,
> although the patch is intended to be agnostic to any of that and policy
> free.
> 
> D-BUS can be found here:
> 
> 	http://dbus.freedesktop.org/
> 
> Other user-space utilities (including code to utilize this) can be found
> here:
> 
> 	http://vrfy.org/projects/kdbusd/
> 
> This patch only implements a single event, processor temperature
> detection.  Other useful events include md sync, filesystem mount,
> driver errors, etc.  We can add those later, on a case-by-case basis.  I
> would like to be more careful with adding events than we are with adding
> printk's, with some aim toward a stable interface.

OK.  Can you give us a ballpark estimate of how many send_kmessage() calls
we're likely to have in two years time?

> Usage of the new interface is simple:
> 
> 	send_kmessage(group, interface, message, ...)
> 
> Credit to Arjan for the initial implementation, Kay Sievers for some
> updates, and the netlink code.

- The GFP_ATOMIC page allocation is unfortunate.  Please pass in the
  gfp_flags, or change it to GFP_KERNEL and provide a separate
  send_kmessage_atomic()?

- Methinks the kernel won't build if the user set CONFIG_NETLINK_DEV=n

- When fixing that up, please add CONFIG_KERNEL_EVENTS or whatever,
  provide the appropriate do-nothing stubs if it's disabled.  For the tiny
  systems.

- send_kmessage() is racy against kmessage_exit().  I'm not sure that's
  worth fixing - if you agree then it would set minds at ease to simply
  remove kmessage_exit().

- This code will never work as a module, so why include the
  MODULE_AUTHOR/DESCRIPTION/etc?

- What led to the decision to export send_kmessage() to only GPL modules?

