Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSLCAF1>; Mon, 2 Dec 2002 19:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSLCAF1>; Mon, 2 Dec 2002 19:05:27 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:41669 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265336AbSLCAFQ>; Mon, 2 Dec 2002 19:05:16 -0500
Message-ID: <3DEBF6BB.7000901@us.ibm.com>
Date: Mon, 02 Dec 2002 16:11:40 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@redhat.com>
Subject: [PATCH] (1/3) allow earlier command line parsing 
Content-Type: multipart/mixed;
 boundary="------------080604080505030005010802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080604080505030005010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I stumbled upon this code when I was trying to get an early printk 
working for 386.  There is a real need for things to be able to parse 
the command line in setup_arch(), for many architectures.

parse_options() no longer runs the setup functions, it only parses.
It may be called more than once with no ill effects.  This way it can 
be called in setup_arch(), then again in the generic start_kernel().

run_setup() comes along later and actually runs the __setup functions.
   It can do this in many phases, as long as parse_options() is called
first.  The last run_setup() is special because it goes through and
picks up all of the environment variables and init arguments that are
left over, setting them with setup_setenv()

-- 
Dave Hansen
haveblue@us.ibm.com


--------------080604080505030005010802
Content-Type: text/plain;
 name="A-ordered-setup-2.5.50-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="A-ordered-setup-2.5.50-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.968   -> 1.969  
#	include/linux/init.h	1.18    -> 1.19   
#	         init/main.c	1.83    -> 1.84   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/02	haveblue@elm3b96.(none)	1.969
# c-1
# --------------------------------------------
#
diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Mon Dec  2 15:59:01 2002
+++ b/include/linux/init.h	Mon Dec  2 15:59:01 2002
@@ -86,21 +86,27 @@
 #define __exitcall(fn)							\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
+#define SETUP_ARCH_BEGIN	0
+#define SETUP_ARCH_LATE		1
+#define SETUP_DEFAULT		2
+#define SETUP_ENV		3
 /*
  * Used for kernel command line parameter setup
  */
 struct kernel_param {
 	const char *str;
 	int (*setup_func)(char *);
+	int level;
 };
 
 extern struct kernel_param __setup_start, __setup_end;
-
-#define __setup(str, fn)						\
+#define __setup(str, fn) __ordered_setup(SETUP_DEFAULT, str, fn)
+	
+#define __ordered_setup(level, str, fn)					\
 	static char __setup_str_##fn[] __initdata = str;		\
 	static struct kernel_param __setup_##fn				\
 		 __attribute__((unused,__section__ (".init.setup")))	\
-		= { __setup_str_##fn, fn }
+		= { __setup_str_##fn, fn, level }
 
 #endif /* __ASSEMBLY__ */
 
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Mon Dec  2 15:59:01 2002
+++ b/init/main.c	Mon Dec  2 15:59:01 2002
@@ -136,20 +136,73 @@
 
 __setup("profile=", profile_setup);
 
-static int __init checksetup(char *line)
+#define MAX_KERNEL_ARGS 64
+static struct kernel_arg {
+	char* str;
+	int handled;
+} kernel_argv[MAX_KERNEL_ARGS];
+static int kernel_argc = -1;
+
+/*
+ * Any cmd-line option is taken to be an environment variable if it contains
+ * the character '='.
+ *
+ * This routine also checks for options meant for the kernel.
+ * These options are not given to init - they are for internal kernel use only.
+ */
+static void __init setup_setenv(char *line)
+{
+	static int args = 0;
+	static int envs = 1; /* TERM is set to 'linux' by default */
+
+	if (!strncmp(line,"init=",5)) {
+		line += 5;
+		execute_command = line;
+		/* In case LILO is going to boot us with default command line,
+		 * it prepends "auto" before the whole cmdline which makes
+		 * the shell think it should execute a script with such name.
+		 * So we ignore all arguments entered _before_ init=... [MJ]
+		 */
+		args = 0;
+		argv_init[0] = NULL;
+		return;
+	}
+	
+	/*
+	 * check if it's an environment variable or
+	 * an option.
+	 */
+	
+	if (strchr(line,'=')) {
+		if (envs >= MAX_INIT_ENVS)
+			return;
+		envp_init[++envs] = line;
+		envp_init[envs+1] = NULL;
+	} else {
+		if (args >= MAX_INIT_ARGS)
+			return;
+		if (*line) {
+			argv_init[++args] = line;
+			argv_init[args+1] = NULL;
+		}
+	}
+}
+
+static void __init checksetup(int setup_level, struct kernel_arg *arg)
 {
 	struct kernel_param *p;
+	char *line = arg->str;
 
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line,p->str,n)) {
-			if (p->setup_func(line+n))
-				return 1;
+		if (p->level == setup_level && !strncmp(line, p->str, n)) {
+			arg->handled = p->setup_func(line+n);
+			if (arg->handled)
+				return;
 		}
 		p++;
 	} while (p < &__setup_end);
-	return 0;
 }
 
 /* this should be approx 2 Bo*oMips to start (note initial shift), and will
@@ -223,22 +276,25 @@
 
 /*
  * This is a simple kernel command line parsing function: it parses
- * the command line, and fills in the arguments/environment to init
- * as appropriate. Any cmd-line option is taken to be an environment
- * variable if it contains the character '='.
+ * the command line, and saves it for later processing by run_setup().
+ * This is designed to be called more than once.  This way, individual
+ * architectures can call it as early as they want, or they can ignore
+ * it and let the generic code call it.
  *
- * This routine also checks for options meant for the kernel.
- * These options are not given to init - they are for internal kernel use only.
+ * Make sure not to modify "line" after you call this, because the 
+ * argv array keeps references inside of it.  
  */
