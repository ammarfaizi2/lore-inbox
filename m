Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267092AbSKWWrE>; Sat, 23 Nov 2002 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267088AbSKWWrE>; Sat, 23 Nov 2002 17:47:04 -0500
Received: from mail.webmaster.com ([216.152.64.131]:49853 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267087AbSKWWrD> convert rfc822-to-8bit; Sat, 23 Nov 2002 17:47:03 -0500
From: David Schwartz <davids@webmaster.com>
To: <folkert@vanheusden.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Sat, 23 Nov 2002 14:54:12 -0800
In-Reply-To: <001701c29340$749e8110$3640a8c0@boemboem>
Subject: RE: TCP memory pressure question
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021123225414.AAA6403@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Nov 2002 23:34:15 +0100, Folkert van Heusden wrote:

>What about:

>int WRITE(int handle, char *whereto, int len)
>{
>int cnt=len;
>
>while(len>0)
>{
>int rc;
>
>rc = write(handle, whereto, len);
>
>if (rc == -1)
>{
>if (errno == EINTR)
>                {
>                    /* just try again */
>                }
>                else if (errno == EAGAIN)
>                {
>                    /* give up time-slice */
>                    if (sched_yield() == -1)
>                    {

	By yielding your time slice, you prevent yourself from performing any 
'read's. So what's going to fix the memory pressure?

	There are two cases where this could work:

	1) For an application that uses very little TCP memory. By yielding, perhaps 
some other process will come along, a more heavy TCP memory user, and fix the 
problem.

	2) For an application that uses a thread-per-connection architecture. By 
yielding, we give other threads a chance to run and hope that they will 
relieve the memory pressure.

	But for a poll/select loop application that is heavily using TCP memory, 
this makes things worse. By stopping our own execution, we delay the time 
when we'll do 'read's. So we extend the TCP memory pressure problem for even 
longer.

	DS


