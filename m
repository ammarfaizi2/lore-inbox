Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135595AbREBPqp>; Wed, 2 May 2001 11:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135598AbREBPqg>; Wed, 2 May 2001 11:46:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:29176 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S135595AbREBPqV>; Wed, 2 May 2001 11:46:21 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [RFC] gcc compile-time assertions
Date: Wed, 02 May 2001 16:46:14 +0100
Message-ID: <10792.988818374@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking for comments on an idea I've thrashed out with David Woodhouse,
Arjan Van de Ven and Andrew Haley...

I've written a patch for gcc to implement compile-time assertions with an eye
to making use of this in the kernel in the future (assuming I can get it to be
accepted into gcc).

One of the main uses I can see for it is for things like udelay() that need
their arguments range checking. The current method of doing this is by causing
an undefined symbol to be referenced, thereby causing the linker to emit an
error that can be hard to trace.

The gcc patch can be downloaded:

	ftp://infradead.org/pub/people/dwh/ctassert.diff

Basically, what I've written is a small extension for gcc that implements
compile-time assertion checking through a new built in function (this has
negligible impact on the rest of the source for gcc).

The assertion function takes two arguments, a condition and a message
string. The return value is an expression "condition!=0". The function would
prototype something like:

	int __builtin_ct_assert(<any-type> condition, const char message[])

Additionally, if that expression can be evaluated to a constant of zero at
compile time, an error will be issued that includes the message string in its
text.

The main reason I'd like to see this added to gcc is to help improve the Linux
kernel's robustness by catching certain conditions at compile time. For
instance, Linux's udelay() function (which waits for a number of microseconds
up to a limit of 20000uS), is implemented in the i386 architecture thus:

| extern void __bad_udelay(void);
| extern void __udelay(unsigned long usecs);
| extern void __const_udelay(unsigned long usecs);
|
| #define udelay(n) (__builtin_constant_p(n) ? \
|       ((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
|       __udelay(n))

This relies on __bad_udelay() getting referenced in the program when n is too
large, and causing a linker error, which is quite hard to trace since the
kernel build makes heavy use of incremental linking.

This can be re-implemented using my gcc patch:

| #define udelay(n) ( \
|    __builtin_ct_assert((n)<=20000,"udelay() value should be <=20000uS"), \
|    __builtin_constant_p(n) ? __const_udelay((n) * 0x10c6ul) : __udelay(n))

And producing an error of the following sort:

| test.c:21: compile-time assertion failed: udelay() value should be <=20000uS

Cheers,
David Howells
