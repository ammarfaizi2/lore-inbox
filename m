Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVIAKx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVIAKx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVIAKx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:53:28 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:23940 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S964874AbVIAKx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:53:27 -0400
Message-ID: <2350.192.168.201.6.1125571990.squirrel@www.masroudeau.com>
Date: Thu, 1 Sep 2005 11:53:10 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@osdl.org>
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: [PATCH 1/4] rm -rf linux/arch/i386/boot  and Gujin bootloader
Content-Type: multipart/mixed;boundary="----=_20050901115310_96263"
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050901115310_96263
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

  Hello,

  This is a list of patch which simplify the file structure of
 the kernel residing in /boot . The file named with a KGZ extension
 ( for instance /boot/linux-2.6.13.kgz ) is simply the usual ELF file
 named linux-2.6.13/vmlinux tranformed to binary with objdump and
 gzip'ed.
 This new file structure can be "natively" loaded by the Gujin GPL
 bootloader version 1.2 available on sourceforge:
http://sourceforge.net/projects/gujin
 Gujin homepage with screenshoots:
http://gujin.org
 Gujin FAQ and HOWTO:
http://sourceforge.net/docman/display_doc.php?docid=1989&group_id=15465

 Gujin can also load files bzImage and the like but only in
 its "compatibility" mode where it replaces the real mode assembler
 by its own C code and uses the 32 bits protected mode entry point,
 for technical reasons.
 To get this new file you apply at least the two first patch of this
 list and simply type:
make /boot/linux-2.6.13.kgz ROOT=auto
 This list of patch does not change the old Makefile process, so you can
 still make the old target and load with LILO or GRUB.

 Gujin bootloader will check some parameter of the kernel (for instance
 to forbid to run a kernel compiled with TSC on a i386) and for that
 purpose check the content of the comment part of the gzip KGZ file.

 The real-mode ia32 assembler parts present in the kernel
 (files under linux-2.6.13/arch/i386/boot) are completely unused for
 the new KGZ file structure and that real mode probing is replaced by
 a function written in standard C (second patch of this list).
 I dropped some complex stuff like the recognition of ISA video card
 from the real-mode C source, because a bit of cleanning is needed from
 times to times (has to be done also for x86_64 - no ISA bus on those).
 The real mode C function produce exactly the same memory mapping for real
 mode parameters (file zero-page.txt), and is inserted at end of the ELF
 vmlinux file by the linker.
 There isn't any more a limit for the size of the uncompressed kernel.

Signed-off-by: Etienne Lorrain <etienne_lorrain@gujin.org>

 This first part just add two standalone programs, one to edit/display
 the comment field of a GZIP file, and one which display a line on
 stdout to describe the main configuration of the kernel being compiled,
 to be output on the comment line of the GZIP being produced.

  Etienne.
------=_20050901115310_96263
Content-Type: text/plain; name="patch2613-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch2613-1"

diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13/Makefile linux-2.6.13-new/Makefile
--- linux-2.6.13/Makefile	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13-new/Makefile	2005-08-30 23:12:59.000000000 +0100
@@ -728,6 +728,19 @@ endif # ifdef CONFIG_KALLSYMS
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
 
+# Utility to display the kernel compile time parameters
+quiet_cmd_gzparam = HOSTCC  $@
+      cmd_gzparam = $(HOSTCC) $(HOSTCFLAGS) -Wl,"-u __ERROR" -o $@ $<
+      # Need to rebuild this if "include/linux/autoconf.h" changed:
+scripts/gzparam: scripts/gzparam.c vmlinux FORCE
+	$(call cmd,gzparam)
+
+# Maybe move building this utility somewhere else?
+quiet_cmd_gzcopy = HOSTCC  $@
+      cmd_gzcopy = $(HOSTCC) $(HOSTCFLAGS) -s -o $@ $<
+scripts/gzcopy: scripts/gzcopy.c
+	$(call cmd,gzcopy)
+
 # The actual objects are generated when descending, 
 # make sure no implicit rule kicks in
 $(sort $(vmlinux-init) $(vmlinux-main)) $(vmlinux-lds): $(vmlinux-dirs) ;
@@ -949,6 +962,7 @@ endef
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
 CLEAN_FILES +=	vmlinux System.map \
