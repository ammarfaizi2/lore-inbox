Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRDNOAl>; Sat, 14 Apr 2001 10:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDNOAb>; Sat, 14 Apr 2001 10:00:31 -0400
Received: from colorfullife.com ([216.156.138.34]:57092 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132301AbRDNOAZ>;
	Sat, 14 Apr 2001 10:00:25 -0400
Message-ID: <002e01c0c4eb$5854b940$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <stewart@dystopia.lab43.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 8139too: defunct threads
Date: Sat, 14 Apr 2001 16:00:25 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0021_01C0C4FC.049C51D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0021_01C0C4FC.049C51D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

>> Ah. Of course. All (or most) kernel initialisation is
>> done by PID 1. Search for "kernel_thread" in init/main.c
>>
>> So it seems that in your setup, process 1 is not reaping
>> children, which is why this hasn't been reported before.
>> Is there something unusual about your setup?

> I found the difference which causes this. If I build my kernel with
> IP_PNP (IP: kernel level autoconfiguration) support I get a defunt
> thread for each 8139too device. If I don't build with IP_PNP
> support I don't get any, defunct ethernet threads.

Does init(8) reap children that died before it was spawned? I assume
that the defunct tasks were there _before_ init was spawned.

Perhaps init() [in linux/init/main.c] should reap all defunct tasks
before the execve("/sbin/init").

I've attached an untested patch, could you try it?

--
    Manfred


------=_NextPart_000_0021_01C0C4FC.049C51D0
Content-Type: application/octet-stream;
	name="patch-main.dat"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-main.dat"

--- main.c	Fri Mar 30 15:42:49 2001=0A=
+++ /pub/home/manfred/main.c	Sat Apr 14 15:56:26 2001=0A=
@@ -777,6 +777,13 @@=0A=
 =0A=
 	(void) dup(0);=0A=
 	(void) dup(0);=0A=
+=0A=
+	while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)=0A=
+		;=0A=
+	spin_lock_irq(&current->sigmask_lock);=0A=
+	flush_signals(curtask);=0A=
+	recalc_sigpending(curtask);=0A=
+	spin_lock_irq(&current->sigmask_lock);=0A=
 	=0A=
 	/*=0A=
 	 * We try each of these until one succeeds.=0A=

------=_NextPart_000_0021_01C0C4FC.049C51D0--

