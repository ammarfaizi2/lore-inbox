Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWIXQ3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIXQ3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWIXQ3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:29:40 -0400
Received: from mail.aknet.ru ([82.179.72.26]:10246 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751202AbWIXQ3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:29:39 -0400
Message-ID: <4516B2C8.4050202@aknet.ru>
Date: Sun, 24 Sep 2006 20:31:04 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>
In-Reply-To: <4516A8E3.4020100@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Ulrich Drepper wrote:
>> The one that goes to /dev/shm should allow PROT_EXEC, yet
>> not allow executing the binaries with execve().
> Why on earth would you want this?  Previously you already acknowledged
> that this kind of "protection" can be worked around by using ld.so
> directly.
I have not acknowledged this but rather was pointed out
to that fact and to that the checks were supposed to solve
this problem.
I agree the problem does exist, but isn't it a user-space
problem? Hugh Dickins points out that the failure of PROT_EXEC
mmap is a quick way for ld.so to find out the fact that the
partition is mounted with "noexec". But are there really no
other ways? Maybe (just maybe, I am unaware about details) ld.so
can look into /proc/mounts or similar and do the right thing
itself?

> Either all executable mapping is forbidden or none.  No middle ground
> can exist.
Exactly. So why such a "middle-ground" solution is currently
there? I can:
1. mprotect() the existing mapping to PROT_EXEC and bypass the
checks (but you can easily restrict that by patching mprotect()).
2. Do the anonymous mmap with PROT_EXEC set, then simply read()
the code there, then execute. This you *can not* restrict!

On the other hand: such a checks hurts the properly-written
code *only*, no malicious loaders can be affected. The properly-
written code breaks because it uses MAP_SHARED mmaps - that's
what you can restrict. The malicious loader will simply read
the code into the area previously mmaped anonymuosly - it doesn't
need MAP_SHARED. As you pointed out, such a malicious loader can
probably be a script. So, by rejecting the file-backed mmaps with
PROT_EXEC set, you hurt the good programs, while the bad ones are
completely unaffected.
Now, the breakage of the properly-written programs forces people
to stop using "noexec" on /dev/shm-mounted tmpfs. As far as I
understand, having the single writeable and executable mountpoint
is almost as bad as having all of them. The attacker will now simply
put his binary into /dev/shm.
IMHO, allowing people to use "noexec" for /dev/shm and making ld.so
to use other ways of finding the "noexecness" will solve the
problem, at least to the much better state than currently.

