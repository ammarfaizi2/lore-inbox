Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268366AbTAMWDK>; Mon, 13 Jan 2003 17:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268367AbTAMWDK>; Mon, 13 Jan 2003 17:03:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38409 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268366AbTAMWC6>;
	Mon, 13 Jan 2003 17:02:58 -0500
Date: Mon, 13 Jan 2003 23:11:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030113221148.GA2423@mars.ravnborg.org>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030112220741.GA15849@mars.ravnborg.org> <20030113003632.J628@nightmaster.csn.tu-chemnitz.de> <20030113180450.GA1870@mars.ravnborg.org> <m1vg0sg92k.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vg0sg92k.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:10:11PM -0700, Eric W. Biederman wrote:
> 
> I consider it a bigger bug that CodingStyle is not followed.  If there
> was an appropriate amount of whitespace linker scripts would be easier
> to read.
I noticed that as well, arm being one of the good guys here.
At least I tried to be consistent with coding style.

> Beyond that linker scripts native support include directives.
But they do not know of standard include paths, and you will see
linker scripts pulling in .h files as well. See ia64 as of today
as a good example.

> And included
> files can have additional SECTIONS attributes.  In particular:
> 
> SECTIONS {
>         .section1 {
> 		*(.section1)                       
>         }
> }
> SECTIONS {
> 	.section2 {
> 		*(.section2)
>         }
> }
> 
> is legal.
> 
> So I would recommend having an arch specific linker script that included
> the architecture independent parts.  And have each part have it's own
> SECTIONS attribute tag.
> 
> Something like:
> 
> ---- arch/i386/vmlinux.lds.S ----
> OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
> OUTPUT_ARCH(i386)
> ENTRY(_start)
> vmlinux.lds.S
> jiffies = jiffies_64;
> SECTIONS
> {
> 	. = 0xC0000000 + 0x100000;
> 	/* read-only */
> 	_text = .;                    /* Text and read-only data */
> 	.text : {
>         	*(.text)
>         	*(.fixup)
>         	*(.gnu.warning)
>         } = 0x9090
> 
> 	_etext = .;                   /* End of text section */
> 	.rodata : { *(.rodata) *(.rodata.*) }
> 	.kstrtab : { *(.kstrtab) }
> }
> INCLUDE ../../kernel/exceptions.lds
> INCLUDE ../../init/initramfs.lds
> 
> ---- kernel/exceptions.lds ----
> SECTIONS {
> 	. = ALIGN(16);                /* Exception table */
> 	__start___ex_table = .;
> 	__ex_table : { *(__ex_table) }
> 	__stop___ex_table = .;
> }
> 
> ---- init/initramfs.lds ----
> SECTIONS {
> 	. = ALIGN(4096);
> 	__initramfs_start = .;
> 	.init.ramfs : { *(.init.ramfs) }
> 	__initramfs_end = .;
> }
Different architectures have different alingments for ramfs for example.
I do not know why, but wanted to support that.

Good point with more sections btw.

	Sam
