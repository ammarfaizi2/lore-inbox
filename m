Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUEYI1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUEYI1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbUEYI1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:27:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35048 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264808AbUEYI1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:27:25 -0400
Date: Tue, 25 May 2004 10:27:04 +0200
From: Jens Axboe <axboe@suse.de>
To: braam <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040525082704.GL1952@suse.de>
References: <20040525064730.GB14792@suse.de> <20040525082305.BAEE93101A0@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525082305.BAEE93101A0@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25 2004, braam wrote:
> Jens,
> 
> I think do answer your question:  
> ...
> > > If we were to return errors, (which, I agree, _seems_ much 
> > more sane, 
> > > and we _did_ try that for a while!) then there is a good chance, 
> > > namely immediately when something is flushed to disk, that 
> > the system 
> > > will detect the errors and not continue to execute 
> > transactions making 
> > > consistent testing of our replay mechanisms impossible.
> 
> So: we can use the flags, but we cannot return the errors.

The generic_make_request() change itself is fine, as long as the proper
error is propagated back. I don't object to that at all, and I outlined
that to Phil last week as well. So in short:

        if (bio_data_dir(bio) == WRITE && bdev_read_only(bio->bi_bdev)) {
                bio_endio(bio, bio->bi_size, -EROFS);
                break;
        }

If you want to pass back 0 instead, then that would be a one-liner in
your (private) debugging patch. Ok?

> > And if this it to make sense for inclusion, io _must_ be 
> > ended with -EROFS or similar.
> > 
> > It seems to me that this probably belongs in your test 
> > harness for debugging purposes. At least in its current state 
> > it's not acceptable for inclusion.
> 
> This is, as I mentioned, only for testing.  It is, clearly, NOT ordinary
> system behavior at all since we don't, and won't, return the error. 
> 
> Some people find it very convenient to have this available, but if the
> opinion is that it is better to let development teams manage their own
> testing infrastructure that is acceptable to me.

I don't think this change makes sense as written for the generic
kernels, not if you want to simply ignore the write. If that is the
case, it's a special case debug entry for a very narrow use (ie lustre).

-- 
Jens Axboe

