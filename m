Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTGJRaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbTGJRaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:30:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269451AbTGJRaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:30:02 -0400
Date: Thu, 10 Jul 2003 10:38:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Message-Id: <20030710103810.1276def5.akpm@osdl.org>
In-Reply-To: <bejhrj$dgg$1@news.cistron.nl>
References: <bejhrj$dgg$1@news.cistron.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
>
> I was running 2.5.74 on our newsfeeder box for a day without
> problems (and 2.5.72-mm2 for weeks before that).

And how was 2.5.72-mm2 performing, generally?

> Now with 2.5.74-mm3 (booted 11 hours ago) it keeps killing processes
> for no apparent reason:
> ...
> I notice that in -mm3 this was deleted relative to -vanilla:
> 
> -
> -       /*
> -        * Enough swap space left?  Not OOM.
> -        */
> -       if (nr_swap_pages > 0)
> -               return;
>   
> .. is that what causes this?

Yes.  That was a "hmm, I wonder what happens if I do this" patch.  It's
interesting that we're going down that code path.

Is your INND configured to use the strange mmap(MAP_SHARED) of a blockdev
thing?   That could explain the scanning hysteria.

> Related mm question - this box is a news server, which does a lot
> of streaming I/O, and also keeps a history database open. I have the
> idea that the streaming I/O evicts the history database hash and
> index file caches from memory, which I do not want. Any chance of
> a control on a filedescriptor that tells it how persistant to be
> in caching file data ? E.g. a sort of "nice" for the cache, so that
> I could say that streaming data may be flushed from buffers/cache
> earlier than other data (where the other data would be the
> database files) ?

Makes sense.  We can use posix_fadvise(POSIX_FADV_NOREUSE) as a hint to
tell the VM/VFS to throw away old pages.  I'll take a look at that.

