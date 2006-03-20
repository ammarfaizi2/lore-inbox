Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWCTWk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWCTWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWCTWk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:40:26 -0500
Received: from strike.wu-wien.ac.at ([137.208.8.200]:62347 "EHLO
	strike.wu-wien.ac.at") by vger.kernel.org with ESMTP
	id S1030562AbWCTWkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:40:25 -0500
Message-ID: <441F2F4C.5050100@strike.wu-wien.ac.at>
Date: Mon, 20 Mar 2006 23:40:12 +0100
From: Alexander Bergolth <leo@strike.wu-wien.ac.at>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
References: <20060206040027.GI43335175@melbourne.sgi.com>	<20060205202733.48a02dbe.akpm@osdl.org>	<43E75ED4.809@rtr.ca>	<43E75FB6.2040203@rtr.ca> <20060206121133.4ef589af.akpm@osdl.org>
In-Reply-To: <20060206121133.4ef589af.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030605040803090008010400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605040803090008010400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/06 21:11, Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
> 
>>A simple test I do for this:
>> $ mkdir t
>> $ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)
>>
>> In another window, I do this:
>>
>> $ while (sleep 1); do echo -n "`date`: "; grep Dirty /proc/meminfo; done
>>
>> And then watch the count get large, but take virtually forever
>> to count back down to a "safe" value.
>>
>> Typing "sync" causes all the Dirty pages to immediately be flushed to disk,
>> as expected.
> 
> I've never seen that happen and I don't recall seeing any other reports of
> it, so your machine must be doing something peculiar.

We are seeing the same issue on several boxes using xfs on some of them 
and ext3 on the others. Dirty pages are not periodically flushed to disk 
and even the sync command sometimes does only flush a small amount of 
the dirty buffers.
It looks like the problems arise after a few days uptime, a freshly 
booted system doesn't show the symptoms. (At least it doesn't show them 
when I'm looking out for them. ;))

I've written a small test-script to visualize the behavior. (Attached.)

The script creates a 200MB file, monitors nr_dirty in /proc/vmstat and
executes sync after some time.

The output looks like that:

-------------------- snip! bad: --------------------
Linux slime.wu-wien.ac.at 2.6.14-1.1653_FC4smp #1 SMP Tue Dec 13
21:46:01 EST 2005 i686 i686 i386 GNU/Linux
  12:22:46 up 10 days, 18:12, 37 users,  load average: 0.17, 0.15, 0.09
12:22:46 start: head -c 200000000 /dev/zero
 >/var/tmp/dirty-buffers.EFYFF13399 # nr_dirty 1076
12:22:46 # nr_dirty 1805
12:22:47 end: head -c 200000000 /dev/zero
 >/var/tmp/dirty-buffers.EFYFF13399 # nr_dirty 31061
12:22:51 # nr_dirty 25671
12:22:56 # nr_dirty 25724
12:23:01 # nr_dirty 25724
12:23:06 # nr_dirty 25724
12:23:11 # nr_dirty 25724
12:23:16 # nr_dirty 25724
12:23:21 # nr_dirty 25724
12:23:26 # nr_dirty 25724
12:23:31 # nr_dirty 25724
12:23:36 # nr_dirty 25724
12:23:41 # nr_dirty 25724
12:23:47 # nr_dirty 25725
12:23:52 # nr_dirty 25726
12:23:57 # nr_dirty 25728
12:24:02 # nr_dirty 25728
12:24:07 # nr_dirty 25728
12:24:12 # nr_dirty 25728
12:24:12 # nr_dirty 25728
12:24:12 start: sync # nr_dirty 25728
12:24:12 end: sync # nr_dirty 23566
12:24:17 # nr_dirty 23566
12:24:22 # nr_dirty 23582
12:24:27 # nr_dirty 23583
12:24:32 # nr_dirty 23583
12:24:37 # nr_dirty 23583
12:24:42 # nr_dirty 23583
12:24:47 # nr_dirty 23583
12:24:52 # nr_dirty 23583
12:24:57 # nr_dirty 23583
-------------------- snip! --------------------

