Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136284AbREGQgn>; Mon, 7 May 2001 12:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136290AbREGQge>; Mon, 7 May 2001 12:36:34 -0400
Received: from colorfullife.com ([216.156.138.34]:55314 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136284AbREGQgR>;
	Mon, 7 May 2001 12:36:17 -0400
Message-ID: <001601c0d713$d60a17b0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Ben LaHaise" <bcrl@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <mailman.989055541.17259.linux-kernel2news@redhat.com> <3AF6CA1B.9849CE6A@redhat.com>
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
Date: Mon, 7 May 2001 18:35:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ben LaHaise" <bcrl@redhat.com>
>
> Any particular reason for not using davem's single copy kiobuf based
> code?
>
The main problem is that map_user_kiobuf() locks pages into memory.
It's a bad idea for pipes. Either we must severely limit the maximum
amount of data in the direct-copy buffers, or we must add a swap file
based backing store. If I understand the BSD direct-pipe code correctly
it has a swap file based backing store. I think that's insane. And
limiting the direct copy buffers to a few kB defeats the purpose of
direct copy.
Instead pipe_write just queues (tsk,addr,len), and then pipe_read() uses
a modified access_process_vm() function to copy directly. Currently I've
copied the code from kernel/ptrace.c, but I plan to merge
copy_user_to_user() back into access_process_vm().

And the current pipe_{read,write} are a total mess with nested loops and
gotos. It's possible to create wakeup storms. I rewrote them as well ;-)

But the new code still contains one deadlock :-(
--
    Manfred


