Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVFUL34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVFUL34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFUL3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:29:03 -0400
Received: from [85.8.12.41] ([85.8.12.41]:4792 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261193AbVFULRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:17:53 -0400
Message-ID: <42B7F740.6000807@drzeus.cx>
Date: Tue, 21 Jun 2005 13:17:20 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-17888-1119352672-0001-2"
To: zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Pointer cast warnings in scripts/
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-17888-1119352672-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

GCC 4 checks the signedness of pointer casts and generates a whole bunch
of warnings for code in scripts/ (which makes heavy use of signed char
strings).

This patch adds explicit casts.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-17888-1119352672-0001-2
Content-Type: text/x-patch; name="signed-char-warnings.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="signed-char-warnings.patch"

Index: linux-wbsd/scripts/basic/fixdep.c
===================================================================
--- linux-wbsd/scripts/basic/fixdep.c	(revision 134)
+++ linux-wbsd/scripts/basic/fixdep.c	(working copy)
@@ -242,7 +242,7 @@
 		continue;
 
 	found:
-		use_config(p+7, q-p-7);
+		use_config((char*)p+7, q-p-7);
 	}
 }
 
@@ -296,7 +296,7 @@
 	signed char *p;
 	char s[PATH_MAX];
 
-	p = strchr(m, ':');
+	p = (signed char*)strchr((char*)m, ':');
 	if (!p) {
 		fprintf(stderr, "fixdep: parse error\n");
 		exit(1);
Index: linux-wbsd/scripts/basic/docproc.c
===================================================================
--- linux-wbsd/scripts/basic/docproc.c	(revision 134)
+++ linux-wbsd/scripts/basic/docproc.c	(working copy)
@@ -181,8 +181,8 @@
 		while(fgets(line, MAXLINESZ, fp)) {
 			signed char *p;
 			signed char *e;
-			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
-                            ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
+			if (((p = (signed char*)strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
+                            ((p = (signed char*)strstr(line, "EXPORT_SYMBOL")) != 0)) {
 				/* Skip EXPORT_SYMBOL{_GPL} */
 				while (isalnum(*p) || *p == '_')
 					p++;
@@ -199,7 +199,7 @@
 				while (isalnum(*e) || *e == '_')
 					e++;
 				*e = '\0';
-				add_new_symbol(sym, p);
+				add_new_symbol(sym, (char*)p);
 			}
 		}
 		fclose(fp);
@@ -271,7 +271,7 @@
                 if (startofsym) {
                         startofsym = 0;
                         vec[idx++] = FUNCTION;
-                        vec[idx++] = &line[i];
+                        vec[idx++] = (char*)&line[i];
                 }
         }
 	vec[idx++] = filename;
@@ -293,7 +293,7 @@
 	signed char * s;
 	while(fgets(line, MAXLINESZ, infile)) {
 		if (line[0] == '!') {
-			s = line + 2;
+			s = (signed char*)(line + 2);
 			switch (line[1]) {
 				case 'E':
 					while (*s && !isspace(*s)) s++;
Index: linux-wbsd/scripts/basic/split-include.c
===================================================================
--- linux-wbsd/scripts/basic/split-include.c	(revision 134)
+++ linux-wbsd/scripts/basic/split-include.c	(working copy)
@@ -110,7 +110,7 @@
 
 	if (line[0] != '#')
 	    continue;
-	if ((str_config = strstr(line, "CONFIG_")) == NULL)
+	if ((str_config = (signed char*)strstr(line, "CONFIG_")) == NULL)
 	    continue;
 
 	/* Make the output file name. */
Index: linux-wbsd/scripts/kconfig/mconf.c
===================================================================
--- linux-wbsd/scripts/kconfig/mconf.c	(revision 153)
+++ linux-wbsd/scripts/kconfig/mconf.c	(working copy)
@@ -334,9 +334,9 @@
 	int res;
 
 	if (!*argptr)
-		*argptr = bufptr;
+		*argptr = (char*)bufptr;
 	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
+	res = vsprintf((char*)bufptr, fmt, ap);
 	va_end(ap);
 	bufptr += res;
 
@@ -354,9 +354,9 @@
 	va_list ap;
 	int res;
 
-	*argptr++ = bufptr;
+	*argptr++ = (char*)bufptr;
 	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
+	res = vsprintf((char*)bufptr, fmt, ap);
 	va_end(ap);
 	bufptr += res;
 	*bufptr++ = 0;
@@ -547,7 +547,7 @@
 		return;
 	}
 
-	sym_arr = sym_re_search(input_buf);
+	sym_arr = sym_re_search((char*)input_buf);
 	res = get_relations_str(sym_arr);
 	free(sym_arr);
 	show_textbox(_("Search Results"), str_get(&res), 0, 0);
@@ -758,11 +758,11 @@
 		if (i >= sizeof(active_entry))
 			i = sizeof(active_entry) - 1;
 		input_buf[i] = 0;
-		strcpy(active_entry, input_buf);
+		strcpy(active_entry, (char*)input_buf);
 
 		sym = NULL;
 		submenu = NULL;
-		if (sscanf(input_buf + 1, "%p", &submenu) == 1)
+		if (sscanf((char*)(input_buf + 1), "%p", &submenu) == 1)
 			sym = submenu->sym;
 
 		switch (stat) {
@@ -912,12 +912,12 @@
 		stat = exec_conf();
 		switch (stat) {
 		case 0:
-			if (sscanf(input_buf, "%p", &child) != 1)
+			if (sscanf((char*)input_buf, "%p", &child) != 1)
 				break;
 			sym_set_tristate_value(child->sym, yes);
 			return;
 		case 1:
-			if (sscanf(input_buf, "%p", &child) == 1) {
+			if (sscanf((char*)input_buf, "%p", &child) == 1) {
 				show_help(child);
 				active = child->sym;
 			} else
@@ -958,7 +958,7 @@
 		stat = exec_conf();
 		switch (stat) {
 		case 0:
-			if (sym_set_string_value(menu->sym, input_buf))
+			if (sym_set_string_value(menu->sym, (char*)input_buf))
 				return;
 			show_textbox(NULL, _("You have made an invalid entry."), 5, 43);
 			break;
@@ -987,7 +987,7 @@
 		case 0:
 			if (!input_buf[0])
 				return;
-			if (!conf_read(input_buf))
+			if (!conf_read((char*)input_buf))
 				return;
 			show_textbox(NULL, _("File does not exist!"), 5, 38);
 			break;
@@ -1016,7 +1016,7 @@
 		case 0:
 			if (!input_buf[0])
 				return;
-			if (!conf_write(input_buf))
+			if (!conf_write((char*)input_buf))
 				return;
 			show_textbox(NULL, _("Can't create file!  Probably a nonexistent directory."), 5, 60);
 			break;
Index: linux-wbsd/scripts/kconfig/confdata.c
===================================================================
--- linux-wbsd/scripts/kconfig/confdata.c	(revision 153)
+++ linux-wbsd/scripts/kconfig/confdata.c	(working copy)
@@ -36,8 +36,8 @@
 
 	res_value[0] = 0;
 	dst = name;
-	while ((src = strchr(in, '$'))) {
-		strncat(res_value, in, src - in);
+	while ((src = (const signed char*)strchr((const char*)in, '$'))) {
+		strncat(res_value, (const char*)in, src - in);
 		src++;
 		dst = name;
 		while (isalnum(*src) || *src == '_')
@@ -48,7 +48,7 @@
 		strcat(res_value, sym_get_string_value(sym));
 		in = src;
 	}
-	strcat(res_value, in);
+	strcat(res_value, (const char*)in);
 
 	return res_value;
 }
@@ -59,7 +59,7 @@
 	static char fullname[PATH_MAX+1];
 	char *env, *name;
 
-	name = conf_expand_value(conf_defname);
+	name = conf_expand_value((const signed char*)conf_defname);
 	env = getenv(SRCTREE);
 	if (env) {
 		sprintf(fullname, "%s/%s", env, name);
@@ -85,7 +85,7 @@
 	} else {
 		const char **names = conf_confnames;
 		while ((name = *names++)) {
-			name = conf_expand_value(name);
+			name = conf_expand_value((const signed char*)name);
 			in = zconf_fopen(name);
 			if (in) {
 				printf(_("#\n"
Index: linux-wbsd/scripts/kconfig/conf.c
===================================================================
--- linux-wbsd/scripts/kconfig/conf.c	(revision 153)
+++ linux-wbsd/scripts/kconfig/conf.c	(working copy)
@@ -43,7 +43,7 @@
 
 	while ((isspace(*p)))
 		p++;
-	l = strlen(p);
+	l = strlen((char*)p);
 	if (p != str)
 		memmove(str, p, l + 1);
 	if (!l)
@@ -91,7 +91,7 @@
 		check_stdin();
 	case ask_all:
 		fflush(stdout);
-		fgets(line, 128, stdin);
+		fgets((char*)line, 128, stdin);
 		return;
 	case set_default:
 		printf("%s\n", def);
@@ -184,8 +184,8 @@
 				break;
 			}
 		default:
-			line[strlen(line)-1] = 0;
-			def = line;
+			line[strlen((char*)line)-1] = 0;
+			def = (char*)line;
 		}
 		if (def && sym_set_string_value(sym, def))
 			return 0;
@@ -233,7 +233,7 @@
 		case 'n':
 		case 'N':
 			newval = no;
-			if (!line[1] || !strcmp(&line[1], "o"))
+			if (!line[1] || !strcmp((char*)&line[1], "o"))
 				break;
 			continue;
 		case 'm':
@@ -245,7 +245,7 @@
 		case 'y':
 		case 'Y':
 			newval = yes;
-			if (!line[1] || !strcmp(&line[1], "es"))
+			if (!line[1] || !strcmp((char*)&line[1], "es"))
 				break;
 			continue;
 		case 0:
@@ -347,7 +347,7 @@
 			check_stdin();
 		case ask_all:
 			fflush(stdout);
-			fgets(line, 128, stdin);
+			fgets((char*)line, 128, stdin);
 			strip(line);
 			if (line[0] == '?') {
 				printf("\n%s\n", menu->sym->help ?
@@ -357,7 +357,7 @@
 			if (!line[0])
 				cnt = def;
 			else if (isdigit(line[0]))
-				cnt = atoi(line);
+				cnt = atoi((char*)line);
 			else
 				continue;
 			break;
@@ -381,7 +381,7 @@
 		}
 		if (!child)
 			continue;
-		if (line[strlen(line) - 1] == '?') {
+		if (line[strlen((char*)line) - 1] == '?') {
 			printf("\n%s\n", child->sym->help ?
 				child->sym->help : nohelp_text);
 			continue;

--=_hermes.drzeus.cx-17888-1119352672-0001-2--
