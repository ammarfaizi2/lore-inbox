Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUIRRDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUIRRDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 13:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUIRRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 13:03:33 -0400
Received: from mail.aknet.ru ([217.67.122.194]:59653 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S267930AbUIRRDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 13:03:30 -0400
Message-ID: <414C6ABC.4030702@aknet.ru>
Date: Sat, 18 Sep 2004 21:05:00 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <4149D243.5050501@aknet.ru> <200409180104.09796.vda@port.imtp.ilyichevsk.odessa.ua> <414C14CD.7030200@aknet.ru> <200409181608.18440.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409181608.18440.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis.

Denis Vlasenko wrote:
> Aha. The only way to sanely handle it is to
> hack on entry.S I'm afraid. Something like rewriting
> CS:EIP so that it returns to a small ring-3 trampoline
> which clears upper 16 bits of ESP and jumps to original CS:EIP.
Well, I don't really want to clear the higher word
of ESP (even if I want to do that in most cases),
but I'd really like to just restore it properly.
Of course (I think) ring-3 trampoline will not
work for many reasons. The most obvious one is
that it itself can be interrupted in any place.
Another problem with it is that the return frame
will have to be pushed to the stack of a DOS prog.
This is not the good thing to do. dosemu avoids
ever touching the stack of a DOS prog by setting
up the sigaltstack.
What *will* work, however, is a ring-1 trampoline,
as Petr Vandrovec suggested. It can be executed
with interrupts disabled (I think) so will not
be interrupted, and it can (isn't it?) use the
kernel stack, if I understand that correctly.

> Now, how to detect when to use this? Hmm.... the simplest thing
> is to check that
> (old_ESP <= 0xffff) && !(old_EFLAGS & VM_MASK) && (descr_old_SS is 16bit one)
Yes, that's an excellent idea (except for the
ESP<=0xffff check - I don't think this one is
necessary).

> This will cost us only one comparison in the normal
> path,
Yes, so I think I should just try to implement
that. Not as a ring-3 trampoline, but as a ring-1
one.

> because typically ESP of Linus executables
> is greater than 0xffff.
I'd rather say, because the stack segment is 32bit
for them always.
And this all should work, as it seems to me.
Thanks for the hint about the checking.

