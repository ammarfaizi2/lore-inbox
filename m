Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVC2Mbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVC2Mbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVC2Mbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:31:42 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:3082 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262234AbVC2MbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:31:25 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: 20050323135317.GA22959@roonstrasse.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050328172820.GA31571@linux.ensimag.fr>
References: <20050328172820.GA31571@linux.ensimag.fr>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 14:31:23 +0200
Message-Id: <1112099483.4784.10.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 19:28 +0200, Matthieu Castet wrote:
> > The memory limits aren't good enough either: if you set them low
> > enough that memory-forkbombs are unperilous for
> > RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
> > applications.
> 
> yes, if you want to run application like openoffice.org you need at
> least 200Mo. If you want that your system is usable, you need at least 40 process per user. So 40*200 = 8Go, and it don't think you have all this memory...
> 
> I think per user limit could be a solution.

You have /etc/limits and /etc/security/limits.conf.

I think it would solve many problems by simply lowering the default
max_treads in kernel/fork.c. RLIMIT_NPROC is calculated from this value.

--- kernel/fork.c.orig  2005-03-02 08:37:48.000000000 +0100
+++ kernel/fork.c       2005-03-21 15:22:50.000000000 +0100
@@ -119,7 +119,7 @@
         * value: the thread structures can take up at most half
         * of memory.
         */
-       max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
+       max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);

        /*
         * we need to allow at least 20 threads to boot a system

I don't think this will cause much problems for most users. (compare the
default maximum process limit in the BSD's and OSX)

This will also limit deamons/services started from boot scripts by
default. The /etc/limits and /etc/security/limits.conf does not.

If it does cause problems for extrem users, they can easily raise the
limits in either initrd and/or using /proc/sys/kernel/threads-max (or
systctl).

BTW... does anyone know *why* the default max number of processes is so
high in Linux?

--
Natanael Copa


