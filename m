Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271520AbRHTReb>; Mon, 20 Aug 2001 13:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271483AbRHTReV>; Mon, 20 Aug 2001 13:34:21 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:16644 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S271520AbRHTReL>;
	Mon, 20 Aug 2001 13:34:11 -0400
Date: Mon, 20 Aug 2001 10:34:18 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: kaos@ocs.com.au
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Fix modutils to check ELF symbol index
Message-ID: <20010820103418.A15514@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

All my previous email sent to you are bounced. I am sending this to the
kernel mailing list, hoping you will read it..

H.J.
---
--- modutils-2.4.6/obj/obj_load.c.symbol	Mon Aug 20 10:13:50 2001
+++ modutils-2.4.6/obj/obj_load.c	Mon Aug 20 10:23:00 2001
@@ -257,7 +257,7 @@ obj_load (int fp, Elf32_Half e_type, con
 	{
 	case SHT_RELM:
 	  {
-	    unsigned long nrel, j;
+	    unsigned long nrel, j, nsyms;
 	    ElfW(RelM) *rel;
 	    struct obj_section *symtab;
 	    char *strtab;
@@ -273,6 +273,7 @@ obj_load (int fp, Elf32_Half e_type, con
 	    nrel = sec->header.sh_size / sizeof(ElfW(RelM));
 	    rel = (ElfW(RelM) *) sec->contents;
 	    symtab = f->sections[sec->header.sh_link];
+	    nsyms = symtab->header.sh_size / symtab->header.sh_entsize;
 	    strtab = f->sections[symtab->header.sh_link]->contents;
 
 	    /* Save the relocate type in each symbol entry.  */
@@ -284,6 +285,13 @@ obj_load (int fp, Elf32_Half e_type, con
 		symndx = ELFW(R_SYM)(rel->r_info);
 		if (symndx)
 		  {
+		    if (symndx >= nsyms)
+		      {
+			error("%s: Bad symbol index: %08lx >= %08lx",
+			      filename, symndx, nsyms);
+			continue;
+		      }
+
 		    extsym = ((ElfW(Sym) *) symtab->contents) + symndx;
 		    if (ELFW(ST_BIND)(extsym->st_info) == STB_LOCAL)
 		      {
--- modutils-2.4.6/obj/obj_reloc.c.symbol	Mon Aug 20 10:20:52 2001
+++ modutils-2.4.6/obj/obj_reloc.c	Mon Aug 20 10:24:32 2001
@@ -284,6 +284,7 @@ obj_relocate (struct obj_file *f, ElfW(A
       ElfW(RelM) *rel, *relend;
       ElfW(Sym) *symtab;
       const char *strtab;
+      unsigned long nsyms;
 
       relsec = f->sections[i];
       if (relsec->header.sh_type != SHT_RELM)
@@ -296,6 +297,7 @@ obj_relocate (struct obj_file *f, ElfW(A
       rel = (ElfW(RelM) *)relsec->contents;
       relend = rel + (relsec->header.sh_size / sizeof(ElfW(RelM)));
       symtab = (ElfW(Sym) *)symsec->contents;
+      nsyms = symsec->header.sh_size / symsec->header.sh_entsize;
       strtab = (const char *)strsec->contents;
 
       for (; rel < relend; ++rel)
@@ -312,6 +314,13 @@ obj_relocate (struct obj_file *f, ElfW(A
 	  if (symndx)
 	    {
 	      /* Note we've already checked for undefined symbols.  */
+
+	      if (symndx >= nsyms)
+		{
+		  error("Bad symbol index: %08lx >= %08lx",
+			symndx, nsyms);
+		  continue;
+		}
 
 	      extsym = &symtab[symndx];
 	      if (ELFW(ST_BIND)(extsym->st_info) == STB_LOCAL)
