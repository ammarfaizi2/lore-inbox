Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWBRV0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWBRV0g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWBRV0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 16:26:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45574 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932162AbWBRV0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 16:26:35 -0500
Date: Sat, 18 Feb 2006 22:25:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060218212549.GA8936@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060217233253.GN4422@stusta.de> <20060217233848.GA26630@mars.ravnborg.org> <1140221699.2907.5.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140221699.2907.5.camel@entropy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:14:59PM -0800, Nicholas Miell wrote:
> > Correct.
> > What I wanted was modpost to tell that the symbol being referenced in
> > the .data section was 'asus_hotk_add' and not just an offset after
> > asus_hotk_driver.
> > 
> > What is needed is a link from the RELOCATION RECORD to the symbol table.
> 
> The r_info field of Elf{32,64}_Rel{,a} contains an index into the symbol
> table which can be extracted using the ELF{32,64}_R_SYM() macro.

What I found here is that the symbol pointed out by ELF_R_SYM(r_info)
only contain one valid entry, namely the section where the symbol that
requires relocation is present. At least for amd64 all RELOCATION
RECORDS are of type RELA so they had an r_addent that pointed out
the offset within that section. So traversing the symbol table I could
find the symbol by looking up the symbol where shndx equals the section
in the symbol table and st_value equal the value of r_addent in the
relocation record.

I cooked up the following:
static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf_Addr addr,
				Elf_Section sec)
{
        Elf_Sym *sym;

        for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
                if (sym->st_shndx != sec)
                        continue;
                if (sym->st_value == addr)
			return sym;
	}
	return NULL;
}

This was with binutils version: 2.16.1 and gcc 3.4.4

So far I have only support for RELA records, not REL records.
That may prove required for other platforms.

	Sam
