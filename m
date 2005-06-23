Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVFWB0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVFWB0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFWB0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:26:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17818 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261175AbVFWB0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:26:36 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17082.4037.875432.648439@segfault.boston.redhat.com>
Date: Wed, 22 Jun 2005 21:26:29 -0400
To: mpm@selenic.com
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch 0/3] netpoll: support multiple netpoll clients per net_device
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series restores the ability to register multiple netpoll clients
against the same network interface.  To this end, I created a new structure:

struct netpoll_info {
	spinlock_t poll_lock;
	int poll_owner;
	int rx_flags;
	spinlock_t rx_lock;
	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
};

This is the structure which gets pointed to by the net_device.  All of the
flags and locks which are specific to the INTERFACE go here.  Any variables
which must be kept per struct netpoll were left in the struct netpoll.  So
now, we have a cleaner separation of data and its scope.

Since we never really supported having more than one struct netpoll
register an rx_hook, I did not re-implement the rx_list.  Instead, there is
a single pointer in the netpoll_info structure (np_rx).  Note that if we
decide that we would like to register multiple rx_hooks per net_device,
this architecture does not preclude such extension.

We need to protect setting and clearing of the rx_np pointer, so I added a
lock (rx_lock) to the netpoll_info struct. [1]  There is one lock per
struct net_device, and I am certain that it will be low contention, as rx_np
will only be changed during an insmod or rmmod.

In the process of making these changes, I fixed a bug in netpoll_poll_unlock.
The function released the lock before setting the poll_owner to -1.


I have tested this by registering two netpoll clients, and verifying that
they both function properly.  The clients were netconsole, and a quick
module I hacked together to send console messages to syslog.  I issued
sysrq-h, sysrq-m, and sysrq-t's both by echo'ing to /proc/sysrq-trigger and
by hitting the key combination on the keyboard.  This verifies that the
modules work both inside and out of interrupt context.

Cheers,

Jeff

[1] Matt notes that we may be able to merge this lock with the poll_lock in
    the future.
