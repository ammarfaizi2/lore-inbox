Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031498AbWLGF4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031498AbWLGF4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031422AbWLGF4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:56:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51579 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031498AbWLGF4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:56:01 -0500
Date: Wed, 6 Dec 2006 21:55:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, trevor.highland@gmail.com,
       tyhicks@ou.edu
Subject: Re: [PATCH 1/2] eCryptfs: Public key; transport mechanism
Message-Id: <20061206215555.85d584ca.akpm@osdl.org>
In-Reply-To: <20061206230638.GA9358@us.ibm.com>
References: <20061206230638.GA9358@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 17:06:38 -0600
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> This is a re-submission of the same public key patches (updated for
> 2.6.19-rc6-mm2) that were submitted for review a while back.

I made a number of comments last time around, some temperate, some not.
I trust the temperate ones were addressed?

Is there really no way in which any other kernel subsystem will ever want
functionality of this nature?

> This is the transport code for public key functionality in
> eCryptfs. It manages encryption/decryption request queues with a
> transport mechanism. Currently, netlink is the only implemented
> transport.

I wouldn't view this as an adequate changelog for this sort of work,
frankly.  Not by a long shot.  You've told us very briefly what the patches
do.  You haven't told us why they do it, nor how they do it.

What design decisions went into this?  What options were considered and
eliminated and why?  etc.

It's just a great lump of code dumped in our laps.


>From a quick scan (and I cannot review in more depth because the code is a
complete mystery to this reviewer):


> +	mutex_init(&ecryptfs_msg_ctx_lists_mux);
> +	mutex_lock(&ecryptfs_msg_ctx_lists_mux);

That's a bizarre thing to do.  If there's really any other process which
can take that mutex, the mutex_init() just trashed it.  If there is no
other such process, the mutex_lock() is unneeded.  There should never be
a need to runtime-initialise a static mutex - just use DEFINE_MUTEX.


ecryptfs now has a dependency upon netlink.  There's no CONFIG_NETLINK.  If
CONFIG_NET=n && CONFIG_ECRYPTFS=y is possible, it won't build.


