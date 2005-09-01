Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVIAQmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVIAQmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVIAQmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:42:47 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:42945 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030237AbVIAQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:42:46 -0400
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
From: Corey Minyard <minyard@acm.org>
To: viro@ZenIV.linux.org.uk
Cc: Matt_Domsch@Dell.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050901064313.GB26264@ZenIV.linux.org.uk>
References: <20050901064313.GB26264@ZenIV.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-4pFnoe/Chh49/PzORS/u"
Date: Thu, 01 Sep 2005 11:41:42 -0500
Message-Id: <1125592902.27283.5.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4pFnoe/Chh49/PzORS/u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Indeed, this function is badly written.  In rewriting, I couldn't find a
nice function for reading integers from userspace, and the proc_dointvec
stuff didn't seem terribly suitable.  So I wrote my own general
function, which I can move someplace else if someone likes.  Patch is
attached.  It should not affect correct usage of this file.

Thank you for pointing this out.

Andrew, can you include this?  Matt, can you test?

-Corey

On Thu, 2005-09-01 at 07:43 +0100, viro@ZenIV.linux.org.uk wrote:
> drivers/char/ipmi/ipmi_poweroff.c::proc_write_chassctrl()
> 	a) does sscanf on userland pointer
> 	b) does sscanf on array that is not guaranteed to have NUL in it
> 	c) interprets input in incredibly cretinous way:
> if strings doesn't start with a decimal number => as if it was "0".
> if it starts with decimal number equal to 0 (e.g. is "-0000splat") - as if
> it was "0".
> if it starts with decimal number equal to 2 (e.g. is "00002FOAD") - as if
> it was "2".
> otherwise - -EINVAL.
> 	In any case that doesn't end up with -EINVAL, pretend that entire
> buffer had been written.
> 
> (a) and (b) are immediate bugs; (c) is a valid reason for immediate severe
> LARTing of the pervert who had done _that_ in a user-visible API.
> 
> Note that API _is_ user-visible, so we can't blindly change it - not without
> checking WTF do its users actually write to /proc/ipmi/poweroff_control.
> 
> Could somebody comment on the actual uses of that FPOS?  My preference would
> be to remove the damn thing completely - it's too ugly to live.

--=-4pFnoe/Chh49/PzORS/u
Content-Disposition: attachment; filename=ipmi-poweroff-fix-chassis-ctrl.patch
Content-Type: text/x-patch; name=ipmi-poweroff-fix-chassis-ctrl.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

The IPMI power control function proc_write_chassctrl was badly
written, it directly used userspace pointers, it assumed that
strings were NULL terminated, and it used the evil sscanf function.
This adds a new function to read integers from userspace and
uses this function to get the integer in question.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
@@ -40,6 +40,8 @@
 #include <linux/kdev_t.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
+#include <linux/ctype.h>
+#include <asm/uaccess.h>
 
 #define PFX "IPMI poweroff: "
 
@@ -545,27 +547,179 @@ static int proc_read_chassctrl(char *pag
 			poweroff_control);
 }
 
