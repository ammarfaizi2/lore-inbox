Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVJNSxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVJNSxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVJNSxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:53:12 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:1037 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1750860AbVJNSxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:53:12 -0400
Date: Fri, 14 Oct 2005 11:53:11 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
Message-ID: <20051014185311.GH14194@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r7aoohwn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 10:13:12PM -0600, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >>  static int __init check_nmi_watchdog(void)
> >>  {
> >> +	volatile int endflag = 0;
> >
> > I don't think this needs to be declared volatile?
> 
> I haven't though it through extremely closely but I believe
> the stores into that variable in check_nmi_watchdog could 
> legitimately be optimized away by the compiler if it doesn't
> have a hint.  As the variable is auto and is never used
> after the store without volatile it seems a reasonable
> assumption that no one else will see the value.
> 
> If the variable was static the volatile would clearly be unnecessary
> as we have taken the address earlier so at some point the compiler
> would be obligated to but with the variable being auto the rules are a
> little murky.

I don't think it's murky at all; since you took the address and passed
it to another function, the compiler has to assume that you saved the
pointer away and will be referring to it later.  (Unless the compiler
can prove that you *won't* be referring to it later, such as if there
are no more function calls between the store and the variable going out
of scope, or if the compiler does whole-program optimization and can see
the entire data flow of that pointer and prove that it's not
dereferenced.)

Proving this using the standard is a bit of a challenge...

6.2.4:
4 An object whose identifier is declared with no linkage and without the
  storage-class specifier static has automatic storage duration.
5 For such an object that does not have a variable length array type,
  its lifetime extends from entry into the block with which it is
  associated until execution of that block ends in any way. (Entering an
  enclosed block or calling a function suspends, but does not end,
  execution of the current block.)

6.5.3.2:
3 The unary & operator returns the address of its operand. If the
  operand has type ``type'', the result has type ``pointer to type''.
4 The unary * operator denotes indirection. If the operand ... points to
  an object, the result is an lvalue designating the object. If the
  operand has type ``pointer to type'', the result has type ``type''.

So the object 'endflag' has lifetime extending until the end of the
function; you are permitted to take its address and pass that address to
a function (which stores it somewhere with static or allocated
duration); a later function call is then permitted to dereference the
stored pointer so long as 'endflag' has not yet passed out of scope.

Now, I think the following could hypothetically be a problem:

static int *bp;

int foo() {
	volatile int flag = 0;
	int blah = 0, count = 0;

	bp = &blah;
	pthread_create(baz, flag);
	blah++;
	while(flag == 0)
		count++;
	return count;
}

int baz(void *p) {
	volatile int *flag = p;
	int count = 1;
	while(*bp == 0)
		count++;
	*flag = count;
}

An optimizing compiler could look at foo() and decide that since blah is
not volatile, and there are no function calls after it is incremented,
the increment can be discarded.  But alas, baz() does check the value on
another thread.

I believe (but have not verified) that GCC simply inhibits
dead-store-elimination when the address of the variable has been taken,
so this theoretical possibility is not a real danger under gcc.  And in
any case, it doesn't apply to your check_nmi_watchdog, because you've
got function calls after the assignment.

-andy
