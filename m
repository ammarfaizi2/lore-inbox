Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSIETK4>; Thu, 5 Sep 2002 15:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSIETK4>; Thu, 5 Sep 2002 15:10:56 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:24839 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318130AbSIETKy>; Thu, 5 Sep 2002 15:10:54 -0400
Date: Thu, 5 Sep 2002 20:15:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905201530.A12457@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194824.A11974@infradead.org> <20020905190600.GH1657@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905190600.GH1657@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 09:06:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 09:06:00PM +0200, Andrea Arcangeli wrote:
> On Thu, Sep 05, 2002 at 07:48:24PM +0100, Christoph Hellwig wrote:
> > On Thu, Sep 05, 2002 at 08:41:25PM +0200, Andrea Arcangeli wrote:
> > > other fs, if you're not holding the i_sem (and you certainly aren't
> > > holding the i_sem that frequently, you don't even for writes).
> > 
> > Except of O_DIRECT writes we _do_ hold i_sem, btw.
> 
> can't you end with this?
> 
> 					O_DIRECT write
> 					write finishes
> 	truncate drops the write
> 	truncate set i_sem to 0
> 					write set i_sem to something

s/i_sem/i_size/g ?

> and the fs is then corrupt? (very minor corruption of course and
> extremely hard to trigger, trivially solvable by an fsck, ext[23] had
> similar issues too with the get_block failures with < PAGE_SIZE
> softblocksize, fixed around 2.4.19, that was certainly easier to
> reproduce btw)

Won't happen:


					O_DIRECT write starts
					+ takes XFS iolock exclusive
					- invalidates pagecache
					+ downgrades iolock to shared
					- perform write

	xfs_setattr for truncate called
	+ takes XFS iolock shared
	  -> blocks

					- write i_size to something
					+ releases iolock
	  -> gets woken

