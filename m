Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVAYGG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVAYGG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVAYGG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:06:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbVAYGGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:06:53 -0500
Date: Mon, 24 Jan 2005 22:06:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: tridge@osdl.org
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: memory leak in 2.6.11-rc2
Message-Id: <20050124220624.4a8eca97.akpm@osdl.org>
In-Reply-To: <16885.53121.883933.986880@samba.org>
References: <20050120020124.110155000@suse.de>
	<16884.8352.76012.779869@samba.org>
	<200501232358.09926.agruen@suse.de>
	<200501240032.17236.agruen@suse.de>
	<16884.56071.773949.280386@samba.org>
	<16885.47804.68041.144011@samba.org>
	<41F5BB0D.6090006@osdl.org>
	<16885.48502.243516.563660@samba.org>
	<16885.53121.883933.986880@samba.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Tridgell <tridge@osdl.org> wrote:
>
>  > I'm trying the little leak tracking patch from Alexander Nyberg now.
> 
>  Here are the results (only backtraces with more than 10k counts
>  included). The leak was at 1G of memory at the time I ran this, so its
>  safe to say 10k page allocations ain't enough to explain it :-)
> 
>  I also attach a hacked version of the pgown sort program that sorts
>  the output by count, and isn't O(n^2). It took 10 minutes to run the
>  old version :-)
> 
>  I'm guessing the leak is in the new xattr code given that is what
>  dbench and nbench were beating on. Andreas, can you look at the
>  following and see if you can spot anything?
> 
>  This was on 2.6.11-rc2 with the pipe leak patch from Linus. The
>  machine had leaked 1G of ram in 10 minutes, and was idle (only thing
>  running was sshd).
> 
>  175485 times:
>  Page allocated via order 0
>  [0xc0132258] generic_file_buffered_write+280
>  [0xc011b6a9] current_fs_time+77
>  [0xc0132a1e] __generic_file_aio_write_nolock+642
>  [0xc0132e70] generic_file_aio_write+100
>  [0xc017e586] ext3_file_write+38
>  [0xc014b7f5] do_sync_write+169
>  [0xc015f6de] fcntl_setlk64+286
>  [0xc01295a8] autoremove_wake_function+0

It would be pretty strange for plain old pagecache pages to leak in this
manner.  A few things come to mind.

- The above trace is indistinguishable from the normal situation of
  having a lot of pagecache floating about.  IOW: we don't know if the
  above pages have really leaked or not.

- It's sometimes possible for ext3 pages to remain alive (on the page
  LRU) after a truncate, but with no other references to them.  These pages
  are trivially reclaimable.  So even if you've deleted the files which the
  benchmark created, there _could_ be pages left over.  Although it would
  be unusual.

So what you should do before generating the leak tool output is to put
heavy memory pressure on the machine to try to get it to free up as much of
that pagecache as possible.  bzero(malloc(lots)) will do it - create a real
swapstorm, then do swapoff to kill remaining swapcache as well.

If we still see a lot of pages with the above trace then something really
broke.  Where does one get the appropriate dbench version?  How are you
mkfsing the filesystem?  Was mke2fs patched?  How is the benchmark being
invoked?

Thanks.
