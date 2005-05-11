Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVEKNGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEKNGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 09:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEKNGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 09:06:44 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:2054 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261215AbVEKNGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 09:06:24 -0400
Date: Wed, 11 May 2005 15:06:04 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511150604.E7594@banaan.localdomain>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it> <20050510232207.A7594@banaan.localdomain> <20050511015509.B7594@banaan.localdomain> <1115770106.17201.21.camel@localhost.localdomain> <20050511031103.C7594@banaan.localdomain> <1115782753.17201.54.camel@localhost.localdomain> <20050511115955.D7594@banaan.localdomain> <1115808722.16408.3.camel@localhost.localdomain> <20050511105818.GB8761@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050511105818.GB8761@wonderland.linux.it>; from md@Linux.IT on Wed, May 11, 2005 at 12:58:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 12:58:18PM +0200, Marco d'Itri wrote:
> On May 11, Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > Then perhaps depmod should be the one to read a blacklist file?  It
> > produces the modules.alias file where these things live.
> I think this would be confusing for users.

Second that.  Modprobe remains smaller, but we would need some wrapper
around depmod to do the blacklisting, plus the user or packager that
adds an entry to the blacklist has to arrange for depmod to be redone
at the right time.  It's so much more convenient if depmod only has
to run at kernel install time.

Here's a second version of the patch, now based on 'blacklist' keyword.

The patch has shrunken from 126 insertions(+)
to 81 insertions(+), 17 deletions(-)

Testing: with blacklist via82cxxx_audio, 
	./modprobe -n -v 'pci:v00001106d00003059sv*sd*bc*sc*i*
gives only alsa, otherwise alsa plus oss.
	./modprobe -n -v via82cxxx_audio
gives oss, regardless of blacklisting.

The test suite complains here for 02proc.sh, both with and without the patch,
in tests/test-modprobe/02proc.sh.  Let me know if it's worthwhile to
dive into that.

Regards,
Erik


Signed-off-by: <ekonijn@xs4all.nl> Erik van Konijnenburg

--- module-init-tools-3.2-pre4/modprobe.c	2005-05-08 09:38:52.000000000 +0200
+++ module-init-tools-3.2-pre4-new/modprobe.c	2005-05-11 14:22:15.000000000 +0200
@@ -611,6 +611,12 @@
 	char *module;
 };
 
+struct module_blacklist
+{
+	struct module_blacklist *next;
+	char *modulename;
+};
+
 /* Link in a new option line from the config file. */
 static struct module_options *
 add_options(const char *modname,
@@ -657,6 +663,45 @@
 	return new;
 }
 
+/* Link in a new blacklist line from the config file. */
+static struct module_blacklist *
+add_blacklist(const char *modname, struct module_blacklist *blacklist)
+{
+	struct module_blacklist *new;
+
+	new = NOFAIL(malloc(sizeof(*new)));
+	new->modulename = NOFAIL(strdup(modname));
+	new->next = blacklist;
+	return new;
+}
+
+/* Find blacklist commands if any. */
+static  int
+find_blacklist(const char *modname, const struct module_blacklist *blacklist)
+{
+	while (blacklist) {
+		if (strcmp(blacklist->modulename, modname) == 0)
+			return 1;
+		blacklist = blacklist->next;
+	}
+	return 0;
+}
+
+/* return a new alias list, with backlisted elems filtered out */
+static struct module_alias *
+apply_blacklist(const struct module_alias *aliases,
+		const struct module_blacklist *blacklist)
+{
+	struct module_alias *result = NULL;
+	while (aliases) {
+		char *modname = aliases->module;
+		if (! find_blacklist (modname, blacklist))
+			result = add_alias (modname, result);
+		aliases = aliases->next;
+	}
+	return result;
+}
+
 /* Find install commands if any. */
 static const char *find_command(const char *modname,
 				const struct module_command *commands)
@@ -977,7 +1022,8 @@
 		       int removing,
 		       struct module_options **options,
 		       struct module_command **commands,
-		       struct module_alias **alias);
+		       struct module_alias **alias,
+		       struct module_blacklist **blacklist);
 
 /* FIXME: Maybe should be extended to "alias a b [and|or c]...". --RR */
 static int read_config_file(const char *filename,
@@ -986,7 +1032,8 @@
 			    int removing,
 			    struct module_options **options,
 			    struct module_command **commands,
-			    struct module_alias **aliases)
+			    struct module_alias **aliases,
+			    struct module_blacklist **blacklist)
 {
 	char *line;
 	unsigned int linenum = 0;
@@ -1027,7 +1074,8 @@
 			else {
 				if (!read_config(newfilename, name,
 						 dump_only, removing,
-						 options, commands, &newalias))
+						 options, commands, &newalias,
+						 blacklist))
 					warn("Failed to open included"
 					      " config file %s: %s\n",
 					      newfilename, strerror(errno));
