Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266441AbUFZVbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUFZVbx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUFZVbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:31:53 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:29841 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266441AbUFZVbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:31:50 -0400
Date: Sat, 26 Jun 2004 23:31:57 +0200
From: Kronos <kronos@people.it>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org,
       "Jens Axboe" <axboe@suse.de>
Subject: Re: [ISOFS] Troubles with multi session DVDs.
Message-ID: <20040626213157.GA12027@dreamland.darkstar.lan>
References: <20040623192900.GA20511@dreamland.darkstar.lan> <40DDC5EB.1010304@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DDC5EB.1010304@fy.chalmers.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Jun 26, 2004 at 08:52:27PM +0200, Andy Polyakov ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> >I'm having a strange (at least for me) problem burning multisession
> >DVD+R media: the dvd becomes unreadable after the 3rd session is burned.
> 
> I have all reasons to believe that it rather has everything to do with 
> position of last session, than with the exact number of sessions. I also 
> have all reasons to believe that it's rather ide-cd.c bug than isofs. In 
> other words this problem was already reported to me, but I didn't have 
> time to bring it up with linux-kernel people yet.
> 
> >mount refuses to do its work, and kernel says:
> >
> >Unable to identify CD-ROM format.
> >
> >Note that there isn't any read error, so the kernel is simply unable to
> >locate the primary volume descriptor.
> 
> The keywords for this problem are:
> 
> >growisofs -M /dev/hdc -J -r <files> (-Z for the first session)
>                     ^^^ ide-cd.c is involved [it's no problem with sr.c 
> if unit is routed through ide-scsi.c]...
> 
> >This is the output of dvd+rw-mediainfo:
> >...
> > Multi-session Info:    #3@1339392
>                              ^^^^^^^ ... and last recorded session 
> starts beyond LBA #1152000, which corresponds ~2.2GB.
> 
> What's so special about 1152000 (besides that it reminds highest posible 
> bitrate for serial port:-) It's 256 times 60 times 75. What's so special 
> about these numbers? 256 is amount of interger values which can be 
> represented with 8-bit number, 60 is amount of seconds in minute and 75 
> is amount of frames in one second of CD-DA. Yes, it's about conversion 
> from MSF to LBA suffering from overflow around 2.2GB. In the nutshell 
> the problem is that drivers/ide/ide-cd.c always pull TOC in MSF format 
> and then attempts to convert it to LBA. If last session is recorded 
> beyond 1152000, isofs driver will be led by ide-cd driver to belief that 
> volume descriptor resides at 1152000, which in turn results in "unable 
> to identify CD-ROM format" message logged upon mount attempt.
> 
> As fast-acting remedy I can suggest to route your unit through ide-scsi. 
> The way it was under 2.4. Even though it's declared unsupported it 
> actually still works in 2.6 (I for one still use it). And once ide-cd.c 
> is fixed you'll be able to revert back to officially recommended path. 

Yes, I can confirm that with ide-scsi I can read the dvd without
problems.

Jens are you aware of this bug in ide-cd?

Luca
-- 
Home: http://kronoz.cjb.net
"Su cio` di cui non si puo` parlare e` bene tacere".
 Ludwig Wittgenstein
