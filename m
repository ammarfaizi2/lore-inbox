Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHIVKx>; Fri, 9 Aug 2002 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSHIVKw>; Fri, 9 Aug 2002 17:10:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6412 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316089AbSHIVKv>; Fri, 9 Aug 2002 17:10:51 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH 2.5.30+] Fourth attempt at a shared credentials patch
Date: Fri, 9 Aug 2002 21:15:20 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aj1bd8$ipm$1@penguin.transmeta.com>
References: <23130000.1028818693@baldur.austin.ibm.com> <81390000.1028837464@baldur.austin.ibm.com> <15698.59577.788998.300262@charged.uio.no> <55560000.1028921049@baldur.austin.ibm.com>
X-Trace: palladium.transmeta.com 1028927658 26602 127.0.0.1 (9 Aug 2002 21:14:18 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 9 Aug 2002 21:14:18 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <55560000.1028921049@baldur.austin.ibm.com>,
Dave McCracken  <dmccr@us.ibm.com> wrote:
>
>--On Thursday, August 08, 2002 11:55:05 PM +0200 Trond Myklebust
><trond.myklebust@fys.uio.no> wrote:
>
>> What if one thread is doing an RPC call while the other is changing
>> the 'groups' entry?
>
>Gah.  Good point.  Ok, I've added locking to the cred structure to handle
>this.

Please don't do this with locking, I really think the right thing to do
is to have a "duplicate()" function, and when you pass credentials off
to something, you dup them at that point.

If you start off as non-root, and then execve suid into root, a pending
NFS request should _not_ suddently have the credentials changed under
it. Yet clearly that kind of thing can't just be locked either.

Along with copy-on-write semantics, this should perform perfectly well
(ie "duplicate()" would only increment a count, and then setuid() would
have to have code soemthing like

	if (cred->count > 1) {
		newcred = alloc_cred();
		copy_cred(newcred, cred);
		for_each_cred_group(p) {
			p->cred = newcred;
			atomic_inc(&newcred->count);
			putcred(cred);
		}
	}

instead.

		Linus
