Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUG1Mvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUG1Mvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbUG1Mvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:51:48 -0400
Received: from main.gmane.org ([80.91.224.249]:23966 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266912AbUG1Mvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:51:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Wed, 28 Jul 2004 08:51:30 -0400
Message-ID: <874qnscn1p.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org>
 <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
 <871xixpdky.fsf@osu.edu> <4106B448.2010308@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:PBluXFzENt5Jq9t+un2b6Dwepo0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> I haven't been paying attention, and I don't know if anyone's already
> suggested this, but going on the title, have you considered running
> the same benchmark more than once and just throwing away the first
> result?

I was gathering from upthread comments that data blocks that are read
more than once will be given a priority to be retained in cache.  So I
think reading the same data twice could lead to unwanted cache hits.
And besides, some of our file sizes are quite small (e.g. 8MB) such
that reading through them the second time would almost guarantee cache
hits.  I see your point, though, for reading through a 64GB file on a
system with 8GB of RAM.  If such a system would retain in cache
anything except the last ~8GB, I'd be very surprised.

Based on comments from Andrew Morton, I'm going to take the following
approach to clear cache for read tests:

1) figure out the available RAM on the test system
2) write out a throwaway file twice that big, and fsync() it
3) delete that file

I gather this is optimistically the best way, that would work for all
filesystem types.

As far as clearing disk/controller cache, I have a plan of (after the
above has been done) reading through a 2GB "dummy" file that I create
once before running the test battery.  The 2GB figure comes from the
fact that we have controllers with a 1GB cache.  Plus, there are
around 36 disks on the backend, all raided together into one raid
device.  So each disk brings 8MB of cache that we have to worry about
as well.  If it is totally obvious that Andrew Morton's above recipe
will clear the disk/controller caches as well, the please point that
out, but it isn't obvious to me.
-- 
Benjamin Rutt

