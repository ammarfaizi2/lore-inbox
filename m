Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUBPNum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265587AbUBPNto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:49:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:18641 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265535AbUBPNq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:46:29 -0500
X-Authenticated: #20799612
Date: Mon, 16 Feb 2004 14:34:18 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: linux-kernel@vger.kernel.org
Cc: hjlipp@web.de
Subject: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040216133418.GA4399@hobbes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In a newsgroup about unix shells we had a discussion, why it is not
possible to pass more than one argument to an interpreter using the
shebang line of a script. We found, that this behaviour is rather
OS dependent. See Sven Mascheck's page for details:
  http://www.in-ulm.de/~mascheck/various/shebang/

As I'm really missing this feature in Linux and changing this would not
break anything (unless someone uses rather unportable "#!cmd x y" to
pass _one_ argument "x y" containing spaces), I'd like to know if it's
possible to apply the patch below to the kernel.

It also allows to pass whitespace by using '\' as escape character:
  "\t" => TAB
  "\n" => LF
  "\ " => SPC
  "\\" => backslash
All other backslashes are discarded.

This allows something like
  #!/usr/bin/awk -F \t -f

This part could break old scripts if the interpreter's path/filename or
the arguments contain backslashes. Although I don't consider this a real
problem, this feature can be deactivated by removing the
  if (c=='\\') { ... }
part from the patch.

Another change: -ENOEXEC is returned, if the shebang line is too long.
So, excessive characters are not dropped silently any more.

The patch is tested for 2.6.1, but also applies cleanly to 2.6.2. I can
also send a tested patch for 2.4.24.

[ CC me on replies, please, as I'm not subscribed. ]

Kind regards
	Hansjoerg Lipp

--- linux-2.6.1/fs/binfmt_script.c.orig	2004-02-06 22:21:30.000000000 +0100
+++ linux-2.6.1/fs/binfmt_script.c	2004-02-06 22:21:30.000000000 +0100
@@ -18,10 +18,16 @@
 
 static int load_script(struct linux_binprm *bprm,struct pt_regs *regs)
 {
-	char *cp, *i_name, *i_arg;
+	char *cp;
 	struct file *file;
 	char interp[BINPRM_BUF_SIZE];
 	int retval;
+	char *argv[(BINPRM_BUF_SIZE-1)/2];
+	char **cur_arg;
+	unsigned argc;
+	int in_arg;
+	char *end, *dest;
+	char c;
 
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!') || (bprm->sh_bang)) 
 		return -ENOEXEC;
@@ -35,51 +41,47 @@
 	fput(bprm->file);
 	bprm->file = NULL;
 
-	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
-	if ((cp = strchr(bprm->buf, '\n')) == NULL)
-		cp = bprm->buf+BINPRM_BUF_SIZE-1;
-	*cp = '\0';
-	while (cp > bprm->buf) {
-		cp--;
-		if ((*cp == ' ') || (*cp == '\t'))
-			*cp = '\0';
-		else
-			break;
+	in_arg=0;
+	cur_arg=argv;
+	argc=0;
+	dest=bprm->buf+2;
+	end=bprm->buf+BINPRM_BUF_SIZE;
+	for (cp=bprm->buf+2;cp<end;++cp) {
+		c=*cp;
+		if (c==' '|| c=='\t' || c=='\n' || !c) {
+			if (in_arg) {
+				in_arg=0;
+				*dest++=0;
+			}
+			if (c=='\n' || !c) break;
+		} else {
+			if (c=='\\') {
+				if (++cp>=end) return -ENOEXEC;
+				c=*cp;
+				if (c=='\n' || !c) return -ENOEXEC;
+				if (c=='t')
+					c='\t';
+				else if (c=='n')
+					c='\n';
+			}
+			if (!in_arg) {
+				in_arg=1;
+				argc++;
+				*cur_arg++=dest;
+			}
+			*dest++=c;
+		}
 	}
-	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
-	if (*cp == '\0') 
-		return -ENOEXEC; /* No interpreter name found */
-	i_name = cp;
-	i_arg = 0;
-	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
-		/* nothing */ ;
-	while ((*cp == ' ') || (*cp == '\t'))
-		*cp++ = '\0';
-	if (*cp)
-		i_arg = cp;
-	strcpy (interp, i_name);
-	/*
-	 * OK, we've parsed out the interpreter name and
-	 * (optional) argument.
-	 * Splice in (1) the interpreter's name for argv[0]
-	 *           (2) (optional) argument to interpreter
-	 *           (3) filename of shell script (replace argv[0])
-	 *
-	 * This is done in reverse order, because of how the
-	 * user environment and arguments are stored.
-	 */
+	if (cp>=end||!argc) return -ENOEXEC;
+
+	strcpy (interp, argv[0]);
 	remove_arg_zero(bprm);
 	retval = copy_strings_kernel(1, &bprm->interp, bprm);
-	if (retval < 0) return retval; 
-	bprm->argc++;
-	if (i_arg) {
-		retval = copy_strings_kernel(1, &i_arg, bprm);
-		if (retval < 0) return retval; 
-		bprm->argc++;
-	}
-	retval = copy_strings_kernel(1, &i_name, bprm);
-	if (retval) return retval; 
+	if (retval < 0) return retval;
 	bprm->argc++;
+	retval = copy_strings_kernel(argc, argv, bprm);
+	if (retval < 0) return retval;
+	bprm->argc += argc;
 	bprm->interp = interp;
 
 	/*

