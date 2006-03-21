Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWCUQ1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWCUQ1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWCUQVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:19 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25100 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932395AbWCUQVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:10 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 02/46] kbuild: use warn()/fatal() consistent in modpost
In-Reply-To: <1142958054202-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <11429580542142-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modpost.c provides warn() and fatal() - so use them all over the place.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/file2alias.c |   13 ++++++-------
 scripts/mod/modpost.c    |   16 ++++++----------
 scripts/mod/modpost.h    |    7 ++++++-
 scripts/mod/sumversion.c |   23 +++++++++--------------
 4 files changed, 27 insertions(+), 32 deletions(-)

cb80514d9c517cc1d101ef304529a0e9b76b4468
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index be97caf..1346223 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -153,8 +153,8 @@ static void do_usb_table(void *symval, u
 	const unsigned long id_size = sizeof(struct usb_device_id);
 
 	if (size % id_size || size < id_size) {
-		fprintf(stderr, "*** Warning: %s ids %lu bad size "
-			"(each on %lu)\n", mod->name, size, id_size);
+		warn("%s ids %lu bad size "
+		     "(each on %lu)\n", mod->name, size, id_size);
 	}
 	/* Leave last one: it's the terminator. */
 	size -= id_size;
@@ -217,9 +217,8 @@ static int do_pci_entry(const char *file
 	if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
 	    || (subclass_mask != 0 && subclass_mask != 0xFF)
 	    || (interface_mask != 0 && interface_mask != 0xFF)) {
-		fprintf(stderr,
-			"*** Warning: Can't handle masks in %s:%04X\n",
-			filename, id->class_mask);
+		warn("Can't handle masks in %s:%04X\n",
+		     filename, id->class_mask);
 		return 0;
 	}
 
@@ -445,8 +444,8 @@ static void do_table(void *symval, unsig
 	int (*do_entry)(const char *, void *entry, char *alias) = function;
 
 	if (size % id_size || size < id_size) {
-		fprintf(stderr, "*** Warning: %s ids %lu bad size "
-			"(each on %lu)\n", mod->name, size, id_size);
+		warn("%s ids %lu bad size "
+		     "(each on %lu)\n", mod->name, size, id_size);
 	}
 	/* Leave last one: it's the terminator. */
 	size -= id_size;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f70ff13..a3c57ec 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -303,8 +303,7 @@ parse_elf(struct elf_info *info, const c
 			             sechdrs[sechdrs[i].sh_link].sh_offset;
 	}
 	if (!info->symtab_start) {
-		fprintf(stderr, "modpost: %s no symtab?\n", filename);
-		abort();
+		fatal("%s has no symtab?\n", filename);
 	}
 	/* Fix endianness in symbols */
 	for (sym = info->symtab_start; sym < info->symtab_stop; sym++) {
@@ -316,8 +315,7 @@ parse_elf(struct elf_info *info, const c
 	return;
 
  truncated:
-	fprintf(stderr, "modpost: %s is truncated.\n", filename);
-	abort();
+	fatal("%s is truncated.\n", filename);
 }
 
 void
@@ -337,8 +335,7 @@ handle_modversions(struct module *mod, s
 
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
-		fprintf(stderr, "*** Warning: \"%s\" [%s] is COMMON symbol\n",
-			symname, mod->name);
+		warn("\"%s\" [%s] is COMMON symbol\n", symname, mod->name);
 		break;
 	case SHN_ABS:
 		/* CRC'd symbol */
@@ -562,8 +559,8 @@ add_versions(struct buffer *b, struct mo
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
 			if (have_vmlinux && !s->weak)
-				fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
-				"undefined!\n",	s->name, mod->name);
+				warn("\"%s\" [%s.ko] undefined!\n",
+				     s->name, mod->name);
 			continue;
 		}
 		s->module = exp->module;
@@ -584,8 +581,7 @@ add_versions(struct buffer *b, struct mo
 			continue;
 		}
 		if (!s->crc_valid) {
-			fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
-				"has no CRC!\n",
+			warn("\"%s\" [%s.ko] has no CRC!\n",
 				s->name, mod->name);
 			continue;
 		}
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 7334d83..c0de7b9 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -91,17 +91,22 @@ struct elf_info {
 	unsigned int modinfo_len;
 };
 
+/* file2alias.c */
 void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname);
-
 void add_moddevtable(struct buffer *buf, struct module *mod);
 
+/* sumversion.c */
 void maybe_frob_rcs_version(const char *modfilename,
 			    char *version,
 			    void *modinfo,
 			    unsigned long modinfo_offset);
 void get_src_version(const char *modname, char sum[], unsigned sumlen);
 
+/* from modpost.c */
 void *grab_file(const char *filename, unsigned long *size);
 char* get_next_line(unsigned long *pos, void *file, unsigned long size);
 void release_file(void *file, unsigned long size);
+
+void fatal(const char *fmt, ...);
+void warn(const char *fmt, ...);
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 43271a1..5c07545 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -316,8 +316,7 @@ static int parse_source_files(const char
 
 	file = grab_file(cmd, &flen);
 	if (!file) {
-		fprintf(stderr, "Warning: could not find %s for %s\n",
-			cmd, objfile);
+		warn("could not find %s for %s\n", cmd, objfile);
 		goto out;
 	}
 
@@ -355,9 +354,8 @@ static int parse_source_files(const char
 		/* Check if this file is in same dir as objfile */
 		if ((strstr(line, dir)+strlen(dir)-1) == strrchr(line, '/')) {
 			if (!parse_file(line, md)) {
-				fprintf(stderr,
-					"Warning: could not open %s: %s\n",
-					line, strerror(errno));
+				warn("could not open %s: %s\n",
+				     line, strerror(errno));
 				goto out_file;
 			}
 
@@ -397,23 +395,20 @@ void get_src_version(const char *modname
 
 	file = grab_file(filelist, &len);
 	if (!file) {
-		fprintf(stderr, "Warning: could not find versions for %s\n",
-			filelist);
+		warn("could not find versions for %s\n", filelist);
 		return;
 	}
 
 	sources = strchr(file, '\n');
 	if (!sources) {
-		fprintf(stderr, "Warning: malformed versions file for %s\n",
-			modname);
+		warn("malformed versions file for %s\n", modname);
 		goto release;
 	}
 
 	sources++;
 	end = strchr(sources, '\n');
 	if (!end) {
-		fprintf(stderr, "Warning: bad ending versions file for %s\n",
-			modname);
+		warn("bad ending versions file for %s\n", modname);
 		goto release;
 	}
 	*end = '\0';
@@ -438,19 +433,19 @@ static void write_version(const char *fi
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
-		fprintf(stderr, "Warning: changing sum in %s failed: %s\n",
+		warn("changing sum in %s failed: %s\n",
 			filename, strerror(errno));
 		return;
 	}
 
 	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
-		fprintf(stderr, "Warning: changing sum in %s:%lu failed: %s\n",
+		warn("changing sum in %s:%lu failed: %s\n",
 			filename, offset, strerror(errno));
 		goto out;
 	}
 
 	if (write(fd, sum, strlen(sum)+1) != strlen(sum)+1) {
-		fprintf(stderr, "Warning: writing sum in %s failed: %s\n",
+		warn("writing sum in %s failed: %s\n",
 			filename, strerror(errno));
 		goto out;
 	}
-- 
1.0.GIT


