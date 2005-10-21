Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVJUJdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVJUJdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 05:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVJUJdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 05:33:22 -0400
Received: from 82-204-8-131.static.bbeyond.nl ([82.204.8.131]:64262 "EHLO
	mail.tomtom.com") by vger.kernel.org with ESMTP id S964872AbVJUJdW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 05:33:22 -0400
Message-ID: <4358B547.7070900@tomtom.com>
Date: Fri, 21 Oct 2005 11:30:47 +0200
From: Koen Martens <Koen.Martens@tomtom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sys_nanosleep round-off error
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 21 Oct 2005 09:30:18.0257 (UTC) FILETIME=[0CD6E810:01C5D622]
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We just had some weird stuff going on with nanosleep. When interrupted 
by a signal, it should return the amount of sleeptime remaining. 
However, when (for example) setting the time to sleep to 10 
milliseconds, it would sometimes return a remaining sleep time of 15ms.

Now, we can see why this is happening, we suspect this line:

        expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);

Expire is the number of jiffies that is passed to schedule_timeout(), 
and we see that if we do indeed have some time to sleep, 1 is added to 
this number.

On the system where we saw this, a jiffie is 5 msec.

So when we enter nanosleep with 10msec to sleep, it converts that to 2 
jiffies, and expire is 3. Then when the timeout is interrupted by a 
signal before any timeout is actually done, we return with 3 and this is 
converted back to 15msec...

So, the big question: why is the + (t.tv_sec || t.tv_nsec) there?? I 
assume it has to do with round-off, eg. when you put 9msec in, you get 1 
jiffie, but want to round-of upwards to 10msec=2jiffies.

Best,

Koen

-- 
Koen Martens | Developer | TomTom | koen.martens@tomtom.com | +31 (0) 20 850 09 81



This e-mail message contains information which is confidential and may be privileged. It is intended for use by the addressee only. If you are not the intended addressee, we request that you notify the sender immediately and delete or destroy this e-mail message and any attachment(s), without copying, saving, forwarding, disclosing or using its contents in any other way. TomTom N.V., TomTom International BV or any other company belonging to the TomTom group of companies will not be liable for damage relating to the communication by e-mail of data, documents or any other information.
