Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWCSOBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWCSOBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 09:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWCSOBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 09:01:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13720 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750700AbWCSOBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 09:01:15 -0500
To: Janak Desai <janak@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk,
       hch@lst.de, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
	<29085.1142557915@www064.gmx.net>
	<Pine.LNX.4.64.0603162140190.3618@g5.osdl.org>
	<m1r74zzjbg.fsf@ebiederm.dsl.xmission.com>
	<441C6570.7040502@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 06:58:37 -0700
In-Reply-To: <441C6570.7040502@us.ibm.com> (Janak Desai's message of "Sat,
 18 Mar 2006 14:54:24 -0500")
Message-ID: <m1irqazgc2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janak Desai <janak@us.ibm.com> writes:

> Eric W. Biederman wrote:
>
>>Was there ever a good reason why we decided to flip the sense of
>>the bits?
>>
>>I put a together a patch to see what the code would look like:
>>
>>- We actually can reuse between clone and unshare.
>>- We don't need the confusing case of when to add additional resources
>>  to unshare.
>>- There is less total code.
>>- We don't confuse users and developers about the inverted values of
>>  the clone bits.
>>
>>
> I guess confusion is subjective. With this patch if I want to unshare files and
> leave the rest as is, I would have to call
>
> unshare(CLONE_VM | CLONE_FS | CLONE_SIGHAND | ...)

Yes. In my patch unshare(0) unshares all resources that a fork won't
share.

Does anyone use unshare on threads?

My corresponding objection with the current interface is that it
appears to be an implementation of "Do what I mean".  Whenever
you do more than is asked for you run into trouble.

> That is, to unshare one type of context, I have to remember and use flags
> corresponding to all other contexts. If I forget to include one of them, I
> might unwittingly unshare it. Unless I am reading the patch incorrectly,
> this to me is more confusing than the current scheme.

Not exactly.  unshare(CLONE_NEWNS) does not need any additional flags
and I believe it is the primary case of interest.

Beyond that for any version of unshare to be predictable you need
to know what you have shared and what you don't.  Which means
either another syscall or a /proc file that will give you that
information.

Personally I think being unthreaded is easier to work with
than the existing rule of everything necessary to unshare the
specified resources.  Especially since I can be explicit and
tell it to leaves things the way they are.

With a query interface mine becomes unshare(get_shared() & ~CLONE_FILES).
Which is the normal paradigm for modifying something expressed as
flags.

With the current kernel implementation I can't see how calling
unshare(CLONE_NEWNS) is any less surprising when called in a user
space thread.  Without a deep understanding of the kernel I don't
see how you can predict that will unshare your current filesystem
root and cwd pointers.   

My rule that you stop being a thread I think is a little easier
to remember if not understand.  Who would suspect that in the current
kernel unshare(CLONE_THREAD) does not completely unshare all of the
resources that a thread shares?

Anyway I think unshare needs to carry a big fat:
WARNING dangerous when used with threads be very very careful!

Unfortunately that isn't something I can think of a general
test for right now.  Which makes using unshare in a library fairly
dangerous.

Eric
