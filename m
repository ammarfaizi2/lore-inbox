Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUFZSwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUFZSwN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUFZSwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:52:12 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:21741 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S266319AbUFZSwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:52:08 -0400
Message-ID: <40DDC5EB.1010304@fy.chalmers.se>
Date: Sat, 26 Jun 2004 20:52:27 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kronos <kronos@people.it>
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [ISOFS] Troubles with multi session DVDs.
References: <20040623192900.GA20511@dreamland.darkstar.lan>
In-Reply-To: <20040623192900.GA20511@dreamland.darkstar.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having a strange (at least for me) problem burning multisession
> DVD+R media: the dvd becomes unreadable after the 3rd session is burned.

I have all reasons to believe that it rather has everything to do with 
position of last session, than with the exact number of sessions. I also 
have all reasons to believe that it's rather ide-cd.c bug than isofs. In 
other words this problem was already reported to me, but I didn't have 
time to bring it up with linux-kernel people yet.

> mount refuses to do its work, and kernel says:
> 
> Unable to identify CD-ROM format.
> 
> Note that there isn't any read error, so the kernel is simply unable to
> locate the primary volume descriptor.

The keywords for this problem are:

> growisofs -M /dev/hdc -J -r <files> (-Z for the first session)
                     ^^^ ide-cd.c is involved [it's no problem with sr.c 
if unit is routed through ide-scsi.c]...

> This is the output of dvd+rw-mediainfo:
> ...
>  Multi-session Info:    #3@1339392
                              ^^^^^^^ ... and last recorded session 
starts beyond LBA #1152000, which corresponds ~2.2GB.

What's so special about 1152000 (besides that it reminds highest posible 
bitrate for serial port:-) It's 256 times 60 times 75. What's so special 
about these numbers? 256 is amount of interger values which can be 
represented with 8-bit number, 60 is amount of seconds in minute and 75 
is amount of frames in one second of CD-DA. Yes, it's about conversion 
from MSF to LBA suffering from overflow around 2.2GB. In the nutshell 
the problem is that drivers/ide/ide-cd.c always pull TOC in MSF format 
and then attempts to convert it to LBA. If last session is recorded 
beyond 1152000, isofs driver will be led by ide-cd driver to belief that 
volume descriptor resides at 1152000, which in turn results in "unable 
to identify CD-ROM format" message logged upon mount attempt.

As fast-acting remedy I can suggest to route your unit through ide-scsi. 
The way it was under 2.4. Even though it's declared unsupported it 
actually still works in 2.6 (I for one still use it). And once ide-cd.c 
is fixed you'll be able to revert back to officially recommended path. A.


