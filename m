Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759435AbWLBKjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759435AbWLBKjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759436AbWLBKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:39:13 -0500
Received: from smtpout.mac.com ([17.250.248.185]:51433 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1759435AbWLBKjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:39:11 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEEDABAC.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKCEEDABAC.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E9F17630-A879-4EEC-8ACB-5E339DB0C79F@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       schwab@suse.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Sat, 2 Dec 2006 05:39:03 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-01_07:2006-12-01,2006-12-01,2006-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0610180000 definitions=main-0612020000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2006, at 09:03:26, David Schwartz wrote:
>> "David Schwartz" <davids@webmaster.com> writes:
>>> The problem is that '*(volatile unsigned int *)' results in a  
>>> 'volatile unsigned int'.
>>
>> No, it doesn't.  Values don't have qualifiers, only objects have.   
>> Qualifiers on rvalues are meaningless.
>
> Yeah. That's the problem here. The 'volatile' has no object to  
> qualify. You are essentially lying to the compiler (telling it the  
> pointer points to a volatile object when it doesn't) and hoping it  
> does the right thing.

No, the volatile has a perfectly valid object to qualify; the object  
pointed to by the provided pointer.  Casting in C is explicitly  
defined so that you can change the properties of something.  When I  
cast a "char *" pointer to "int *", I'm not telling the compiler to  
go through and magically convert a bunch of data, I'm telling it to  
treat the preexisting memory addresses, whatever they happened to be,  
as integer data.  The _only_ place where that is not true is casting  
an "int" to a "float" or vice versa, and even then it doesn't apply  
to any levels of indirection (casting "int *" to "float *" is  
virtually guaranteed to cause headaches for first-year CS students).

Likewise when I cast a pointer to "(volatile int *)", I am telling it  
that whatever happened before I want it to treat accesses through  
that new pointer as accesses to a volatile object, with all the  
implied confusion.  Now if my code isn't careful about aliasing and I  
modified the data through a different pointer a few moments before  
(and I have strict-aliasing turned on) then I may get inconsistent  
results because the value has not been written to memory yet just  
stored in a register.

> Nothing in the standard requires any special behavior for accesses  
> through volatile-qualified pointers. It only requires special  
> behavior for access to objects that are in fact volatile.

This is completely and utterly wrong.  See this quote from the C99  
standard pulled from the bugzilla page:
>> 6.7.3:  any expression referring to an object of volatile- 
>> qualified type must be evaluated strictly by the rules of the  
>> abstract machine, although precisely what constitutes an "access"  
>> to the object is implementation-defined.  (Note, implementation- 
>> defined" behavior is required to be well-defined and  
>> documented*.)  So if the reference in question is an "access", it  
>> must occur where the abstract machine says it should.

Now GCC's documentation in multiple places refer to an empty  
statement containing an lvalue or rvalue as being "read" access.   
Example: The statement "int i = 0; i;" would cause "i" to be "read"  
in the second statement.  Since "i" is not volatile then it may be  
optimized out, however if I stated "volatile int i = 0; i;", then the  
compiler would allocate "i" on the stack, assign 0 to it, then read  
it into a register.  GCC could not optimize any part of that out  
without breaking the rules of the abstract machine.

> I think the technically right solution is some mechanism to define  
> an object (which can be volatile-qualified) that exists at a  
> particular address.  Accessing this object would be accessing a  
> volatile object and you'd get all the things the standard promises.

Umm, that's exactly what "volatile" on a pointer means; treat this  
memory address as containing a volatile-qualified object.

> An adequate solution would probably be to make 'readl' return a  
> volatile-qualified unsigned integer.

No, you cannot return a volatile-qualified value because you a return  
value is an "rvalue" and rvalues cannot be "volatile".  They can't be  
"const" or "restrict" either, it just doesn't make any sense.

What would these mean?

const int foo(float x);
restrict int foo(float x);

How can a return-value be const or restrict?  It doesn't have an  
address I can take so I can't modify it where it is.  If you have an  
expression for which you cannot get the address of with the "&"  
operator (in other words, an rvalue) then "volatile", "const", or  
"restrict" make no sense on the type of your expression.

> It comes down to just what those guarantees GCC provides actually are.

This is the first correct statement in your email.  In any case the  
documented GCC guarantees have always been much stronger than you  
have been trying to persuade us they should be.  I would argue that  
the C standard somewhat indirectly specifies those guarantees but I  
really don't have the heart for any more language-lawyering so I'm  
going to leave it at that.

Cheers,
Kyle Moffett

