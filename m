Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRAUEzg>; Sat, 20 Jan 2001 23:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAUEz0>; Sat, 20 Jan 2001 23:55:26 -0500
Received: from sunny.pacific.net.au ([210.23.129.40]:30166 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S129790AbRAUEzU>; Sat, 20 Jan 2001 23:55:20 -0500
Date: Sun, 21 Jan 2001 15:54:56 +1100
From: David Luyer <david_luyer@pacific.net.au>
Message-Id: <200101210454.f0L4sug02747@typhaon.pacific.net.au>
To: alan@redhat.com, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: PATCH: "Pass module parameters" to built-in drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, Keith, All,

Here's a proposed v2.4 "quick fix" to allow specifying "module parameters" to
any of the many drivers without option parsers when built in to the kernel.

I understand Keith has intentions to do this differently in v2.5, however I'd
be happy if something along these lines could find its way into v2.4, maybe
the below, something similar to the below but with the default of "N" instead,
or maybe a completely different.

I haven't tested it extensively - only so far as that it works just fine with
all the modules that I wanted set options for on bootup; none of these are, for
example, string or integer list options so those aren't tested.

All code is placed in init functions, I'm not sure about where the strings
specified as options to generic_parse_function will end up though.

Comments/feedback?

(and I know without the ".c" would be nicer, but AFAIK that can't be done
without either extra run-time code (chop the .c at run-time) or makefile
support (-D__FILEBASE__=....).

diff -urN orig/linux/Documentation/Configure.help linux/Documentation/Configure.help
--- orig/linux/Documentation/Configure.help	Wed Jan 17 15:30:13 2001
+++ linux/Documentation/Configure.help	Sat Jan 20 11:18:41 2001
@@ -3729,6 +3729,14 @@
   replacement for kerneld.) Say Y here and read about configuring it
   in Documentation/kmod.txt.
 
+Module parameter parsing for non-modular drivers
+CONFIG_MODPARM_BUILTIN
+  This allows you to set parameters which are normally passed as
+  options to modules by specifying the parameter as file.c:var=value
+  on the kernel command line (eg, xirc2ps_cs.c:lockup_hack=1).
+  Say Y here if unsure - all additional memory used is freed during
+  bootup.
+
 ARP daemon support (EXPERIMENTAL)
 CONFIG_ARPD
   Normally, the kernel maintains an internal cache which maps IP 
diff -urN orig/linux/arch/alpha/config.in linux/arch/alpha/config.in
--- orig/linux/arch/alpha/config.in	Wed Jan 17 15:30:14 2001
+++ linux/arch/alpha/config.in	Sat Jan 20 11:21:02 2001
@@ -20,6 +20,7 @@
   bool 'Set version information on all symbols for modules' CONFIG_MODVERSIONS
   bool 'Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/alpha/defconfig linux/arch/alpha/defconfig
--- orig/linux/arch/alpha/defconfig	Tue Oct 17 09:38:41 2000
+++ linux/arch/alpha/defconfig	Sat Jan 20 11:19:05 2001
@@ -14,6 +14,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/arch/arm/config.in linux/arch/arm/config.in
--- orig/linux/arch/arm/config.in	Wed Jan 17 15:30:14 2001
+++ linux/arch/arm/config.in	Sat Jan 20 11:21:08 2001
@@ -25,6 +25,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 
diff -urN orig/linux/arch/arm/defconfig linux/arch/arm/defconfig
--- orig/linux/arch/arm/defconfig	Tue Jun 20 10:59:33 2000
+++ linux/arch/arm/defconfig	Sat Jan 20 11:19:11 2001
@@ -42,6 +42,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/arch/i386/config.in linux/arch/i386/config.in
--- orig/linux/arch/i386/config.in	Wed Jan 17 15:30:15 2001
+++ linux/arch/i386/config.in	Sat Jan 20 11:14:55 2001
@@ -22,6 +22,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/i386/defconfig linux/arch/i386/defconfig
--- orig/linux/arch/i386/defconfig	Wed Jan 17 15:30:15 2001
+++ linux/arch/i386/defconfig	Sat Jan 20 11:19:14 2001
@@ -17,6 +17,7 @@
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # Processor type and features
diff -urN orig/linux/arch/ia64/config.in linux/arch/ia64/config.in
--- orig/linux/arch/ia64/config.in	Wed Jan 17 15:30:16 2001
+++ linux/arch/ia64/config.in	Sat Jan 20 11:21:18 2001
@@ -12,6 +12,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/ia64/defconfig linux/arch/ia64/defconfig
--- orig/linux/arch/ia64/defconfig	Fri Jun 23 00:09:44 2000
+++ linux/arch/ia64/defconfig	Sat Jan 20 11:19:24 2001
@@ -39,6 +39,7 @@
 # Loadable module support
 #
 # CONFIG_MODULES is not set
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # Parallel port support
diff -urN orig/linux/arch/m68k/config.in linux/arch/m68k/config.in
--- orig/linux/arch/m68k/config.in	Fri Jan  5 08:00:55 2001
+++ linux/arch/m68k/config.in	Sat Jan 20 11:22:40 2001
@@ -19,6 +19,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/m68k/defconfig linux/arch/m68k/defconfig
--- orig/linux/arch/m68k/defconfig	Tue Jun 20 05:56:08 2000
+++ linux/arch/m68k/defconfig	Sat Jan 20 11:19:30 2001
@@ -58,6 +58,7 @@
 # Loadable module support
 #
 # CONFIG_MODULES is not set
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # Block devices
diff -urN orig/linux/arch/mips/config.in linux/arch/mips/config.in
--- orig/linux/arch/mips/config.in	Wed Jan 17 15:30:16 2001
+++ linux/arch/mips/config.in	Sat Jan 20 11:21:36 2001
@@ -101,6 +101,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/mips/defconfig linux/arch/mips/defconfig
--- orig/linux/arch/mips/defconfig	Fri Jul 28 11:36:54 2000
+++ linux/arch/mips/defconfig	Sat Jan 20 11:19:34 2001
@@ -34,6 +34,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # CPU selection
diff -urN orig/linux/arch/mips64/config.in linux/arch/mips64/config.in
--- orig/linux/arch/mips64/config.in	Wed Jan 17 15:30:16 2001
+++ linux/arch/mips64/config.in	Sat Jan 20 11:21:55 2001
@@ -120,6 +120,7 @@
    bool 'Set version information on all symbols for modules' CONFIG_MODVERSIONS
    bool 'Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 
 source drivers/pci/Config.in
 
diff -urN orig/linux/arch/mips64/defconfig linux/arch/mips64/defconfig
--- orig/linux/arch/mips64/defconfig	Wed Nov 29 16:42:04 2000
+++ linux/arch/mips64/defconfig	Sat Jan 20 11:19:54 2001
@@ -60,6 +60,7 @@
 # Loadable module support
 #
 # CONFIG_MODULES is not set
+CONFIG_MODPARM_BUILTIN=y
 CONFIG_PCI_NAMES=y
 
 #
diff -urN orig/linux/arch/parisc/config.in linux/arch/parisc/config.in
--- orig/linux/arch/parisc/config.in	Wed Dec  6 07:29:39 2000
+++ linux/arch/parisc/config.in	Sat Jan 20 11:22:10 2001
@@ -53,6 +53,7 @@
   bool 'Set version information on all symbols for modules' CONFIG_MODVERSIONS
   bool 'Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/parisc/defconfig linux/arch/parisc/defconfig
--- orig/linux/arch/parisc/defconfig	Wed Dec  6 07:29:39 2000
+++ linux/arch/parisc/defconfig	Sat Jan 20 11:20:01 2001
@@ -29,6 +29,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/arch/ppc/config.in linux/arch/ppc/config.in
--- orig/linux/arch/ppc/config.in	Wed Jan 17 15:30:17 2001
+++ linux/arch/ppc/config.in	Sat Jan 20 11:22:14 2001
@@ -18,6 +18,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/ppc/defconfig linux/arch/ppc/defconfig
--- orig/linux/arch/ppc/defconfig	Wed Jan 17 15:30:17 2001
+++ linux/arch/ppc/defconfig	Sat Jan 20 11:20:10 2001
@@ -14,6 +14,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # Platform support
diff -urN orig/linux/arch/s390/config.in linux/arch/s390/config.in
--- orig/linux/arch/s390/config.in	Wed Jan 17 15:30:19 2001
+++ linux/arch/s390/config.in	Sat Jan 20 11:22:17 2001
@@ -23,6 +23,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/s390/defconfig linux/arch/s390/defconfig
--- orig/linux/arch/s390/defconfig	Wed Jan 17 15:30:19 2001
+++ linux/arch/s390/defconfig	Sat Jan 20 11:20:15 2001
@@ -24,6 +24,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/arch/s390x/config.in linux/arch/s390x/config.in
--- orig/linux/arch/s390x/config.in	Wed Jan 17 15:30:21 2001
+++ linux/arch/s390x/config.in	Sat Jan 20 11:22:20 2001
@@ -32,6 +32,7 @@
   bool 'Set version information on all symbols for modules' CONFIG_MODVERSIONS
   bool 'Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/s390x/defconfig linux/arch/s390x/defconfig
--- orig/linux/arch/s390x/defconfig	Wed Jan 17 15:30:21 2001
+++ linux/arch/s390x/defconfig	Sat Jan 20 11:20:18 2001
@@ -25,6 +25,7 @@
 CONFIG_MODULES=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/arch/sh/config.in linux/arch/sh/config.in
--- orig/linux/arch/sh/config.in	Fri Jan  5 08:19:13 2001
+++ linux/arch/sh/config.in	Sat Jan 20 11:22:23 2001
@@ -20,6 +20,7 @@
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/sh/defconfig linux/arch/sh/defconfig
--- orig/linux/arch/sh/defconfig	Thu Aug 10 06:59:04 2000
+++ linux/arch/sh/defconfig	Sat Jan 20 11:20:22 2001
@@ -13,6 +13,7 @@
 # Loadable module support
 #
 # CONFIG_MODULES is not set
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # Processor type and features
diff -urN orig/linux/arch/sparc/config.in linux/arch/sparc/config.in
--- orig/linux/arch/sparc/config.in	Wed Nov 29 16:53:44 2000
+++ linux/arch/sparc/config.in	Sat Jan 20 11:22:25 2001
@@ -19,6 +19,7 @@
    bool '  Set version information on all symbols for modules' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/sparc/defconfig linux/arch/sparc/defconfig
--- orig/linux/arch/sparc/defconfig	Fri Aug 11 05:43:12 2000
+++ linux/arch/sparc/defconfig	Sat Jan 20 11:20:26 2001
@@ -15,6 +15,7 @@
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/arch/sparc64/config.in linux/arch/sparc64/config.in
--- orig/linux/arch/sparc64/config.in	Wed Jan 17 15:30:23 2001
+++ linux/arch/sparc64/config.in	Sat Jan 20 11:22:31 2001
@@ -16,6 +16,7 @@
    bool '  Set version information on all symbols for modules' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+bool 'Module parameter passing for non-modular drivers' CONFIG_MODPARM_BUILTIN
 endmenu
 
 mainmenu_option next_comment
diff -urN orig/linux/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- orig/linux/arch/sparc64/defconfig	Tue Oct 31 09:34:12 2000
+++ linux/arch/sparc64/defconfig	Sat Jan 20 11:20:30 2001
@@ -13,6 +13,7 @@
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 CONFIG_KMOD=y
+CONFIG_MODPARM_BUILTIN=y
 
 #
 # General setup
diff -urN orig/linux/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- orig/linux/drivers/scsi/sr.c	Wed Jan 17 15:30:54 2001
+++ linux/drivers/scsi/sr.c	Sat Jan 20 11:07:38 2001
@@ -56,6 +56,10 @@
 #include <scsi/scsi_ioctl.h>	/* For the door lock/unlock commands */
 #include "constants.h"
 
+#ifndef MODULE
+extern int xa_test;
+#endif
+
 MODULE_PARM(xa_test, "i");	/* see sr_ioctl.c */
 
 #define MAX_RETRIES	3
diff -urN orig/linux/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- orig/linux/drivers/scsi/sr_ioctl.c	Sat Dec 30 09:07:22 2000
+++ linux/drivers/scsi/sr_ioctl.c	Sat Jan 20 11:09:28 2001
@@ -21,7 +21,11 @@
 
 /* The sr_is_xa() seems to trigger firmware bugs with some drives :-(
  * It is off by default and can be turned on with this module parameter */
+#ifdef MODULE
 static int xa_test = 0;
+#else
+int xa_test = 0;
+#endif
 
 extern void get_sectorsize(int);
 
diff -urN orig/linux/include/linux/module.h linux/include/linux/module.h
--- orig/linux/include/linux/module.h	Fri Jan  5 09:50:46 2001
+++ linux/include/linux/module.h	Sun Jan 21 14:28:56 2001
@@ -274,10 +274,25 @@
 
 #else /* MODULE */
 
+/* needed for __init */
+#include <linux/init.h>
+
+/* from main.c but used (and only used) here */
+extern int generic_parse_function (char *input, const char *name, void *loc, const char *fmt) __init;
+
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
+#ifdef CONFIG_MODPARM_BUILTIN
+#define MODULE_PARM(var,type) \
+  static int __init _setup_##var (char *str) { \
+    /* are the strings put in the correct section? */ \
+    return generic_parse_function(str, __FILE__##":"#var, &var, type); \
+  } \
+  __setup (__FILE__##":"#var"=", _setup_##var);
+#else
 #define MODULE_PARM(var,type)
+#endif
 #define MODULE_PARM_DESC(var,desc)
 #define MODULE_GENERIC_TABLE(gtype,name)
 #define MODULE_DEVICE_TABLE(type,name)
diff -urN orig/linux/lib/cmdline.c linux/lib/cmdline.c
--- orig/linux/lib/cmdline.c	Sat Aug 12 12:14:46 2000
+++ linux/lib/cmdline.c	Sun Jan 21 15:12:21 2001
@@ -114,6 +114,211 @@
 	return ret;
 }
 
+#ifdef CONFIG_MODPARM_BUILTIN
+
+#include <linux/ctype.h>
+#include <linux/malloc.h>
+
+#define tgt_sizeof_short sizeof(short)
+#define tgt_sizeof_int sizeof(int)
+#define tgt_sizeof_long sizeof(long)
+#define tgt_sizeof_char_p sizeof(char *)
+
+/* Taken from modutils and modified so all data is initialized and hence can
+ * be placed in the correct ELF section.
+ */
+extern int __init generic_parse_function (char *input, const char *name, void *loc, const char *fmt) {
+	static int min __initdata = 1, max __initdata = 1;
+	static int c __initdata = 0, n __initdata = 1;
+
+	/* From modutils:insmod/insmod.c:v2.4.1, lines 771-778 */
+	if (isdigit(*fmt)) {
+		min = simple_strtoul(fmt, (char **) &fmt, 10);
+		if (*fmt == '-')
+			max = simple_strtoul(fmt + 1, (char **) &fmt, 10);
+		else
+			max = min;
+	}
+
+	/* From modutils:insmod/insmod.c:v2.4.1 lines 805-972 */
+	while (*input) {
+		static char *str __initdata = NULL;
+
+		switch (*fmt) {
+		case 's':
+		case 'c':
+			/*
+			 * Do C quoting if we begin with a ",
+			 * else slurp the lot.
+			 */
+			if (*input == '"') {
+				static char *r __initdata = NULL;
+
+				str = alloca(strlen(input));
+				for (r = str, input++; *input != '"'; ++input, ++r) {
+					if (*input == '\0') {
+						printk("improperly terminated string argument for %s\n", name);
+						return 0;
+					}
+					/* else */
+					if (*input != '\\') {
+						*r = *input;
+						continue;
+					}
+					/* else  handle \ */
+					switch (*++input) {
+					case 'a': *r = '\a'; break;
+					case 'b': *r = '\b'; break;
+					case 'e': *r = '\033'; break;
+					case 'f': *r = '\f'; break;
+					case 'n': *r = '\n'; break;
+					case 'r': *r = '\r'; break;
+					case 't': *r = '\t'; break;
+
+					case '0':
+					case '1':
+					case '2':
+					case '3':
+					case '4':
+					case '5':
+					case '6':
+					case '7':
+						c = *input - '0';
+						if ('0' <= input[1] && input[1] <= '7') {
+							c = (c * 8) + *++input - '0';
+							if ('0' <= input[1] && input[1] <= '7')
+								c = (c * 8) + *++input - '0';
+						}
+						*r = c;
+						break;
+
+					default: *r = *input; break;
+					}
+				}
+				*r = '\0';
+				++input;
+			} else {
+				/*
+				 * The string is not quoted.
+				 * We will break it using the comma
+				 * (like for ints).
+				 * If the user wants to include commas
+				 * in a string, he just has to quote it
+				 */
+				static char *r __initdata = NULL;
+
+				/* Search the next comma */
+				if ((r = strchr(input, ',')) != NULL) {
+					/*
+					 * Found a comma
+					 * Recopy the current field
+					 */
+					str = alloca(r - input + 1);
+					memcpy(str, input, r - input);
+					str[r - input] = '\0';
+					/* Keep next fields */
+					input = r;
+				} else {
+					/* last string */
+					str = input;
+					input = "";
+				}
+			}
+
+			if (*fmt == 's') {
+				/* Normal string - kstrdup please? */
+				*(char **)loc = kmalloc(strlen(str) + 1, GFP_KERNEL);
+				if (*(char **)loc == NULL) {
+					/* Bail on this variable */
+					printk("parameter %s - kmalloc() failed\n", name);
+				} else
+					strcpy(*(char **)loc, str);
+
+				(char *)loc += tgt_sizeof_char_p;
+			} else {
+				/* Array of chars (in fact, matrix !) */
+				static long charssize __initdata = 0;	/* size of each member */
+
+				/* Get the size of each member */
+				/* Probably we should do that outside the loop ? */
+				if (!isdigit(*(fmt + 1))) {
+					printk("parameter type 'c' for %s must be followed by"
+					" the maximum size\n", name);
+					return 0;
+				}
+				charssize = simple_strtoul(fmt + 1, (char **) NULL, 10);
+
+				/* Check length */
+				if (strlen(str) >= charssize-1) {
+					printk("string too long for %s (max %ld)",
+					      name, charssize - 1);
+					return 0;
+				}
+				/* Copy to location */
+				strcpy((char *) loc, str);	/* safe, see check above */
+				(char *)loc += charssize;
+			}
+			/*
+			 * End of 's' and 'c'
+			 */
+			break;
+
+		case 'b':
+			*(char *)loc++ = simple_strtoul(input, &input, 0);
+			break;
+
+		case 'h':
+			*(short *) loc = simple_strtoul(input, &input, 0);
+			(char *)loc += tgt_sizeof_short;
+			break;
+
+		case 'i':
+			*(int *) loc = simple_strtoul(input, &input, 0);
+			(char *)loc += tgt_sizeof_int;
+			break;
+
+		case 'l':
+			*(long *) loc = simple_strtoul(input, &input, 0);
+			(char *)loc += tgt_sizeof_long;
+			break;
+
+		default:
+			printk("unknown parameter type '%c' for %s",
+			      *fmt, name);
+			return 0;
+		}
+		/*
+		 * end of switch (*fmt)
+		 */
+
+		while (*input && isspace(*input))
+			++input;
+		if (*input == '\0')
+			break; /* while (*input) */
+		/* else */
+
+		if (*input == ',') {
+			if (max && (++n > max)) {
+				printk("too many values for %s (max %d)", name, max);
+				return 0;
+			}
+			++input;
+			/* continue with while (*input) */
+		} else {
+			printk("invalid argument syntax for %s: '%c'",
+			      name, *input);
+			return 0;
+		}
+	} /* end of while (*input) */
+
+	if (min && (n < min)) {
+		printk("too few values for %s (min %d)", name, min);
+		return 0;
+	}
+
+	return 1;
+}
+#endif
 
 EXPORT_SYMBOL(memparse);
 EXPORT_SYMBOL(get_option);

David.
--
David Luyer                                        Phone:   +61 3 9674 7525
Senior Network Engineer        P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
