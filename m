Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318805AbSHLUFD>; Mon, 12 Aug 2002 16:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSHLUFC>; Mon, 12 Aug 2002 16:05:02 -0400
Received: from pat.uio.no ([129.240.130.16]:49085 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318805AbSHLUFC>;
	Mon, 12 Aug 2002 16:05:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15704.5582.889793.670322@charged.uio.no>
Date: Mon, 12 Aug 2002 22:08:46 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Fourth attempt at a shared credentials patch
In-Reply-To: <71170000.1028926261@baldur.austin.ibm.com>
References: <23130000.1028818693@baldur.austin.ibm.com>
	<shsofcdfjt6.fsf@charged.uio.no>
	<44050000.1028823650@baldur.austin.ibm.com>
	<15698.41542.250846.334946@charged.uio.no>
	<52960000.1028829902@baldur.austin.ibm.com>
	<15698.52455.437254.428402@charged.uio.no>
	<81390000.1028837464@baldur.austin.ibm.com>
	<15698.59577.788998.300262@charged.uio.no>
	<55560000.1028921049@baldur.austin.ibm.com>
	<15700.7516.306330.976815@charged.uio.no>
	<71170000.1028926261@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > I think I mostly nailed the intermezzo case.  I did go through
     > it.

Are you sure? AFAICS, the intermezzo code assumes that ngroups/groups
won't change while you inside the intermezzo layer itself. Look at the
way they stuff current->ngroups into the record 'size', then do the
actual copy in journal_log_prefix()...

    >> Finally, you also want all those reads and changes to more than
    >> one value in the credential such as the stuff in
    >> security/capability.c, or net/socket.c,... to be atomic. (Note:
    >> This is where 'struct ucred' with COW gives you an efficiency
    >> gain).

     > I disagree.  It won't generate bogus values of any of these
     > fields.  There may be some cases where it'll pick up a
     > combination of before and after values, but I don't see where
     > any of that is fatal.

It doesn't have to be fatal in order to be a security risk. The kernel
simply does not know whether or not formula A (random combination of
uid/gid/groups) will be secure as opposed to the before/after states.
 
    >> Please also note that you only need spinlocking for the
    >> particular case of tasks that have set CLONE_CRED. In all other
    >> cases, it adds a rather nasty overhead...

     > Spinlock isn't nasty overhead, if it's not contested. It seems
     > to me that checking whether it's shared is as much overhead as
     > just taking the lock.

spinlocking is designed so as to invalidate the processor caches.

Cheers,
  Trond
