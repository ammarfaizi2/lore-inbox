Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261787AbSJNBNE>; Sun, 13 Oct 2002 21:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261788AbSJNBNE>; Sun, 13 Oct 2002 21:13:04 -0400
Received: from zero.aec.at ([193.170.194.10]:14600 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261787AbSJNBND>;
	Sun, 13 Oct 2002 21:13:03 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: James Simmons <jsimmons@infradead.org>, Anton Blanchard <anton@samba.org>,
       " " "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, " "@averellmail.firstfloor.org,
       torvalds@transmeta.com,
       " " Linux console project 
	<linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
References: <20021012014332.GA7050@krispykreme>
	<Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
	<20021013220041.G23142@flint.arm.linux.org.uk>
	<3DA9E439.3613F889@digeo.com>
From: Andi Kleen <ak@muc.de>
Date: 14 Oct 2002 03:18:12 +0200
In-Reply-To: <3DA9E439.3613F889@digeo.com>
Message-ID: <m3adlhkecr.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> I think what we need James is just the low-level hook in printk.c which
> the various platforms and boards can plug into.  The one in Martin's
> patch (module some cleanups, docco, conversion to C, etc) looks
> suitable to me.  The actual early console drivers don't appear to have
> much relationship at all to the console layer really.  They're just
> minimal-code busy-wait port banging.

The hook already exists and it is called register_console. Has been there
for years. early_printk on x86-64 uses that. Originally I used the hackish
printk hook way, but Linus put me on the right track. 

Your arch code just does a register_console very early which does the low level 
output.

Actually you need one new hook for cosmetic reason: when the real console
starts you want to disable the early console, otherwise you get duplicated
output when they go to the same output device. This can be done with a
straight forward function call in console_init.

BTW the x86-64 early console should just work fine on i386 too, with minor
changes. 

All you need to do is: 

- cp arch/x86_64/kernel/early_printk.c arch/i386/kernel/early_printk.c
- edit arch/i386/kernel/early_printk.c and replace VGABASE with 
__PAGE_OFFSET+0xb8000
- add it to arch/i386/kernel/Makefile
- (optional - if you don't do it will be only initialised after setup_arch when
  __setup arguments are parsed) 
  add something like
        if (c == ' ' && !memcmp(from,"earlyprintk=",12)) { 
                extern int setup_early_printk(char *opt)
                setup_early_printk(from+12); 
        }  
  to the comand line parsing in arch/i386/kernel/setup.c
- Enable CONFIG_EARLY_PRINTK so that console_init disables it.
- Boot with earlyprintk=vga (for vga output) 
  or earlyprintk=serial,ttySx,baud for serial output.
  Add ,keep when you want to keep it even after console_init


-Andi

