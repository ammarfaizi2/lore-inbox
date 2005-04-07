Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVDGPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVDGPwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVDGPwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:52:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262497AbVDGPvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:51:46 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1112818233.3377.52.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
	 <1112818233.3377.52.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112889078.2859.264.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 07 Apr 2005 16:51:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 21:10, Stephen C. Tweedie wrote:

> However, 2.6 is suspected of still having leaks in ext3.  To be certain
> that we're not just backporting one of those to 2.4, we need to
> understand who exactly is going to clean up these bh's if they are in
> fact unused once we complete this code and do the final put_bh().  
> 
> I'll give this patch a spin with Andrew's fsx-based leak stress and see
> if anything unpleasant appears.  

I'm currently running with the buffer-trace debug patch, on 2.4, with a
custom patch to put every buffer jbd ever sees onto a per-superblock
list, and remove it only when the bh is destroyed in
put_unused_buffer_head().  At unmount time, we can walk that list to
find stale buffers attached to data pages (invalidate_buffers() already
does such a walk for metadata.)

I just ran it with a quick test and it found 300,000 buffers still
present at unmount.  Whoops, I guess I need to move the check to _after_
the final invalidate_inodes() call. :-)

But this method ought to allow us to test for this sort of leak a lot
more reliably, and to report via the usual buffer history tracing the
most recent activity on any bh that does leak.

Andrew, I'll give this a try on 2.6 once I've got this 2.4 patch tested
for Marcelo.  I've got uptodate buffer_trace for 2.6 anyway, so it
shouldn't be too hard.

--Stephen

