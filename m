Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135772AbREICMP>; Tue, 8 May 2001 22:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135775AbREICMG>; Tue, 8 May 2001 22:12:06 -0400
Received: from smtp.mountain.net ([198.77.1.35]:27662 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S135772AbREICL6>;
	Tue, 8 May 2001 22:11:58 -0400
Message-ID: <3AF8A73A.C02F119E@mountain.net>
Date: Tue, 08 May 2001 22:11:06 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > the memory copy in the fast_page_copy routine.  The machine then
> > proceeded
> > not to stop at my panic, but I got my "normal" oopses.  I then had an
> 
> Ok
> 
> > idea and removed all the prefetch instructions from the beginning of the
> > routine and tried the resultin kernel.  I now have no crashes.
> > What could this mean?
> 
> I think it has to mean a hardware problem.

I don't think so, reasons below
 
> What still stands out is that exactly _zero_ people have reported the same
> problem with non VIA chipset Athlons.

Not any more :-(

Hi Alan,

IIRC this thread is about boot going catatonic right after unloading
__initmem.
I'm seeing that in 2.4.5-pre1 with Athlon stepping 2, AMD 751, MS-6195 mobo,
128M.
The machine is fine with kernels up through 2.4.4-pre3, and still works with
them.

On that gear, there is no crash. The keyboard and display are alive and
SysRq works.
I have copied the stack trace for pid=1 and the processor dump. I'm short of
time
but I have a kind typist electrifying the trace, and I'll try to generate
something
ksymoops can digest.

Here is what a quick eyeballing of System.map shows.

The code is at the end of init/main.c:init(). The processor dump shows
init() halted
in default_idle() from the sequence L6 -> init -> cpu_idle.

Trace of pid 1 shows it stuck in D state. The last addresses listed are from
filemap_nopage -> do_execve -> do_no_page -> handle_mm_fault -> __pmd_alloc
-> rwsem_down_write_failed -> stext_lock -> system_call. That looks fishy.

Earlier, it looks like handle_mm_fault is being triggered from
fast_clear_page.

I'll post the full dump soon as I have it.

Btw, above happens with both gcc-2.95.3 and gcc-3.0-[20010423] compiled
kernels.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
