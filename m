Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWHUAfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWHUAfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHUAfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:35:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:56219 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932328AbWHUAfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:35:40 -0400
From: Neil Brown <neilb@suse.de>
To: Andi Kleen <ak@suse.de>
Date: Mon, 21 Aug 2006 10:35:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17640.65491.458305.525471@cse.unsw.edu.au>
Cc: Jens Axboe <axboe@suse.de>, David Chinner <dgc@sgi.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
In-Reply-To: message from Andi Kleen on  August 18
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
	<20060818070314.GE798@suse.de>
	<p73hd0998is.fsf@verdi.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  August 18, ak@suse.de wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Thu, Aug 17 2006, Andrew Morton wrote:
> > > It seems that the many-writers-to-different-disks workloads don't happen
> > > very often.  We know this because
> > > 
> > > a) The 2.4 performance is utterly awful, and I never saw anybody
> > >    complain and
> > 
> > Talk to some of the people that used DVD-RAM devices (or other
> > excruciatingly slow writers) on their system, and they would disagree
> > violently :-)
> 
> I hit this recently while doing backups to a slow external USB disk.
> The system was quite unusable (some commands blocked for over a minute)

Ouch.  
I suspect we are going to see more of this, as USB drive for backups
is probably a very attractive option for many.

The 'obvious' solution would be to count dirty pages per backing_dev
and rate limit writes based on this.
But counting pages can be expensive.  I wonder if there might be some
way to throttle the required writes without doing too much counting.

Could we watch when the backing_dev is congested and use that?
e.g.
 When Dirty+Writeback is between max_dirty/2 and max_dirty,
  balance_dirty_pages waits until mapping->backing_dev_info
    is not congested.

That might slow things down, but it is hard to know if it would slow
things down the right amount...

Given that large machines are likely to have lots of different
backing_devs, maybe counting all the dirty pages per backing_dev
wouldn't be too expensive?

NeilBrown
