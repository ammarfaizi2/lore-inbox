Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275358AbTHSGTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275361AbTHSGTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:19:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:20897 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275358AbTHSGTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:19:03 -0400
Date: Mon, 18 Aug 2003 23:20:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: russo.lutions@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-Id: <20030818232024.20c16d1f.akpm@osdl.org>
In-Reply-To: <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
References: <3F41AA15.1020802@verizon.net>
	<200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> There was a discussion (and patches) in the middle of 2.5 series
>  about O_STREAMING open flag which mean "do not aggressively cache
>  this file". Targeted at MP3/video playing, copying large files and such.
> 
>  I don't know whether it actually was merged. If it was,
>  your program can use it.

It was not.  Instead we have fadvise.  So it would be appropriate to change
applications such as rsync to optionally run

	posix_fadvise(fd, 0, -1, POSIX_FADV_DONTNEED)

against file descriptors just before closing them, so all the pagecache
gets thrown away.  (Well, most of the pagecache - dirty pages won't get
dropped - the app must fsync the files by hand first if it wants this)

This would be a useful addition to rsync and such applications - it is
stronger and more specific and safer than banging on the VM for a special
case.

But if you want to bang on the VM for a special case, run 2.6 and set
/proc/sys/vm/swappiness to zero during the rsync run.

