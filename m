Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVEIXVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEIXVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVEIXVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:21:34 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:23681 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261262AbVEIXVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:04 -0400
Date: Mon, 9 May 2005 16:21:03 -0700
From: Greg KH <gregkh@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux@dominikbrodowski.net
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050509232103.GA24238@suse.de>
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1115611034.14447.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2005 at 01:57:14PM +1000, Rusty Russell wrote:
> On Fri, 2005-05-06 at 14:22 -0700, Greg KH wrote:
> > Oh, and the upstream module-init-tools maintainer needs to accept that
> > patch one of these days...
> 
> ??

I've attached the original message sent to you and me below.

thanks,

greg k-h

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modprobe_load_all_aliases.mbox"

>From brodo@linta.de Fri Mar  4 13:16:17 2005
Return-Path: <brodo@linta.de>
Delivered-To: unknown
Received: from kroah.com ([216.218.225.136]) by kroah.com for <kroah@kroah.com>; Fri, 4 Mar 2005 13:09:32 -0800
Received: from linta.de ([213.239.214.66]) by kroah.com for <greg@kroah.com>; Fri, 4 Mar 2005 13:09:28 -0800
Received: (qmail 26925 invoked by uid 1000); 4 Mar 2005 21:09:27 -0000
Date: Fri, 4 Mar 2005 22:09:27 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: rusty@rustcorp.com.au, greg@kroah.com
Subject: [PATCH] module-init-tools - modprobe: load _all_ aliases instead of only one
Message-ID: <20050304210927.GA26896@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-SpamProbe: GOOD 0.0000021 44092103930514f517776d6bcb20e468
Status: RO
Content-Length: 7103
Lines: 241

This patch compiles, it seems to work for the purposes I use modprobe for 
locally, but please review it thoroughly.

Thanks,
	Dominik


hotplug-ng as well as pcmcia's hotplug agents require that "modprobe" called
with an alias string load _all_ modules instead of just one match. The
attached patch tries to implement it.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

--- module-init-tools-3.2-pre1/modprobe.c.original	2005-03-04 20:51:22.000000000 +0100
+++ module-init-tools-3.2-pre1/modprobe.c	2005-03-04 22:00:55.000000000 +0100
@@ -950,6 +950,21 @@
 	return strsep(string, delim);
 }
 
+struct alias_module {
+	struct alias_module *next;
+	char * name;
+};
+
+static int add_alias_module(char *name, struct alias_module **alias_module)
+{
+	struct alias_module *new = NOFAIL(malloc(sizeof(struct alias_module)));
+	new->next = *alias_module;
+	new->name = NOFAIL(strdup(name));
+	*alias_module = new;
+
+	return 0;
+}
+
 /* Recursion */
 static int read_config(const char *filename,
 		       const char *name,
@@ -957,7 +972,8 @@
 		       int removing,
 		       struct module_options **options,
 		       struct module_command **commands,
-		       char **alias);
+		       struct alias_module **alias);
+
 
 /* FIXME: Maybe should be extended to "alias a b [and|or c]...". --RR */
 static int read_config_file(const char *filename,
@@ -966,7 +982,7 @@
 			    int removing,
 			    struct module_options **options,
 			    struct module_command **commands,
-			    char **alias)
+			    struct alias_module **alias)
 {
 	char *line;
 	unsigned int linenum = 0;
@@ -996,9 +1012,9 @@
 			if (!wildcard || !realname)
 				grammar(cmd, filename, linenum);
 			else if (fnmatch(wildcard,name,0) == 0)
-				*alias = NOFAIL(strdup(realname));
+				add_alias_module(realname, alias);
 		} else if (strcmp(cmd, "include") == 0) {
-			char *newalias = NULL, *newfilename;
+			char *newfilename;
 
 			newfilename = strsep_skipspace(&ptr, "\t ");
 			if (!newfilename)
@@ -1006,15 +1022,10 @@
 			else {
 				if (!read_config(newfilename, name,
 						 dump_only, removing,
-						 options, commands, &newalias))
+						 options, commands, alias))
 					warn("Failed to open included"
 					      " config file %s: %s\n",
 					      newfilename, strerror(errno));
-
-				/* Files included override aliases,
-				   etc that was already set ... */
-				if (newalias)
-					*alias = newalias;
 			}
 		} else if (strcmp(cmd, "options") == 0) {
 			modname = strsep_skipspace(&ptr, "\t ");
@@ -1060,7 +1071,7 @@
 		       int removing,
 		       struct module_options **options,
 		       struct module_command **commands,
-		       char **alias)
+		       struct alias_module **alias)
 {
 	DIR *dir;
 
@@ -1103,7 +1114,7 @@
 				 int removing,
 				 struct module_options **options,
 				 struct module_command **commands,
-				 char **alias)
+				 struct alias_module **alias)
 {
 	unsigned int i;
 
@@ -1226,6 +1237,48 @@
 	return 0;
 }
 
