Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWGXQVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWGXQVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWGXQVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:21:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:34724 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751342AbWGXQVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:21:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QPbhXX0BoDAWE9sKtsYTfwuP5yDXf5xI0GhMaFrCCPSbkgSdGSEsa850y4ZfuJFl9sMALRQ9cU6Ipb8iRfD1fsrJ/q9epYMi/khpy1lnxI4JhgJpfzMquxSP//kWKDwvcjKb/PQUaL/fkxq+bqFHnEYjsoFSkJJHePdEgZF5/G0=
Message-ID: <bda6d13a0607240921x78049eefraae775e4c6c0ba5c@mail.gmail.com>
Date: Mon, 24 Jul 2006 09:21:04 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: <200607240725.k6O7PTp1012347@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it>
	 <E1G4Kpi-0001Os-AK@be1.lrz>
	 <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com>
	 <17604.27801.796726.164279@gargle.gargle.HOWL>
	 <200607240725.k6O7PTp1012347@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Mon, 24 Jul 2006 10:45:45 +0400, Nikita Danilov said:
> > Joshua Hudson writes:
>
> >  > In my filesystem, any attempt to create a loop of hard links
> >  > is detected and cancelled.
> >
> > Can you elaborate a bit on this exciting mechanism? Obviously an ability
> > to efficiently detect loops would be a break-through in a
> > reference-counted garbage collection, somehow missed for last 40
>
> It's actually pretty trivial to do if it's a toy filesystem and all the
> relevant inodes are in-memory already.  The hard-to-solve part is getting
> around the (apparent) need to walk across essentially the entire tree
> structure making sure that you aren't creating a loop.  This can get
> rather performance piggy - even /home on my laptop has some 400K
> inodes on it, and a 'find /home -type d' takes 28 seconds.  That's a *long*
> time to lock and freeze a filesystem.

Actually, I walk from the source inode down to try to find the
target inode. If not found, this is not attempting to create a loop.
Should be obvious that the average case is much less than the
whole tree.

>
> Where it gets *really* messy is that it isn't just mkdir that's the problem -
> once you let there be more than one path from the fs root to a given directory,
> it gets *really* hard to make sure that any given 'mv' command isn't going to
> to screw things up (is 'mv a/b/c/d ../../w/z/b' safe? How do you know, without
> examining a *lot* of stuff under a/ and ../../w/?

mv /a/b/c/d ../../w/z/b is implemented as this in the filesystem:
ln /a/b/c/d ../../w/z/b && rm /a/b/c/d

So what it's going to do is try to find z under /a/b/c/d.

Oh, and Nakita's right about the NFS server stuff. Actually, I think
the current filesystem I use for this is totally incompatible with
NFS (cannot call d_splice_alias on directory dnodes) so that
doesn't concern me.
