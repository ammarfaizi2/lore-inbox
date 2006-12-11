Return-Path: <linux-kernel-owner+w=401wt.eu-S1762674AbWLKJNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762674AbWLKJNp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762675AbWLKJNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:13:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33475 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762674AbWLKJNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:13:44 -0500
Date: Mon, 11 Dec 2006 01:13:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-Id: <20061211011327.f9478117.akpm@osdl.org>
In-Reply-To: <20061211005557.04643a75.akpm@osdl.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
	<20061211005557.04643a75.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 00:55:57 -0800
Andrew Morton <akpm@osdl.org> wrote:

> I think the bug really is the running of populate_rootfs() before running
> the initcalls, in init/main.c:init().  It's just more sensible to start
> running userspace after the initcalls have been run.  Statically-linked
> drivers which want to load firmware files will lose.  To fix that we'd need
> a new callback.  It could be with a new linker section or perhaps simply a
> notifier chain.

hm, actually...  Add two new initcall levels, one for populate_rootfs() and
one for things which want to come after it (ie: drivers which want to
access the filesytem):

 #define core_initcall(fn)		__define_initcall("1",fn,1)
 #define core_initcall_sync(fn)		__define_initcall("1s",fn,1s)
 #define postcore_initcall(fn)		__define_initcall("2",fn,2)
 #define postcore_initcall_sync(fn)	__define_initcall("2s",fn,2s)
 #define arch_initcall(fn)		__define_initcall("3",fn,3)
 #define arch_initcall_sync(fn)		__define_initcall("3s",fn,3s)
 #define subsys_initcall(fn)		__define_initcall("4",fn,4)
 #define subsys_initcall_sync(fn)	__define_initcall("4s",fn,4s)
 #define fs_initcall(fn)		__define_initcall("5",fn,5)
 #define fs_initcall_sync(fn)		__define_initcall("5s",fn,5s)
 #define device_initcall(fn)		__define_initcall("6",fn,6)
 #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
 #define late_initcall(fn)		__define_initcall("7",fn,7)
 #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
+#define populate_rootfs_initcall ...
+#define post_populate_rootfs_initcall ...

?