+#define HANDLE_ONE_MODULE()						\
+	if (list_empty(&list)) {					\
+		/* The dependencies have to be real modules, but	\
+		   handle case where the first is completely bogus. */	\
+		command = find_command(modname, commands);		\
+		if (command && !ignore_commands) {			\
+			do_command(modname, command, verbose, dry_run,	\
+				   fatal, remove ? "remove":"install");	\
+			continue;					\
+		}							\
+		if (unknown_silent)					\
+			exit(1);					\
+		error("Module %s not found.\n", modname);		\
+		continue;						\
+	}								\
+									\
+	if (remove)							\
+		rmmod(&list, newname, first_time, error, dry_run,	\
+		      verbose, commands, ignore_commands, 0);		\
+	else								\
+		insmod(&list, NOFAIL(strdup(optstring)), newname,	\
+		       first_time, error, dry_run, verbose, modoptions,	\
+		       commands, ignore_commands, ignore_proc,		\
+		       strip_vermagic, strip_modversion);		\
+	free(modname);
+
+#define HANDLE_ALL_ALIASES()						\
+	while (alias_module) {						\
+		struct alias_module *next = alias_module->next;		\
+		char *modname = alias_module->name;			\
+									\
+		optstring = add_extra_options(modulearg, optstring,	\
+					      modoptions);		\
+		read_depends(dirname, modname, &list);			\
+									\
+		HANDLE_ONE_MODULE();					\
+									\
+		free(alias_module);					\
+		alias_module = next;					\
+	}
+
+
 int main(int argc, char *argv[])
 {
 	struct utsname buf;
@@ -1391,7 +1444,7 @@
 	if (dump_only) {
 		struct module_command *commands = NULL;
 		struct module_options *modoptions = NULL;
-		char *a = NULL;
+		struct alias_module *a = NULL;
 
 		read_toplevel_config(config, "", 1, 0,
 				     &modoptions, &commands, &a);
@@ -1415,27 +1468,26 @@
 		LIST_HEAD(list);
 		char *modulearg = argv[optind + i];
 		char *modname = NULL;
+		struct alias_module *alias_module = NULL;
 
 		/* Convert name we are looking for */
 		underscores(modulearg);
 
 		/* Returns the resolved alias, options */
 		read_toplevel_config(config, modulearg, 0,
-				     remove, &modoptions, &commands, &modname);
+				     remove, &modoptions, &commands, &alias_module);
 
 		/* No luck?  Try symbol names, if starts with symbol:. */
-		if (!modname
+		if (!alias_module
 		    && strncmp(modulearg, "symbol:", strlen("symbol:")) == 0)
 			read_config(symfilename, modulearg, 0,
-				    remove, &modoptions, &commands, &modname);
+				    remove, &modoptions, &commands, &alias_module);
 
-		/* If we have an alias, gather any options associated with it
+
+		/* If we have aliases, gather any options associated with it
 		   (needs to happen after parsing complete). */
-		if (modname) {
-		got_modname:
-			optstring = add_extra_options(modulearg, optstring,
-						      modoptions);
-			read_depends(dirname, modname, &list);
+		if (alias_module) {
+			HANDLE_ALL_ALIASES();
 		} else {
 			read_depends(dirname, modulearg, &list);
 			/* We don't allow canned aliases to override
@@ -1446,37 +1498,14 @@
 			    && read_config(aliasfilename,
 					   modulearg, 0,
 					   remove, &modoptions,
-					   &commands, &modname)
-			    && modname)
-				goto got_modname;
-
-			modname = strdup(modulearg);
-		}
-
-		if (list_empty(&list)) {
-			/* The dependencies have to be real modules, but
-			   handle case where the first is completely bogus. */
-			command = find_command(modname, commands);
-			if (command && !ignore_commands) {
-				do_command(modname, command, verbose, dry_run,
-					   fatal, remove ? "remove":"install");
-				continue;
+					   &commands, &alias_module)
+			    && alias_module) {
+				HANDLE_ALL_ALIASES();
+			} else {
+				modname = strdup(modulearg);
+				HANDLE_ONE_MODULE();
 			}
-			if (unknown_silent)
-				exit(1);
-			error("Module %s not found.\n", modname);
-			continue;
 		}
-
-		if (remove)
-			rmmod(&list, newname, first_time, error, dry_run,
-			      verbose, commands, ignore_commands, 0);
-		else
-			insmod(&list, NOFAIL(strdup(optstring)), newname,
-			       first_time, error, dry_run, verbose, modoptions,
-			       commands, ignore_commands, ignore_proc,
-			       strip_vermagic, strip_modversion);
-		free(modname);
 	}
 
 	free(dirname);


--huq684BweRXVnRxX--