While writing the temp-file, some buffers are flushed. (31061->25671)
But after writing is completed, the 25000 buffers remain dirty and are
not flushed after 30 secs, as I would expect. The sync causes the dirty
buffers to shrink from 25728 to 23566 but I'd expect that sync should
cause them to become near 0.

Here is the output of another system with a lower uptime that doesn't
show that behavior yet:

-------------------- snip! good: --------------------
Linux roaster.wu-wien.ac.at 2.6.12-1.1376_FC3.stk16smp #1 SMP Mon Aug 29
16:41:37 EDT 2005 i686 i686 i386 GNU/Linux
  12:44:54 up 3 days,  1:50,  2 users,  load average: 0.00, 0.16, 0.14
12:44:54 start: head -c 200000000 /dev/zero
 >/tmp/dirty-buffers.cgRFjZ1720 # nr_dirty 2
12:44:54 # nr_dirty 2
12:44:55 end: head -c 200000000 /dev/zero >/tmp/dirty-buffers.cgRFjZ1720
# nr_dirty 31257
12:44:59 # nr_dirty 22239
12:45:04 # nr_dirty 22239
12:45:09 # nr_dirty 22239
12:45:14 # nr_dirty 22240
12:45:19 # nr_dirty 22240
12:45:24 # nr_dirty 22240
12:45:29 # nr_dirty 4830
12:45:34 # nr_dirty 1
12:45:39 # nr_dirty 1
12:45:44 # nr_dirty 2
12:45:49 # nr_dirty 2
12:45:54 # nr_dirty 2
12:45:59 # nr_dirty 2
12:46:04 # nr_dirty 1
12:46:09 # nr_dirty 1
12:46:14 # nr_dirty 1
12:46:19 # nr_dirty 1
12:46:19 # nr_dirty 1
12:46:19 start: sync # nr_dirty 1
12:46:19 end: sync # nr_dirty 0
12:46:24 # nr_dirty 0
12:46:29 # nr_dirty 0
12:46:34 # nr_dirty 0
12:46:39 # nr_dirty 0
12:46:44 # nr_dirty 0
12:46:49 # nr_dirty 0
12:46:54 # nr_dirty 0
12:46:59 # nr_dirty 1
12:47:04 # nr_dirty 1
-------------------- snip! --------------------

There are no special mount options used in the first example (ext3), 
noatime is used in the second example (xfs).

Cheers,
--leo

--------------030605040803090008010400
Content-Type: application/x-shellscript;
 name="dirty-buffers.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dirty-buffers.sh"

IyEvYmluL3NoCgpsb2coKSB7CiAgZWNobyAiYGRhdGUgKyVUYCAkQCIKfQoKbG9ncnVuKCkg
ewogIGxvZyAic3RhcnQ6ICRAICMgYGhlYWQgLTEgL3Byb2Mvdm1zdGF0YCIKICBzaCAtYyAi
JEAiCiAgbG9nICJlbmQ6ICRAICMgYGhlYWQgLTEgL3Byb2Mvdm1zdGF0YCIKfQoKdm1zdGF0
KCkgewogIGk9IiQxIgogIHdoaWxlIGxldCAxOyBkbwogICAgbG9nICIjIGBoZWFkIC0xIC9w
cm9jL3Ztc3RhdGAiCiAgICBbICQoKC0taSkpIC1lcSAwIF0gJiYgYnJlYWsKICAgIHNsZWVw
IDUKICBkb25lCn0KCnVuYW1lIC1hCnVwdGltZQpUTVBGSUxFPSJgbWt0ZW1wIC10IGRpcnR5
LWJ1ZmZlcnMuWFhYWFhYWFhYWGAiIHx8IGV4aXQgMQp0cmFwICJybSAtZiAkVE1QRklMRSIg
RVhJVApsb2dydW4gImhlYWQgLWMgMjAwMDAwMDAwIC9kZXYvemVybyA+JFRNUEZJTEUiICYK
dm1zdGF0IDE4CmxvZ3J1biAic3luYyIgJgp2bXN0YXQgMTAKCg==
--------------030605040803090008010400--
