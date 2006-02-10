Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWBJBTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWBJBTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWBJBTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:19:45 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:47538 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750985AbWBJBTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:19:44 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: pid_t range question
To: Jesper Juhl <jesper.juhl@gmail.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 10 Feb 2006 02:19:33 +0100
References: <5DDTr-6Lw-43@gated-at.bofh.it> <5DJlY-6J8-29@gated-at.bofh.it> <5EnCK-7Qt-9@gated-at.bofh.it> <5Eoz4-PV-21@gated-at.bofh.it> <5Eqr8-3To-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F7Mwg-0001SK-3p@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:

> I can think of at least 3 ways to at least hide that cosmetic problem
[of /bin/ps]
> a bit. Won't solve the problem but will make it less likely that most
> people will ever encounter it.
> 
> (assuming below that we want something like 64bit pids but want to
> keep pids at 5 digits as much as possible)
[...]
> 2. Allocate pid's as we currently do, but once we hit 99999 wrap the
> pids and start allocating from free pids starting from 2 and up. only
> if no pids below 99999 are free do we continue upwards and allocate
> pid 100000.

2b) don't try that hard, and hopefully speed things up:

<pseudocode>
for (max = 3814; /* max == 999817216 * 8 */; max = max * 8) {
// the above values result from int(1000000000/8^6){,*8^6}
        newpid = random(max)+1;
        if allocate_pid(newpid)
                goto got_the_pid;
        // repeat the above in order to make it less likely
        // to get a high PID? I hope it's not nescensary.
        if (max == 999817216) // otherwise an uint32 will overflow
                break;
}
// possible here to increase the chance for a low pid but also for
// long runs while searching for the first free pid:
// newpid = random(99999)+1;
pid_search_stop = newpid;
while (++newpid != pid_search_stop) {
        if allocate_pid(newpid)
                goto got_the_pid;
}
got_the_pid:
</pseudocode>

TOSOLVE:

Find a cheap random function.

What to do on 4294967295 allocated processes?

Eternal starvation if nearly 4294967295 are present and the right ones
get stopped/started?

How to get CPU power to run 4294967295 processes?

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
