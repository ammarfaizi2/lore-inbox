Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316284AbSEKXjA>; Sat, 11 May 2002 19:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316285AbSEKXi7>; Sat, 11 May 2002 19:38:59 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33291 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316284AbSEKXi7>;
	Sat, 11 May 2002 19:38:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2 
In-Reply-To: Your message of "Sat, 11 May 2002 19:11:18 +0100."
             <20020511191118.F1574@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 09:38:48 +1000
Message-ID: <15591.1021160328@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002 19:11:18 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Sat, May 11, 2002 at 10:37:39AM -0700, Linus Torvalds wrote:
>> On Sat, 11 May 2002, george anzinger wrote:
>> >
>> > So, what to do?  For ARM and MIPS we could go back to solution 1:
>> 
>> Why not just put that knowledge in the ARM/MIPS architecture makefile?
>> 
>> ARM already has multiple linker scripts, and it already selects on them
>> based on CONFIG options, so I'd much rather just do that straightforward
>> kind of thing than play any clever games.
>
>So would I - there will be a config option, so we can just use sed on the
>relevant linker script to do the right thing.

Any reason that you are using sed and not cpp like the other
architectures?

The use and name of linker scripts varies across architectures, some
use cpp, some use sed, some do not pre-process at all.  This makes it
awkward for repositories and dont-diff lists, they need special rules
for every architecture.  In kbuild 2.5 I am trying to standardize on
arch/$(ARCH)/vmlinux.lds.S which is always pre-processed by cpp to
vmlinux.lds.i which is used to link vmlinux.

Using .S -> .i has three benefits.  The file name and the code for
converting the file is standardized.  Dont-diff lists exclude *.[oais]
files, no need for special cases for each architecture.  kbuild 2.5
tracks the command, timestamp and dependencies for all .S -> .i
conversions so the ld script will become a properly controlled file,
being rebuilt when necessary and only when necessary.

For architectures that need to choose between multiple ld scripts.  In
my tree I have made the ld script name a variable (arch_ld_script) that
may be set in arch/$(ARCH)/Makefile.defs.config.  If the variable is
not set, it defaults to /arch/$(ARCH)/vmlinux.lds.i.

