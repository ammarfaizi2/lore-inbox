Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSKBUu1>; Sat, 2 Nov 2002 15:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSKBUu0>; Sat, 2 Nov 2002 15:50:26 -0500
Received: from pasky.ji.cz ([62.44.12.54]:48629 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261407AbSKBUuL>;
	Sat, 2 Nov 2002 15:50:11 -0500
Date: Sat, 2 Nov 2002 21:59:55 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       gpm@lists.linux.it
Subject: [PATCH] Extended selection API
Message-ID: <20021102205955.GB4247@pasky.ji.cz>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>,
	gpm@lists.linux.it
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  this patch (against 2.5.45) extends the selection interface, so that userland
programs can directly save the data into the buffer and fetch them from it.
This way, it is possible for userland programs to handle cutting and pasting on
their own (not necessarily working with the screen content and getting the
content of the selection on stdin) or to implement shared selection buffer
between X11 and console etc.

  This patch is roughly based on some very ancient diff I found lying on my
disk, however unfortunately I can't remember anymore who implemented this idea
originally; I made a lot of changes to the original patch anyway.

  I wrote a trivial commandline-driven userland interface for this in order to
demonstrate the functionality. It is attached and it can be also found at
http://pasky.ji.cz/~pasky/dev/kernel/chsel.c.

  Note that it's possibly totally flawed (I don't know anything about this
piece of code), but it looks to work ok. Please review, test and comment.

  Kind regards,
				Petr Baudis

--- linux-2.5.45/include/linux/selection.h	Sat Nov  2 18:31:31 2002
+++ linux-2.5.45+pasky/include/linux/selection.h	Sat Nov  2 19:18:40 2002
@@ -18,6 +18,9 @@
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
+extern int set_selection_user(const unsigned long arg);
+extern int get_selection_user(const unsigned long arg);
+
 #define video_num_columns	(vc_cons[currcons].d->vc_cols)
 #define video_num_lines		(vc_cons[currcons].d->vc_rows)
 #define video_size_row		(vc_cons[currcons].d->vc_size_row)
--- linux-2.5.45/drivers/char/vt.c	Sat Nov  2 18:31:12 2002
+++ linux-2.5.45+pasky/drivers/char/vt.c	Sat Nov  2 19:17:27 2002
@@ -2255,6 +2255,12 @@
 		case 12:	/* get fg_console */
 			ret = fg_console;
 			break;
+		case 13:	/* set selection to data provided by user */
+			ret = set_selection_user(arg);
+			break;
+		case 14:	/* get selection */
+			ret = get_selection_user(arg);
+			break;
 		default:
 			ret = -EINVAL;
 			break;
--- linux-2.5.45/drivers/char/selection.c	Sat Nov  2 18:31:22 2002
+++ linux-2.5.45+pasky/drivers/char/selection.c	Sat Nov  2 20:20:30 2002
@@ -7,8 +7,13 @@
  *     'void clear_selection(void)'
  *     'int paste_selection(struct tty_struct *tty)'
  *     'int sel_loadlut(const unsigned long arg)'
+ *     'int get_selection_user(const unsigned long arg)'
+ *     'int set_selection_user(const unsigned long arg)'
  *
  * Now that /dev/vcs exists, most of this can disappear again.
+ *
+ * Introduced usable userland selection interface
+ * 2002-11-02 Petr Baudis <pasky@ucw.cz>
  */
 
 #include <linux/module.h>
@@ -310,5 +315,75 @@
 	return 0;
 }
 
