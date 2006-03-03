Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWCCRuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWCCRuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWCCRuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:50:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13725 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030265AbWCCRuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:50:11 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
	<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
	<4408753B.52E3B003@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 03 Mar 2006 10:48:05 -0700
In-Reply-To: <4408753B.52E3B003@tv-sign.ru> (Oleg Nesterov's message of
 "Fri, 03 Mar 2006 19:56:27 +0300")
Message-ID: <m1u0afe7xm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@tv-sign.ru> writes:
>>
>> > I think there is another, much simpler solution. We can make a "reference"
> to
>> > the
>> > pid itself to protect it against free_pidmap(), so that this pid can't be
>> > reused.
>>
>> However with my trivial hostile program I can with 32 or 33 living processes
>> each with 1000 references to dead processes I can completely saturate the
>> default pid map.  And it won't be obvious why alloc_pidmap is failing.
>
> Yes, this is a problem. Please see the new version below. Instead of delaying
> pid releasing, free_pidmap() just invalidates pid_ref. The code becomes even
> simpler.

And it removes most of my interaction problem with multiple pid spaces.

>> Your resource consumption with the extra hash table is higher than
>> mine at until very high process counts.
>
> The size of ref_array[] could be arbitrary low (we can't use pid_hashfn() in
> this case, of course). And tref adds 4 * sizeof(void*) to every task, and it
> is much more complicated.

I guess the worst case behavior would be triggered by a find in /proc.
Which would probably populate a ref for every pid, and it isn't that
uncommon.   So I suspect we really want to make ref_array be able to
use pid hashfn as it is likely to get an equal amount of use.

More comments when I have time.

Eric
