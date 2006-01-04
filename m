Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWADWCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWADWCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWADWCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:02:40 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:37623 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932080AbWADWCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:02:09 -0500
Date: Wed, 04 Jan 2006 17:01:49 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 15/15] kconf: Check for eof from input stream.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL003ZI97GCY@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 scripts/kconfig/conf.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

62bb36dcb307ca53999a14f74da6a803e36d5f62
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 8ba5d29..10eeae5 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -63,6 +63,20 @@ static void check_stdin(void)
 	}
 }
 
+static char *fgets_check_stream(char *s, int size, FILE *stream)
+{
+	char *ret = fgets(s, size, stream);
+
+	if (ret == NULL && feof(stream)) {
+		printf(_("aborted!\n\n"));
+		printf(_("Console input is closed. "));
+		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
+		exit(1);
+	}
+
+	return ret;
+}
+
 static void conf_askvalue(struct symbol *sym, const char *def)
 {
 	enum symbol_type type = sym_get_type(sym);
@@ -100,7 +114,7 @@ static void conf_askvalue(struct symbol 
 		check_stdin();
 	case ask_all:
 		fflush(stdout);
-		fgets(line, 128, stdin);
+		fgets_check_stream(line, 128, stdin);
 		return;
 	case set_default:
 		printf("%s\n", def);
@@ -356,7 +370,7 @@ static int conf_choice(struct menu *menu
 			check_stdin();
 		case ask_all:
 			fflush(stdout);
-			fgets(line, 128, stdin);
+			fgets_check_stream(line, 128, stdin);
 			strip(line);
 			if (line[0] == '?') {
 				printf("\n%s\n", menu->sym->help ?
-- 
1.0.5
