Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWJCRNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWJCRNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWJCRNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:13:11 -0400
Received: from mail.aknet.ru ([82.179.72.26]:31492 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1030338AbWJCRNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:13:10 -0400
Message-ID: <45229A99.6060703@aknet.ru>
Date: Tue, 03 Oct 2006 21:15:05 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org>  <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org>
In-Reply-To: <1159887682.2891.537.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Arjan van de Ven wrote:
> no what bothers me that on the one hand you want no execute from the
> partition, and AT THE SAME TIME want stuff to execute from there (being
> libraries or binaries, same thing to me).
The original problem came from "noexec" on /dev/shm
mount. There is no library and no binary there, but
the programs do shm_open(), ftruncate() and
mmap(MAP_SHARED, PROT_EXEC) to get some shared memory
with an exec perm. That fails.

> That duality feels strange to me,
IMHO there should be some policy that can be achieved.
If the policy is: "noexec should fail execve()", then
this can be achieved, and that's what it was in the past.
What is the policy now? The things like a possibility
to mprotect() that memory to PROT_EXEC, or in case of a
MAP_PRIVATE, to simply use MAP_ANONYMOUS then read(),
suggests that there is no strict policy at all any more.

> I could understand if you wanted noexec to be MORE strict; I fail to
> understand why you want it LESS strict!
My point is that it is neither more not less strict with
such a change. If the workaround is trivial anyway
(either mprotect or use MAP_ANONYMOUS and read()), then
there is no point in such a strictness. On the other
hand, the programs break.
What was pointed out by Hugh is that the current behaveour
is needed to solve one particular problem, which is when
the user invokes ld.so directly and you want it to fail on
a noexec partition. I accept that argument, but I have to
add that the mmap change doesn't solve the similar problem
when the user uses ld.so directly to execute the binaries
he doesn't have an exec permissions for.
So I think another solution is needed: the one, preferrably,
not breaking an existing apps; solving both of the above
problems, not just one of them; allowing an admin to control
that behaveour in a convenient way.
My idea is to execute the loader with the fsuid=0. Then you
can do simply "chmod 'go-x' ld.so", and the problem solved.
I'd like any opinions on that idea, although nothing positive
is expected at that point. :)

> What breaks?
You missed the beginning of the discussion, but briefly:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945
... breaks UML and dosemu.
Also I speculate that it makes Wine slower causing it to
fallback to read() if the windows partition is mounted with
"noexec" (which I think is/was common). In that case people
will never figure out why Wine suddenly became slower and
more memory-consuming than before.

