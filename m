Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUFYStD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUFYStD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUFYStC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:49:02 -0400
Received: from nevyn.them.org ([66.93.172.17]:31661 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266838AbUFYSs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:48:27 -0400
Date: Fri, 25 Jun 2004 14:48:18 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp.S: meaningfull assembly labels
Message-ID: <20040625184817.GA3939@nevyn.them.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20040625115936.GA2849@elf.ucw.cz> <Pine.LNX.4.53.0406250827250.28070@chaos> <20040625151858.GA27013@nevyn.them.org> <Pine.LNX.4.53.0406251152580.28750@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0406251152580.28750@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 12:02:47PM -0400, Richard B. Johnson wrote:
> On Fri, 25 Jun 2004, Daniel Jacobowitz wrote:
> 
> > On Fri, Jun 25, 2004 at 08:37:45AM -0400, Richard B. Johnson wrote:
> > > NO! You just made those labels public! The LOCAL symbols need to
> > > begin with ".L".  Now, if you have a 'copy_loop' in another module,
> > > linked with this, anywhere in the kernel, they will share the
> > > same address -- not what you expected, I'm sure! The assembler
> > > has some strange rules you need to understand. Use `nm` and you
> > > will find that your new labels are in the object file!
> >
> > Er, no.  They'll show up in the object file.  That doesn't mean they're
> > global; static symbols also show up in the object file.
> >
> > --
> > Daniel Jacobowitz
> 
> I got caught on these, thinking that they weren't globals when
> I made a assembly files that used, not only named labels but
> also definitions like:
> 
> BUF = 0x08
> LEN = 0x0c
> 
> code:	movl	BUF(%esp), %ebx
> 	movl	LEN(%esp), %ecx
> 
> 
> This was done in several files. When linked, I got 'duplicate synbol'
> errors. These symbols, while not 'globals' in the sense that 'C'
> code can link with them are global definitions that are seen by
> the linker and cause duplicate symbol errors. I went through

Those are what gas calls absolute symbols.

> the gas documentation, trying to find how to prevent these
> private symbols from being written to the object file and there
> is no command-line mechanism. You just have to start every name
> with .L to keep them local.
> 
> When I used labels like 'code' above, even though not declared
> '.global',  the labels also showed up as duplicate symbols when
> linking the resulting object files.

Does this only happen in your world?  Or were you using a broken
non-GNU linker?

drow@nevyn:~% cat a.s
BUF = 0x1
code:
        mov %eax, 0
drow@nevyn:~% as -o a.o a.s  
drow@nevyn:~% as -o b.o a.s
drow@nevyn:~% ld -o a a.o b.o
ld: warning: cannot find entry symbol _start; defaulting to 0000000008048074
drow@nevyn:~% nm a.o
00000001 a BUF
00000000 t code
drow@nevyn:~% nm a
00000001 a BUF
00000001 a BUF
08049084 A __bss_start
08049084 A _edata
08049084 A _end
08048074 t code
0804807c t code

LD won't even warn about duplicate absolute symbols unless they have
different values.

-- 
Daniel Jacobowitz
