Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVBGVJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVBGVJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBGVJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:09:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59027 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261274AbVBGVJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:09:48 -0500
Date: Mon, 7 Feb 2005 22:08:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050207210809.GA9781@elte.hu>
References: <4202BFDB.24670.67046BC@localhost> <42080689.15768.1B0C5E5F@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42080689.15768.1B0C5E5F@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> > still wrong. What you get this way is a nice, complicated NOP.
> 
> not only a nop but also a likely crash given that i didn't adjust
> the declaration of some_function appropriately ;-). let's cater
> for less complexity too with the following payload (of the 'many
> other ways' kind):
> 
> [field1 and other locals replaced with shellcode]
> [space to cover the locals of __libc_dlopen_mode()]

yes, i agree with you, __libc_dlopen_mode() is an easier target (but not
_that_ easy of a target, see further down), and your code looks right -
but what this discussion was about was the _dl_make_stack_executable()
function. Similar 'protection' techniques can be used for
__libc_dlopen_mode() too, and it's being fixed.

(you'd be correct to point out that what cannot be 'fixed' even this way
are libdl.so using applications and the dlopen() symbol - for them, if
randomization is not enough, PaX or SELinux is the fix.)

> one disadvantage of this approach is that now not only the randomness
> in libc.so has to be found but also that of the stack (repeating parts
> of the payload would help reduce it though), and if user_input itself
> is on the heap (and there're no copies on the stack), we'll need that
> randomness too.

such an attack needs to get 2 or 3 random values right - which,
considering 13-bits randomization per value is still 26-39 bits (minus
the constant number of bits you can get away via replication). If the
stack wasnt nonexec then the attack would need to get only 1 random
value right. In that sense it still makes quite a difference in
increasing the complexity of the attack, do you agree?

Yes, the drastic method is to disable the adding of code to a process
image altogether (PaX did this first, and does a nice job in that, and
SELinux is catching up as well), but that clearly was not a product
option when PT_GNU_STACK was written. As you can see on lkml, people are
resisting changes hard that affect 2-3 apps. What chances do changes
have that break dozens of common applications? PT_GNU_STACK is not
perfect, but it was the maximum we could get away on the non-selinux
side of the distribution, mapping many of the dependencies and
assumptions of apps.

So PT_GNU_STACK is certainly a beginning, and as the end result
(hopefully soon) we can do away with libraries having any RWE
PT_GNU_STACK markings (so that only binaries can carry RWE) and can move
make_stacks_executable() from libc.so. You seem to consider these steps
of how Fedora 'morphs' into a productized version of SELinux as 'fully
vulnerable' (and despise it), there's no way around walking that walk
and persuading users to actually follow - which is the hardest part.

	Ingo
