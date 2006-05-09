Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWEISgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWEISgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEISgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:36:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:2480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750759AbWEISgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:36:02 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC PATCH] kbuild support for %.symtypes files
Date: Tue, 9 May 2006 20:37:30 +0200
User-Agent: KMail/1.9.1
Cc: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rFOYEyVb0WtsHI1"
Message-Id: <200605092037.31228.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rFOYEyVb0WtsHI1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

here is a patch that adds a new -T option to genksyms for generating dumps of 
the type definition that makes up the symbol version hashes. This allows to 
trace modversion changes back to what caused them. The dump format is the 
name of the type defined, followed by its definition (which is almost C):

  s#list_head struct list_head { s#list_head * next , * prev ; }

The s#, u#, e#, and t# prefixes stand for struct, union, enum, and typedef.  
The exported symbols do not define types, and thus do not have an x# prefix:

  nfs4_acl_get_whotype int nfs4_acl_get_whotype ( char * , t#u32 )

The symbol type defintion of a single file can be generated with:

  make fs/jbd/journal.symtypes

If KBUILD_SYMTYPES is defined, all the *.symtypes of all object files that 
export symbols are generated.

The single *.symtypes files can be combined into a single file after a kernel 
build with a script like the following:

for f in $(find -name '*.symtypes' | sort); do
    f=${f#./}
    echo "/* ${f%.symtypes}.o */"
    cat $f
    echo
done \
| sed -e '\:UNKNOWN:d' \
      -e 's:[,;] }:}:g' \
      -e 's:\([[({]\) :\1:g' \
      -e 's: \([])},;]\):\1:g' \
      -e 's: $::' \
      $f \
| awk '
/^.#/   { if (defined[$1] == $0) {
            print $1
            next
          }
          defined[$1] = $0
        }
        { print }
'

When the kernel ABI changes, diffing individual *.symtype files, or the 
combined files, against each other will show which symbol changes caused the 
ABI changes. This can save a tremendous amount of time.

I've been discussing this patch with Jon, and I think the patch makes more 
sense upstream than in a vendor kernel only. Comments?

Thanks,
Andreas

--Boundary-00=_rFOYEyVb0WtsHI1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="symtypes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="symtypes.diff"

Dump the types that make up modversions

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.16/scripts/Makefile.build
===================================================================
--- linux-2.6.16.orig/scripts/Makefile.build
+++ linux-2.6.16/scripts/Makefile.build
@@ -140,6 +140,15 @@ cmd_cc_i_c       = $(CPP) $(c_flags)   -
 %.i: %.c FORCE
 	$(call if_changed_dep,cc_i_c)
 
+quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
+cmd_cc_symtypes_c	   = \
+		$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
+		| $(GENKSYMS) -T $@ >/dev/null;				\
+		test -s $@ || rm -f $@
+
+%.symtypes : %.c FORCE
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
Index: linux-2.6.16/scripts/genksyms/genksyms.c
===================================================================
--- linux-2.6.16.orig/scripts/genksyms/genksyms.c
+++ linux-2.6.16/scripts/genksyms/genksyms.c
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
@@ -236,26 +238,11 @@ static int equal_list(struct string_list
 
 static void print_node(FILE * f, struct string_list *list)
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
+	if (list->tag != SYM_NORMAL) {
+		putc(symbol_type_name[list->tag][0], f);
 		putc('#', f);
-	case SYM_NORMAL:
-		fputs(list->string, f);
-		break;
 	}
+	fputs(list->string, f);
 }
 
 static void print_list(FILE * f, struct string_list *list)
@@ -287,9 +274,9 @@ static void print_list(FILE * f, struct 
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
@@ -332,7 +319,7 @@ static unsigned long expand_and_crc_list
 			} else {
 				subsym->expansion_trail = expansion_trail;
 				expansion_trail = subsym;
-				crc = expand_and_crc_list(subsym->defn, crc);
+				crc = expand_and_crc_sym(subsym, crc);
 			}
 			break;
 
@@ -382,12 +369,22 @@ static unsigned long expand_and_crc_list
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
 
@@ -406,7 +403,7 @@ void export_symbol(const char *name)
 
 		expansion_trail = (struct symbol *)-1L;
 
-		crc = expand_and_crc_list(sym->defn, 0xffffffff) ^ 0xffffffff;
+		crc = expand_and_crc_sym(sym, 0xffffffff) ^ 0xffffffff;
 
 		sym = expansion_trail;
 		while (sym != (struct symbol *)-1L) {
@@ -464,6 +461,7 @@ static void genksyms_usage(void)
 
 int main(int argc, char **argv)
 {
+	FILE *dumpfile = NULL;
 	int o;
 
 #ifdef __GNU_LIBRARY__
@@ -473,15 +471,16 @@ int main(int argc, char **argv)
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
@@ -502,6 +501,14 @@ int main(int argc, char **argv)
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
@@ -524,6 +531,24 @@ int main(int argc, char **argv)
 
 	yyparse();
 
+	if (flag_dump_types && visited_symbols) {
+		while (visited_symbols != (struct symbol *)-1L) {
+			struct symbol *sym = visited_symbols;
+
+			if (sym->type != SYM_NORMAL) {
+				putc(symbol_type_name[sym->type][0], dumpfile);
+				putc('#', dumpfile);
+			}
+			fputs(sym->name, dumpfile);
+			putc(' ', dumpfile);
+			print_list(dumpfile, sym->defn);
+			putc('\n', dumpfile);
+
+			visited_symbols = sym->visited;
+			sym->visited = NULL;
+		}
+	}
+
 	if (flag_debug) {
 		fprintf(debugfile, "Hash table occupancy %d/%d = %g\n",
 			nsyms, HASH_BUCKETS,
Index: linux-2.6.16/scripts/genksyms/genksyms.h
===================================================================
--- linux-2.6.16.orig/scripts/genksyms/genksyms.h
+++ linux-2.6.16/scripts/genksyms/genksyms.h
@@ -41,6 +41,7 @@ struct symbol {
 	enum symbol_type type;
 	struct string_list *defn;
 	struct symbol *expansion_trail;
+	struct symbol *visited;
 	int is_extern;
 };
 
Index: linux-2.6.16/Makefile
===================================================================
--- linux-2.6.16.orig/Makefile
+++ linux-2.6.16/Makefile
@@ -961,7 +961,8 @@ clean: archclean $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
-		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
+		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
+		-o -name '*.symtypes' \) \
 		-type f -print | xargs rm -f
 
 # mrproper - Delete all generated files, including .config
@@ -1303,6 +1304,8 @@ endif
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.S prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+%.symtypes: %.c prepare scripts FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
 / %/: prepare scripts FORCE

--Boundary-00=_rFOYEyVb0WtsHI1--
