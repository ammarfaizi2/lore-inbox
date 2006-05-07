Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWEGRZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWEGRZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWEGRZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:25:56 -0400
Received: from [65.205.244.70] ([65.205.244.70]:62629 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by vger.kernel.org with ESMTP
	id S932203AbWEGRZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:25:56 -0400
From: Jason Schoonover <jasons@pioneer-pra.com>
Organization: Pioneer PRA
To: Andrew Morton <akpm@osdl.org>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Date: Sun, 7 May 2006 10:24:22 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org>
In-Reply-To: <20060507095039.089ad37c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071024.22341.jasons@pioneer-pra.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I see, so it sounds as though the load average is not telling the true load of 
the machine.  However, it still feels that it's consuming quite a bit of 
resources.  The machine is almost unresponsive if I were to start two or 
three copies at the same time.

I noticed the behavior initially when I installed vmware server: I started one 
of the vm's booting and was copying another in the background (about a 12GB 
directory).  The booting VM would started getting slower and slower and 
eventually just hung.  It wasn't locked up, just seemed like it was "paused."   
When I tried an "ls" in another window, it just hung.  I then tried to ssh 
into the server to open another window and I couldn't even get an ssh prompt.  
I had to eventually Ctrl-C the copy and wait for it to be done before I could 
do anything.  And the load average had skyrocketed, but the consensus here is 
definitely that it's not the true load average of the system.

Possibly should I revert back to an older kernel?  2.6.12 or 2.6.10 maybe?  Do 
you know when abouts the I/O was changed?

I can certainly help debug this issue if you (or someone else) has the time to 
look into it and fix it.  Otherwise I will just revert back and hope that it 
will get fixed in the future.

Thanks,
Jason


-------Original Message-----
From: Andrew Morton
Sent: Sunday 07 May 2006 09:50
To: Jason Schoonover
Subject: Re: High load average on disk I/O on 2.6.17-rc3

On Fri, 5 May 2006 10:10:19 -0700

Jason Schoonover <jasons@pioneer-pra.com> wrote:
> I'm having some problems on the latest 2.6.17-rc3 kernel and SCSI disk I/O.
> Whenever I copy any large file (over 500GB) the load average starts to
> slowly rise and after about a minute it is up to 7.5 and keeps on rising
> (depending on how long the file takes to copy).  When I watch top, the
> processes at the top of the list are cp, pdflush, kjournald and kswapd.

This is probably because the number of pdflush threads slowly grows to its
maximum.  This is bogus, and we seem to have broken it sometime in the past
few releases.  I need to find a few quality hours to get in there and fix
it, but they're rare :(

It's pretty harmless though.  The "load average" thing just means that the
extra pdflush threads are twiddling thumbs waiting on some disk I/O -
they'll later exit and clean themselves up.  They won't be consuming
significant resources.
