Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVCGXEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVCGXEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCGXBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:01:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261778AbVCGVWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:22:25 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050307131113.0fd7477e.akpm@osdl.org>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
	 <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307131113.0fd7477e.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 21:22:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-03-07 at 21:11, Andrew Morton wrote:

> > I'm having trouble testing it, though --- I seem to be getting livelocks
> >  in O_DIRECT running 400 fsstress processes in parallel; ring any bells? 
> 
> Nope.  I dont think anyone has been that cruel to ext3 for a while.
> I assume this workload used to succeed?

I think so.  I remember getting a lockup a couple of months ago that I
couldn't get to the bottom of and that looked very similar, so it may
just be a matter of it being much more reproducible now.  But I seem to
be able to livelock the directIO bits in minutes now, quite reliably. 
I'll try to narrow things down.

altgr-scrlck is showing a range of EIPs all in ext3_direct_IO->
invalidate_inode_pages2_range().  I'm seeing

invalidate_inode_pages2_range()->pagevec_lookup()->find_get_pages()

as by far the most common trace, but also 

invalidate_inode_pages2_range()->__might_sleep()
invalidate_inode_pages2_range()->unlock_page()
and a few other similar paths.

invalidate_inode_pages2_range() does do a cond_resched(), so the machine
carries on despite having 316 fsstress tasks in system-mode R state at
the moment. :-)  The scheduler is doing a rather impressive job.

--Stephen

