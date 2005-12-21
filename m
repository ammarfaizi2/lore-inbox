Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVLUVdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVLUVdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:33:00 -0500
Received: from smtpout.mac.com ([17.250.248.46]:50894 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750745AbVLUVc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:32:59 -0500
In-Reply-To: <20051221211915.GI1736@flint.arm.linux.org.uk>
References: <200512211039.25449.gene.heskett@verizon.net> <20051221155012.GG1736@flint.arm.linux.org.uk> <200512211543.51702.gene.heskett@verizon.net> <20051221211915.GI1736@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B921F09E-A4F3-4AD3-918A-D25B4FE7C186@mac.com>
Cc: gene.heskett@verizononline.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Another casualty of -rc6
Date: Wed, 21 Dec 2005 16:32:38 -0500
To: Russell King <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 21, 2005, at 16:19, Russell King wrote:
> As I explained in my first reply, I was led to believe that it is  
> wrong to have the local clock in the configuration.  Since then  
> I've been running ntp without the local clock line, and it's been  
> fine since.
>
> I'm not saying that this is your problem, but I suspect that this  
> may not be helping the situation - especially since it appears that  
> ntpd has ruled out the other peers as possible synchronisation  
> sources.

ntpd _only_ considers peers of larger strata numbers after it has  
considered all smaller strata peers to be erroneous using various  
checks (such as too-high slew rate).

>> it out now, and ntpd restarted.  We'll see if it (ntpq -p) even  
>> bothers to report LOCAL now.  Nope.
>
> It won't do.  ntpq -p reports the _peers_ known to the server.  
> Obviously, if you remove the local peer, it won't be shown in that  
> output anymore.  Moreover, think whether it is correct to setup a  
> peering between your local clock and your local clock.

That's not why that line goes in there.  As documented in the Debian  
ntpd file, the extra local line is there for when you use ntpd as a  
server for _other_ systems.  Essentially, if you point all other  
systems at that server, it will temporarily serve out its local time  
as a strata 10 clock with that line.  Without, it will refuse to  
serve out _any_ time.  The result is that people include that line so  
that even during network failure, all their local clocks remain  
synchronized to each other, even if not to an atomic clock.

>> 21 Dec 15:22:47 ntpd[9198]: logging to file /var/log/ntp.log
>> 21 Dec 15:22:47 ntpd[9198]: ntpd 4.2.0a@1.1190-r Fri Aug 26  
>> 04:27:20 EDT 2005 (1)
>> 21 Dec 15:22:47 ntpd[9198]: precision = 1.000 usec
>> 21 Dec 15:22:47 ntpd[9198]: Listening on interface wildcard,  
>> 0.0.0.0#123
>> 21 Dec 15:22:47 ntpd[9198]: Listening on interface lo, 127.0.0.1#123
>> 21 Dec 15:22:47 ntpd[9198]: Listening on interface eth0,  
>> 192.168.71.3#123
>> 21 Dec 15:22:47 ntpd[9198]: kernel time sync status 0040
>> 21 Dec 15:22:47 ntpd[9198]: frequency initialized 3.712 PPM from / 
>> var/lib/ntp/drift
>> 21 Dec 15:27:06 ntpd[9198]: synchronized to 128.6.213.15, stratum 3
>> 21 Dec 15:27:06 ntpd[9198]: kernel time sync disabled 0041
>> 21 Dec 15:31:21 ntpd[9198]: synchronized to 192.36.143.151, stratum 1
>> 21 Dec 15:32:29 ntpd[9198]: kernel time sync enabled 0001
>
> So the kernel's timekeeping transitioned from unsynchronised to PLL  
> mode, to PLL + synchronised.  Great, ntpd has adjusted the kernels  
> timekeeping in an attempt to keep it synchronised.

If the local clock slews too much, then ntpd basically gives up  
(because it assumes that the server must be broken :-/).  When it  
does so, it flags the kernels clock as unsynched.


Cheers,
Kyle Moffett

--
When you go into court you either want a very, very, very bright line  
or you want the stomach to outlast the other guy in trench warfare.   
If both sides are reasonable, you try to stay _out_ of court in the  
first place.
   -- Rob Landley