@@ -1055,6 +1103,14 @@
 				*commands = add_command(underscores(modname),
 							ptr, *commands);
 			}
+		} else if (strcmp(cmd, "blacklist") == 0) {
+			modname = strsep_skipspace(&ptr, "\t ");
+			if (!modname)
+				grammar(cmd, filename, linenum);
+			else if (!removing) {
+				*blacklist = add_blacklist(underscores(modname),
+							*blacklist);
+			}
 		} else if (strcmp(cmd, "remove") == 0) {
 			modname = strsep_skipspace(&ptr, "\t ");
 			if (!modname || !ptr)
@@ -1081,7 +1137,8 @@
 		       int removing,
 		       struct module_options **options,
 		       struct module_command **commands,
-		       struct module_alias **aliases)
+		       struct module_alias **aliases,
+		       struct module_blacklist **blacklist)
 {
 	DIR *dir;
 
@@ -1097,8 +1154,8 @@
 
 				sprintf(sub, "%s/%s", filename, i->d_name);
 				if (!read_config(sub, name,
-						 dump_only, removing,
-						 options, commands, aliases))
+						 dump_only, removing, options,
+						 commands, aliases, blacklist))
 					warn("Failed to open"
 					      " config file %s: %s\n",
 					      sub, strerror(errno));
@@ -1109,7 +1166,7 @@
 	}
 
 	return read_config_file(filename, name, dump_only, removing,
-				options, commands, aliases);
+				options, commands, aliases, blacklist);
 }
 
 static const char *default_configs[] = 
@@ -1124,13 +1181,14 @@
 				 int removing,
 				 struct module_options **options,
 				 struct module_command **commands,
-				 struct module_alias **aliases)
+				 struct module_alias **aliases,
+				 struct module_blacklist **blacklist)
 {
 	unsigned int i;
 
 	if (filename) {
 		if (!read_config(filename, name, dump_only, removing,
-				 options, commands, aliases))
+				 options, commands, aliases, blacklist))
 			fatal("Failed to open config file %s: %s\n",
 			      filename, strerror(errno));
 		return;
@@ -1138,8 +1196,8 @@
 
 	/* Try defaults. */
 	for (i = 0; i < ARRAY_SIZE(default_configs); i++) {
-		if (read_config(default_configs[i], name, dump_only,
-				removing, options, commands, aliases))
+		if (read_config(default_configs[i], name, dump_only, removing,
+				options, commands, aliases, blacklist))
 			return;
 	}
 }
@@ -1457,13 +1515,14 @@
 		struct module_command *commands = NULL;
 		struct module_options *modoptions = NULL;
 		struct module_alias *aliases = NULL;
+		struct module_blacklist *blacklist = NULL;
 
 		read_toplevel_config(config, "", 1, 0,
-				     &modoptions, &commands, &aliases);
+			     &modoptions, &commands, &aliases, &blacklist);
 		read_config(aliasfilename, "", 1, 0,&modoptions, &commands,
-			    &aliases);
+			    &aliases, &blacklist);
 		read_config(symfilename, "", 1, 0, &modoptions, &commands,
-			    &aliases);
+			    &aliases, &blacklist);
 		exit(0);
 	}
 
@@ -1480,6 +1539,7 @@
 		struct module_command *commands = NULL;
 		struct module_options *modoptions = NULL;
 		struct module_alias *aliases = NULL;
+		struct module_blacklist *blacklist = NULL;
 		LIST_HEAD(list);
 		char *modulearg = argv[optind + i];
 
@@ -1488,13 +1548,14 @@
 
 		/* Returns the resolved alias, options */
 		read_toplevel_config(config, modulearg, 0,
-				     remove, &modoptions, &commands, &aliases);
+		     remove, &modoptions, &commands, &aliases, &blacklist);
 
 		/* No luck?  Try symbol names, if starts with symbol:. */
 		if (!aliases
 		    && strncmp(modulearg, "symbol:", strlen("symbol:")) == 0)
 			read_config(symfilename, modulearg, 0,
-				    remove, &modoptions, &commands, &aliases);
+			    remove, &modoptions, &commands,
+			    	&aliases, &blacklist);
 
 		if (!aliases) {
 			/* We only use canned aliases as last resort. */
@@ -1502,9 +1563,12 @@
 
 			if (list_empty(&list)
 			    && !find_command(modulearg, commands))
+			{
 				read_config(aliasfilename, modulearg, 0,
 					    remove, &modoptions, &commands,
-					    &aliases);
+					    &aliases, &blacklist);
+				aliases = apply_blacklist(aliases, blacklist);
+			}
 		}
 
 		if (aliases) {
