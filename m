Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbTGTJWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 05:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbTGTJWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 05:22:45 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:63461 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP id S265764AbTGTJWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 05:22:42 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre3 and up
Date: Sun, 20 Jul 2003 05:37:35 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307200537.35509.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [151.205.62.27] at Sun, 20 Jul 2003 04:37:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings list;

>From my logs, I've determined that as of the time I rebooted to 
2.4.22-pre3, something has been going on with the seriel port(s)

In particular, the log I have heyu keeping, and which is in the 
logrotate list, suddenly started getting what it thought was bogus 
data as of that reboot.

The version of heyu I'm running is unpublished as my bugfixes weren't 
of any great interest to the author and has therefore never been 
released as an offical new version.  The original code was missing a 
} in x10.c, and could make you a gigabyte plus log in 5 minutes if 
triggered.  My copy does not do that, but instead logs any data 
incoming from the CM-11a that doesn't match expected data, more as a 
bug shooter, which in this case allows me to define the exact time it 
started.

>From that log for that week, starting before the -pre3 reboot:
-------------
Wed Jul  9 06:00:01 EDT 2003: Changing to daylight mode
Wed Jul  9 06:00:08 EDT 2003: Changing to /etc/.xtendrc-day
7/9 at 06:00:08  Transmitted data ...04 68
7/9 at 06:00:09  Response to transmission ...6c
7/9 at 06:00:09  Transmitted data ...00
7/9 at 06:00:09  Response to transmission ...55
7/9 at 06:00:10  Transmitted data ...06 63
7/9 at 06:00:10  Response to transmission ...69
7/9 at 06:00:10  Transmitted data ...00
7/9 at 06:00:10  Response to transmission ...55
7/9 at 07:04:52  Transmitted data ...04 68
7/9 at 07:04:54  Response to transmission ...6c
7/9 at 07:04:54  Transmitted data ...00
7/9 at 07:04:54  Response to transmission ...55
7/9 at 07:04:54  Transmitted data ...06 63
7/9 at 07:04:54  Response to transmission ...69
7/9 at 07:04:54  Transmitted data ...00
7/9 at 07:04:54  Response to transmission ...55

The above is legit logging, below starts when I rebooted to -pre3, and 
continues unabated until I shut down all heyu related stuff 2 days 
back.

7/9 at 07:34:28 Poll line 1043 received unknown value (1 bytes), 
leading byte = fd wasflag = 0
7/9 at 07:34:29 Poll line 1043 received unknown value (1 bytes), 
leading byte = fd wasflag = 0
7/9 at 07:34:35 Poll line 1043 received unknown value (251 bytes), 
leading byte = ff wasflag = 0
7/9 at 07:34:35 Poll line 1043 received unknown value (251 bytes), 
leading byte = ff wasflag = 0
7/9 at 07:34:37 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:34:38 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:34:49 Poll line 1043 received unknown value (1 bytes), 
leading byte = fd wasflag = 0
7/9 at 07:34:54 Poll line 1043 received unknown value (251 bytes), 
leading byte = ff wasflag = 0
7/9 at 07:34:55 Poll line 1043 received unknown value (251 bytes), 
leading byte = ff wasflag = 0
7/9 at 07:34:55 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:34:55 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:34:56 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:34:57 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:34:58 Poll line 1043 received unknown value (1 bytes), 
leading byte = fb wasflag = 0
7/9 at 07:35:09 Poll line 1043 received unknown value (1 bytes), 
leading byte = fd wasflag = 0
7/9 at 07:35:14 Poll line 1043 received unknown value (251 bytes), 
leading byte = ff wasflag = 0
-------------
And continues on for an additional 110 megabytes in this particular 
weeks log...  At other places, and for later reboots, the leading 
byte of the incoming data might change to ea, but the random garbage 
just continues.

Here is a clip from my version of that code, showing what it does with 
any incoming data that is not a legit 1st byte of a CM-11a output.
This is the end of the function 'check4poll()', in src file x10.c.
----------------
	else /* Its not an a5. nor a 5a, nor a 5b, so . . . */
        {
            printf("%d/%d at %02d:%02d:%02d Poll line 1043 received 
unknown value (%d bytes), leading byte = %0x wasflag = %d\n",
                tp->tm_mon + 1, tp->tm_mday, tp->tm_hour, tp->tm_min, 
tp->tm_sec, n, buf[0], wasflag);
            fflush(stdout);
        }
        return(0);
---------------

Was there anything in the 2.4.22-pre3 patch that may have effected 
this?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

