Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTGUM2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTGUM2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:28:36 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:49138 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S270066AbTGUM0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:26:05 -0400
Subject: Re: 2.6-test1 startup messages?
From: Martin Schlemmer <azarah@gentoo.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1AD2AA.9010603@cornell.edu>
References: <20030720140035.GC20163@rdlg.net> <3F1AD2AA.9010603@cornell.edu>
Content-Type: multipart/mixed; boundary="=-20r4zGaFG3wRnfmvR7mb"
Organization: 
Message-Id: <1058791258.5737.36.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 21 Jul 2003 14:40:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-20r4zGaFG3wRnfmvR7mb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-07-20 at 19:34, Ivan Gyurdiev wrote:
> Robert L. Harris wrote:
> > 
> >   I just converted a box to 2.6-test1.  I've installed the module-init-tools
> > per another thread on the list.  Spread throughout the startup messages
> > of the system (Debian Unstable) are messages that read:
> > 
> > FATAL: Module /dev/tts not found
> > FATAL: Module /dev/tts not found
> > FATAL: Module /dev/ttsS?? not found
> > FATAL: Module /dev/ttsS?? not found
> > 
> > looking at /dev/tty* I have /dev/tty, /dev/tty0-tty63.  There is no
> > /dev/ttyS0 (serial console) or tts*.
> >
> 
> Are you using devfs?
> I get the same messages with devfs.
> Looking up a /dev file that does not presently exist
> or have a corresponding module results in the above warnings.
> At boot time, on a redhat distro pam_console_apply tries to lookup
> the devices specified in /etc/security/console.perms, which causes a 
> zillion warnings for me. The question is - are those warnings to correct 
> way to handle a devfs lookup of a nonexisting device. I don't remember 
> getting warnings under 2.4. Maybe I did, and just didn't notice (but I 
> doubt it). They're certainly annoying and I don't like them.
> 

You could try the attached patch.  Rusty do not like it though =)


Regards,

-- 
Martin Schlemmer