+/*
+ * Convert a character to an integer, returning -1 if the character is
+ * not a valid digit for "base".
+ */
+static int convdigit(char ch, int base)
+{
+	int v;
+	if ((ch >= '0') && (ch <= '9'))
+		v = ch - '0';
+	else if ((ch >= 'A') && (ch <= 'Z'))
+		v = ch - 'A' + 10;
+	else if ((ch >= 'a') && (ch <= 'z'))
+		v = ch - 'a' + 10;
+	else
+		return -1;
+	if (v >= base)
+		return -1;
+	return v;
+}
+
+/*
+ * Get a unsigned long from userspace, much like strtoul, but getting
+ * the data from userspace.  This is a little complicated to use, but
+ * is quite flexible.
+ *
+ * @buffer - is a pointer to the start of the user buffer.  Basically,
+ * this will read from buffer+*pos up to buffer+count-1.
+ * @pos - points to the start offset in buffer to start reading at.
+ * pos will be updated to the current location after the scan upon return.
+ * May be NULL, where it is assumed to be zero.
+ * @count - the total buffer length.
+ * @fbase - forces the base.  If this value is zero 0, the base will be
+ * hex if the string starts with 0x, octal if it starts with 0, and
+ * decimal otherwise.
+ * @stop_at_inval - a flag that, if true, causes the function to
+ * return if it already has a valid number and has reached an invalid
+ * character.  "pos" will be set to the offset of the invalid
+ * character upon return.  If false, the entire buffer is expected to
+ * be a single integer value surrounded by optional space characters.
+ *
+ * Unlike strtoul, the value is returned in the "val" parameter.  The
+ * return value of this function is a errno if negative or the number
+ * of characters processed if positive.
+ */
+static ssize_t user_strtoul(const char __user *buffer, loff_t *ppos,
+			    size_t count, int fbase, int stop_at_inval,
+			    unsigned long *val)
+{
+	unsigned long newval = 0;
+	char          buf[20];
+	unsigned int  rc;
+	unsigned int  i;
+	enum { SC_ST, SC_ST2, SC_AFTPRE, SC_DAT, SC_END } state = SC_ST;
+	int           base = fbase;
+	loff_t        start;
+	loff_t        pos;
+
+	if (ppos)
+		pos = *ppos;
+	else
+		pos = 0;
+	start = pos;
+	count -= pos;
+	if (base == 0)
+		base = 10;
+	while (count > 0) {
+		rc = min(count, (size_t) sizeof(buf));
+		if (copy_from_user(buf, buffer + pos, rc))
+			return -EFAULT;
+		for (i = 0; i < rc; i++) {
+			char ch = buf[i];
+			int  chval;
+
+			switch(state) {
+			case SC_ST:
+				if (isspace(ch))
+					break;
+				if (ch == '0') {
+					if (fbase == 0)
+						base = 8;
+					state = SC_ST2;
+					break;
+				}
+				goto aftpre;
+
+			case SC_ST2:
+				if (ch == 'x') {
+					if (fbase == 0)
+						base = 16;
+					else if (fbase != 16)
+						return -EINVAL;
+					state = SC_AFTPRE;
+					break;
+				}
+				goto aftpre;
+
+			case SC_AFTPRE:
+			aftpre:
+				chval = convdigit(ch, base);
+				if (chval == -1)
+					return -EINVAL;
+				newval = (newval * base) + chval;
+				state = SC_DAT;
+				break;
+
+			case SC_DAT:
+				if (isspace(ch)) {
+					if (stop_at_inval) {
+						pos += i;
+						goto out;
+					}
+					state = SC_END;
+				} else {
+					unsigned long oldval = newval;
+					chval = convdigit(ch, base);
+					if (chval == -1) {
+						if (stop_at_inval) {
+							pos += i;
+							goto out;
+						}
+						return -EINVAL;
+					}
+					newval *= base;
+					if (newval < oldval) /* overflow */
+						return -EINVAL;
+					oldval = newval;
+					newval += chval;
+					if (newval < oldval) /* overflow */
+						return -EINVAL;
+				}
+				break;
+
+			case SC_END:
+				if (!isspace(ch))
+					return -EINVAL;
+				break;
+			}
+		}
+
+		count -= rc;
+		pos += rc;
+	}
+
+ out:
+	if (ppos)
+		*ppos = pos;
+	*val = newval;
+	return pos - start;
+}
+
 /* process property writes from proc */
-static int proc_write_chassctrl(struct file *file, const char *buffer,
+static int proc_write_chassctrl(struct file *file, const char __user *buffer,
 			        unsigned long count, void *data)
 {
-	int          rv = count;
-	unsigned int newval = 0;
+	unsigned long newval;
+	ssize_t       rv;
 
-	sscanf(buffer, "%d", &newval);
+	rv = user_strtoul(buffer, NULL, count, 0, 0, &newval);
+	if (rv < 0)
+		return rv;
 	switch (newval) {
-		case IPMI_CHASSIS_POWER_CYCLE:
-			printk(KERN_INFO PFX "power cycle is now enabled\n");
-			poweroff_control = newval;
-			break;
-
-		case IPMI_CHASSIS_POWER_DOWN:
-			poweroff_control = IPMI_CHASSIS_POWER_DOWN;
-			break;
-
-		default:
-			rv = -EINVAL;
-			break;
+	case IPMI_CHASSIS_POWER_CYCLE:
+		printk(KERN_INFO PFX "power cycle is now enabled\n");
+		poweroff_control = newval;
+		break;
+
+	case IPMI_CHASSIS_POWER_DOWN:
+		poweroff_control = IPMI_CHASSIS_POWER_DOWN;
+		break;
+
+	default:
+		rv = -EINVAL;
+		break;
 	}
 
 	return rv;

--=-4pFnoe/Chh49/PzORS/u--

