Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131520AbQLMXsN>; Wed, 13 Dec 2000 18:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131554AbQLMXsC>; Wed, 13 Dec 2000 18:48:02 -0500
Received: from fe4.rdc-kc.rr.com ([24.94.163.51]:26130 "EHLO mail4.kc.rr.com")
	by vger.kernel.org with ESMTP id <S131520AbQLMXrp>;
	Wed, 13 Dec 2000 18:47:45 -0500
To: Mark Kettenis <kettenis@wins.uva.nl>
Cc: Peter Berger <peterb@telerama.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Pthreads, linux, gdb, oh my! (and ptrace must die!)
In-Reply-To: <Pine.BSI.4.02.10012081445290.26743-100000@frogger.telerama.com>
	<s3ilmtka14t.fsf@debye.wins.uva.nl>
From: Mike Coleman <mcoleman2@kc.rr.com>
Date: 13 Dec 2000 17:16:52 -0600
In-Reply-To: Mark Kettenis's message of "13 Dec 2000 14:42:26 +0100"
Message-ID: <87zohzoqsb.fsf_-_@subterfugue.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Kettenis <kettenis@wins.uva.nl> writes:
> However, the "zombie problem" is caused by the way ptrace() interacts
> with clone()/exit()/wait(), which I consider to be a kernel bug.
[insightful analysis omitted]

I think you've hit the nail on the head, and I'm a bit frustrated that I never
noticed this problem even though I've spent quite a bit of time poring over
the code that makes ptrace work.

My limited mental abilities notwithstanding, I think this is one more reason
to ditch ptrace for a better method of process tracing/control.  It's served
up to this point, but ptrace has a fundamental flaw, which is that it tries to
do a lot of interprocess signalling and interlocking in an in-band way, doing
process reparenting to try to take advantage of existing code.  In the end
this seems to be resulting in an inscrutable, flaky mess.

What would a better process tracing facility be like?  One key feature is
utter transparency.  That is, it should be impossible for traced processes or
other processes that interact with them to be aware of whether or not tracing
is going on.  This means that there should be no difference between the way a
process behaves under tracing versus how it would behave if it weren't being
traced, which is a key to faithful tracing/debugging and avoiding the
Heisenbug effect.  (There does need to be some interface via which information
about tracing itself can be observed, but it should be hidden from the target
processes.)

It would also be nice to have something accessible via devices in the proc
filesystem.  Maybe something like Solaris' "proc" debugging interface would be
a starting point:

   http://docs.sun.com:80/ab2/coll.40.6/REFMAN4/@Ab2PageView/42351?DwebQuery=proc&Ab2Lang=C&Ab2Enc=iso-8859-1

--Mike

-- 
[O]ne of the features of the Internet [...] is that small groups of people can
greatly disturb large organizations.  --Charles C. Mann
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
