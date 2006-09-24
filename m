Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWIXJ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWIXJ7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 05:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWIXJ73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 05:59:29 -0400
Received: from mail.aknet.ru ([82.179.72.26]:25618 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751849AbWIXJ73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 05:59:29 -0400
Message-ID: <45165755.8070607@aknet.ru>
Date: Sun, 24 Sep 2006 14:00:53 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>  <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>  <451555CB.5010006@aknet.ru>  <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com> <1159037913.24572.62.camel@localhost.localdomain> <45162BE5.2020100@aknet.ru> <Pine.LNX.4.64.0609241009020.17400@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0609241009020.17400@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hugh Dickins wrote:
>> Since "noexec" was already rendered useless - yes.
> I'm very puzzled.  The intention of "noexec" is to prevent execution
> of files on that mount.  You're saying it's useless because it's
That was actually a bad english on my side, sorry
(English is not my native lang). Instead of "useless"
I meant to say "changed to the point where it cannot be
effectively used any more".

> preventing execution of files on that mount?
What exactly the "execution" consist of here? You are
not going to prevent an execution of some perl scripts
etc, dont you? So IMHO that applies to only the execution
of the native binaries, ie, similair to just removing the
exec permission from all the files on that partition. Or
at least that's how I understand it. And clearing an exec
permission doesn't disable PROT_EXEC, AFAIK.

> It seems to me that
> you simply have a mount where "noexec" presents more problems than
> it solves: so don't use it there.
I am not at all an expert in a security but I think the point
of "noexecing" the partitions was to make it difficult for an
attacker to put his own binaries somewhere and execute them.
In this case (but I may be wrong) leaving tmpfs without noexec
prevents that goal from being achieved even if all the other
writeable partitions are noexeced, because an attacker will
use /dev/shm for his binaries then. Just my guesses though.

> That doesn't mean it's useless:
> not every mmap involves PROT_EXEC, not every mount demands execution.
I think it is now more useless than before because that
restriction breaks *only* the properly written apps, while
the malicious ones are completely unaffected. That forces
the people to use it rarely than before (not on tmpfs), and
so it looses its use almost completely, leaving at least that
partition executable.
Why only the properly-written apps breaks is because they use
MAP_SHARED - that you *can* effectively protect from PROT_EXEC,
provided you restrict also mprotect(). The malicious apps are
unaffected because they will not use MAP_SHARED, but instead
just read() the binary into the anonymously mapped area with
PROT_EXEC set. ld.so could certainly do that work on his own,
but I don't know how difficult it could be. (I guess it could
retrieve the "noexec" flag from /proc/mounts or something like
that, instead of trying PROT_EXEC and see if it fails).

