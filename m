Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVEJX4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVEJX4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 19:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVEJX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 19:56:04 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:30471 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S261808AbVEJXzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:55:35 -0400
Date: Wed, 11 May 2005 01:55:09 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
Subject: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511015509.B7594@banaan.localdomain>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
References: <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it> <20050510232207.A7594@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050510232207.A7594@banaan.localdomain>; from ekonijn@xs4all.nl on Tue, May 10, 2005 at 11:22:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch against module-init-tools-3.2-pre4 to ignore modules
listed in /etc/hotplug/blacklist or blacklist.d (recursively).

* blacklist is only effective during adding,
  not during remove or match with -a,
  and not for modules required to resolve a dependency.
* tested only with -n, -v and --showdeps, not in live use.
* in particular, no testing for interaction with /etc/init.d scripts
* Roman, I'm not sure how this meshes with your patch to pass $MODNAME
  from the driver to hotplug, discussed in:
  http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=110994425816837
  Perhaps you could have a look at it?

Regards,
Erik

Signed-off-by: Erik van Konijnenburg <ekonijn@xs4all.nl>

diff -urN module-init-tools-3.2-pre4/modprobe.c module-init-tools-3.2-pre4-new/modprobe.c
--- module-init-tools-3.2-pre4/modprobe.c	2005-05-08 09:38:52.000000000 +0200
+++ module-init-tools-3.2-pre4-new/modprobe.c	2005-05-11 01:14:16.000000000 +0200
@@ -1291,6 +1291,123 @@
 	return 0;
 }
 
+
+struct blacklist
+{
+	struct blacklist *next;
+	char *module;
+};
+
+/* Link in a blacklist line */
+static struct blacklist *
+add_blacklist (const char *modname, struct blacklist *blacklist)
+{
+	struct blacklist *new;
+
+	new = NOFAIL(malloc(sizeof(*new)));
+	new->module = NOFAIL(strdup(modname));
+	new->next = blacklist;
+	return new;
+}
+
+/* add stuff from file to list, return false on error */
+static int
+read_blacklist_file (const char *filename, struct blacklist **blacklist)
+{
+	char *line;
+	unsigned int linenum = 0;
+	FILE *cfile;
+
+	cfile = fopen(filename, "r");
+	if (!cfile)
+		return 0;
+
+	while ((line = getline_wrapped(cfile, &linenum)) != NULL) {
+		char *ptr = line;
+		char *modname;
+
+		modname = strsep_skipspace(&ptr, "\t ");
+		if (modname == NULL || modname[0] == '#' || modname[0] == '\0')
+			continue;
+
+		*blacklist = add_blacklist(modname, *blacklist);
+		free(line);
+	}
+	fclose(cfile);
+	return 1;
+}
+
+/* add stuff from file or dir to list, return false on error */
+static int
+read_blacklist (const char *filename, struct blacklist **blacklist)
+{
+	DIR *dir;
+
+	/* If it's a directory, recurse. */
+	dir = opendir(filename);
+	if (dir) {
+		struct dirent *i;
+
+		/* FIXME: don't we want .rpmnew protection? */
+		while ((i = readdir(dir)) != NULL) {
+			if (!streq(i->d_name,".") && !streq(i->d_name,"..")) {
+				char sub[strlen(filename) + 1
+					 + strlen(i->d_name) + 1];
+
+				sprintf(sub, "%s/%s", filename, i->d_name);
+				if (!read_blacklist(sub, blacklist))
+					warn("Failed to open"
+					      " blacklist file %s: %s\n",
+					      sub, strerror(errno));
+			}
+		}
+		closedir(dir);
+		return 1;
+	}
+
+	return read_blacklist_file(filename, blacklist);
+}
+
+static const char *default_blacklists[] = 
+{
+	"/etc/hotplug/blacklist",
+	"/etc/hotplug/blacklist.d",
+};
+
+static void
+read_toplevel_blacklist(const char *filename, struct blacklist **blacklist)
+{
+	unsigned int i;
+
+	if (filename) {
+		if (!read_blacklist(filename, blacklist))
+			fatal("Failed to open blacklist file %s: %s\n",
+			      filename, strerror(errno));
+		return;
+	}
+
+	/* Try defaults. */
+	for (i = 0; i < ARRAY_SIZE(default_blacklists); i++) {
+		if (!read_blacklist(default_blacklists[i], blacklist))
+			warn("Failed to open blacklist file %s: %s\n",
+			      filename, strerror(errno));
+	}
+}
+
+static int is_blacklisted (struct blacklist *blacklist, char *modulename)
+{
+	int result = 0;
+	
+	while (blacklist) {
+		if (strcmp (blacklist->module, modulename) == 0) {
+			result = 1;
+			break;
+		}
+		blacklist = blacklist->next;
+	}
+	return result;
+}
+
 int main(int argc, char *argv[])
 {
 	struct utsname buf;
@@ -1315,6 +1432,7 @@
 	char *newname = NULL;
 	char *aliasfilename, *symfilename;
 	errfn_t error = fatal;
+	struct blacklist *blacklist = NULL;
 
 	/* Prepend options from environment. */
 	argv = merge_args(getenv("MODPROBE_OPTIONS"), argv, &argc);
@@ -1475,6 +1593,9 @@
 		optstring = gather_options(argv+optind+1);
 	}
 
+	/* FIXME: extra option for alternate blacklist file? */
+	read_toplevel_blacklist (NULL, &blacklist);
+
 	/* num_modules is always 1 except for -r or -a. */
 	for (i = 0; i < num_modules; i++) {
 		struct module_command *commands = NULL;
@@ -1486,6 +1607,11 @@
 		/* Convert name we are looking for */
 		underscores(modulearg);
 
+		/* FIXME: do we blacklist on -a? */
+		if (is_blacklisted (blacklist, modulearg) && !remove) {
+			continue;
+		}
+
 		/* Returns the resolved alias, options */
 		read_toplevel_config(config, modulearg, 0,
 				     remove, &modoptions, &commands, &aliases);
