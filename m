Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWJaHZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWJaHZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWJaHZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:25:43 -0500
Received: from brick.kernel.dk ([62.242.22.158]:59964 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422897AbWJaHZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:25:42 -0500
Date: Tue, 31 Oct 2006 08:27:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice blocks indefinitely when len > 64k?
Message-ID: <20061031072722.GU14055@kernel.dk>
References: <1162226390.7280.18.camel@systems03.lan.brontes3d.com> <20061030195426.GO14055@kernel.dk> <20061030130813.12b3adc1@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030130813.12b3adc1@freekitty>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Stephen Hemminger wrote:
> On Mon, 30 Oct 2006 20:54:27 +0100
> Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > On Mon, Oct 30 2006, Daniel Drake wrote:
> > > Hi,
> > > 
> > > I'm experimenting with splice and have run into some unusual behaviour.
> > > 
> > > I am using the utilities in git://brick.kernel.dk/data/git/splice.git
> > > 
> > > In splice.h, when changing SPLICE_SIZE from:
> > > 
> > > #define SPLICE_SIZE (64*1024)
> > > 
> > > to
> > > 
> > > #define SPLICE_SIZE ((64*1024)+1)
> > > 
> > > splice-cp hangs indefinitely when copying files sized 65537 bytes or
> > > more. It hangs on the first splice() call.
> > > 
> > > Is this a bug? I'd like to be able to copy much more than 64kb on a
> > > single splice call.
> > 
> > You can't, internally splice is using a pipe which is currently confined
> > to 16 pages. The SPLICE_SIZE define isn't a suggestion in the code, it
> > reflects that. You could fix splice-cp to not stall on changing that,
> > however that still doesn't change the fact that you can only move chunks
> > of 64kb (on your arch) right now.
> > 
> 
> It could accept larger values but only move SPLICE_SIZE, assuming
> caller checked for partial completions.

(one more time, for the list)

The caller has to check for partial completions, it would be like
calling read(2) or write(2) and not checking the return value if you
didn't. SPLICE_SIZE is the _maximum_ amount of data that current fits in
a pipe, there's no way to ensure that you will actually be able to write
that amount - the pipe may not be empty when you begin writing, or
someone else could be filling it as well.

The initial mail said that splice-cp doesn't work when you change the
SPLICE_SIZE define, and I'm not at all surprised that this is the case.
That would be like saying program foo doesn't work when you randomly
change some define or variable in the source.

-- 
Jens Axboe

