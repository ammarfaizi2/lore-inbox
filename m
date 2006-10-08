Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWJHNob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWJHNob (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWJHNob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:44:31 -0400
Received: from mail.aknet.ru ([82.179.72.26]:13065 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751160AbWJHNoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:44:30 -0400
Message-ID: <45290143.80808@aknet.ru>
Date: Sun, 08 Oct 2006 17:46:43 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru>	 <1160170464.12835.4.camel@localhost.localdomain>	 <4526C7F4.6090706@redhat.com> <45278D2A.4020605@aknet.ru>	 <4527D64A.7060002@redhat.com>  <4527FC8B.8010208@aknet.ru>	 <1160296364.3000.167.camel@laptopd505.fenrus.org>	 <4528C0B0.4070002@aknet.ru> <1160304945.3000.175.camel@laptopd505.fenrus.org>
In-Reply-To: <1160304945.3000.175.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Arjan van de Ven wrote:
> But when invoked manually.. there is even LESS special about it... it
> could be ANY file on the system. And it's no different from any other
> file in /bin, /usr/bin etc etc
I agree with that completely, but it was not me
who started adding the ld.so-specific tricks to
the kernel, making it special.
The assumptions of the current mmap check are:
1. The program does mmap with PROT_EXEC, not mmap/mprotect
(it was explicitly pointed out that this is unlikely to change).
2. The program does the file-backed mmap, not the anon
mmap then read.
That suits ld.so very well because it happened to work that
way, but it is not very usefull for pretty much anything else
(unless someone can show the real-life examples).
So this is what makes ld.so special. Right now it checks
exec/noexec by trying mmap(PROT_EXEC) and see if that fails.
But there can be other ways to check that, including the ones
that will not break the other progs/configurations.
And I don't see any harm in having a way for the program
to explicitly say whether it wants an exec perm or not.
(access() suits exactly for that, but it is racey)

>> Otherwise, please tell me, how can you solve the problem
>> of ld.so started directly, can execute the files you do
>> not have an exec permission for?
> denying PROT_EXEC of non-"x" files does (somewhat).
But you can't do that - lets be realistic. Also I wonder
whether it will violate the posix specs or not.

> It's never fool
> proof obviously, as long as you need to allow jits.
Certainly.

>> Then ld.so can just use that to solve all those permission
>> problems.
> this is just entirely a wrong assumption; one based on the assumption
> that ld.so is something special, that it isn't.
Yes, that assumption is wrong, but it was not me who
invented it. I only want to move the ld.so-specific
stuff to ld.so itself, nothing more.

