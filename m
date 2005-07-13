Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVGMAo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVGMAo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVGMAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:42:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:34019 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262512AbVGMAmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:42:16 -0400
From: Chris Mason <mason@suse.com>
To: "Rob Mueller" <robm@fastmail.fm>, akpm@osdl.org
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Tue, 12 Jul 2005 20:42:09 -0400
User-Agent: KMail/1.8
Cc: "Lars Roland" <lroland@gmail.com>, "Bron Gondwana" <brong@fastmail.fm>,
       linux-kernel@vger.kernel.org, "Jeremy Howard" <jhoward@fastmail.fm>,
       "Vladimir Saveliev" <vs@namesys.com>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <4ad99e0505071209372176f625@mail.gmail.com> <039301c58741$a4df9fb0$7c00a8c0@ROBMHP>
In-Reply-To: <039301c58741$a4df9fb0$7c00a8c0@ROBMHP>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507122042.11397.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 20:27, Rob Mueller wrote:
> > > We're also applying the attached patch.  There's a bug in reiserfs that
> > > gets tickled by our huge MMAP usage (it's amazing what really busy
> > > Cyrus daemons can do to a server, ouch).  It's fixed in generic_write,
> > > so we take the few percent performance hit for something that doesn't
> > > break!
> >
> > Interesting - When I got the problem it was on mail servers under high
> > load (handling 60.000 emails pr. hour) with reiserfs as file system. I
> > have seen this problem on 5 different servers so I am confident that
> > it is not hardware failure.
> >
> > Sometimes the server load just rises and then the server dies other
> > times the load rises but the kernel manages to get it back alive
> > filling up syslog with messages like this
>
> Sounds like a different issue. The patch Bron included before fixes (or at
> least reduces to the point where it fixes it for us) a problem where
> processes get stuck in D state and are unkillable. A reboot is required to
> remove them. Apparently this is a known bug in ReiserFS (see messages
> below). As noted, the same bug exists in ext3. There appears to have been
> some patches to try and fix it for both reiserfs and ext3, but I'm not sure
> if they're in the mainline kernel yet.
>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2056.html
> http://hulllug.principalhosting.net/archive/index.php/t-22774.html
>

There is a much less complex solution that I've just recently gotten working 
in the SUSE kernel.  If reiser3/ext3 don't log the inode during atime 
updates, the problem goes away.

You can solve this now by mounting with -o noatime (although that might not 
play well with cyrus, not sure).  My current patch works around this in ugly 
ways, what I plan on doing during OLS is finding out why ext3 is still 
logging the inode all the time.

For reiser3, this was to avoid kswapd having to log a bunch of inodes in 
response to memory pressure, but that was back in 2.4 when things were 
different.  We shouldn't need to do it anymore...

-chris
