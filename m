Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVDKM6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVDKM6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDKM6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:58:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32916 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261569AbVDKM4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:56:17 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1112889078.2859.264.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
	 <1112818233.3377.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112889078.2859.264.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113224149.2164.78.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 11 Apr 2005 13:55:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-04-07 at 16:51, Stephen C. Tweedie wrote:

> I'm currently running with the buffer-trace debug patch, on 2.4, with a
> custom patch to put every buffer jbd ever sees onto a per-superblock
> list, and remove it only when the bh is destroyed in
> put_unused_buffer_head().  At unmount time, we can walk that list to
> find stale buffers attached to data pages (invalidate_buffers() already
> does such a walk for metadata.)

After a 50-process dbench run, unmount is showing ~300 buffers
unclaimed; that seems to be OK, it's a large stress test doing _lots_ of
create/unlink and we expect to see a few buffers around at the end where
they were truncated during commit and couldn't be instantly reclaimed.

The main thing now is to test these buffers to make 100% sure that they
are in a state where the VM can reclaim them.  That looks fine: the
buffers I see are unjournaled, have no jh, and are clean and on the
BUF_CLEAN lru.

Andrew, what was the exact illegal state of the pages you were seeing
when fixing that recent leak?  It looks like it's nothing more complex
than dirty buffers on an anon page.  I think that simply calling
try_to_release_page() for all the remaining buffers at umount time will
be enough to catch these; if that function fails, it tells us that the
VM can't reclaim these pages.  The only thing that would be required on
top of that would be a check that the page is also on the VM LRU lists.

--Stephen

