Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTJUOpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 10:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTJUOpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 10:45:36 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:2475 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263133AbTJUOpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 10:45:34 -0400
Date: Tue, 21 Oct 2003 16:37:41 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>
Subject: Re: [PATCH] RH7.3 can't compile 2.6.0-test8 (fs/proc/array.c)
Message-ID: <20031021143741.GB22633@localhost>
References: <20031021131915.GA4436@rushmore> <20031021135221.GA22633@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031021135221.GA22633@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 21st 2003 at 15:52 uur Marco Roeland wrote:

> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106651554401143&w=2
> > 
> > It's supposed to fix test8 compile with gcc-2.96 for RedHat 7.x.
> 
> Perhaps if the huge sprintf with 40+ arguments (fs/proc/array.c, line 346)
> amongst which several trinary operators, were to be split up into several
> parts, might that not solve the problem more elegantly?

Does this compile (and work) for any of you friendly RedHat 7.[23] users? 
In 2.6.0-test8 yet another argument was added to the monstrous sprintf.
Perhaps this was just the droplet to overflow gcc-2.96's buckets? Here we
split it into 3 distinct parts.

--- linux-2.6.0-test8/fs/proc/array.c.orig	2003-10-21 16:18:40.000000000 +0200
+++ linux-2.6.0-test8/fs/proc/array.c	2003-10-21 16:24:42.000000000 +0200
@@ -343,9 +343,7 @@
 	read_lock(&tasklist_lock);
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
-	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu ",
 		task->pid,
 		task->comm,
 		state,
@@ -355,7 +353,8 @@
 		tty_nr,
 		tty_pgrp,
 		task->flags,
-		task->min_flt,
+		task->min_flt);
+	res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu ",
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
@@ -375,7 +374,8 @@
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
 		mm ? mm->start_stack : 0,
-		esp,
+		esp);
+	res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		eip,
 		/* The signal information here is obsolete.
 		 * It must be decimal for Linux 2.0 compatibility.

