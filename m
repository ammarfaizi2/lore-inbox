Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUD2XRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUD2XRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUD2XRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:17:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:15306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262391AbUD2XRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:17:46 -0400
Date: Thu, 29 Apr 2004 16:19:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: elf@buici.com, riel@redhat.com, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429161912.6e694b90.akpm@osdl.org>
In-Reply-To: <20040429222704.GD5957@hexapodia.org>
References: <20040428180038.73a38683.akpm@osdl.org>
	<Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
	<20040428185720.07a3da4d.akpm@osdl.org>
	<20040429022944.GA24000@buici.com>
	<20040428193541.1e2cf489.akpm@osdl.org>
	<20040429031059.GA26060@buici.com>
	<20040428201924.719dfb68.akpm@osdl.org>
	<20040429165116.GA24033@hexapodia.org>
	<20040429134222.291f83d4.akpm@osdl.org>
	<20040429222704.GD5957@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> > What kernel version are you using?  If 2.6, what value of
> > /proc/sys/vm/swappiness?
> 
> 2.4.various, including 2.4.25 and 2.4.26.  I haven't taken the 2.6
> plunge yet.

OK.  Please try 2.6 and let us know how it changes things.

> > I just did a 4GB `dd if=/dev/sda of=/x bs=1M' on a 1GB 2.6.6-rc2-mm2
> > swappiness=85 machine here and there was no swapout at all.
> > 
> > Probably your machine has less memory.  But without real, hard details
> > nothing can be done.
> 
> I'm pleased to hear that 2.6 is apparently better behaved.  In your
> test, what was the impact on the file cache?

It will have munched everything else.

>  It's a big improvement to
> not be paging out to swap, but it's also important that sequential IO
> not evict my cached build tree.

Yup.  We don't have any large-streaming-file heuristics in there.

It is the case that if you have recently accessed a file *twice* then its
pages will be preferred over the large streaming file.  But if you've
accessed the valuable file only once, the streaming I/O will evict it.

> > > There is *no* benefit to cacheing
> > > more than about 2 pages, under this workload.
> > 
> > Sure, we could do better things with the large streaming files, although
> > the risk of accidentally screwing up particular workloads is high.
> 
> Yeah, I agree.  For example, I've occasionally used cat(1) or wc(1) to
> prefetch files that I knew I was going to be accessing randomly; with my
> hypothetical "sequential IO doesn't cause cacheing" it would be much
> harder to do effective manual prefetching.

We have a new syscall in 2.6 (fadvise) with which an app can provide hints
about its access patterns and its desired cache usage.  So, for example,
tar or rsync or whatever could (if told to do so by the user) deliberately
throw away the pagecache after having accessed the file.  But that does
require application modifications.  They're pretty simple though:

+	if (user said to throw away the cache)
+		posix_fadvise64(fd, 0, -1, POSIX_FADV_DONTNEED);
	close(fd);

> > But the use-once logic which we have in there at present does handle these
> > cases quite well.
> 
> Where is the use-once logic available?  Is it in mainstream 2.6 or only
> in some development branches?  I've not upgraded from 2.4 mostly because
> I didn't see much benefits evident in the discussions, but improved
> paging logic would be nice.

It's in 2.4 also.  I think 2.4 tends to do the wrong thing because dirty
pages easily make it to the tail of the VM LRU's, which eventually causes
the VM to go off and hunt down mapped pages instead.  2.6 takes more care
to prevent dirty pages from hitting the tail of the LRU.

> > >  But with current kernels,
> > > IME, that workload results in a gargantuan buffer cache and lots of
> > > swapout of apps I was using 3 minutes ago.  I've taken to walking away
> > > for some coffee, coming back when it's done, and "sudo swapoff
> > > /dev/hda3; sudo swapon -a" to avoid the latency that is so annoying when
> > > trying to use bloaty apps.
> > 
> > What kernel, what system specs, what swappiness setting?
> 
> 2.4.25, Athlon XP 2 GHz, 512MB.  I suppose you're not terribly
> interested in 2.4.  I'll see if I can reasonably upgrade, if you can
> tell me what I should upgrade to for the good stuff.

2.6.6-rc3 would be suitable.
