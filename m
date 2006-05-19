Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWESUI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWESUI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWESUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:08:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964800AbWESUI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:08:57 -0400
Date: Fri, 19 May 2006 13:11:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: adilger@clusterfs.com, torvalds@osdl.org, aia21@cam.ac.uk,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: [PATCH] sector_t overflow in block layer
Message-Id: <20060519131130.71c390d9.akpm@osdl.org>
In-Reply-To: <1148067412.5156.65.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1147884610.16827.44.camel@localhost.localdomain>
	<m34pzo36d4.fsf@bzzz.home.net>
	<1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com>
	<m364k4zfor.fsf@bzzz.home.net>
	<20060517235804.GA5731@schatzie.adilger.int>
	<1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
	<20060518185955.GK5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0605181403550.10823@g5.osdl.org>
	<Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.64.0605181526240.10823@g5.osdl.org>
	<20060518232324.GW5964@schatzie.adilger.int>
	<1148067412.5156.65.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Hi,
> 
> On Thu, 2006-05-18 at 17:23 -0600, Andreas Dilger wrote:
> 
> > I looked at that also, but it isn't clear from the use of "b_size" here
> > that there is any constraint that b_size is a power of two, only that it
> > is a multiple of 512.  Granted, I don't know whether there are any users
> > of such a crazy thing, but the fact that this is in bytes instead of a
> > shift made me think twice.
> 
> Yeah.  It was very strongly constrained to a power-of-two in the dim and
> distant past, when buffer_heads were only ever used for true buffer-
> cache data (the entire IO path had to be special-cased for IO that
> wasn't from the buffer cache, such as swap IO.)  
> 
> But more recently it has been a lot more relaxed, and we've had patches
> like Jens' "varyIO" patches on 2.4 which routinely generated odd-sized
> b_size buffer_heads when doing raw/direct IO on unaligned disk offsets.
> 
> But in 2.6, I _think_ such paths should be going straight to bio, not
> via submit_bh.  Direct IO certainly doesn't use bh's any more, and
> pretty much any other normal disk IO paths are page-aligned.  I might be
> missing something, though.
> 

We use various values of b_size when using a buffer_head for gathering a
disk mapping.  See, for example, fs/direct-io.c:get_more_blocks().

I don't think we ever play such tricks when a bh is used as an IO
container.  But we might - I see nothing in submit_bh() which would prevent
it.



btw, it seems odd to me that we're trying to handle the
device-too-large-for-sector_t problem at the submit_bh() level.  What
happens if someone uses submit_bio()?  Isn't it something we can check at
mount time, or partition parsing, or...?
