Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbVBEL0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbVBEL0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbVBEL0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:26:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:16577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264759AbVBEL0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:26:11 -0500
Date: Sat, 5 Feb 2005 03:26:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.11-rc3-mm1 : can't insmod dm-mod
Message-Id: <20050205032605.764eedac.akpm@osdl.org>
In-Reply-To: <4204880A.3010703@free.fr>
References: <20050204103350.241a907a.akpm@osdl.org>
	<4204880A.3010703@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> Le 04.02.2005 19:33, Andrew Morton a écrit :
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
>  >
> 
>  loading dm-mod module fails with this message :
> 
>  FATAL: Error inserting dm-mod
>  (/lib/modules/2.6.11-rc3-mm1/kernel/drivers/md/dm-mod.ko): Device or resource busy
> 
>  The following line appears in dmesg :
> 
>  register_blkdev: failed to get major for device-mapper

You've enabled CONFIG_BASE_SMALL and so the major_names[] hashtable has
just one element.  device-mapper uses dynamic major allocation, the range
of which is limited to the size of the top-level major_names[] array.  You
ran out of slots and register_blkdev() failed.

So for now I guess we must drop base-small-shrink-major_names-hash.patch.

Al, that code looks rather crappy.  Shouldn't we be using an idr tree or
something?

Also, we can never generate a major number of zero if the caller passed in
major=0.  How come?


