Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUHHCNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUHHCNu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUHHCNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:13:50 -0400
Received: from server02.akkaya.de ([213.168.83.203]:64113 "EHLO
	server02.akkaya.de") by vger.kernel.org with ESMTP id S264960AbUHHCNi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:13:38 -0400
From: Juergen Pabel <jpabel@akkaya.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Masking kernel commandline parameters (2.6.7)
Date: Sun, 8 Aug 2004 04:12:24 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408080413.29905.jpabel@akkaya.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

my patch allows for kernel commandline parameters (ie: from bootloader) to be masked in order to 
prevent later retrieval (/proc/cmdline for example). I plan on using this to pass a passphrase into the 
kernel for dm-crypt'ing the root partition (the according dm-crypt patch will be published on the 
dm-crypt list shortly).

The patch provides two new kernel parameters: hidden and secret.
hidden: masks the value for /proc/cmdline, but leaves the payload so that it is available for retrieval as 
if it was passed without being hidden
secret: masks like hidden, but allows the retrieval only via a destructive get-function
Thus, data protected with "hidden", will easily be readable by other kernel code, while "secret" ensures that 
at least it will be detectable if a parameter has been retrieved before (it won't be there for whomever is looking for 
it later on) - I am aware of the 'dirty' methods of getting access to the "secret" data, but the current method is 
probably good enough for most scenarios...after all, I started this out only as a way of masking /proc/cmdline.
It's impossible anyhow to protect this data perfectly...but the intention of "secret" is to allow for 'late' retrieval, like when 
a kernel module is loaded that will retrieve that data, which may be long after the system booted - for as long as
kernel memory access remains 'controlled' it should be an acceptable way of storing any sensitive data.

A few examples to illustrate:

I) rootfs=/dev/systemVG/root secret="dmcryptpass=/dev/systemVG/root:password"

The value "/dev/systemVG/root:password" will only be retrievable via the destructive get function (which is 
done in the dm-crypt module - this encoding of dmcryptpass allows multiple disks/passwords in a single option).
/proc/cmdline shows somethin' like (didn't count the stars)
rootfs=/dev/systemVG/root secret="*************************************"

II) rootfs=/dev/systemVG/root hidden="dmcryptpass=/dev/systemVG/root:password"