+                scripts/gzparam scripts/gzcopy \
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
 
 # Directories & files removed with 'make mrproper'
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13/scripts/gzcopy.c linux-2.6.13-new/scripts/gzcopy.c
--- linux-2.6.13/scripts/gzcopy.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-new/scripts/gzcopy.c	2005-08-30 22:51:10.000000000 +0100
@@ -0,0 +1,1005 @@
+/*
+ * gzcopy: utility to copy (only) GZip files, possibly displaying or
+ * modifying their header.
+ *
+ * Copyright (C) 2004 Etienne Lorrain, fingerprint (2D3AF3EA):
+ *   2471 DF64 9DEE 41D4 C8DB 9667 E448 FF8C 2D3A F3EA
+ * E-Mail: etienne dot lorrain at gujin dot org
+ *
+ *   This software is provided 'as-is', without any express or implied
+ *  warranty.  In no event will the authors be held liable for any damages
+ *  arising from the use of this software.
+ *
+ *  Permission is granted to anyone to use this software for any purpose,
+ *  including commercial applications, and to alter it and redistribute it
+ *  freely, subject to the following restrictions:
+ *
+ *  1. The origin of this software must not be misrepresented; you must not
+ *     claim that you wrote the original software. If you use this software
+ *     in a product, an acknowledgment in the product documentation would be
+ *     appreciated but is not required.
+ *  2. Altered source versions must be plainly marked as such, and must not be
+ *     misrepresented as being the original software.
+ *  3. This notice may not be removed or altered from any source distribution.
+ *
+ *   The data format used by the zlib library is described by RFCs (Request for
+ *  Comments) 1950 to 1952 in the files http://www.ietf.org/rfc/rfc1950.txt
+ *  (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format).
+ */
+
+/*
+ * TODO: Manage (extract/remove/insert...) concatenated ZIP files.
+ *
+ * Changelog:
+ * 15/9/2001: Etienne Lorrain. Initial release for the Gujin bootloader.
+ * 23/8/2002: Etienne Lorrain. '-s' -> '-c', only one input/output file
+ * 10/9/2004: Etienne Lorrain. Formal BSD-like license release & correct minibug.
+ *
+ */
+
+#include <stdio.h>
+#include <malloc.h>
+#include <errno.h>
+#include <sys/stat.h>		/* stat() */
+#include <unistd.h>		/* stat() */
+
+#if 0
+#include <string.h>
+#else
+static inline unsigned strlen(const char *str)
+{
+	const char *ptr = str;
+	while (*ptr)
+		ptr++;
+	return ptr - str;
+}
+
+static inline void my_strcpy(char *dst, const char *src)
+{
+	while (*src)
+		*dst++ = *src++;
+	*dst = *src;		/* copy the zero */
+}
+#define strcpy my_strcpy
+
+static inline void my_strcat(char *dst, const char *src)
+{
+	dst += strlen(dst);
+	strcpy(dst, src);
+}
+#define strcat my_strcat
+
+static inline unsigned strcmp(const char *s1, const char *s2)
+{
+	while (*s1 && *s1 == *s2) {
+		s1++;
+		s2++;
+	}
+	return (*s1 != *s2);
+}
+#endif
+
+#define STR static const char
+
+STR usage[] = "gzcopy: utility to copy (only) GZip files, possibly displaying\n"
+	      "        or modifying their header.\n"
+    "Copyright 2003 Etienne Lorrain, BSD-like license.\n"
+    "USAGE:\n"
+    "    gzcopy -h              -> display this help\n"
+    "    gzcopy -V              -> display the version\n"
+    "    gzcopy -v              -> be verbose\n"
+    "    gzcopy -c infile.gz    -> show the comment. (-c0 for raw form)\n"	/* was -s */
+    "    gzcopy -c='' infile.gz outfile.gz    -> set (clear if '') the comment\n"
+    "    gzcopy -a=\"<a comment>\" in.gz out.gz -> add/append a comment\n"
+    "    gzcopy -p='<a comment>' in.gz out.gz -> add/prepend a comment.\n"
+    "    gzcopy -k infile.gz    -> show the header CRC. (-k0 for raw form)\n"
+    "    gzcopy -k={0,1} infile.gz outfile.gz  -> (de)activate the header CRC\n"
+    "    gzcopy -b infile.gz    -> show the text/binary flag\n"
+    "    gzcopy -b={0,1} infile.gz outfile.gz  -> set the flag: binary=0/text=1\n"
+    "    gzcopy -n infile.gz    -> show the original name. (-n0 for raw form)\n"
+    "    gzcopy -n=filename in.gz out.gz       -> set (clear if '') original name\n"
+    "NOTE:\n"
+    " Use multiple command: gzcopy -c= -a='com' -a='m' -pl='ent' in.gz out.gz .\n"
+    " Use option -a{s,l,t} or -p{s,l,t} to check/force a {space,linefeed,tab}\n"
+    "  in between comment parts. Use filename \"-\" for stdin and/or stdout.\n"
+    " Use the -f option to force overwriting output file, or if you want\n"
+    " the output in the input file - you then need a lot of virtual memory.\n";
+
+STR version[] = "gzcopy version 1.2 (C) 2003 Etienne Lorrain, BSD-like license.";
+STR show_textflags_text_msg[] = "\"%s\" is probably a text file\n";
+STR show_textflags_binary_msg[] = "\"%s\" is probably a binary file\n";
+STR show_header_crc_msg[] = "\"%s\" header CRC16 is 0x%X.\n";
+STR no_CRC_to_show_msg[] = "\"%s\" does not contain any header CRC.\n";
+STR show_name_msg[] = "\"%s\" original name: \"%s\"\n";
+STR no_name_to_show_msg[] = "\"%s\" does not contain any original name.\n";
+STR show_comment_msg[] = "\"%s\" comment: \"%s\"\n";
+STR no_comment_to_show_msg[] = "\"%s\" does not contain any comment.\n";
+
+#define PRINTERR(format, args...) do { \
+	if (errno) perror ("gzcopy");		\
+	fprintf (stderr, "gzcopy: ");		\
+	fprintf (stderr, format , ## args);	\
+	fprintf (stderr, "\n");			\
+	} while (0)
+
+#define ENDHLP	", try: gzcopy -h"
+
+STR unknown_action[] = "unrecognised option -%c" ENDHLP;
+STR malformed_crc_param[] = "header crc option is neither "
+				"enable (-k=1) nor disable (-k=0)" ENDHLP;
+STR malformed_param[] = "no parameter after -%c= option" ENDHLP;
+STR too_many_param[] = "too many parameters: \"%s\"" ENDHLP;
+STR unknown_comment[] = "no comment to pre/append" ENDHLP;
+STR no_input_file[] = "no input file" ENDHLP;
+STR no_output_file[] = "no output file" ENDHLP;
+STR cannot_open_input_file[] = "cannot open input file \"%s\".";
+STR not_gzip_file[] = "input file \"%s\" is not a gzip file, "
+			"signature: 0x%X.";
+STR bad_header_crc[] = "bad header crc32: is 0x%X, " "should be 0x%X.";
+STR not_enough_memory[] = "not enough memory.";
+STR cannot_open_output_file[] = "cannot open input file \"%s\".";
+STR outfile_already_exists[] = "output file \"%s\" already exists and "
+				"option -f not specified.\n";
+STR cannot_write_to_file[] = "cannot write to file \"%s\".";
+STR read_input_file_error[] = "error reading from file \"%s\".";
+STR cannot_close_input_file[] = "cannot close input file \"%s\".";
+STR cannot_close_output_file[] = "cannot close output file \"%s\".";
+
+#define VERBOSE(format, args...) do { \
+	if (verbose)				\
+	    fprintf (stderr, format , ## args);	\
+	} while (0)
+
+STR treating_intput_file[] = "treating \"%s\" as input file.\n";
+STR standart_input[] = "standart input";
+STR standart_output[] = "standart output";
+STR extra_field_present[] = "extra field of %u bytes present.\n";
+STR original_name[] = "original name: \"%s\".\n";
+STR comment_present[] = "comment: \"%s\".\n";
+STR header_crc_present[] = "header CRC16 present: 0x%X.\n";
+STR treating_output_file[] = "treating \"%s\" as output file.\n";
+STR enabling_header_crc[] = "enabling header CRC.\n";
+STR disabling_header_crc[] = "disabling header CRC.\n";
+STR removing_comment[] = "removing comment.\n";
+STR replacing_comment[] = "replacing comment with \"%s\".\n";
+STR adding_comment[] = "adding comment \"%s\".\n";
+STR appending_comment[] = "appending comment \"%s\".\n";
+STR prepending_comment[] = "prepending comment \"%s\".\n";
+STR new_header_crc[] = "new header CRC16: 0x%X.\n";
+STR removing_name[] = "removing the original name field.\n";
+STR changing_name[] = "changing the original name field to \"%s\".\n";
+STR set_probablytext_flag[] = "set the probably ASCII/text flags.\n";
+STR clear_probablytext_flag[] = "clear the probably ASCII/text flags.\n";
+
+#undef STR
+
+enum main_returned_enum {
+	warn_empty_comment = 1,
+	warn_no_comment = 2,
+	err_none = 0,
+	err_too_many_param = -1,
+	err_unknown_comment = -2,
+	err_unknown_action = -3,
+	err_malformed_param = -4,
+	err_malformed_crc_param = -5,
+	err_no_input_file = -6,
+	err_no_output_file = -7,
+	err_cannot_open_input_file = -8,
+	err_not_gzip_file = -9,
+	err_bad_header_crc = -10,
+	err_not_enough_memory = -11,
+	err_cannot_open_output_file = -12,
+	err_outfile_already_exists = -13,
+	err_cannot_write_to_file = -14,
+	err_read_input_file_error = -15,
+	err_cannot_close_input_file = -16,
+	err_cannot_close_output_file = -17
+};
+
+/* The Gzip header (with unsigned char flags): */
+struct gzheader_str {
+	unsigned short signature_0x8B1F;
+	unsigned char compression_method;	/* =Z_DEFLATED */
+	unsigned char flags;
+#define FLAGS_ascii		0x01	/* file probably ascii text */
+#define FLAGS_header_crc	0x02	/* header CRC present */
+#define FLAGS_extra_field	0x04	/* extra field present */
+#define FLAGS_orig_name		0x08	/* original file name present */
+#define FLAGS_comment		0x10	/* file comment present */
+#define FLAGS_unknown		0xE0	/* reserved */
+	unsigned modif_time;	/* nb second since 1/1/1970 */
+	unsigned char extraflags;
+#define EXTRAFLAGS_max_compress	2
+#define EXTRAFLAGS_fast_algo	4
+	unsigned char operating_system;
+} __attribute__ ((packed));
+
+/* The only compression method recognised by Gzip: */
+#define Z_DEFLATED	8
+
+static inline unsigned crc32(unsigned crc, const unsigned char *buf, unsigned len)
+{
+	const unsigned char *end = buf + len;
+
+	if (buf == 0)
+		return 0L;
+
+	crc = ~crc;
+	while (buf < end) {
+		unsigned c = (crc ^ *buf++) & 0xff;
+		unsigned short k;
+#define POLY	0xedb88320L	/* polynomial exclusive-or pattern */
+		for (k = 8; k != 0; k--)
+			c = c & 1 ? (c >> 1) ^ POLY : c >> 1;
+		crc = c ^ (crc >> 8);
+	}
+	return ~crc;
+}
+
+static unsigned initheader_crc32(struct gzheader_str *hdr)
+{
+	unsigned crc = crc32(0, 0, 0);
+	return crc32(crc, (unsigned char *)hdr, sizeof(struct gzheader_str));
+}
+
+static unsigned addbyte_crc32(unsigned crc, int val)
+{
+	unsigned char tmp = val;
+
+	return crc32(crc, &tmp, 1);
+}
+
+int main(int argc, char **argv)
+{
+	char /* *progname = *argv, */ help_option[] = "-h", *help_option_ptr = help_option;
+
+	enum main_returned_enum returned = err_none;
+
+	char *infilename = 0, *outfilename = 0;
+	FILE *infile = NULL, *outfile = NULL;
+
+	int verbose = 0, show_name = 0, show_comment = 0, overwrite = 0,
+	    show_header_crc = 0, show_text_flag = 0,
+	    set_text_flag = -1, activate_header_crc = -1;
+
+	struct gzheader_str header;
+	unsigned header_crc = 0, calculated_header_crc;
+	unsigned short extrafield_len = 0;
+	char *extrafield = 0;
+	char *name = 0, *comment = 0;
+
+	char *newcomment = 0, *newprecomment = 0, *newpostcomment = 0, *newname = 0;
+	char checkprespc = 0, checkpostspc = 0;
+	char *ptr;
+	int cpt;
+
+	if (argc == 1) {
+		argc = 2;
+		argv = &help_option_ptr;
+	} else {
+		argc--;
+		argv++;
+	}
+
+	for (cpt = 0; cpt < argc; cpt++) {
+		if (argv[cpt][0] == '-' && argv[cpt][1] != '\0') {
+			switch (argv[cpt][1]) {
+			case 'V':
+				printf("%s\n", version);
+				return err_none;
+			case 'h':
+				printf("%s\n", usage);
+				return err_none;
+			case 'v':
+				verbose = 1;
+				break;
+			case 'f':
+				if (argv[cpt][2] == '\0')
+					overwrite = 1;
+				break;
+			case 'b':
+				if (argv[cpt][2] == '\0') {
+					show_text_flag = 1;
+					break;
+				}
+				if (argv[cpt][2] == '0') {
+					show_text_flag = 2;	/* raw form */
+					break;
+				}
+				if (argv[cpt][2] != '='
+				    || (argv[cpt][3] != '0' && argv[cpt][3] != '1')) {
+					PRINTERR(malformed_param, argv[cpt][1]);
+					return err_malformed_param;
+				}
+				set_text_flag = (argv[cpt][3] == '1');
+				break;
+			case 'k':
+				if (argv[cpt][2] == '\0') {
+					show_header_crc = 1;
+					break;
+				}
+				if (argv[cpt][2] == '0') {
+					show_header_crc = 2;	/* raw form */
+					break;
+				}
+				if (argv[cpt][2] != '='
+				    || (argv[cpt][3] != '0' && argv[cpt][3] != '1')) {
+					PRINTERR(malformed_crc_param);
+					return err_malformed_crc_param;
+				}
+				activate_header_crc = (argv[cpt][3] == '1');
+				break;
+			case 'n':
+				if (argv[cpt][2] == '\0') {
+					show_name = 1;
+					break;
+				}
+				if (argv[cpt][2] == '0') {
+					show_name = 2;
+					break;
+				}
+				if (argv[cpt][2] != '=') {
+					PRINTERR(malformed_param, argv[cpt][1]);
+					return err_malformed_param;
+				}
+				newname = &argv[cpt][3];
+				break;
+			case 'c':
+				if (argv[cpt][2] == '\0') {
+					show_comment = 1;
+					break;
+				}
+				if (argv[cpt][2] == '0') {
+					show_comment = 2;
+					break;
+				}
+				if (argv[cpt][2] != '=') {
+					PRINTERR(malformed_param, argv[cpt][1]);
+					return err_malformed_param;
+				}
+				newcomment = &argv[cpt][3];
+				break;
+			case 'p':{
+					unsigned len;
+					unsigned char checkspc;
+					char *start;
+
+					len = 2;
+					switch (argv[cpt][len]) {
+					case 's':
+						checkspc = ' ';
+						len++;
+						break;
+					case 'l':
+						checkspc = '\n';
+						len++;
+						break;
+					case 't':
+						checkspc = '\t';
+						len++;
+						break;
+					default:
+					case '=':
+						checkspc = '\0';
+						break;
+					}
+
+					if (argv[cpt][len++] != '=') {
+						PRINTERR(malformed_param, argv[cpt][1]);
+						return err_malformed_param;
+					}
+					start = &argv[cpt][len];
+					len = strlen(start) + 1;
+					if (*start == 0) {
+						if (newprecomment == 0)
+							checkprespc = checkspc;
+					} else if (newprecomment == 0) {
+						newprecomment = malloc(len);
+						if (newprecomment == 0)
+							goto label_not_enough_memory;
+						checkprespc = checkspc;
+						strcpy(newprecomment, start);
+					} else {
+						char *tmp = malloc(strlen(newprecomment)
+									 + len + 1);
+						if (tmp == 0)
+							goto label_not_enough_memory;
+						strcpy(tmp, start);
+						/* last char: */
+						ptr = &tmp[len - 2];
+						if (checkspc != '\0' && *ptr != checkspc
+							&& newprecomment[0] != checkspc)
+							*++ptr = checkspc;
+						ptr++;
+						strcpy(ptr, newprecomment);
+						free(newprecomment);
+						newprecomment = tmp;
+					}
+				}
+				break;
+			case 'a':{
+					unsigned len;
+					unsigned char checkspc;
+					char *start;
+
+					len = 2;
+					switch (argv[cpt][len]) {
+					case 's':
+						checkspc = ' ';
+						len++;
+						break;
+					case 'l':
+						checkspc = '\n';
+						len++;
+						break;
+					case 't':
+						checkspc = '\t';
+						len++;
+						break;
+					case '=':
+					default:
+						checkspc = '\0';
+						break;
+					}
+
+					if (argv[cpt][len++] != '=') {
+						PRINTERR(malformed_param, argv[cpt][1]);
+						return err_malformed_param;
+					}
+					start = &argv[cpt][len];
+					len = strlen(start) + 1;
+					if (*start == 0) {
+						if (newpostcomment == 0)
+							checkpostspc = checkspc;
+					} else if (newpostcomment == 0) {
+						newpostcomment = malloc(len);
+						if (newpostcomment == 0)
+							goto label_not_enough_memory;
+						checkpostspc = checkspc;
+						strcpy(newpostcomment, start);
+					} else {
+						ptr = realloc(newpostcomment,
+							 strlen(newpostcomment) + len + 1);
+						if (ptr == 0)
+							goto label_not_enough_memory;
+						newpostcomment = ptr;
+						/* last char: */
+						ptr = &newpostcomment[strlen(newpostcomment) - 1];
+						if (checkspc != '\0' && *ptr != checkspc
+						    && *start != checkspc)
+							*++ptr = checkspc;
+						ptr++;
+						strcpy(ptr, start);
+					}
+				}
+				break;
+			default:
+				PRINTERR(unknown_action, argv[cpt][1]);
+				return err_unknown_action;
+			}
+		} else if (infilename == 0) {
+			infilename = argv[cpt];
+		} else if (outfilename == 0) {
+			outfilename = argv[cpt];
+		} else {
+			PRINTERR(too_many_param, argv[cpt]);
+			return err_too_many_param;
+		}
+	}
+
+	/*
+	 * Check option validity:
+	 */
+	if (infilename == 0) {
+		PRINTERR(no_input_file);
+		return err_no_input_file;
+	}
+
+	if (newname || newcomment || newpostcomment || newprecomment
+		|| activate_header_crc != -1 || set_text_flag != -1) {
+		if (outfilename == 0) {
+			if (overwrite) {
+				outfilename = infilename;
+			} else {
+				PRINTERR(no_output_file);
+				return err_no_output_file;
+			}
+		}
+	}
+
+	/*
+	 * Read the input file:
+	 */
+	if (!strcmp(infilename, "-")) {
+		infile = stdin;
+		VERBOSE(treating_intput_file, standart_input);
+	} else {
+		infile = fopen(infilename, "r");
+		if (infile == NULL) {
+			PRINTERR(cannot_open_input_file, infilename);
+			return err_cannot_open_input_file;
+		}
+		VERBOSE(treating_intput_file, infilename);
+	}
+
+	ptr = (char *)&header;
+	for (cpt = 0; cpt < sizeof(header); cpt++) {
+		int tmp = fgetc(infile);
+		if (tmp == EOF) {
+			if (!ferror(infile))
+				goto label_not_gzip_file;
+			else
+				goto label_read_input_file_error;
+		}
+		*ptr++ = tmp;
+	}
+
+	calculated_header_crc = initheader_crc32(&header);
+
+	if (header.signature_0x8B1F != 0x8B1F || header.compression_method != Z_DEFLATED
+		|| header.flags & FLAGS_unknown)
+		goto label_not_gzip_file;
+
+	if (header.flags & FLAGS_extra_field) {
+		int tmp = fgetc(infile);
+		if (tmp == EOF) {
+			if (!ferror(infile))
+				goto label_not_gzip_file;
+			else
+				goto label_read_input_file_error;
+		}
+		calculated_header_crc = addbyte_crc32(calculated_header_crc, tmp);
+		extrafield_len = tmp;
+		tmp = fgetc(infile);
+		if (tmp == EOF) {
+			if (!ferror(infile))
+				goto label_not_gzip_file;
+			else
+				goto label_read_input_file_error;
+		}
+		calculated_header_crc = addbyte_crc32(calculated_header_crc, tmp);
+		extrafield_len |= tmp << 8;
+		VERBOSE(extra_field_present, extrafield_len);
+
+		if (extrafield_len != 0) {
+			if ((extrafield = malloc(extrafield_len)) == 0)
+				goto label_not_enough_memory;
+		}
+		for (cpt = 0; cpt < extrafield_len; cpt++) {
+			tmp = fgetc(infile);
+			if (tmp == EOF) {
+				if (!ferror(infile))
+					goto label_not_gzip_file;
+				else
+					goto label_read_input_file_error;
+			}
+			calculated_header_crc = addbyte_crc32(calculated_header_crc, tmp);
+			extrafield[cpt] = tmp;
+		}
+	}
+
+	if (header.flags & FLAGS_orig_name) {
+		unsigned name_len = 0, name_alloced = 0;
+		int tmp;
+
+		do {
+			tmp = fgetc(infile);
+			if (tmp == EOF) {
+				if (!ferror(infile))
+					goto label_not_gzip_file;
+				else
+					goto label_read_input_file_error;
+			}
+			calculated_header_crc = addbyte_crc32(calculated_header_crc, tmp);
+			if (name_len >= name_alloced) {
+				if (name != 0) {
+					if ((ptr = realloc(name, name_alloced += 1024)) == 0)
+						goto label_not_enough_memory;
+					name = ptr;
+				} else {
+					if ((name = malloc(name_alloced = 1024)) == 0)
+						goto label_not_enough_memory;
+				}
+			}
+			name[name_len++] = tmp;
+		} while (tmp != '\0');
+		VERBOSE(original_name, name);
+	}
+
+	if (header.flags & FLAGS_comment) {
+		unsigned comment_len = 0, comment_alloced = 0;
+		int tmp;
+
+		do {
+			tmp = fgetc(infile);
+			if (tmp == EOF) {
+				if (!ferror(infile))
+					goto label_not_gzip_file;
+				else
+					goto label_read_input_file_error;
+			}
+			calculated_header_crc = addbyte_crc32(calculated_header_crc, tmp);
+			if (comment_len >= comment_alloced) {
+				if (comment != 0) {
+					if ((ptr = realloc(comment, comment_alloced += 1024))
+						== 0)
+						goto label_not_enough_memory;
+					comment = ptr;
+				} else {
+					if ((comment = malloc(comment_alloced = 1024)) == 0)
+						goto label_not_enough_memory;
+				}
+			}
+			comment[comment_len++] = tmp;
+		} while (tmp != '\0');
+		VERBOSE(comment_present, comment);
+	}
+
+	if (header.flags & FLAGS_header_crc) {
+		int tmp = fgetc(infile);
+		if (tmp == EOF) {
+			if (!ferror(infile))
+				goto label_not_gzip_file;
+			else
+				goto label_read_input_file_error;
+		}
+		header_crc = tmp;
+		tmp = fgetc(infile);
+		if (tmp == EOF) {
+			if (!ferror(infile))
+				goto label_not_gzip_file;
+			else
+				goto label_read_input_file_error;
+		}
+		header_crc |= tmp << 8;
+		calculated_header_crc &= 0xFFFF;
+		if (show_header_crc == 2)
+			printf("0x%X\n", header_crc);
+		else if (show_header_crc != 0)
+			printf(show_header_crc_msg, infilename, header_crc);
+		VERBOSE(header_crc_present, header_crc);
+		if (calculated_header_crc != header_crc) {
+			PRINTERR(bad_header_crc, header_crc, calculated_header_crc);
+			returned = err_bad_header_crc;
+			goto label_end;
+		}
+	} else {
+		if (show_header_crc != 0 && show_header_crc != 2)
+			printf(no_CRC_to_show_msg, infilename);
+	}
+
+	/*
+	 * Treat commands:
+	 */
+
+	if (show_name == 2) {
+		if (name != 0)
+			printf("%s\n", name);
+	} else if (show_name) {
+		if (name != 0)
+			printf(show_name_msg, infilename, name);
+		else
+			printf(no_name_to_show_msg, infilename);
+	}
+
+	if (show_comment == 2) {
+		if (comment != 0)
+			printf("%s\n", comment);
+	} else if (show_comment) {
+		if (comment != 0)
+			printf(show_comment_msg, infilename, comment);
+		else
+			printf(no_comment_to_show_msg, infilename);
+	}
+
+	if (show_text_flag == 2) {
+		printf("%u\n", header.flags & FLAGS_ascii);
+	} else if (show_text_flag) {
+		if (header.flags & FLAGS_ascii)
+			printf(show_textflags_text_msg, infilename);
+		else
+			printf(show_textflags_binary_msg, infilename);
+	}
+
+	if (set_text_flag != -1) {
+		if (set_text_flag == 0) {
+			header.flags &= ~FLAGS_ascii;
+			VERBOSE(clear_probablytext_flag);
+		} else {
+			header.flags |= FLAGS_ascii;
+			VERBOSE(set_probablytext_flag);
+		}
+	}
+
+	if (activate_header_crc != -1) {
+		if (activate_header_crc) {
+			header.flags |= FLAGS_header_crc;
+			VERBOSE(enabling_header_crc);
+		} else {
+			header.flags &= ~FLAGS_header_crc;
+			VERBOSE(disabling_header_crc);
+		}
+	}
+
+	if (newname) {
+		if (*newname == 0) {
+			header.flags &= ~FLAGS_orig_name;
+			VERBOSE(removing_name);
+		} else {
+			header.flags |= FLAGS_orig_name;
+			VERBOSE(changing_name, newname);
+			if (name)
+				free(name);
+			name = malloc(strlen(newname) + 1);
+			strcpy(name, newname);
+		}
+	}
+
+	if (newcomment) {
+		if (*newcomment == '\0') {
+			VERBOSE(removing_comment);
+			if (comment)
+				free(comment);
+			comment = 0;
+			header.flags &= ~FLAGS_comment;
+		} else {
+			VERBOSE(replacing_comment, newcomment);
+			if (comment)
+				free(comment);
+			comment = malloc(strlen(newcomment) + 1);
+			strcpy(comment, newcomment);
+			header.flags |= FLAGS_comment;
+		}
+	}
+
+	if (newprecomment) {
+		if ((header.flags & FLAGS_comment) == 0) {
+			VERBOSE(adding_comment, newprecomment);
+			comment = malloc(strlen(newprecomment) + 1);
+			if (comment == 0)
+				goto label_not_enough_memory;
+			strcpy(comment, newprecomment);
+			/* last char: */
+			ptr = &comment[strlen(comment)];
+			if (checkprespc != '\0' && *ptr != checkprespc) {
+				*++ptr = checkprespc;
+				*++ptr = '\0';
+			}
+			free(newprecomment);
+			newprecomment = 0;
+		} else {
+			VERBOSE(prepending_comment, newprecomment);
+			ptr = realloc(newprecomment, strlen(newprecomment) + 1
+							+ strlen(comment) + 1);
+			if (ptr == 0)
+				goto label_not_enough_memory;
+			newprecomment = ptr;
+			/* last char: */
+			ptr = &newprecomment[strlen(newprecomment)];
+			if (checkprespc != '\0'
+			    && *ptr != checkprespc && comment[0] != checkprespc)
+				*++ptr = checkprespc;
+			ptr++;
+			strcpy(ptr, comment);
+			free(comment);
+			comment = newprecomment;
+			newprecomment = 0;
+		}
+		header.flags |= FLAGS_comment;
+	}
+
+	if (newpostcomment) {
+		if ((header.flags & FLAGS_comment) == 0) {
+			VERBOSE(adding_comment, newpostcomment);
+			comment = malloc(strlen(newpostcomment) + 1);
+			if (comment == 0)
+				goto label_not_enough_memory;
+			strcpy(comment, newpostcomment);
+			/* last char: */
+			ptr = &comment[strlen(comment)];
+			if (checkpostspc != '\0' && *ptr != checkpostspc) {
+				*++ptr = checkpostspc;
+				*++ptr = '\0';
+			}
+			free(newpostcomment);
+			newpostcomment = 0;
+		} else {
+			VERBOSE(appending_comment, newpostcomment);
+			ptr = realloc(comment, strlen(comment)
+						 + 1 + strlen(newpostcomment) + 1);
+			if (ptr == 0)
+				goto label_not_enough_memory;
+			comment = ptr;
+			/* last char: */
+			ptr = &comment[strlen(comment) - 1];
+			if (checkpostspc != '\0'
+			    && *ptr != checkpostspc && newpostcomment[0] != checkpostspc)
+				*++ptr = checkpostspc;
+			ptr++;
+			strcpy(ptr, newpostcomment);
+			free(newpostcomment);
+			newpostcomment = 0;
+		}
+		header.flags |= FLAGS_comment;
+	}
+
+	/*
+	 * Write the file back:
+	 */
+
+	if (outfilename != 0) {
+		struct stat inbuf;
+		char *full_content = 0;
+		unsigned full_length = 0;
+
+		if (fstat(fileno(infile), &inbuf) != -1) {
+			full_content = malloc(inbuf.st_size);	/* bit too much but... */
+			if (full_content != 0) {
+				unsigned char *ptr = full_content;
+				for (;;) {
+					int tmp = fgetc(infile);
+
+					if (tmp == EOF) {
+						if (ferror(infile)) {
+							free(full_content);
+							goto label_read_input_file_error;
+						}
+						break;
+					}
+					full_length++;
+					if (full_length >= inbuf.st_size) {
+						free(full_content);
+						goto label_read_input_file_error;
+					}
+					*ptr++ = tmp;
+				}
+			} else if (outfilename == infilename)
+				goto label_read_input_file_error;
+		}
+
+		if (!strcmp(outfilename, "-")) {
+			outfile = stdout;
+			VERBOSE(treating_output_file, standart_output);
+		} else {
+			if (overwrite == 0) {
+				struct stat buf;
+				if (stat(outfilename, &buf) != -1 && errno != ENOENT) {
+					errno = 0;
+					PRINTERR(outfile_already_exists, outfilename);
+					returned = err_outfile_already_exists;
+					goto label_end;
+				}
+				errno = 0;
+			}
+			outfile = fopen(outfilename, "w");
+			if (outfile == NULL) {
+				PRINTERR(cannot_open_output_file, outfilename);
+				returned = err_cannot_open_output_file;
+				goto label_end;
+			}
+			VERBOSE(treating_output_file, outfilename);
+		}
+
+		ptr = (char *)&header;
+		for (cpt = 0; cpt < sizeof(header); cpt++) {
+			if (fputc(*ptr++, outfile) == EOF)
+				goto label_cannot_write_to_file;
+		}
+
+		calculated_header_crc = initheader_crc32(&header);
+
+		if (header.flags & FLAGS_extra_field) {
+			ptr = extrafield;
+			if (fputc(extrafield_len, outfile) == EOF
+				|| fputc(extrafield_len >> 8, outfile) == EOF)
+				goto label_cannot_write_to_file;
+			calculated_header_crc = addbyte_crc32(calculated_header_crc,
+								extrafield_len);
+			calculated_header_crc = addbyte_crc32(calculated_header_crc,
+								extrafield_len >> 8);
+
+			for (cpt = 0; cpt < extrafield_len; cpt++) {
+				if (fputc(*ptr, outfile) == EOF)
+					goto label_cannot_write_to_file;
+				calculated_header_crc = addbyte_crc32(calculated_header_crc,
+								*ptr);
+				ptr++;
+			}
+		}
+		if (header.flags & FLAGS_orig_name) {
+			unsigned name_len = strlen(name) + 1;
+
+			ptr = name;
+			for (cpt = 0; cpt < name_len; cpt++) {
+				if (fputc(*ptr, outfile) == EOF)
+					goto label_cannot_write_to_file;
+				calculated_header_crc = addbyte_crc32(calculated_header_crc,
+								*ptr);
+				ptr++;
+			}
+		}
+		if (header.flags & FLAGS_comment) {
+			unsigned comment_len = strlen(comment) + 1;
+
+			ptr = comment;
+			for (cpt = 0; cpt < comment_len; cpt++) {
+				if (fputc(*ptr, outfile) == EOF)
+					goto label_cannot_write_to_file;
+				calculated_header_crc = addbyte_crc32(calculated_header_crc,
+								*ptr);
+				ptr++;
+			}
+		}
+		if (header.flags & FLAGS_header_crc) {
+			calculated_header_crc &= 0xFFFF;
+			if (fputc(calculated_header_crc, outfile) == EOF
+				|| fputc(calculated_header_crc >> 8, outfile) == EOF)
+				goto label_cannot_write_to_file;
+			if (show_header_crc == 2)
+				printf("0x%X\n", header_crc);
+			else if (show_header_crc != 0)
+				printf(show_header_crc_msg, infilename, header_crc);
+			VERBOSE(new_header_crc, calculated_header_crc);
+		}
+
+		if (full_content == 0) {
+			for (;;) {
+				int tmp = fgetc(infile);
+
+				if (tmp == EOF) {
+					if (ferror(infile))
+						goto label_read_input_file_error;
+					break;
+				}
+				if (fputc(tmp, outfile) == EOF)
+					goto label_cannot_write_to_file;
+			}
+		} else {
+			if (fwrite(full_content, 1, full_length, outfile) != full_length)
+				goto label_cannot_write_to_file;
+		}
+	}
+
+      label_end:
+	if (extrafield != 0)
+		free(extrafield);
+	if (name != 0)
+		free(name);
+	if (comment != 0)
+		free(comment);
+
+	if (infile != NULL) {
+		if (fclose(infile) == EOF) {
+			PRINTERR(cannot_close_input_file, infilename);
+			returned = err_cannot_close_input_file;
+		}
+	}
+
+	if (outfile != NULL) {
+		if (fclose(outfile) == EOF) {
+			PRINTERR(cannot_close_output_file, outfilename);
+			returned = err_cannot_close_output_file;
+		}
+	}
+	return returned;
+
+      label_not_gzip_file:
+	PRINTERR(not_gzip_file, infilename, header.signature_0x8B1F);
+	returned = err_not_gzip_file;
+	goto label_end;
+
+      label_not_enough_memory:
+	PRINTERR(not_enough_memory);
+	returned = err_not_enough_memory;
+	goto label_end;
+
+      label_read_input_file_error:
+	PRINTERR(read_input_file_error, infilename);
+	returned = err_read_input_file_error;
+	goto label_end;
+
+      label_cannot_write_to_file:
+	PRINTERR(cannot_write_to_file, outfilename);
+	returned = err_cannot_write_to_file;
+	goto label_end;
+}
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13/scripts/gzparam.c linux-2.6.13-new/scripts/gzparam.c
--- linux-2.6.13/scripts/gzparam.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-new/scripts/gzparam.c	2005-08-30 23:04:58.000000000 +0100
@@ -0,0 +1,209 @@
+/*
+ * This file "gzparam.c" is licensed with the same license as the LINUX kernel.
+ * Copyright 2004, Etienne Lorrain (etienne dot lorrain at gujin dot org)
+ *
+ *  The main use of this file is to produce a "Gujin native bootable
+ * file" i.e. a LINUX kernel with a "kgz" extension, more exactly
+ * the option part which is going to be written in the comment field
+ * of the GZIP file (as documented in the GZIP format).
+ * See linux/Makefile to know how the following is used for target
+ * *.kgz - simply by using the "gzcopy" utility.
+ *
+ * This standalone executable named "gzparam" is just displaying a
+ * line containing zero or more field of the pattern
+ * "<variable>=0x<hexavalue>" (i.e. no decimal), to define for which
+ * CPU this kernel is for, which video mode can be used (for instance
+ * forbid VESA 1.0 graphic modes), where to load the kernel
+ * (default 0x100000 - other value needs kernel modifications but
+ * would free DMA memory), where to copy the Linux parameter 4 Kb page
+ * in real-mode memory and the like.
+ *
+ * Because most values depend on compilation switches of the
+ * Linux kernel - we have to use an up-to-date file reflecting
+ * the configuration options - but because we may cross compile
+ * the kernel we have here to use the host compiler (with maybe
+ * different optimisation options). The simpler seems to use
+ * the file "linux/include/linux/autoconf.h". This file is
+ * automagically updated by "make menuconfig".
+ *
+ * First version has been written by Etienne Lorrain in December 2004.
+ */
+
+#include <stdio.h>
+
+#include "../include/linux/autoconf.h"
+
+/*
+ *  Those are not used for now, Gujin will use its default behaviour
+ * because we do not display them on stdout:
+ */
+const unsigned runadr = 0, minram = 0, option = 0;
+
+/*
+ * Gujin-0.9 will not be able to load the kernel being generated,
+ * the first acceptable version is Gujin-1.0:
+ */
+const unsigned min_gujin_version = 0x102;
+
+/*
+ *  Keep for now the default of 0x80000 (linear address) for paramadr:
+ * it has to be a "free" real mode memory address, and if the user is using
+ * a DOS bootloader the bootloader code can be quite high in memory when
+ * using a lot of DOS drivers (like DOS USB disk drivers).
+ *  realfct_size is calculated on-line in Makefile, it is the size of
+ * the real-mode code output section of the vmlinux ELF file.
+ */
+const unsigned paramadr = 0 /* , realfct_size = 0 */ ;
+
+/*
+ * Since 2.6.13, this can be set up manually to free DMA-able memory,
+ * i.e. memory below 16 Mbytes. Also old PC may have a hole in between
+ * 15 and 16 Mbytes so starting the kernel at 16 Mbytes is better,
+ * as long as you have more than 16 Mbytes of memory...
+ * This PHYSICAL_START = 0x1000000 is only bootable with Gujin-1.2+
+ */
+#if defined (CONFIG_PHYSICAL_START) && CONFIG_PHYSICAL_START != 0x100000
+const unsigned loadadr = CONFIG_PHYSICAL_START;
+#endif
+
+/*
+ * Q: Why check the processor here (i.e. before even calling linux_set_params(),
+ *    we could check the processor and exit with an error code...) ?
+ * A: First the processor may not be an ia32 one (x86_64, ia64 or even
+ *    PowerPC) and the compilation of linux_set_params() may use ia32
+ *    instructions (MMX) not defined for the current processor used.
+ *    This mask shall say: do not even try to execute the first assembly
+ *    instruction of linux_set_params() if corresponding bit is set.
+ *    It may still be easier to refuse a CPU here (Pentium code on an i386)
+ */
+/* Please help checking and completing this array.
+   filed from www.sandpile.org CPUID.
+   The family of your processor is displayed at Gujin startup.
+   In case of problem, boot a bare DOS floppy and use "dbgload.exe" to
+   (try to) load a standard vmlinuz kernel - the file a:DBG will show
+   all usefull information.
+   If load fails, exit "dbgload.exe" by ^C and not by reboot to close
+   the DBG file.
+   If everything fails, you can also debug to a serial line or a printer. */
+const unsigned maskcpu = 0x80000000	/* refuse to start if no IA32 BIOS (not a PC) */
+	//| 0x40000000	/* refuse to start from DOS/windows */
+	//| 0x20000000	/* refuse to start from EMM386/virtual environment */
+	| (0x000180FF	/* bits used for precise CPU type compatibility */
+	// & ~(1 << 0)	/* can run on 8086 */
+	// & ~(1 << 1)	/* can run on 80186 */
+	// & ~(1 << 2)	/* can run on 80286 */
+#ifdef CONFIG_M386
+	& ~(1 << 3)	/* can run on 80386, i.e. cannot set AC i.e. bit 18 of flags */
+	& ~(1 << 4)	/* can run on 80486, i.e. CPUID family = 4 or no CPUID */
+	& ~(1 << 5)	/* can run on 80586, i.e. CPUID family == 5 */
+	& ~(1 << 6)	/* can run on 80686, i.e. CPUID family == 6 */
+	& ~(1 << 15)	/* can run on 80F86, i.e. CPUID family == (0xF + 0) extended_family */
+ /* HELPME: Is an IA64 compatible enough to boot a CONFIG_M386 kernel? I do not think so. */
+#elif defined (CONFIG_M486)
+	& ~(1 << 4)	/* can run on 80486, i.e. CPUID family = 4 or no CPUID */
+	& ~(1 << 5)	/* can run on 80586, i.e. CPUID family == 5 */
+	& ~(1 << 6)	/* can run on 80686, i.e. CPUID family == 6 */
+	& ~(1 << 15)	/* can run on 80F86, i.e. CPUID family == (0xF + 0) extended_family */
+#elif defined (CONFIG_M586) || defined (CONFIG_MK6) \
+	|| defined (CONFIG_MCRUSOE) || defined (CONFIG_MWINCHIPC6)
+	& ~(1 << 5)	/* can run on 80586, i.e. CPUID family == 5 */
+	& ~(1 << 6)	/* can run on 80686, i.e. CPUID family == 6 */
+	& ~(1 << 15)	/* can run on 80F86, i.e. CPUID family == (0xF + 0) extended_family */
+#elif defined (CONFIG_M686) || defined (CONFIG_MPENTIUMII) \
+	|| defined (CONFIG_MPENTIUMIII) || defined (CONFIG_MPENTIUMM) \
+	|| defined (CONFIG_MK7) || defined (CONFIG_MWINCHIP2) \
+	|| defined (CONFIG_MCYRIXIII) || defined (CONFIG_MVIAC3_2)
+	& ~(1 << 6)	/* can run on 80686, i.e. CPUID family == 6 */
+	& ~(1 << 15)	/* can run on 80F86, i.e. CPUID family == (0xF + 0) extended_family */
+#elif defined (CONFIG_MPENTIUM4) || defined (CONFIG_MK8)
+	& ~(1 << 15)	/* can run on 80F86, i.e. CPUID family == (0xF + 0) extended_family */
+#elif defined (CONFIG_IA64)
+	& ~(1 << 7)	/* can run on 80786, i.e. CPUID family == 7 */
+	& ~(1 << 16)	/* can run on 80?86, i.e. CPUID family == (0xF + 1) extended_family */
+#elif defined (CONFIG_IA64_2)
+	& ~(1 << 16)	/* can run on 80?86, i.e. CPUID family == (0xF + 1) extended_family */
+#endif
+	);
+
+/* Probably plenty of other checks to do here... see vmlinuz.h */
+const unsigned maskDflags = 0
+#ifndef CONFIG_MATH_EMULATION
+	| (1 << 0)
+#endif
+#ifdef CONFIG_M586TSC
+	| (1 << 4)
+#endif
+#ifdef CONFIG_X86_CMPXCHG
+	| (1 << 8)
+#endif
+#ifdef CONFIG_M586MMX
+	| (1 << 23)
+#endif
+	;
+const unsigned maskCflags = 0
+#ifdef CONFIG_X86_CMPXCHG16B
+	| (1 << 13)
+#endif
+	;
+
+/* unused on PCs: */
+const unsigned maskBflags = 0;
+
+/* AMD CPUID 0x80000001: */
+const unsigned maskAflags = 0
+#ifdef CONFIG_X86_64
+	| (1 << 29)
+#endif
+#ifdef CONFIG_X86_USE_3DNOW
+	| (1 << 31)
+#endif
+	;
+
+/*
+ * maskvesa and maskresolution are only checked when the loader has
+ * screen management compiled-in, i.e. not for tiny.img nor tiny.exe
+ * version of Gujin.
+ * Set them to zero to completely disable those check in Gujin.
+ */
+const unsigned maskvesa = 0
+#ifndef CONFIG_FB_VESA
+	| (1 << 0)	/* Cannot boot in MASKVESA_1BPP */
+	| (1 << 1)	/* Cannot boot in MASKVESA_2BPP */
+	| (1 << 3)	/* Cannot boot in MASKVESA_4BPP */
+	| (1 << 7)	/* Cannot boot in MASKVESA_8BPP */
+	| (1 << 14)	/* Cannot boot in MASKVESA_15BPP */
+	| (1 << 15)	/* Cannot boot in MASKVESA_16BPP */
+	| (1 << 23)	/* Cannot boot in MASKVESA_24BPP */
+	| (1 << 31)	/* Cannot boot in MASKVESA_32BPP */
+#endif
+#if defined (CONFIG_VGA_CONSOLE) || defined (CONFIG_MDA_CONSOLE)
+	| (1 << 16)	/* able to boot in text mode */
+#endif
+	// | (1 << 17)	/* not able to boot in VESA1 mode */
+#ifdef CONFIG_FB_VESA
+	| (1 << 18)	/* able to boot in VESA2 linear mode */
+#endif
+	// | (1 << 19)	/* force VESA1 if in VESA2 */
+	| (1 << 20)	/* Cannot handle VGA graphic modes */
+	;
+const unsigned maskresolution = 0
+	| (1 << 0)	/* exclude MASKRESOLUTION_40cols */
+	| (1 << 15)	/* exclude MASKRESOLUTION_320x200 */
+	| (1 << 16)	/* exclude MASKRESOLUTION_320x400 */
+	// | (1 << 31)	/* not listed invalid */
+	;
+
+int main (int argc, char **argv) {
+	printf ("min_gujin_version=0x%X maskcpu=0x%X ",
+		min_gujin_version, maskcpu);
+	if (maskDflags != 0)
+		printf ("maskDflags=0x%X ", maskDflags);
+	if (maskAflags != 0)
+		printf ("maskAflags=0x%X ", maskAflags);
+#if defined (CONFIG_PHYSICAL_START) && CONFIG_PHYSICAL_START != 0x100000
+	printf ("loadadr=0x%X ", loadadr);
+#endif
+	printf ("maskvesa=0x%X maskresolution=0x%X\n",
+		maskvesa, maskresolution);
+	return 0;
+	}
------=_20050901115310_96263--


