Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277408AbRJEPY1>; Fri, 5 Oct 2001 11:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277411AbRJEPYR>; Fri, 5 Oct 2001 11:24:17 -0400
Received: from IP-213157001138.dialin.heagmedianet.de ([213.157.1.138]:15366
	"EHLO gateway.me") by vger.kernel.org with ESMTP id <S277408AbRJEPYD>;
	Fri, 5 Oct 2001 11:24:03 -0400
Message-ID: <3BBDD0BA.94E53586@frontsite.de>
Date: Fri, 05 Oct 2001 17:24:42 +0200
From: Matthias Welwarsky <matthias.welwarsky@frontsite.de>
Reply-To: matze@stud.fbi.fh-darmstadt.de
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-rt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem understanding cap_emulate_setxuid()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm having certain difficulties to understand how cap_emulate_setxuid()
in kernel/sys.c is supposed to work. I have a program that needs
CAP_SYS_NICE in order to create realtime threads.

For security reasons, I don't want the program to run as the root user.
So, I initially start the program setuid-root, then set CAP_SYS_NICE,
then drop root privileges. In pseudo-C, the program looks like this:

prctl(PR_SET_KEEPCAPS, 1);
cap_set(CAP_SYS_NICE);
seteuid(getuid());

However, from looking at cap_emulate_setxuid() I learned that when
switching the effective uid != 0, current->cap_effective is cleared,
regardless the settings of current->keep_capabilities. Huh? How is this
supposed to work at all? It at least seems to be a little impractical.

When a program is started setuid-root, getuid() == real_user_id and
geteuid() == 0. So, how would I drop root privileges without switching
the effective user id away from 0? Is this a bug in
cap_emulate_setxuid() or am I missing something?

It seems that with the current implementation, cap_effective ==
cap_permitted is only true when the effective uid == 0? However, to
minimize security implications, I'd like the process to run with
real_uid == effective_uid so that e.g. plugins cannot switch the
effective uid back to 0 and do funny things on root-owned files.
Shouldn't this be possible with capabilities?

best regards,
    Matthias

--
Matthias Welwarsky
Fachschaft Informatik FH Darmstadt
Email: matze@stud.fbi.fh-darmstadt.de

"I bet the human brain is a kludge."
                -- Marvin Minsky
