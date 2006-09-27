Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031193AbWI0Wz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031193AbWI0Wz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWI0Wz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:55:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965163AbWI0Wz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:55:56 -0400
Date: Wed, 27 Sep 2006 15:55:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "roland" <devzero@web.de>, Jay Lan <jlan@engr.sgi.com>
Cc: "Fengguang Wu" <fengguang.wu@gmail.com>, <linux-kernel@vger.kernel.org>,
       <lserinol@gmail.com>
Subject: Re: I/O statistics per process
Message-Id: <20060927155549.4a69490d.akpm@osdl.org>
In-Reply-To: <008f01c6e27a$f9bd5460$962e8d52@aldipc>
References: <0e2001c6de7a$fe756280$962e8d52@aldipc>
	<359067036.19509@ustc.edu.cn>
	<008f01c6e27a$f9bd5460$962e8d52@aldipc>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 23:22:02 +0200
"roland" <devzero@web.de> wrote:

> thanks. tried to contact redflag, but they don`t answer. maybe support is 
> being on holiday.... !?
> 
> linux kernel hackers - there is really no standard way to watch i/o metrics 
> (bytes read/written) at process level?

The patch csa-accounting-taskstats-update.patch in current -mm kernels
(whcih is planned for 2.6.19) does have per-process chars-read and
chars-written accounting ("Extended accounting fields").  That's probably
not waht you really want, although it might tell you what you want to know.

> it`s extremly hard for the admin to track down, what process is hogging the 
> disk - especially if there is more than one task consuming cpu.

Sure.  Doing this is actually fairly tricky because disk writes are almost
always deferred.  We'd need to remember which process dirtied some memory,
then track that info all the way down to the disk IO level, then perform
the accounting operations at IO submit-time or completion time, on a
per-page basis.  It isn't rocket-science, but it's a lot of stuff and some
overhead.

> meanwhile i found blktrace and read into the documenation. looks really cool 
> and seems to be very powerful tool - but it it`s seems a little bit 
> "oversized" and not the right tool for this. seems to be for 
> tracing/debugging/analysis
> 
> what about http://lkml.org/lkml/2005/9/12/89  "with following patch, 
> userspace processes/utilities will be able to access per process I/O 
> statistics. for example, top like utilites can use this information" which 
> has been posted to lkml one year ago ? any update on this ?

csa-accounting-taskstats-update.patch makes that information available to
userspace.

But it's approximate, because

- it doesn't account for disk readahead

- it doesn't account for pagefault-initiated reads (althought it easily
  could - Jay?)

- it overaccounts for a process writing to an already-dirty page.

  (We could fix this too: nuke the existing stuff and do

	current->wchar += PAGE_CACHE_SIZE;

   in __set_page_dirty_[no]buffers().) (But that ends up being wrong if
   someone truncates the file before it got written)

- it doesn't account for file readahead (although it easily could)

- it doesn't account for pagefault-initiated readahead (it could)


hm.  There's actually quite a lot we could do here to make these fields
more accurate and useful.  A lot of this depends on what the definition of
these fields _is_.  Is is just for disk IO?  Is it supposed to include
console IO, or what?
