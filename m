Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUHROG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUHROG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUHROG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:06:26 -0400
Received: from holomorphy.com ([207.189.100.168]:63926 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266292AbUHROFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:05:55 -0400
Date: Wed, 18 Aug 2004 07:05:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anders Saaby <as@cohaesio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom-killer 2.6.8.1
Message-ID: <20040818140550.GY11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anders Saaby <as@cohaesio.com>, linux-kernel@vger.kernel.org
References: <200408181455.42279.as@cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408181455.42279.as@cohaesio.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 02:55:42PM +0200, Anders Saaby wrote:
> This is a high-volume NFS server running almost no user-space
> applications. It serves a handfull of web server NFS clients from a
> ~700G XFS filesystem. The machine has about 2.5 GB of RAM and 4G of
> swap (which is almost not in use - i may use 5-10 MB total tops).
> CONFIG_HIGHMEM and CONFIG_HIGHMEM4G enabled, SMP enabled, preempt disabled.
> Today the OOM killer kicked in - it seemed that swap was almost unused at the 
> time (which is strange, as that should prevent the OOM killer from kicking 
> in).
> Relevant part of the syslog follows (syslogd was killed too eventually):

This seems to have been meant to resolve laptop_mode issues, but looks
like it didn't get applied. I'm not convinced it will help given that
you appear to have a vanilla ZONE_NORMAL slab OOM (858MB slab), but you
never know. Capturing /proc/slabinfo data may be more helpful.


Index: oom-2.6.8-rc1/mm/vmscan.c
===================================================================
--- oom-2.6.8-rc1.orig/mm/vmscan.c	2004-07-14 06:17:13.876343912 -0700
+++ oom-2.6.8-rc1/mm/vmscan.c	2004-07-14 06:22:15.986416200 -0700
@@ -417,7 +417,8 @@
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if (laptop_mode && !sc->may_writepage &&
+							!PageSwapCache(page))
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
