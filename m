Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSHIUrd>; Fri, 9 Aug 2002 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSHIUrd>; Fri, 9 Aug 2002 16:47:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4528 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315784AbSHIUrb>;
	Fri, 9 Aug 2002 16:47:31 -0400
Date: Fri, 09 Aug 2002 15:51:01 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: trond.myklebust@fys.uio.no
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Fourth attempt at a shared credentials patch
Message-ID: <71170000.1028926261@baldur.austin.ibm.com>
In-Reply-To: <15700.7516.306330.976815@charged.uio.no>
References: <23130000.1028818693@baldur.austin.ibm.com>
 <shsofcdfjt6.fsf@charged.uio.no><44050000.1028823650@baldur.austin.ibm.com>
 <15698.41542.250846.334946@charged.uio.no>
 <52960000.1028829902@baldur.austin.ibm.com>
 <15698.52455.437254.428402@charged.uio.no>
 <81390000.1028837464@baldur.austin.ibm.com>
 <15698.59577.788998.300262@charged.uio.no>
 <55560000.1028921049@baldur.austin.ibm.com>
 <15700.7516.306330.976815@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, August 09, 2002 09:51:56 PM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> Err... Well my original point about your changes to the sunrpc code
> still stand: no spinlocking there AFAICS. In addition, you'll want to
> talk to the Intermezzo people: they do allocation of buffers based on
> the (volatile) value of cred->ngroups.

Oops.  I missed the sunrpc case.  This patch fixes it:

http://www.ibm.com/linux/ltc/patches/misc/cred-2.5.30-6.diff.gz

I think I mostly nailed the intermezzo case.  I did go through it.

> Finally, you also want all those reads and changes to more than one
> value in the credential such as the stuff in security/capability.c, or
> net/socket.c,... to be atomic. (Note: This is where 'struct ucred'
> with COW gives you an efficiency gain).

I disagree.  It won't generate bogus values of any of these fields.  There
may be some cases where it'll pick up a combination of before and after
values, but I don't see where any of that is fatal.
 
> Please also note that you only need spinlocking for the particular
> case of tasks that have set CLONE_CRED. In all other cases, it adds a
> rather nasty overhead...

Spinlock isn't nasty overhead, if it's not contested. It seems to me that
checking whether it's shared is as much overhead as just taking the lock.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

