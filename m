Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWIYVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWIYVgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIYVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:36:37 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:37287 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751458AbWIYVgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:36:36 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Mon, 25 Sep 2006 21:36:26 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef9i4q$emc$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4516C9D0.3080606@aknet.ru> <ef6ldq$uup$1@taverner.cs.berkeley.edu> <20060925105355.GA4390@elf.ucw.cz>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159220186 15052 128.32.168.222 (25 Sep 2006 21:36:26 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 25 Sep 2006 21:36:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek  wrote:
>> I'm curious about this, too.  ld-linux.so is a purely unprivileged
>> program.  It isn't setuid root.  Can you write a variant of ld-linux.so
>> that reads an executable into memory off of a partition mounted noexec and
>> then begins executing that code?  (perhaps by using anonymous mmap
>> with
>
>Yes, you can, but to execute your ld-linux-ignore-noexec.so variant,
>you need to put it somewhere with exec permissions, right?

Well, yes, if you write it as a binary executable -- but not if you're
more clever.  For instance, you can write a ld-linux-ignore-noexec.so.pl
Perl script, store the Perl script on the noexec partition, and execute
it via "/usr/bin/perl ld-linux-ignore-noexec.so.pl" (since I think
Perl scripts can execute all of the system calls you'd need to use to
write your own loader, since it's pretty well guaranteed that /usr/bin
will live on a partition that is not marked noexec).  Note that Perl
will happily execute scripts that are stored on a noexec partition and
that do not have the execute bit set.  That bypassess all of the noexec
protections pretty handily.

I'm still having a hard time understanding in what way this is an
effective security mechanism.  What is the threat model?  What is the
security goal that it is trying to achieve?  It strikes me as a mechanism
that might be effective at preventing some kinds of unintentional
execution of code off of the noexec partition, but not at preventing
intentional execution of code.  If that is the case, it's not really
a security check in the first place.  And in that case, if a recent
tightening of the noexec restrictions breaks some real distribution,
then I think it might be reasonable to re-think that tightening.

Then again, maybe I'm missing something.  My knowledge of noexec and
the motivation for introducing it is rather limited.  If anyone cares
to enlighten me, I'll be glad to listen.

(Out of curiousity, why was noexec introduced in the first place?
What problem is it designed to solve?  When I was first introduced to
noexec, I was told that the reason it existed was so that you could
mark your NFS mounts as noexec.  The problem is that NFS is insecure.
Especially in the old days of non-switched networks, anyone who was
on the same subnet as you could easily modify the bytes of all files
read over NFS.  This meant that executing programs that reside on a NFS
partition was a bad idea.  The noexec flag was intended to help remind
you not to do that.  Of course, the noexec flag was a total kludge that
didn't solve the real problem at all; the only argument going for it was
that it was easy to introduce, it didn't break anything, maybe it helped
prevent some kinds of unintentional failures, and it gave us a little time
to fix NFS the right way.  Well, it's years later, and we still haven't
fixed NFS; noexec is still a kludge that doesn't appear to solve the real
problem; only now we hear that a recent modification to noexec semantics
has broken an important Linux distribution.  That story is what makes me
inclined to be sympathetic to Stas's complaints and skeptical about the
arguments in favor of the recently-added strengthening of enforcement
of noexec.  Of course, maybe I don't have the whole story or maybe I'm
missing something.)
