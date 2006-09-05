Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWIECcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWIECcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWIECcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:32:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52411 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965097AbWIECcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:32:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       saito.tadashi@soft.fujitsu.com, ak@suse.de, oleg@tv-sign.ru,
       jdelvare@suse.de
Subject: Re: [PATCH] proc: readdir race fix.
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
	<20060905103010.5f744bee.kamezawa.hiroyu@jp.fujitsu.com>
Date: Mon, 04 Sep 2006 20:30:55 -0600
In-Reply-To: <20060905103010.5f744bee.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Tue, 5 Sep 2006 10:30:10 +0900")
Message-ID: <m1lkoz3uzk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> Hi,
>
> On Mon, 04 Sep 2006 17:13:10 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>> These better semantics are implemented by scanning through the
>> pids in numerical order and by making the file offset a pid
>> plus a fixed offset.
> I think this is very sane/solid approach.
> Maybe this is the way to go. I'll test and ack later, thank you.
>
>> The pid scan happens on the pid bitmap, which when you look at it is
>> remarkably efficient for a brute force algorithm.  Given that a typical
>> cache line is 64 bytes and thus covers space for 64*8 == 200 pids.  There
>> are only 40 cache lines for the entire 32K pid space.  A typical system
>> will have 100 pids or more so this is actually fewer cache lines we have
>> to look at to scan a linked list, and the worst case of having to scan
>> the entire pid bitmap is pretty reasonable.
>
> I agree with you but..
> Becasue this approach has to access *all* task structs in a system,
> and have to scan pidhash many times. I'm not sure that this scan & lookup
> is good for future implementation. But this patch is obviously better than
> current implementation.

Quite possibly.  But where this approach falls down in not in the basics
but in the data structures.  And it isn't that hard to fix the data
structures.  Just something I don't want to do the first pass.

>>  /*
>> + * Used by proc to find the pid with the first
>> + * pid that is greater than or equal to number.
>> + *
>> + * If there is a pid at nr this function is exactly the same as find_pid.
>> + */
>> +struct pid *find_next_pid(int nr)
>> +{
>
> How about find_first_used_pid(int nr) ?

Maybe.  The best name I can think of is:
find_greater_or_equal_pid(int nr) and that is a little 
clumsy.   On the other hand it isn't confusing what the function
does.

Any other suggestions?

Eric
