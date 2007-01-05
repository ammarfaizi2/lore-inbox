Return-Path: <linux-kernel-owner+w=401wt.eu-S1422671AbXAESss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbXAESss (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbXAESsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:48:22 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34877 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422668AbXAESrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:42 -0500
Message-Id: <200701051842.l05IgGsU004632@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/9] UML - console locking commentary and code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last vestiges of devfs from console registration.  Change
the name of the function, plus remove a couple of unused fields from
the line_driver structure.

struct lines is no longer needed, all traces of it are gone.

The only way that I can see to mark a structure as being almost-const
is to individually const the fields.  This is the case for the
line_driver structure, which has only one modifiable field - a
list_head in a sub-structure.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/line.c          |    7 +++----
 arch/um/drivers/ssl.c           |   16 +++++++---------
 arch/um/drivers/stdio_console.c |   17 +++++++----------
 arch/um/include/line.h          |   36 ++++++++++++++----------------------
 4 files changed, 31 insertions(+), 45 deletions(-)
Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2007-01-01 13:34:20.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2007-01-02 13:27:16.000000000 -0500
@@ -707,10 +707,9 @@ int line_remove(struct line *lines, unsi
 	return err;
 }
 
-struct tty_driver *line_register_devfs(struct lines *set,
-				       struct line_driver *line_driver,
-				       const struct tty_operations *ops,
-				       struct line *lines, int nlines)
+struct tty_driver *register_lines(struct line_driver *line_driver,
+				  const struct tty_operations *ops,
+				  struct line *lines, int nlines)
 {
 	int i;
 	struct tty_driver *driver = alloc_tty_driver(nlines);
Index: linux-2.6.18-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ssl.c	2007-01-02 12:25:18.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ssl.c	2007-01-02 13:31:38.000000000 -0500
@@ -51,6 +51,8 @@ static int ssl_config(char *str, char **
 static int ssl_get_config(char *dev, char *str, int size, char **error_out);
 static int ssl_remove(int n, char **error_out);
 
+
+/* Const, except for .mc.list */
 static struct line_driver driver = {
 	.name 			= "UML serial line",
 	.device_name 		= "ttyS",
@@ -62,8 +64,6 @@ static struct line_driver driver = {
 	.read_irq_name 		= "ssl",
 	.write_irq 		= SSL_WRITE_IRQ,
 	.write_irq_name 	= "ssl-write",
-	.symlink_from 		= "serial",
-	.symlink_to 		= "tts",
 	.mc  = {
 		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "ssl",
@@ -74,14 +74,12 @@ static struct line_driver driver = {
 	},
 };
 
-/* The array is initialized by line_init, which is an initcall.  The 
- * individual elements are protected by individual semaphores.
+/* The array is initialized by line_init, at initcall time.  The
+ * elements are locked individually as needed.
  */
 static struct line serial_lines[NR_PORTS] =
 	{ [0 ... NR_PORTS - 1] = LINE_INIT(CONFIG_SSL_CHAN, &driver) };
 
-static struct lines lines = LINES_INIT(NR_PORTS);
-
 static int ssl_config(char *str, char **error_out)
 {
 	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str, &opts,
@@ -175,6 +173,7 @@ static int ssl_console_setup(struct cons
 	return console_open_chan(line, co);
 }
 
+/* No locking for register_console call - relies on single-threaded initcalls */
 static struct console ssl_cons = {
 	.name		= "ttyS",
 	.write		= ssl_console_write,
@@ -190,9 +189,8 @@ static int ssl_init(void)
 
 	printk(KERN_INFO "Initializing software serial port version %d\n",
 	       ssl_version);
-	ssl_driver = line_register_devfs(&lines, &driver, &ssl_ops,
-					 serial_lines,
-					 ARRAY_SIZE(serial_lines));
+	ssl_driver = register_lines(&driver, &ssl_ops, serial_lines,
+				    ARRAY_SIZE(serial_lines));
 
 	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
 
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2007-01-01 13:30:24.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2007-01-02 13:31:51.000000000 -0500
@@ -55,6 +55,8 @@ static int con_config(char *str, char **
 static int con_get_config(char *dev, char *str, int size, char **error_out);
 static int con_remove(int n, char **con_remove);
 
+
+/* Const, except for .mc.list */
 static struct line_driver driver = {
 	.name 			= "UML console",
 	.device_name 		= "tty",
@@ -66,8 +68,6 @@ static struct line_driver driver = {
 	.read_irq_name 		= "console",
 	.write_irq 		= CONSOLE_WRITE_IRQ,
 	.write_irq_name 	= "console-write",
-	.symlink_from 		= "ttys",
-	.symlink_to 		= "vc",
 	.mc  = {
 		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "con",
@@ -78,10 +78,8 @@ static struct line_driver driver = {
 	},
 };
 
-static struct lines console_lines = LINES_INIT(MAX_TTYS);
-
-/* The array is initialized by line_init, which is an initcall.  The 
- * individual elements are protected by individual semaphores.
+/* The array is initialized by line_init, at initcall time.  The
+ * elements are locked individually as needed.
  */
 static struct line vts[MAX_TTYS] = { LINE_INIT(CONFIG_CON_ZERO_CHAN, &driver),
 				     [ 1 ... MAX_TTYS - 1 ] =
@@ -149,6 +147,7 @@ static int uml_console_setup(struct cons
 	return console_open_chan(line, co);
 }
 
+/* No locking for register_console call - relies on single-threaded initcalls */
 static struct console stdiocons = {
 	.name		= "tty",
 	.write		= uml_console_write,
@@ -156,16 +155,14 @@ static struct console stdiocons = {
 	.setup		= uml_console_setup,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
-	.data		= &vts,
 };
 
 int stdio_init(void)
 {
 	char *new_title;
 
-	console_driver = line_register_devfs(&console_lines, &driver,
-					     &console_ops, vts,
-					     ARRAY_SIZE(vts));
+	console_driver = register_lines(&driver, &console_ops, vts,
+					ARRAY_SIZE(vts));
 	if (console_driver == NULL)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2007-01-02 13:29:54.000000000 -0500
@@ -15,19 +15,18 @@
 #include "chan_user.h"
 #include "mconsole_kern.h"
 
+/* There's only one modifiable field in this - .mc.list */
 struct line_driver {
-	char *name;
-	char *device_name;
-	short major;
-	short minor_start;
-	short type;
-	short subtype;
-	int read_irq;
-	char *read_irq_name;
-	int write_irq;
-	char *write_irq_name;
-	char *symlink_from;
-	char *symlink_to;
+	const char *name;
+	const char *device_name;
+	const short major;
+	const short minor_start;
+	const short type;
+	const short subtype;
+	const int read_irq;
+	const char *read_irq_name;
+	const int write_irq;
+	const char *write_irq_name;
 	struct mc_device mc;
 };
 
@@ -67,12 +66,6 @@ struct line {
 	  .lock =	SPIN_LOCK_UNLOCKED, \
 	  .driver =	d }
 
-struct lines {
-	int num;
-};
-
-#define LINES_INIT(n) {  .num =	n }
-
 extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty);
 extern int line_setup(struct line *lines, unsigned int sizeof_lines,
@@ -94,10 +87,9 @@ extern char *add_xterm_umid(char *base);
 extern int line_setup_irq(int fd, int input, int output, struct line *line,
 			  void *data);
 extern void line_close_chan(struct line *line);
-extern struct tty_driver * line_register_devfs(struct lines *set,
-					       struct line_driver *line_driver,
-					       const struct tty_operations *driver,
-					       struct line *lines, int nlines);
+extern struct tty_driver *register_lines(struct line_driver *line_driver,
+					 const struct tty_operations *driver,
+					 struct line *lines, int nlines);
 extern void lines_init(struct line *lines, int nlines, struct chan_opts *opts);
 extern void close_lines(struct line *lines, int nlines);
 

