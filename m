Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWFJUeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWFJUeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWFJUeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 16:34:05 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:35507 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161011AbWFJUeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 16:34:04 -0400
Date: Sat, 10 Jun 2006 22:33:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH] kbuild support for %.symtypes files
Message-ID: <20060610203348.GB9502@mars.ravnborg.org>
References: <200605092037.31228.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605092037.31228.agruen@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 08:37:30PM +0200, Andreas Gruenbacher wrote:
> Hello,
> 
> here is a patch that adds a new -T option to genksyms for generating dumps of 
> the type definition that makes up the symbol version hashes. This allows to 
> trace modversion changes back to what caused them. The dump format is the 
> name of the type defined, followed by its definition (which is almost C):
> 
>   s#list_head struct list_head { s#list_head * next , * prev ; }
Reading something just a little more complex than the above was very
difficult. So I went on and updated your patch to spit out something
almost 'C' alike with proper indention and a few newlines too.

The list_head struct looks like this now:

struct#list_head  struct list_head {
	struct# list_head * next , * prev;
};

The real win is for structs with 20+ members, they are now divided up in
several lines.
See attached patch.

Changes:
o print_node properly idents symbols (added putident)
o close file before exit
o ident cmd_cc_symtypes_c in Makefile.build

Patch is not yet committed, awaiting feedback from you first.

	Sam

diff --git a/Makefile b/Makefile
index 1b2fd97..f0b7c96 100644
--- a/Makefile
+++ b/Makefile
@@ -948,7 +948,8 @@ clean: archclean $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
-		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
+		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
+		-o -name '*.symtypes' \) \
 		-type f -print | xargs rm -f
 
 # mrproper - Delete all generated files, including .config
@@ -1290,6 +1291,8 @@ endif
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.S prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+%.symtypes: %.c prepare scripts FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
 / %/: prepare scripts FORCE
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 53e53a2..99ec1c3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -140,6 +140,15 @@ cmd_cc_i_c       = $(CPP) $(c_flags)   -
 %.i: %.c FORCE
 	$(call if_changed_dep,cc_i_c)
 
+quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
+      cmd_cc_symtypes_c = \
+		$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
+		| $(GENKSYMS) -T $@ >/dev/null;				\
+		test -s $@ || rm -f $@
+
+%.symtypes: %.c FORCE
+	$(call if_changed_dep,cc_symtypes_c)
+
 # C (.c) files
 # The C file is compiled and updated dependency information is generated.
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
@@ -166,7 +175,8 @@ cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D
 cmd_modversions =							\
 	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
-		| $(GENKSYMS) -a $(ARCH)				\
+		| $(GENKSYMS) $(if $(KBUILD_SYMTYPES),			\
+			      -T $(@D)/$(@F:.o=.symtypes)) -a $(ARCH)	\
 		> $(@D)/.tmp_$(@F:.o=.ver);				\
 									\
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 5b0344e..33ffebf 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -42,7 +42,7 @@ static FILE *debugfile;
 int cur_line = 1;
 char *cur_filename;
 
-static int flag_debug, flag_dump_defs, flag_warnings;
+static int flag_debug, flag_dump_defs, flag_dump_types, flag_warnings;
 static const char *arch = "";
 static const char *mod_prefix = "";
 
@@ -50,6 +50,7 @@ static int errors;
 static int nsyms;
 
 static struct symbol *expansion_trail;
