Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTDYBKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDYBKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:10:17 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:32473 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261860AbTDYBKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:10:15 -0400
Date: Fri, 25 Apr 2003 13:09:36 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030424154608.V26054@schatzie.adilger.int>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       cat@zip.com.au, mbligh@aracnet.com, gigerstyle@gmx.ch,
       geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1051232975.1919.26.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030423173720.6cc5ee50.akpm@digeo.com>
 <20030424091236.GA3039@elf.ucw.cz> <20030424022505.5b22eeed.akpm@digeo.com>
 <20030424093534.GB3084@elf.ucw.cz> <20030424024613.053fbdb9.akpm@digeo.com>
 <1051182797.2250.10.camel@laptop-linux>
 <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz>
 <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz>
 <20030424154608.V26054@schatzie.adilger.int>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-25 at 09:46, Andreas Dilger wrote:
> On Apr 24, 2003  22:48 +0200, Pavel Machek wrote:
> OK, then why all of the talk earlier saying that journal recovery will
> corrupt a swapfile?  That was the reason journaling was brought into the
> discussion in the first place:
> 
> 	"And now you have kernel which expects data still in journal (that was
> 	 state before suspend), but reality on disk is quite different (journal
> 	 was replayed). Data corruption." -- Pavel

I don't believe Pavel was saying the image would be corrupted. Rather,
the rest of the disk contents are corrupted by replaying the journal and
then resuming back to a memory state that has been made inconsistent
with the disk state because of the journal replay.

> If the filesystem was not unmounted and remounted, then no replay will happen.  
> End of story.  If the suspend code is doing something like:
> 	
> 	1) save memory contents to disk
> 	2) suspend/power off
> 	3) reboot kernel, mount filesystem(s), etc

This is just reboot kernel. Filesystems aren't mounted before (4).

> 	4) check for presence of suspend image
> 	5) replace currently-running kernel with suspended kernel
> 
> Then you are in for a world of hurt regardless of whether the data is in a
> swap file or a swap partition.  The data in the swapfile isn't touched by
> journal replay at all (so that is safe regardless), but the rest of the
> filesystem is, which could cause strange disk corruption since the in-memory
> data doesn't match the on-disk data.

On the second part, "Precisely."

> If that is the case, then the only way to avoid this would be to call
> sync_super_lockfs() on each filesystem before the suspend, which will
> force the journal to be empty when it returns.  That API is supported
> by all of the journaling filesystems, and is probably a good thing to
> do anyways, as it will potentially free a lot of dirty data from RAM,
> and also ensure that the on-disk data is consistent in case the resume
> isn't handled gracefully.

Sounds like a good idea to me.

Regards,

Nigel


