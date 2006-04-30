Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWD3OSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWD3OSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWD3OS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:18:28 -0400
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]:23448
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1751135AbWD3OSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:18:01 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/7] uml: search from uml_net in a more reasonable PATH
Date: Sun, 30 Apr 2006 16:16:11 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060430141611.9060.59508.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattia Dongili <malattia@linux.it>

Append /usr/lib/uml to the existing PATH environment variable to let
execvp() search uml_net in FHS compliant locations.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/main.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 2878e89..02cf668 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -74,6 +74,33 @@ static void last_ditch_exit(int sig)
 	exit(1);
 }
 
+#define UML_LIB_PATH	":/usr/lib/uml"
+
+static void setup_env_path(void) {
+	char *new_path = NULL;
+	char *old_path = NULL;
+	int path_len = 0;
+
+	old_path = getenv("PATH");
+	/* if no PATH variable is set or it has an empty value
+	 * just use the default + /usr/lib/uml
+	 */
+	if (!old_path || (path_len = strlen(old_path)) == 0) {
+		putenv("PATH=:/bin:/usr/bin/" UML_LIB_PATH);
+		return;
+	}
+
+	/* append /usr/lib/uml to the existing path */
+	path_len += strlen("PATH=" UML_LIB_PATH) + 1;
+	new_path = malloc(path_len);
+	if (!new_path) {
+		perror("coudn't malloc to set a new PATH");
+		return;
+	}
+	snprintf(new_path, path_len, "PATH=%s" UML_LIB_PATH, old_path);
+	putenv(new_path);
+}
+
 extern int uml_exitcode;
 
 extern void scan_elf_aux( char **envp);
@@ -114,6 +141,8 @@ int main(int argc, char **argv, char **e
 
 	set_stklim();
 
+	setup_env_path();
+
 	new_argv = malloc((argc + 1) * sizeof(char *));
 	if(new_argv == NULL){
 		perror("Mallocing argv");