+/* Fill the current selection buffer with the data provided in user buffer.
+ * The maximal size of the selection buffer is trimmed to 65535 here; could
+ * anyone possibly want more?
+ * Invoked by ioctl(). */
+int set_selection_user(const unsigned long arg)
+{
+	unsigned int buf_length;
+	char *new_sel_buffer = NULL;
+	char *args;
+
+	clear_selection();
+
+	args = (char *) (arg + 1);
+	get_user(buf_length, (unsigned int *) args);
+	args += sizeof(unsigned int);
+
+	if (buf_length > 0 && buf_length < 65536) {
+		new_sel_buffer = kmalloc(buf_length, GFP_KERNEL);
+		if (!new_sel_buffer) {
+			printk(KERN_WARNING "selection: kmalloc() failed\n");
+			return -ENOMEM;
+		}
+		if (copy_from_user(new_sel_buffer, (char *) args, buf_length)){
+			kfree(new_sel_buffer);
+			return -EFAULT;
+		}
+	} else if (buf_length) {
+		return -EINVAL;
+	}
+
+	if (sel_buffer)
+		kfree(sel_buffer);
+
+	sel_buffer = new_sel_buffer;
+	sel_buffer_lth = buf_length;
+
+	return 0;
+}
+
+/* Get (start of) content of the current selection buffer. Users should
+ * re-fetch if return_value > buf_length.
+ * Invoked by ioctl(). */
+int get_selection_user(const unsigned long arg)
+{
+	unsigned int buf_length;
+	char *args;
+
+	args = (char *) (arg + 1);
+	get_user(buf_length, (unsigned int *) args);
+	if (buf_length > sel_buffer_lth) {
+		buf_length = sel_buffer_lth;
+		if (copy_to_user((char *) args, &buf_length,
+				sizeof(unsigned int))) {
+			return -EFAULT;
+		}
+	}
+	args += sizeof(unsigned int);
+
+	if (!sel_buffer)
+		return 0;
+
+	if (copy_to_user((char *) args, sel_buffer, buf_length)) {
+		return -EFAULT;
+	}
+
+	return sel_buffer_lth;
+}
+
 EXPORT_SYMBOL(set_selection);
 EXPORT_SYMBOL(paste_selection);
+EXPORT_SYMBOL(set_selection_user);
+EXPORT_SYMBOL(get_selection_user);

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chsel.c"

/* chsel - example program providing simple command-line interface for
 * manipulation with the kernel selection buffer. */

/* Note that in the output of chsel get, newlines are returned as ^M (\x0d).
 * This is just how it's stored in the kernel. Should we translate it? */

/* You currently need a kernel patch available at
 * http://pasky.ji.cz/~pasky/dev/kernel/selection.patch */

/* [GPL'd] (c) 2002  Petr Baudis <pasky@ucw.cz> */

#define VERSION	"0.1"

/* This is really not coded nicely, it's rather a dirty hack. Its goal for
 * now is to be as simple and short as possible, so that people can get the
 * general idea. */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>

int
main(int argc, char *argv[]) {
  enum { MODE_GET, MODE_SET } mode;
  char *buffer;
  int len;
  int fd = 0;

  if (argc < 2) {
usage:
    fprintf(stderr, "chsel %s\nUsage: %s {get|set <selection>}\n",
	VERSION, argv[0]);
    return 1;
  }

  if (!strcmp(argv[1], "get"))
    mode = MODE_GET;
  else if (!strcmp(argv[1], "set"))
    mode = MODE_SET;
  else
    goto usage;

  if (mode == MODE_SET && argc != 3)
    goto usage;

  switch (mode) {
    case MODE_SET:
      len = strlen(argv[2]);
      buffer = malloc(len + 1 + sizeof(unsigned int));
      buffer[0] = 13;
      memcpy(buffer + 1, &len, sizeof(unsigned int));
      memcpy(buffer + 1 + sizeof(unsigned int), argv[2], len);

      if (ioctl(fd, TIOCLINUX, buffer) < 0) {
ioctl_error:
	perror("chsel - ioctl()");
	free(buffer);
	return 2;
      }

      break;

    case MODE_GET:
      /* I could do this by simply going directly for 65536, but this limit
       * can change in future and it wouldn't be so demonstrational and
       * educational ;-). --pasky */
      len = 128;
get_loop:
      buffer = malloc(len + 1 + sizeof(unsigned int));
      buffer[0] = 14;
      memcpy(buffer + 1, &len, sizeof(unsigned int));
      
      if ((len = ioctl(fd, TIOCLINUX, buffer)) < 0)
	goto ioctl_error;

      if (len > *((unsigned int *) (buffer + 1))) {
	free(buffer);
	goto get_loop; /* and now with the right buffer len */
      }

      if (*((unsigned int *) (buffer + 1)))
      printf("%*s",
	  *((unsigned int *) (buffer + 1)),
	  buffer + 1 + sizeof(unsigned int));
      free(buffer);

      break;
  }

  return 0;
}

--wac7ysb48OaltWcw--
