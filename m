Return-Path: <linux-kernel-owner+w=401wt.eu-S932613AbWLSBVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWLSBVv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 20:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWLSBVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 20:21:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39041 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932613AbWLSBVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 20:21:50 -0500
Date: Mon, 18 Dec 2006 17:21:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061218172126.0822b5d2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612181648490.3479@woody.osdl.org>
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
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 16:57:30 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> What happens if you only ifdef out that single thing? 
> 
> The actual page-cleaning functions make sure to only clear the TAG_DIRTY 
> bit _after_ the page has been marked for writeback. Is there some ordering 
> constraint there, perhaps?
> 
> I'm really reaching here. I'm trying to see the pattern, and I'm not 
> seeing it. I'm asking you to test things just to get more of a feel for 
> what triggers the failure, than because I actually have any kind of idea 
> of what the heck is going on.
> 
> Andrew, Nick, Hugh - any ideas?

If all of test_clear_page_dirty() has been commented out then the page will
never become clean hence will never fall out of pagecache, so unless Andrei
is doing a reboot before checking for corruption, perhaps the underlying
data on-disk is incorrect, but we can't see it.

Andrei, how _are_ you running this test?    What's the exact sequence of steps?

In particular, are you doing anything which would cause the corrupted file
to be evicted from memory, thus forcing a read from disk?  Such as
unmounting and then remounting the filesystem?

The point of my question is to check that the data is really incorrect
on-disk, or whether it is incorrect in pagecache.

Also, it'd be useful if you could determine whether the bug appears with
the ext2 filesystem: do s/ext3/ext2/ in /etc/fstab, or boot with
rootfstype=ext2 if it's the root filesystem.

Thanks.
