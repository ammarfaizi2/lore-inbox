Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUEWO54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUEWO54 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUEWO5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 10:57:55 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:58303 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262909AbUEWO5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 10:57:52 -0400
Subject: Re: consistent ioctl for getting all net interfaces?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, joshk@triplehelix.org
Content-Type: text/plain
Organization: 
Message-Id: <1085315717.955.920.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2004 08:35:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viro cluelessly writes:
On Sat, May 22, 2004 at 09:28:28PM -0700, Joshua Kwan wrote:
 
>> I'm interested in not having to parse /proc/net/dev to get
>> a list of all available (not necessarily even up) interfaces
>> on the system. I investigated the ioctl SIOCGIFCONF, but it
>> seems to behave differently on 2.4 and 2.6 series kernels,
>> e.g. sometimes it won't return all interfaces.
>>
>> Is there some end-all ioctl that does what I want, or am
>> I forever doomed to process /proc/net/dev (in C, no less..)?
>
> ASCII is tough, let's go shopping?
>
>  char name[17];
>  FILE *in = fopen("/proc/net/dev", "r");
>  if (!in)
>   die("can't open");
>  fscanf(in, "%*[^\n]\n%*[^\n]");  /* skip two lines */
>  while (fscanf(in, " %16[^:]:%*[^\n]", name) == 1)
>   do_whatever_you_want(name);
>
> That you are calling "forever doomed"?  Wimp...

What makes you think you got that right? Do you have a
specification for the grammar? Let's look at an example
of /proc/net/dev, and I'll use my extensive /proc-parsing
experience to count your errors. Here is a sample:

Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
  eth0:3077476015 33231846    0    0    0     0          0         0 101565261  774586    0    0    0     0       0          0
    lo:    1360      24    0    0    0     0          0         0     1360      24    0    0    0     0       0          0
  tap0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
  eth1:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
  eth2:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0

Excuse me while I vomit.

Let's start with the device names. Users can change
them at will, and some driver authors aren't normal.
So, in C notation, a name could be "x1: 1 2 3\n".

It doesn't even need to that evil to screw up your
wimpy parser. A simple "av6:3" would do nicely.
Think it won't happen? Sorry, but it does and will.
This is the nature of /proc crap.

Now we get to format changes. Don't you think the
above is kind of ugly? I sure do. I'm not crazy
enough to touch the formatting, but that readable
ASCII is a temptation for many. Just look at the
history of /proc/cpuinfo, which long ago looked a
bit more like the above in terms of ':' placement.
Also, it's foolish to rely on that leading space.

Here is what my data might look like in a few years:

Iface |   Receive                                                |  Transmit
name  |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
eth0  :3077476015 33231846    0    0    0     0          0         0 101565261  774586    0    0    0     0       0          0
lo    :    1360      24    0    0    0     0          0         0     1360      24    0    0    0     0       0          0
tap0  :       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
eth1  :       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
eth2  :       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0

Subtle, isn't it? Your parser broke.

(then there is performance, or lack of it...)