+static struct symbol *visited_symbols;
 
 static const char *const symbol_type_name[] = {
 	"normal", "typedef", "enum", "struct", "union"
@@ -176,6 +177,7 @@ struct symbol *add_symbol(const char *na
 	sym->type = type;
 	sym->defn = defn;
 	sym->expansion_trail = NULL;
+	sym->visited = NULL;
 	sym->is_extern = is_extern;
 
 	sym->hash_next = symtab[h];
@@ -233,28 +235,50 @@ static int equal_list(struct string_list
 
 	return !a && !b;
 }
+static void putident(int l, FILE *f)
+{
+	while (l--)
+		fputc('\t', f);
+}
 
-static void print_node(FILE * f, struct string_list *list)
+static void print_node(FILE * f, struct string_list *list, int *ident)
 {
-	switch (list->tag) {
-	case SYM_STRUCT:
-		putc('s', f);
-		goto printit;
-	case SYM_UNION:
-		putc('u', f);
-		goto printit;
-	case SYM_ENUM:
-		putc('e', f);
-		goto printit;
-	case SYM_TYPEDEF:
-		putc('t', f);
-		goto printit;
-
-	      printit:
+	static int newline = 1;
+	if (list->tag != SYM_NORMAL) {
+		if (newline) {
+			putident(*ident, f);
+			newline = 0;
+		} else {
+			putc(' ', f);
+		}
+		fputs(symbol_type_name[list->tag], f);
 		putc('#', f);
-	case SYM_NORMAL:
-		fputs(list->string, f);
-		break;
+	}
+	switch (list->string[0]) {
+		case '{':
+			fputs(" {\n", f);
+			(*ident)++;
+			newline = 1;
+			break;
+		case '}':
+			(*ident)--;
+			putident(*ident, f);
+			fputc('}', f);
+			newline = 0;
+			break;
+		case ';':
+			fputs(";\n", f);
+			newline = 1;
+			break;
+		default:
+			if (newline) {
+				putident(*ident, f);
+				newline = 0;
+			} else {
+				putc(' ', f);
+			}
+			fputs(list->string, f);
+			break;
 	}
 }
 
@@ -263,6 +287,7 @@ static void print_list(FILE * f, struct 
 	struct string_list **e, **b;
 	struct string_list *tmp, **tmp2;
 	int elem = 1;
+	int ident = 0;
 
 	if (list == NULL) {
 		fputs("(nil)", f);
@@ -282,14 +307,13 @@ static void print_list(FILE * f, struct 
 		*(tmp2--) = list;
 
 	while (b != e) {
-		print_node(f, *b++);
-		putc(' ', f);
+		print_node(f, *b++, &ident);
 	}
 }
 
-static unsigned long expand_and_crc_list(struct string_list *list,
-					 unsigned long crc)
+static unsigned long expand_and_crc_sym(struct symbol *sym, unsigned long crc)
 {
+	struct string_list *list = sym->defn;
 	struct string_list **e, **b;
 	struct string_list *tmp, **tmp2;
 	int elem = 1;
@@ -332,7 +356,7 @@ static unsigned long expand_and_crc_list
 			} else {
 				subsym->expansion_trail = expansion_trail;
 				expansion_trail = subsym;
-				crc = expand_and_crc_list(subsym->defn, crc);
+				crc = expand_and_crc_sym(subsym, crc);
 			}
 			break;
 
@@ -382,12 +406,22 @@ static unsigned long expand_and_crc_list
 			} else {
 				subsym->expansion_trail = expansion_trail;
 				expansion_trail = subsym;
-				crc = expand_and_crc_list(subsym->defn, crc);
+				crc = expand_and_crc_sym(subsym, crc);
 			}
 			break;
 		}
 	}
 
+	{
+		static struct symbol **end = &visited_symbols;
+
+		if (!sym->visited) {
+			*end = sym;
+			end = &sym->visited;
+			sym->visited = (struct symbol *)-1L;
+		}
+	}
+
 	return crc;
 }
 
@@ -406,7 +440,7 @@ void export_symbol(const char *name)
 
 		expansion_trail = (struct symbol *)-1L;
 
-		crc = expand_and_crc_list(sym->defn, 0xffffffff) ^ 0xffffffff;
+		crc = expand_and_crc_sym(sym, 0xffffffff) ^ 0xffffffff;
 
 		sym = expansion_trail;
 		while (sym != (struct symbol *)-1L) {
@@ -464,6 +498,7 @@ #endif				/* __GNU_LIBRARY__ */
 
 int main(int argc, char **argv)
 {
+	FILE *dumpfile = NULL;
 	int o;
 
 #ifdef __GNU_LIBRARY__
@@ -473,15 +508,16 @@ #ifdef __GNU_LIBRARY__
 		{"warnings", 0, 0, 'w'},
 		{"quiet", 0, 0, 'q'},
 		{"dump", 0, 0, 'D'},
+		{"dump-types", 1, 0, 'T'},
 		{"version", 0, 0, 'V'},
 		{"help", 0, 0, 'h'},
 		{0, 0, 0, 0}
 	};
 
-	while ((o = getopt_long(argc, argv, "a:dwqVDk:p:",
+	while ((o = getopt_long(argc, argv, "a:dwqVDT:k:p:",
 				&long_opts[0], NULL)) != EOF)
 #else				/* __GNU_LIBRARY__ */
-	while ((o = getopt(argc, argv, "a:dwqVDk:p:")) != EOF)
+	while ((o = getopt(argc, argv, "a:dwqVDT:k:p:")) != EOF)
 #endif				/* __GNU_LIBRARY__ */
 		switch (o) {
 		case 'a':
@@ -502,6 +538,14 @@ #endif				/* __GNU_LIBRARY__ */
 		case 'D':
 			flag_dump_defs = 1;
 			break;
+		case 'T':
+			flag_dump_types = 1;
+			dumpfile = fopen(optarg, "w");
+			if (!dumpfile) {
+				perror(optarg);
+				return 1;
+			}
+			break;
 		case 'h':
 			genksyms_usage();
 			return 0;
@@ -524,6 +568,28 @@ #endif				/* __GNU_LIBRARY__ */
 
 	yyparse();
 
+	if (flag_dump_types) {
+		if (visited_symbols) {
+			while (visited_symbols != (struct symbol *)-1L) {
+				struct symbol *sym = visited_symbols;
+
+				if (sym->type != SYM_NORMAL) {
+					fputs(symbol_type_name[sym->type],
+					     dumpfile);
+					putc('#', dumpfile);
+				}
+				fputs(sym->name, dumpfile);
+				putc(' ', dumpfile);
+				print_list(dumpfile, sym->defn);
+				fputs(";\n\n", dumpfile);
+
+				visited_symbols = sym->visited;
+				sym->visited = NULL;
+			}
+		}
+		fclose(dumpfile);
+	}
+
 	if (flag_debug) {
 		fprintf(debugfile, "Hash table occupancy %d/%d = %g\n",
 			nsyms, HASH_BUCKETS,
diff --git a/scripts/genksyms/genksyms.h b/scripts/genksyms/genksyms.h
index ab6f34f..2668287 100644
--- a/scripts/genksyms/genksyms.h
+++ b/scripts/genksyms/genksyms.h
@@ -41,6 +41,7 @@ struct symbol {
 	enum symbol_type type;
 	struct string_list *defn;
 	struct symbol *expansion_trail;
+	struct symbol *visited;
 	int is_extern;
 };
 
