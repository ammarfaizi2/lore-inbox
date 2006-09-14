Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWINOLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWINOLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWINOLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:11:41 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:52866 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750779AbWINOLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:11:40 -0400
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Migration of standard timers
References: <20060914132917.GA9898@sgi.com>
From: Jes Sorensen <jes@sgi.com>
Date: 14 Sep 2006 10:11:39 -0400
In-Reply-To: <20060914132917.GA9898@sgi.com>
Message-ID: <yq0irjqedwk.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dimitri" == Dimitri Sivanich <sivanich@sgi.com> writes:

Dimitri> This patch allows the user to migrate currently queued
Dimitri> standard timers from one cpu to another, thereby reducing
Dimitri> timer induced latency on the chosen cpu.  Timers that were
Dimitri> placed with add_timer_on() are considered to have 'cpu
Dimitri> affinity' and are not moved.

Dimitri> The changes in drivers/base/cpu.c provide a clean and
Dimitri> convenient interface for triggering the migration through
Dimitri> sysfs, via writing the destination cpu number to a file
Dimitri> associated with the source cpu.

Hi Dimitri,

I just took a quick look at your patch, and at least on the surface it
looks pretty nice to me.

One minor nit, why choose short for the affinity field in struct
timer_list, it seems a strange size to pick for something which is
either 0 or 1. Wouldn't int or char be better?  I don't know if all
CPUs have 16 bit stores, but they should have 8 and 32 bit.

The name 'aff' for affinity might not be good either, since we tend to
refer to affinity as a mask specifying where it's locked to, maybe
'locked' would be better?

All in the nit-picking department though.

Cheers,
Jes


Index: linux/include/linux/timer.h
===================================================================
--- linux.orig/include/linux/timer.h
+++ linux/include/linux/timer.h
@@ -15,6 +15,8 @@ struct timer_list {
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+
+	short aff;
 };
 