--=-20r4zGaFG3wRnfmvR7mb
Content-Disposition: attachment; filename=module-init-tools-0.9.11-be-quiet-for-devfsd.patch
Content-Type: text/plain; name=module-init-tools-0.9.11-be-quiet-for-devfsd.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- module-init-tools-0.9.11-pre/modprobe.c.orig	2003-03-16 22:32:46.000000000 +0200
+++ module-init-tools-0.9.11-pre/modprobe.c	2003-03-18 03:43:52.000000000 +0200
@@ -52,6 +52,8 @@ struct module {
 
 /* Do we use syslog or stderr for messages? */
 static int log;
+/* Should we be totally quiet? */
+static int quiet = 0;
 
 static int getlen(const char *fmt, va_list ap)
 {
@@ -70,6 +72,9 @@ static void message(const char *prefix, 
 	va_list arglist;
 	int len;
 
+	if (quiet)
+		return;
+
 	va_start(arglist, fmt);
 	len = strlen(prefix) + getlen(fmt, arglist) + 1;
 	buf = malloc(len);
@@ -87,7 +92,7 @@ static void message(const char *prefix, 
 
 #define warn(fmt, ...) message("WARNING: ", fmt , ## __VA_ARGS__)
 #define fatal(fmt, ...) \
-	do { message("FATAL: ", fmt , ## __VA_ARGS__); exit(1); } while(0)
+	do { message("FATAL: ", fmt , ## __VA_ARGS__);  if (quiet) exit(0); else exit(1); } while(0)
 
 static void grammar(const char *cmd, const char *filename, unsigned int line)
 {
@@ -1093,6 +1098,7 @@ static struct option options[] = { { "ve
 				   { "showconfig", 0, NULL, 'c' },
 				   { "autoclean", 0, NULL, 'k' },
 				   { "quiet", 0, NULL, 'q' },
+				   { "really-quiet", 0, NULL, 'Q' },
 				   { "show", 0, NULL, 'n' },
 				   { "dry-run", 0, NULL, 'n' },
 				   { "syslog", 0, NULL, 's' },
@@ -1108,6 +1114,7 @@ static struct option options[] = { { "ve
 				   { NULL, 0, NULL, 0 } };
 
 #define DEFAULT_CONFIG "/etc/modprobe.conf"
+#define MODPROBE_DEVFSD_CONF "/etc/modprobe.devfs"
 
 int main(int argc, char *argv[])
 {
@@ -1146,7 +1153,7 @@ int main(int argc, char *argv[])
 		try_old_version("modprobe", argv);
 
 	uname(&buf);
-	while ((opt = getopt_long(argc, argv, "vVC:o:rknqsclt:aif", options, NULL)) != -1){
+	while ((opt = getopt_long(argc, argv, "vVC:o:rknqQsclt:aif", options, NULL)) != -1){
 		switch (opt) {
 		case 'v':
 			add_to_env_var("-v");
@@ -1193,6 +1200,10 @@ int main(int argc, char *argv[])
 			add_to_env_var("-q");
 			fail_if_already = 0;
 			break;
+		case 'Q':
+			add_to_env_var("-Q");
+			quiet = 1;
+			break;
 		case 's':
 			add_to_env_var("-s");
 			log = 1;
@@ -1215,8 +1226,51 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* A hack to have absolutely no output if:
+	 *
+	 *   1) we have no logging enabled
+	 * 
+	 *   2) our config file is /etc/modprobe.devfs or /etc/modules.devfs
+	 *   
+	 *   3) with the module name starting with '/dev/'.
+	 *
+	 * Rasionale:  This is what modprobe from modutils-2.4.22 does:
+	 *
+	 *   gateway root # modprobe /dev/sd1   
+	 *   modprobe: Can't locate module /dev/sd1
+	 *   gateway root # modprobe -C /etc/modules.conf /dev/sd1
+	 *   modprobe: Can't locate module /dev/sd1
+	 *   gateway root # modprobe -C /etc/modules.devfs /dev/sd1
+	 *   gateway root #
+	 *   
+	 *   gateway root # modprobe foo     
+	 *   modprobe: Can't locate module foo
+	 *   gateway root # modprobe -C /etc/modules.conf foo     
+	 *   modprobe: Can't locate module foo
+	 *   gateway root # modprobe -C /etc/modules.devfs foo     
+	 *   modprobe: Can't locate module foo
+	 *   gateway root #
+	 *   
+	 *   gateway root # modprobe -C /etc/modules.devfs /dev/sd1 && echo yes
+	 *   yes
+	 *   gateway root # modprobe -C /etc/modules.devfs foo && echo yes
+	 *   modprobe: Can't locate module foo
+	 *   gateway root # 
+	 *   
+	 */
+	if (!log && !quiet && !dump_only && config) {
+		if (strncmp(argv[optind], "/dev/", 5) == 0
+				/* Handle recursive calls */
+			&& ((strcmp(MODPROBE_DEVFSD_CONF, config) == 0)
+				/* devfsd calls modprobe with '-C /etc/modules.devfs' */
+				|| (strcmp("/etc/modules.devfs", config) == 0))) {
+			add_to_env_var("-Q");
+			quiet = 1;
+		}
+	}
+
 	/* If stderr not open, go to syslog */
-	if (log || fstat(STDERR_FILENO, &statbuf) != 0) {
+	if (log || (!quiet && fstat(STDERR_FILENO, &statbuf) != 0)) {
 		openlog("modprobe", LOG_CONS, LOG_DAEMON);
 		log = 1;
 	}
@@ -1253,7 +1307,7 @@ int main(int argc, char *argv[])
 		if (strcmp("/etc/modules.conf", config) == 0)
 			config = NULL;
 		else if (strcmp("/etc/modules.devfs", config) == 0)
-			config = "/etc/modprobe.devfs";
+			config = MODPROBE_DEVFSD_CONF;
 	}
 
 	/* -r only allows certain restricted options */

--=-20r4zGaFG3wRnfmvR7mb--