Same as above, only that the value can be retrieved via the usual kernel/module parameter framework (which my dm-crypt 
patch doesn't do), it internally transforms the given line into:
rootfs=/dev/systemVG/root         dmcryptpass=/dev/systemVG/root:password
while reading /proc/cmdline still only yields
rootfs=/dev/systemVG/root hidden="******************************************"


Also, within hidden and secret, single quotes are replaced with double quotes during processing in order to facilitate quoting 
transparently within these options:

rootfs=/dev/systemVG/root hidden="dmcryptpass='/dev/systemVG/root:password /dev/systemVG/swap:anotherpassword'"

becomes

rootfs=/dev/systemVG/root         dmcryptpass="/dev/systemVG/root:password /dev/systemVG/swap:anotherpassword"

Providing multiple hidden's and secret's also works (but not nesting...that wouldn't make any sense anyhow):
rootfs=/dev/systemVG/root hidden="dmcryptpass=/dev/systemVG/root:password" hidden="dmcryptpass=/dev/systemVG/swap:anotherpassword'"

In other news: I am thinking of setting up a special kernel+initrd/initramfs project that will ask the user "nicely" to authenticate 
(something lilo/grub don't provide afaik)...maybe even with a network based authentication scheme that results in the key - that 
will be passed to the then-to-be-kexec'd real boot kernel...contact me if interested (please include "[linux]" in the subject).

jp

ps: I got no clue who would be the appropriate contact for this patch - if it is interesting enough to be included, would someone 
please take it on - or let me know of who the appropriate maintainer would be (even without the dm-crypt thing, this feature seems 
like it would be of interest).

- ---
Jürgen Pabel, CISSP

Akkaya Consulting GmbH
Eupener Straße 137
50933 Köln

Internet: http://www.akkaya.de


- --- linux-2.6.7/init/main.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.7_hiddenkernelparams/init/main.c	2004-08-08 01:46:59.000000000 +0200
@@ -406,6 +406,7 @@ asmlinkage void __init start_kernel(void
 	page_address_init();
 	printk(linux_banner);
 	setup_arch(&command_line);
+	unclassify_arguments( &command_line[0], &saved_command_line[0]);
 	setup_per_cpu_areas();
 
 	/*
- --- linux-2.6.7/kernel/params.c	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7_hiddenkernelparams/kernel/params.c	2004-08-08 01:40:47.000000000 +0200
@@ -152,6 +152,139 @@ int parse_args(const char *name,
 	return 0;
 }
 
+/* COMMAND_LINE_SIZE appears not to be available on all archs */
+#ifndef COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE 1024
+#endif
+
+static char secret_kp_str[COMMAND_LINE_SIZE] = { 0, };
+static int  secret_kp_len = 0;
+
+/* needed to avoid error messages during parse_args call*/
+static int helper_ignore_unknown(char *param, char *val)
+{
+	return 0;
+}
+
+/* copy to secret buffer, replace ' with " and wipe original buffer */
+static int prepare_secret_kernelparam(const char *val, struct kernel_param *kp)
+{
+	int pos;
+
+	for ( pos=0; val[pos]; pos++ ) {
+		if ( val[pos] == '\'' )
+			secret_kp_str[secret_kp_len++] = '"';
+		else
+			secret_kp_str[secret_kp_len++] = val[pos];
+		((char*)val)[pos] = '*';
+	}
+	secret_kp_str[secret_kp_len++] = ' ';
+
+	if ( val[-1] == '"' )
+		((char*)val)[pos] = '"';
+
+	return 0;
+}
+
+/* mangles the commandline so that the payload of the hidden parameter is taken as-is */
+static int fix_hidden_kernelparam(const char *val, struct kernel_param *kp)
+{
+	int n;
+
+	for ( n=0; val[n]; n++ ) 
+		if ( val[n] == '\'' )
+			((char*)val)[n] = '"';
+
+	if ( val[-1] == '"' )
+	{
+		((char*)val)[n] = '"';
+		n = 8; /* strlen("hidden=\"") == 8 */
+	}
+	else
+	{
+		n = 7; /* strlen("hidden=") == 7 */
+	}
+	memset( &((char*)val)[-n], ' ', n );
+
+	return 0;
+}
+
+/* masks the content of the hidden parameter */
+static int mask_hidden_kernelparam(const char *val, struct kernel_param *kp)
+{
+	int pos;
+
+	for ( pos=0; val[pos]; pos++ ) 
+		((char*)val)[pos] = '*';
+
+	if ( val[-1] == '"' )
+		((char*)val)[pos] = '"';
+
+	return 0;
+}
+
+/* remembers each equal sign for restoration and initiates the parsing process  */
+static void process_command_line( const char *msg, char *data, struct kernel_param* kp )
+{
+	char tmp[COMMAND_LINE_SIZE];
+	int pos;
+
+	for ( pos=0; data[pos]; pos++ )
+		tmp[pos] = (data[pos] ^ '=') ? 0x00 : 0xff;
+	parse_args( msg, data, kp, 1, &helper_ignore_unknown );
+	while ( pos-- ) {
+		if ( !data[pos] )
+			data[pos] |= (tmp[pos] & '=');
+		if ( !data[pos] )
+			data[pos] = ' ';
+	}
+}
+
+/* !! feature only available for boot time parameters, not module options !! */
+void unclassify_arguments( char *pcommand_line, char *psaved_command_line )
+{
+	struct kernel_param param1 = { "secret", 000, prepare_secret_kernelparam, NULL };
+	struct kernel_param param2 = { "hidden", 000, fix_hidden_kernelparam, NULL };
+	struct kernel_param param3 = { "hidden", 000, mask_hidden_kernelparam, NULL };
+
+	process_command_line( "Preparing secret parameters", pcommand_line, &param1 );
+	process_command_line( "Preparing secret parameters", psaved_command_line, &param1 );
+	process_command_line( "Fixing hidden parameters", pcommand_line, &param2 );
+	process_command_line( "Masking hidden parameters",   psaved_command_line, &param3 );
+}
+
+/*
+ * retrieves the value of a hidden kernel parameter - the parameter and its value are
+ * erased after copying to the caller's buffer. at least then it's detectable if
+ * "someone else" retrieved the value before the intended recipient gets a chance
+ */
+int get_and_erase_secret_kernelparam( const char *key, char *buf, int buflen )
+{
+	char copy[COMMAND_LINE_SIZE];
+	char *next, *cur_key, *cur_val;
+        int found = 0;
+
+	if ( !key || *key == '\0' )
+		return found; /*not found*/
+
+	memcpy( &copy[0], &secret_kp_str[0], COMMAND_LINE_SIZE );
+	next = &copy[0];
+
+        while (*next) {
+		next = next_arg(next, &cur_key, &cur_val);
+		if ( !strcmp( key, cur_key ) ) {
+			if ( cur_val && buf && buflen )
+				strncpy( buf, cur_val, buflen-1 );
+
+			memset( &secret_kp_str[ cur_key-&copy[0] ], ' ', next-cur_key );
+			found = 1;
+		}
+	}
+
+	memset( copy, '\0', COMMAND_LINE_SIZE );
+	return found;
+}
+
 /* Lazy bastard, eh? */
 #define STANDARD_PARAM_DEF(name, type, format, tmptype, strtolfn)      	\
 	int param_set_##name(const char *val, struct kernel_param *kp)	\
- --- linux-2.6.7/include/linux/moduleparam.h	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.7_hiddenkernelparams/include/linux/moduleparam.h	2004-08-08 01:07:11.000000000 +0200
@@ -147,4 +147,8 @@ int param_array(const char *name,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
 		int *num);
+
+extern void unclassify_arguments( char *pcommand_line, char* psaved_command_line );
+extern int get_and_erase_secret_kernelparam( const char *key, char *buf, int buflen );
+
 #endif /* _LINUX_MODULE_PARAMS_H */
- --- linux-2.6.7/Documentation/kernel-parameters.txt	2004-06-16 07:20:26.000000000 +0200
+++ linux-2.6.7_hiddenkernelparams/Documentation/kernel-parameters.txt	2004-08-08 02:32:36.000000000 +0200
@@ -450,6 +450,14 @@ running once the system is up.
 	hd?=		[HW] (E)IDE subsystem
 	hd?lun=		See Documentation/ide.txt.
 
+	hidden=		Masks the value with askteriks (*) in /proc/cmdline and presents the values as
+	                vanilla parameters to the kernel internally (ie: hidden="rootfs=/dev/ram0 debug")
+			this is usefull to pass passwords to the kernel via boot parameter. Single quotes
+			within the double quotes are replaced with double quotes to provide quoting within
+			the hidden payload (hidden="test='1 2 3'" becomes test="1 2 3")
+			See also secret= for an even more protective means of passing sensitive data via
+			boot parameter
+
 	hisax=		[HW,ISDN]
 			See Documentation/isdn/README.HiSax.
 
@@ -989,6 +997,10 @@ running once the system is up.
 
 	scsihosts=	[SCSI]
 
+	secret=		Like hidden, only that the content is not even available to the kernel via the normal
+			kernel/module parameter interfaces - but has to be retrieved through a special function
+			(which in allows only a single get operation for each parameter)
+
 	serialnumber	[BUGS=IA-32]
 
 	sf16fm=		[HW] SF16FMI radio driver for Linux
- --- linux-2.6.7/CREDITS	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.7_hiddenkernelparams/CREDITS	2004-08-08 01:58:11.000000000 +0200
@@ -2430,6 +2430,15 @@ S: Subiaco, 6008
 S: Perth, Western Australia
 S: Australia
 
+N: Juergen Pabel
+E: jpabel@akkaya.de
+D: Boot parameter hiding
+S: Akkaya Consulting GmbH
+S: Eupender Strasse 137
+S: 50933 Koeln
+S: Germany
+S: http://www.akkaya.de
+
 N: Greg Page
 E: gpage@sovereign.org
 D: IPX development and support
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBFYwWz6J7R+QJGuwRAqxLAJ9Vk5Yl8Ir1YhK8VKyFaJaOIAHjngCfVihA
6U/GLHR8A7uPennzj1bRs+8=
=ZoIe
-----END PGP SIGNATURE-----
