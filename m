Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVJOMu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJOMu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 08:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJOMu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 08:50:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6852 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751082AbVJOMu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 08:50:26 -0400
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
References: <20051014185311.GH14194@hexapodia.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 15 Oct 2005 06:49:56 -0600
In-Reply-To: <20051014185311.GH14194@hexapodia.org> (Andy Isaacson's message
 of "Fri, 14 Oct 2005 11:53:11 -0700")
Message-ID: <m13bn3ndvv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> writes:

> On Thu, Oct 13, 2005 at 10:13:12PM -0600, Eric W. Biederman wrote:
>> Andrew Morton <akpm@osdl.org> writes:
>> > ebiederm@xmission.com (Eric W. Biederman) wrote:
>> >>  static int __init check_nmi_watchdog(void)
>> >>  {
>> >> +	volatile int endflag = 0;
>> >
>> > I don't think this needs to be declared volatile?
>> 
>> If the variable was static the volatile would clearly be unnecessary
>> as we have taken the address earlier so at some point the compiler
>> would be obligated to but with the variable being auto the rules are a
>> little murky.
>
> I don't think it's murky at all; since you took the address and passed
> it to another function, the compiler has to assume that you saved the
> pointer away and will be referring to it later.  (Unless the compiler
> can prove that you *won't* be referring to it later, such as if there
> are no more function calls between the store and the variable going out
> of scope, or if the compiler does whole-program optimization and can see
> the entire data flow of that pointer and prove that it's not
> dereferenced.)
>
> Now, I think the following could hypothetically be a problem:
>
> An optimizing compiler could look at foo() and decide that since blah is
> not volatile, and there are no function calls after it is incremented,
> the increment can be discarded.  But alas, baz() does check the value on
> another thread.
>
> I believe (but have not verified) that GCC simply inhibits
> dead-store-elimination when the address of the variable has been taken,
> so this theoretical possibility is not a real danger under gcc.  And in
> any case, it doesn't apply to your check_nmi_watchdog, because you've
> got function calls after the assignment.

It comes very close to applying to check_nmi_watchdog as both
of the functions called after endflag is set: printk and kfree 
both have nothing to do with the setting of endflag.   If they
were simpler functions an optimizing compiler could look at
them realizing that.  Since those two functions have nothing
to do with endflag someone else looking at the code remove or
reorder them with a trivial patch and the code could stop working.

GCC keeps getting more powerful optimizations so I am not comfortable
with depending on it simply eliminating dead-store-elimination when the
address of a variable has been taken.

If there is a better idiom to synchronize the cpus which does
not mark the variable volatile I could see switching to that. 

There is a theoretical race there as some cpu might not see endflag
get set and the next function on the stack could set it that same
stack slot to 0.  I can see value in fixing that, if there is a simple
and clear solution.  Currently I am having a failure of imagination.

Eric
