Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274611AbRJNHNS>; Sun, 14 Oct 2001 03:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJNHNJ>; Sun, 14 Oct 2001 03:13:09 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:11783 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274611AbRJNHND>;
	Sun, 14 Oct 2001 03:13:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recursive deadlock on die_lock 
In-Reply-To: Your message of "Sat, 13 Oct 2001 23:42:51 MST."
             <3BC933EA.4636D57C@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Oct 2001 17:13:16 +1000
Message-ID: <28465.1003043596@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 23:42:51 -0700, 
Andrew Morton <akpm@zip.com.au> wrote:
>Keith Owens wrote:
>> 
>> ...
>> If show_registers() fails (which it does far too often on IA64) then
>> the system deadlocks trying to recursively obtain die_lock.  Also
>> die_lock is never used outside die(), it should be proc local.
>> Suggested fix:
>> 
>
>Looks to me like it'll work.  But why does ia64 show_registers()
>die so easily?  Can it be taught to validate addresses before
>dereferencing them somehow?

Unwind code.  It is impossible to obtain IA64 saved registers or back
trace the calling sequence without using the unwind API.  That API
relies on decent unwind data being associated with each function
prologue, stack adjustment, save of return registers etc.  Not an issue
for C code, it is for Assembler where the unwind info has to be hand
coded to match what the asm is doing.  IA64 also has PAL code which is
called directly by the kernel, that PAL code has no unwind data so
failures in PAL code result in bad or incomplete back traces.

Unwind is not supposed to fail, it should detect bad input data and
avoid errors.  Alas, sometimes it does fail.

