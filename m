Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269901AbUJMXB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269901AbUJMXB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269905AbUJMXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:01:28 -0400
Received: from ozlabs.org ([203.10.76.45]:53686 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269901AbUJMXBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:01:13 -0400
Subject: Re: Fw: signed kernel modules?
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <27277.1097702318@redhat.com>
References: <1097626296.4013.34.camel@localhost.localdomain>
	 <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <27277.1097702318@redhat.com>
Content-Type: text/plain
Message-Id: <1097707986.14303.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 09:01:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 07:18, David Howells wrote:
> > Write the code.  Then come back and tell me it "isn't that hard".
> 
> It isn't that hard.

I see.  Well, the good news is that I think your canonicalization step
now covers all the exploits I can think of.

@@ -1536,8 +1538,59 @@ static struct module *load_module(void _
 		goto free_hdr;
 	}
 
-	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
-		goto truncated;
+	/* verify the module (validates ELF and checks signature) */
+	gpgsig_ok = 0;
+	err = module_verify(hdr, len);
+	if (err < 0)
+		goto free_hdr;
+	if (err == 1)
+		gpgsig_ok = 1;
 
 	/* Convenience variables */
 	sechdrs = (void *)hdr + hdr->e_shoff;

I'd prefer to see:
	err = module_verify(hdr, len, &gpgsig_ok);
	if (err)
		goto free_hdr;

And then have module_verify for the !CONFIG_MODULE_SIG case (in
module-verify.h) simply be:

	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
		return -EINVAL;
	*gpgsig_ok = 1;

+/*****************************************************************************/
+/*
+ * verify the ELF structure of a module
+ */
+static int module_verify_elf(struct module_verify_data *mvdata)
+{
+	const Elf_Ehdr *hdr = mvdata->hdr;
+	const Elf_Shdr *section, *section2, *secstop;
+	const Elf_Rela *relas, *rela, *relastop;
+	const Elf_Rel *rels, *rel, *relstop;
+	const Elf_Sym *symbol, *symstop;
+	size_t size, sssize, *secsize, tmp, tmp2;
+	int line;
+
+	size = mvdata->size;
+	mvdata->nsects = hdr->e_shnum;
+
+#define elfcheck(X) \
+do { if (unlikely(!(X))) { line = __LINE__; goto elfcheck_error; } } while(0)
+
+#define seccheck(X) \
+do { if (unlikely(!(X))) { line = __LINE__; goto seccheck_error; } } while(0)
+
+#define symcheck(X) \
+do { if (unlikely(!(X))) { line = __LINE__; goto symcheck_error; } } while(0)
+
+#define relcheck(X) \
+do { if (unlikely(!(X))) { line = __LINE__; goto relcheck_error; } } while(0)
+
+#define relacheck(X) \
+do { if (unlikely(!(X))) { line = __LINE__; goto relacheck_error; } } while(0)
+
+	/* validate the ELF header */
+	elfcheck(hdr->e_ehsize < size);
+	elfcheck(hdr->e_entry == 0);
+	elfcheck(hdr->e_phoff == 0);
+	elfcheck(hdr->e_phnum == 0);
+
+	elfcheck(hdr->e_shoff < size);
+	elfcheck(hdr->e_shoff >= hdr->e_ehsize);
+	elfcheck((hdr->e_shoff & (sizeof(long) - 1)) == 0);
+	elfcheck(hdr->e_shstrndx > 0);
+	elfcheck(hdr->e_shstrndx < hdr->e_shnum);
+
+	tmp = (size_t) hdr->e_shentsize * (size_t) hdr->e_shnum;
+	elfcheck(tmp < size - hdr->e_shoff);

Multiplicative overflow.  Also check that hdr->e_shentsize is
sizeof(Elf_Shdr) since you assume that below.

+	/* allocate a table to hold in-file section sizes */
+	mvdata->secsizes = kmalloc(hdr->e_shnum * sizeof(size_t), GFP_KERNEL);
+	if (!mvdata->secsizes)
+		return -ENOMEM;
+	memset(mvdata->secsizes, 0, hdr->e_shnum * sizeof(size_t));

Multiplicative overflow again: we could kmalloc 0 bytes and overflow below.

+	/* validate the ELF section headers */
+	mvdata->sections = mvdata->buffer + hdr->e_shoff;
+	secstop = mvdata->sections + mvdata->nsects;

Subtler multiplicative overflow.

+	sssize = mvdata->sections[hdr->e_shstrndx].sh_size;
+	elfcheck(sssize > 0);
+
+	section = mvdata->sections;
+	seccheck(section->sh_type == SHT_NULL);
+	seccheck(section->sh_size == 0);
+	seccheck(section->sh_offset == 0);
+
+	secsize = mvdata->secsizes + 1;
+	for (section++; section < secstop; secsize++, section++) {
+		seccheck(section->sh_name < sssize);
+		seccheck(section->sh_addr == 0);
+		seccheck(section->sh_link < hdr->e_shnum);
+
+		if (section->sh_entsize > 0)
+			seccheck(section->sh_size % section->sh_entsize == 0);

Divide by zero (thanks Alan!).

+		seccheck(section->sh_offset >= hdr->e_ehsize);
+		seccheck(section->sh_offset < size);
+
+		/* determine the section's in-file size */
+		tmp = size - section->sh_offset;
+		if (section->sh_offset < hdr->e_shoff)
+			tmp = hdr->e_shoff - section->sh_offset;
+
+		for (section2 = mvdata->sections + 1; section2 < secstop; section2++) {
+			if (section->sh_offset < section2->sh_offset) {
+				tmp2 = section2->sh_offset - section->sh_offset;
+				if (tmp2 < tmp)
+					tmp = tmp2;
+			}
+		}
+		*secsize = tmp;
+
+		_debug("Section %ld: %zx bytes at %lx\n",
+		       section - mvdata->sections,
+		       *secsize,
+		       section->sh_offset);
+
+		/* perform section type specific checks */
+		switch (section->sh_type) {
+		case SHT_NOBITS:
+			break;
+
+		case SHT_REL:
+		case SHT_RELA:
+			seccheck(section->sh_info > 0);
+			seccheck(section->sh_info < hdr->e_shnum);
+			/* fall through */
+
+		default:
+			/* most types of section must be contained entirely
+			 * within the file */
+			seccheck(section->sh_size <= *secsize);
+			break;
+		}
+	}
+
+	/* validate the ELF section names */
+	section = &mvdata->sections[hdr->e_shstrndx];
+
+	seccheck(section->sh_offset != hdr->e_shoff);
+
+	mvdata->secstrings = mvdata->buffer + section->sh_offset;
+
+	for (section = mvdata->sections + 1; section < secstop; section++) {
+		const char *secname;
+		tmp = sssize - section->sh_name;
+		secname = mvdata->secstrings + section->sh_name;
+		seccheck(secname[0] != 0);
+		seccheck(memchr(secname, 0, tmp) != NULL);
+	}
+
+	/* look for various sections in the module */
+	for (section = mvdata->sections + 1; section < secstop; section++) {
+		switch (section->sh_type) {
+		case SHT_SYMTAB:
+			if (strcmp(mvdata->secstrings + section->sh_name,
+				   ".symtab") == 0
+			    ) {
+				seccheck(mvdata->symbols == NULL);
+				mvdata->symbols =
+					mvdata->buffer + section->sh_offset;
+				mvdata->nsyms =
+					section->sh_size / sizeof(Elf_Sym);
+				seccheck(section->sh_size > 0);
+			}
+			break;
+
+		case SHT_STRTAB:
+			if (strcmp(mvdata->secstrings + section->sh_name,
+				   ".strtab") == 0
+			    ) {
+				seccheck(mvdata->strings == NULL);
+				mvdata->strings =
+					mvdata->buffer + section->sh_offset;
+				sssize = mvdata->nstrings = section->sh_size;
+				seccheck(section->sh_size > 0);
+			}
+			break;
+		}
+	}
+
+	if (!mvdata->symbols) {
+		printk("Couldn't locate module symbol table\n");
+		goto format_error;
+	}
+
+	if (!mvdata->strings) {
+		printk("Couldn't locate module strings table\n");
+		goto format_error;
+	}
+
+	/* validate the symbol table */
+	symstop = mvdata->symbols + mvdata->nsyms;
+
+	symbol = mvdata->symbols;
+	symcheck(ELF_ST_TYPE(symbol[0].st_info) == STT_NOTYPE);
+	symcheck(symbol[0].st_shndx == SHN_UNDEF);
+	symcheck(symbol[0].st_value == 0);
+	symcheck(symbol[0].st_size == 0);
+
+	for (symbol++; symbol < symstop; symbol++) {
+		symcheck(symbol->st_name < sssize);

I think you have to check (as above) that st_name is nul terminated
within size.

+		symcheck(symbol->st_shndx < mvdata->nsects ||
+			 symbol->st_shndx >= SHN_LORESERVE);
+	}
+
+	/* validate each relocation table as best we can */
+	for (section = mvdata->sections + 1; section < secstop; section++) {
+		section2 = mvdata->sections + section->sh_info;
+
+		switch (section->sh_type) {
+		case SHT_REL:
+			rels = mvdata->buffer + section->sh_offset;
+			relstop = mvdata->buffer + section->sh_offset + section->sh_size;
+
+			for (rel = rels; rel < relstop; rel++) {
+				relcheck(rel->r_offset < section2->sh_size);
+				relcheck(ELF_R_SYM(rel->r_info) > 0);
+				relcheck(ELF_R_SYM(rel->r_info) < mvdata->nsyms);

I think you can overflow here.  For REL and RELA sections, you don't
check that sh_size is <= *secsize.

That's all I found,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

