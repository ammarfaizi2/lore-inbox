Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316584AbSEPGMy>; Thu, 16 May 2002 02:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSEPGMy>; Thu, 16 May 2002 02:12:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12294 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316584AbSEPGMx>; Thu, 16 May 2002 02:12:53 -0400
Message-Id: <200205160556.g4G5uEY15953@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [RFC][PATCH] iowait statistics
Date: Thu, 16 May 2002 08:58:46 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
In-Reply-To: <Pine.LNX.3.96.1020515111134.5026B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2002 13:15, you wrote:
> On Wed, 15 May 2002, Denis Vlasenko wrote:
> > It can be fixed for SMP:
> > * add spinlock
> > or
> > * add per_cpu_idle, account it too at timer/APIC int
> >   and get rid of idle % calculations for /proc/stat
> >
> > As a user, I vote for glitchless statistics even if they
> > consume extra i++ cycle every timer int on every CPU.
>
> You have pointed out the problem, but since your fix is UP only and
> doesn't have the iowait stuff, I think more of same is needed. I don't
> recall seeing this with preempt, but I am not a top user unless I'm
> looking for problems.

I just wanted to inform Rik of this small problem. Since he's going
to fiddle with stats, he can fix this on the way.
BTW, the bug is easily triggered on SMP kernel, very hard to see
(but definitely happens) with UP, I bet you'll see it on preempt too.

Try these two scripts:

#!/bin/sh
# Prints dots until bad thing happens
# Prints old_idle_cnt -> new_idle_cnt then
prev=0
while true; do cat /proc/stat; done | \
grep -F 'cpu  ' | \
cut -d ' ' -f 6 | \
while read next; do
    echo -n .
    diff=$(($next-$prev))
    if test $diff -lt 0; then
	echo "$prev -> $next"
    fi
    prev=$next
done

#!/bin/sh
# Prints cpu line from /proc/stat repeatedly
# When bad thing happens, flags it by '<<<'
prev=0
while true; do cat /proc/stat; done | \
grep -F 'cpu  ' | \
while read line; do
    next=`echo "$line" | cut -d ' ' -f 6`
    diff=$(($next-$prev))
    if test $diff -lt 0; then
	echo "$line <<<"
    else
	echo "$line"
    fi
    prev=$next
done

--
vda
