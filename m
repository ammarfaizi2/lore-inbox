Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSFTJzD>; Thu, 20 Jun 2002 05:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSFTJzC>; Thu, 20 Jun 2002 05:55:02 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:56960 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S313113AbSFTJzB>; Thu, 20 Jun 2002 05:55:01 -0400
Date: Thu, 20 Jun 2002 10:54:49 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com,
       ext2-devel@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <20020620105449.A3824@redhat.com>
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com> <3D1127D6.F6988C4B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D1127D6.F6988C4B@zip.com.au>; from akpm@zip.com.au on Wed, Jun 19, 2002 at 05:54:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2002 at 05:54:46PM -0700, Andrew Morton wrote:

> The vague plan there is to replace lock_kernel with lock_journal
> where appropriate.  But ext3 scalability work of this nature
> will be targetted at the 2.5 kernel, most probably.

I think we can do better than that, with care.  lock_journal could
easily become a read/write lock to protect the transaction state
machine, as there's really only one place --- the commit thread ---
where we end up changing the state of a transaction itself (eg. from
running to committing).  For short-lived buffer transformations, we
already have the datalist spinlock.

There are a few intermediate types of operation, such as the
do_get_write_access.  That's a buffer operation, but it relies on us
being able to allocate memory for the old version of the buffer if we
happen to be committing the bh to disk already.  All of those cases
are already prepared to accept BKL being dropped during the memory
allocation, so there's no problem with doing the same for a short-term
buffer spinlock; and if the journal_lock is only taken shared in such
places, then there's no urgent need to drop that over the malloc.

Even the commit thread can probably avoid taking the journal lock in
many cases --- it would need it exclusively while changing a
transaction's global state, but while it's just manipulating blocks on
the committing transaction it can probably get away with much less
locking.

Cheers,
 Stephen
