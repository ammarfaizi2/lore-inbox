Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266240AbSKWAVE>; Fri, 22 Nov 2002 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKWAVE>; Fri, 22 Nov 2002 19:21:04 -0500
Received: from mail.webmaster.com ([216.152.64.131]:45973 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266223AbSKWAVD> convert rfc822-to-8bit; Fri, 22 Nov 2002 19:21:03 -0500
From: David Schwartz <davids@webmaster.com>
To: <lk@tantalophile.demon.co.uk>
CC: <gianni@ecsc.co.uk>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 22 Nov 2002 16:28:10 -0800
In-Reply-To: <20021123000616.GB19162@bjl1.asuk.net>
Subject: Re: TCP memory pressure question
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021123002812.AAA5286@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Nov 2002 00:06:17 +0000, Jamie Lokier wrote:

>David Schwartz wrote:

>>So this would be a case where 'poll' or 'select' would return
>>a write hit for a socket but 'write' would return -1 and set errno
>>to EAGAIN.

>Is this really true?  It would livelock several servers I've worked on...
>
>-- Jamie

	We're now getting close to my motivation for asking this question.

	If it does in fact return EAGAIN, then a poll/select loop program that is 
trying to write could get into trouble if another process was responsible for 
large receive queues. It would spin uselessly burning its timeslice as more 
data comes in and it delays the execution of the other process that might be 
able to drain receive queues.

	On the other hand, if send blocked, there would be a disaster if a 
select/poll loop process were the only TCP user on the box. In this case, it 
would deadlock. The process is blocked waiting for memory but the only way to 
get that memory is for the process to get around to reading from other 
connections, which it can't do because it's blocked.

	My motivation in assessing what happens is to develop a sane application 
strategy to detect and handle this condition. If we could detect it, we could 
try not to do TCP writes and try to do reads to relieve the memory problem.

	Some strategies I was considering were this:

	1) For applications that probably aren't using most of the TCP memory: In 
the select/poll loop, we keep track of whether we were able to do any work. 
If we never successfully wrote or read, but did get a hit on at least one 
socket, we sleep for a few milliseconds. (We hope that while we sleep other 
applications can free up more memory for us by draining their receive 
queues.)

	2) For applications that probably are using all or a significant fraction of 
the TCP memory: If a 'write' for a socket that we got a write hit on returns 
EAGAIN, for the rest of this poll/select cycle, we do not attempt any writes, 
only reads. (We hope that this will relieve the memory pressure scenario and 
allow the system to function normally as quickly as possible.)

	3) For applications that have control over how much load they take: If 
writes begin returning EAGAIN under suspicious circumstances, treat this as 
an overload condition and trigger your handling logic. Refuse expensive 
commands or refuse to handle new connections.

	Any comments or suggestions are appreciated. I've found that when we hit TCP 
memory pressure, many applications become very badly behaved.

	DS