-static void __init parse_options(char *line)
+void __init parse_options(char *line)
 {
 	char *next,*quote;
-	int args, envs;
-
+	
 	if (!*line)
 		return;
-	args = 0;
-	envs = 1;	/* TERM is set to 'linux' by default */
+
+	if( kernel_argc != -1 )
+		return;
+	kernel_argc = 0;
+
 	next = line;
 	while ((line = next) != NULL) {
                 quote = strchr(line,'"');
@@ -255,39 +311,37 @@
                 }
                 if (next != NULL)
                         *next++ = 0;
-		if (!strncmp(line,"init=",5)) {
-			line += 5;
-			execute_command = line;
-			/* In case LILO is going to boot us with default command line,
-			 * it prepends "auto" before the whole cmdline which makes
-			 * the shell think it should execute a script with such name.
-			 * So we ignore all arguments entered _before_ init=... [MJ]
-			 */
-			args = 0;
-			continue;
-		}
-		if (checksetup(line))
-			continue;
-		
-		/*
-		 * Then check if it's an environment variable or
-		 * an option.
-		 */
-		if (strchr(line,'=')) {
-			if (envs >= MAX_INIT_ENVS)
-				break;
-			envp_init[++envs] = line;
-		} else {
-			if (args >= MAX_INIT_ARGS)
-				break;
-			if (*line)
-				argv_init[++args] = line;
+
+		kernel_argv[kernel_argc++].str = line;
+		if (kernel_argc == MAX_KERNEL_ARGS) {
+			kernel_argc--;
+			return;
 		}
 	}
-	argv_init[args+1] = NULL;
-	envp_init[envs+1] = NULL;
 }
 
+/*
+ * This routine depends on parse_options() being called first.  If you 
+ * want to use this in setup_arch(), make sure you can parse_options() 
+ * first.  
+ *
+ * during the SETUP_ENV level, all previously unused variables will be
+ * filled in as arguments/environment to init as appropriate. 
+ *
+ */
+void __init run_setup(int setup_level)
+{
+	int i;
+	
+	for( i=0; i<kernel_argc; i++ ) {
+		struct kernel_arg *arg = &kernel_argv[i];
+		if (setup_level == SETUP_ENV && !arg->handled)
+			setup_setenv(arg->str);
+		else
+			checksetup(setup_level,arg);
+	}
+
+}
 
 extern void setup_arch(char **);
 extern void cpu_idle(void);
@@ -394,6 +448,8 @@
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
+	run_setup(SETUP_DEFAULT);
+	run_setup(SETUP_ENV);
 	trap_init();
 	extable_init();
 	rcu_init();

--------------080604080505030005010802--

