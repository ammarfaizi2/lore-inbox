Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268196AbTAMTGJ>; Mon, 13 Jan 2003 14:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268245AbTAMTGJ>; Mon, 13 Jan 2003 14:06:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65073 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268196AbTAMTFz>; Mon, 13 Jan 2003 14:05:55 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
References: <20030112220741.GA15849@mars.ravnborg.org>
	<20030113003632.J628@nightmaster.csn.tu-chemnitz.de>
	<20030113180450.GA1870@mars.ravnborg.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2003 12:10:11 -0700
In-Reply-To: <20030113180450.GA1870@mars.ravnborg.org>
Message-ID: <m1vg0sg92k.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Mon, Jan 13, 2003 at 12:36:32AM +0100, Ingo Oeser wrote:
> > Hi,
> > 
> > > This is first version, where I have converted i386, s390 and sparc64.
> > > The latter two is not tested, only to make sure it can be used by more
> > > than one platform.
> > 
> > Liker scripts are hard enough to read, so I would not like to see
> > more CPP magic here. Consolidation should stop, where the
> > readability stops.
> 
> Hi Ingo & Eric.
> 
> The purpose was to define common stuff in a single place.
> Ask Rusty Russell if it is fun to add the same section to > 50
> .lds files.
> 
> Based on the feedback I will try to come up with a lighter proposal,
> that does not hurt readability.
> I still want the common stuff separated away.
> 
> And I will in the process try to add a bit more descriptive comments,
> I agree the linker scripts are hard to read today. It would help if people
> cared to spend a few more lines explaning the actual usage.
> Having such explanation in a common place would make the chances for
> an update of the comments bigger.

I consider it a bigger bug that CodingStyle is not followed.  If there
was an appropriate amount of whitespace linker scripts would be easier
to read.

Beyond that linker scripts native support include directives.  And included
files can have additional SECTIONS attributes.  In particular:

SECTIONS {
        .section1 {
		*(.section1)                       
        }
}
SECTIONS {
	.section2 {
		*(.section2)
        }
}

is legal.

So I would recommend having an arch specific linker script that included
the architecture independent parts.  And have each part have it's own
SECTIONS attribute tag.

Something like:

---- arch/i386/vmlinux.lds.S ----
OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)
vmlinux.lds.S
jiffies = jiffies_64;
SECTIONS
{
	. = 0xC0000000 + 0x100000;
	/* read-only */
	_text = .;                    /* Text and read-only data */
	.text : {
        	*(.text)
        	*(.fixup)
        	*(.gnu.warning)
        } = 0x9090

	_etext = .;                   /* End of text section */
	.rodata : { *(.rodata) *(.rodata.*) }
	.kstrtab : { *(.kstrtab) }
}
INCLUDE ../../kernel/exceptions.lds
INCLUDE ../../init/initramfs.lds

---- kernel/exceptions.lds ----
SECTIONS {
	. = ALIGN(16);                /* Exception table */
	__start___ex_table = .;
	__ex_table : { *(__ex_table) }
	__stop___ex_table = .;
}

---- init/initramfs.lds ----
SECTIONS {
	. = ALIGN(4096);
	__initramfs_start = .;
	.init.ramfs : { *(.init.ramfs) }
	__initramfs_end = .;
}

Eric
