Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSLPH0A>; Mon, 16 Dec 2002 02:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLPH0A>; Mon, 16 Dec 2002 02:26:00 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:40715 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265567AbSLPH0A>;
	Mon, 16 Dec 2002 02:26:00 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200212160733.gBG7XhD67922@saturn.cs.uml.edu>
Subject: Re: Intel P6 vs P7 system call performance
To: pavel@ucw.cz (Pavel Machek)
Date: Mon, 16 Dec 2002 02:33:43 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
       hpa@zytor.com, terje.eggestad@scali.com
In-Reply-To: <20021215220132.GB6347@elf.ucw.cz> from "Pavel Machek" at Dec 15, 2002 11:01:32 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
> [Albert Cahalan]

>> Have apps enter kernel mode via Intel's purposely undefined
>> instruction, plus a few bytes of padding and identification.
>> Require that this not cross a page boundry. When it faults,
>> write the SYSENTER, INT 0x80, or SYSCALL as needed. Leave
>> the page marked clean so it doesn't need to hit swap; if it
>> gets paged in again it gets patched again.
>
> Thats *very* dirty hack. vsyscalls seem cleaner than that.

Sure it's dirty. It's also fast, with the only overhead being
a few NOPs that could get skipped on syscall return anyway.
Patching overhead is negligible, since it only happens when a
page is brought in fresh from the disk.

The vsyscall stuff costs you on every syscall. It's nice for
when you can avoid entering kernel mode entirely, but in that
case the hack I described above can write out a call to user
code (for time-of-day I imagine) just as well as it can write
out a SYSENTER, INT 0x80, or SYSCALL instruction.

Enter with INT 0x42 if you prefer, or just pick one of the new
instructions.

An alternative would be to hack ld.so to patch the syscalls,
but then you get dirty C-O-W pages in every address space.
Permissions change, swap gets used, etc.

