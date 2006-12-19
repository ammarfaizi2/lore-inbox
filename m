Return-Path: <linux-kernel-owner+w=401wt.eu-S932638AbWLSBzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWLSBzH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 20:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWLSBzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 20:55:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41358 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932638AbWLSBzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 20:55:04 -0500
Date: Mon, 18 Dec 2006 17:54:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrei.popa@i-neo.ro
Cc: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061218175449.3c752879.akpm@osdl.org>
In-Reply-To: <1166492691.6890.12.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<1166466272.10372.96.camel@twins>
	<Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	<1166468651.6983.6.camel@localhost>
	<Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	<1166471069.6940.4.camel@localhost>
	<Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
	<1166476297.6862.1.camel@localhost>
	<Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>
	<1166485691.6977.6.camel@localhost>
	<Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
	<1166488199.6950.2.camel@localhost>
	<Pine.LNX.4.64.0612181648490.3479@woody.osdl.org>
	<20061218172126.0822b5d2.akpm@osdl.org>
	<1166492691.6890.12.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 03:44:51 +0200
Andrei Popa <andrei.popa@i-neo.ro> wrote:

> On Mon, 2006-12-18 at 17:21 -0800, Andrew Morton wrote:
> > On Mon, 18 Dec 2006 16:57:30 -0800 (PST)
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > What happens if you only ifdef out that single thing? 
> > > 
> > > The actual page-cleaning functions make sure to only clear the TAG_DIRTY 
> > > bit _after_ the page has been marked for writeback. Is there some ordering 
> > > constraint there, perhaps?
> > > 
> > > I'm really reaching here. I'm trying to see the pattern, and I'm not 
> > > seeing it. I'm asking you to test things just to get more of a feel for 
> > > what triggers the failure, than because I actually have any kind of idea 
> > > of what the heck is going on.
> > > 
> > > Andrew, Nick, Hugh - any ideas?
> > 
> > If all of test_clear_page_dirty() has been commented out then the page will
> > never become clean hence will never fall out of pagecache, so unless Andrei
> > is doing a reboot before checking for corruption, perhaps the underlying
> > data on-disk is incorrect, but we can't see it.
> 
> if I do a sync and echo 1 > /proc/sys/vm/drop_caches

OK, that works.

>  does the reboot is
> still necesary ?

It might be necessary to reboot in this case - if we're leaving the
pagecache dirty, writing to drop_caches won't remove it.  And you probably
won't be able to get a clean reboot either.

> > 
> > Andrei, how _are_ you running this test?    What's the exact sequence of steps?
> > 
> > In particular, are you doing anything which would cause the corrupted file
> > to be evicted from memory, thus forcing a read from disk?  Such as
> > unmounting and then remounting the filesystem?
> 
> I boot linux, I start rtorrent and start the download, while it's
> downloading I start evolution and i check my mail(my mbox is very large,
> several hundered megabytes), I close evolution(I use evolution just to
> have another application witch uses the filesystem and the memory), I
> start evolution again. I start firefox. The download is complete.
> Rtorrent says if the hash is good or not. I do a "unrar t qwe.rar" to
> test that all 84 downloaded rar files are ok and see the result.
> 
> > 
> > The point of my question is to check that the data is really incorrect
> > on-disk, or whether it is incorrect in pagecache.
> > 
> > Also, it'd be useful if you could determine whether the bug appears with
> > the ext2 filesystem: do s/ext3/ext2/ in /etc/fstab, or boot with
> > rootfstype=ext2 if it's the root filesystem.
> 
> I will test.

ok, thanks.
