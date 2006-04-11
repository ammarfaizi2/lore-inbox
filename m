Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWDKMm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDKMm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDKMm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:42:28 -0400
Received: from strike.wu-wien.ac.at ([137.208.8.200]:43177 "EHLO
	strike.wu-wien.ac.at") by vger.kernel.org with ESMTP
	id S1750713AbWDKMm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:42:27 -0400
Message-ID: <443BA41E.2020403@strike.wu-wien.ac.at>
Date: Tue, 11 Apr 2006 14:42:06 +0200
From: Alexander Bergolth <leo@strike.wu-wien.ac.at>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Mark Lord <lkml@rtr.ca>, dgc@sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: dirty pages (Was: Re: [PATCH] Prevent large file writeback starvation)
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <43E75ED4.809@rtr.ca> <43E75FB6.2040203@rtr.ca> <20060206121133.4ef589af.akpm@osdl.org> <20060213135925.GA6173@linuxtv.org>
In-Reply-To: <20060213135925.GA6173@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2006 02:59 PM, Johannes Stezenbach wrote:
> On Mon, Feb 06, 2006, Andrew Morton wrote:
>>Mark Lord <lkml@rtr.ca> wrote:
>>
>>>A simple test I do for this:
>>>
>>> $ mkdir t
>>> $ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)
>>>
>>> In another window, I do this:
>>>
>>> $ while (sleep 1); do echo -n "`date`: "; grep Dirty /proc/meminfo; done
>>>
>>> And then watch the count get large, but take virtually forever
>>> to count back down to a "safe" value.
>>>
>>> Typing "sync" causes all the Dirty pages to immediately be flushed to disk,
>>> as expected.
>>
>>I've never seen that happen and I don't recall seeing any other reports of
>>it, so your machine must be doing something peculiar.  I think it can
>>happen if, say, an inode gets itself onto the wrong inode list, or
>>incorrectly gets its dirty flag cleared.

Are you still suffering from this problem?
I'm seeing exactly the same issue on many boxes (including
kernel-2.6.16). (See my tests and the corresponding test-script at [1].)

Are you using Software-Suspend? I am able to trigger the problem after
suspending to disk and resuming (swsuspend2). However, it does also
happen on some boxes with a stock fedora kernel and without suspending,
though it is hard to reproduce on those boxes. (But once it is
triggered, it doesn't go away anymore.)

On most machines that show the problem, buffers are flushed only based
on the amount of dirty memory (dirty_ratio and dirty_background_ratio)
or when doing a "sync", they are not periodically flushed anymore.
There is one box where even "sync" does only flush a fraction of the
dirty buffers [2].

I am not using vmware, no laptop_mode and no custom /proc/sys/vm/dirty*
settings are involved.

Cheers,
--leo

[1] Tests results and test-script:
http://leo.kloburg.at/tmp/dirty-buffers/

[2] sync does flush only a fraction of dirty buffers:
http://leo.kloburg.at/tmp/dirty-buffers/bad_slime-2.6.14-1.1653_FC4smp.txt

