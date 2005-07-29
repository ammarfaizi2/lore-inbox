Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVG2Xsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVG2Xsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVG2XrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:47:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262936AbVG2XqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:46:11 -0400
Date: Fri, 29 Jul 2005 16:48:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: OOM problems still left in 2.6.13-rc3
Message-Id: <20050729164806.32ecd152.akpm@osdl.org>
In-Reply-To: <018101c5943a$1a07a5d0$4168010a@bsd.tnes.nec.co.jp>
References: <018101c5943a$1a07a5d0$4168010a@bsd.tnes.nec.co.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Takashi Sato" <sho@bsd.tnes.nec.co.jp> wrote:
>
> Below is the comparison of the memory leak rate before and after this
> fix.  We counted them from (Active+Inactive)-(Cached+Buffers+SwapCached
> +Mapped), which are in /proc/meminfo.
> ---------------------------------------------------------------------
> Linux 2.6.13-rc3 (including Andrew's patch):
>   leaked-rate   = 4869 KB/h
>   (leaked memory = 53564 KB, 11 hours)
>   
> My patch applied:
>   leaked-rate   = 213 KB/h
>   (leaked memory = 1492 KB, 7 hours) 
> ---------------------------------------------------------------------

What workload are you using here?

Be aware that due to truncate-vs-commit activity, ext3 can leave anonymous,
zero-refcount, unused pages on the page LRU.  They will appear to have
leaked, but the VM can trivially reclaim them so they're not really leaked
at all.

At least that's the way it's _supposed_ to work.  It might of course be
broken.  But it's not possible to say that the system has really leaked
pages unless you first put a lot of memory reclaim pressure on the machine
to try to reclaim those oddball pages.
