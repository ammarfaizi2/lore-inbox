Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292079AbSBAVhh>; Fri, 1 Feb 2002 16:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292080AbSBAVhb>; Fri, 1 Feb 2002 16:37:31 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:25243 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292079AbSBAVhX>; Fri, 1 Feb 2002 16:37:23 -0500
Date: Fri, 1 Feb 2002 16:38:05 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net
Subject: GCOV coverage support under linux
Message-ID: <20020201163805.A6900@elinux01.watson.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


GCOV kernel support for Linux
=============================

What is GCOV?
-------------
gcov is a test coverage program, which helps discover where your 
optimization efforts will best affect your code. Using gcov one can find 
out some basic performance statistics on a per source file level such as:
        * how often each line of code executes
        * what lines of code are actually executed
        * how much computing time each section of code uses


What we implemented?
--------------------
gcov is already available for user level applications. 
We implemented gcov support for the linux kernel, by providing
coverage support infrastructure to the kernel and a dynamic
module (gcov-prof.o) to produce the basic block profile information, 
which gives the statistics for the running kernel and modules. 


Installing GCOV support on the kernel
-------------------------------------
To provide the coverage support infrastructure to the kernel,
install the gcov patch (2.4.17-gcov-kernel.patch) from the root
level of the kernel source path, as

        patch -p1< {path}/2.4.17-gcov-kernel.patch

and compile the kernel. 
In order to produce the profiling information, compile and install the
gcov-prof.o module as follows:

        make 
        insmod gcov-prof.o

and to remove the module, run

        rmmod gcov-prof

The detailed explanation of how gcov-prof provides the statistics
information are in "How it works?" section.

Configuring the kernel
----------------------

To configure the entire kernel for gcov profiling, run
        make xconfig or menuconfig

There are two options under GCOV coverage profiling. They are
        * enable GCOV kernel
        * GCOV kernel profiler

where "enable GCOV kernel" will provide the infrastructure for 
coverage support for the kernel. 
But this will not compile the kernel with the necessary flags. 

To obtain the coverage information for the entire kernel, one should
enable the "GCOV kernel profiler" option. 

To get the profiling information for a particular file or directory of
the kernel, provide the following compile options for such targets 
itself, like

        CLAGS += ($CFLAGS $LPROF_FLAGS)

where LPROF_FLAGS is "-fprofile-arcs -ftest-coverage"

How it works?
-------------

Here is the brief explanation of how gcov works for user level
applications.

The C compiler supports the command line options -fprofile-arcs and
-ftest-coverage. These options cause the compiler to insert additional
code in the object files. These options also generate two files
(a) <sourcefile>.bb and (b) <sourcefile>.bbg, where 
        * .bb file contains a list of source files (including headers), 
functions within those files, and line numbers corresponding to each 
basic block in the source file.
        * .bbg file contains a list of the program flow arcs for each
function which in combination with the .bb file enables gcov to 
reconstruct the program flow.

Upon executing a gcov enabled user program, it dumps the counter
information into <sourcefile>.da at the time of exit.

Running gcov with the program's source file name as argument, will combine the
information from .bb, .bbg and .da files and produce a listing of the code 
along with the frequency of execution of each line. 

For further detailed information, refer gcov.readme which is the text
form of gcc/doc/gcov.texi from the GCC source code.

As the kernel never does exit as a program, this cannot be deployed in such a
fashion. The .da file is made available under /proc/gcov/{kernel source path}.

For example:
Consider a file ./kernel/sched.c. After compiling this file, the
compiler will generate .bb and .bbg file and it will be in the directory
where the source code is located. ie. ./kernel/sched.bb and ./kernel/sched.bbg.

Installing the gcov-prof kernel module will create a file at 
/proc/gcov/kernel/sched.da and create symbolic links for the files
 ./kernel/sched.c, ./kernel/sched.bb and ./kernel/sched.bbg to
/proc/gcov. We opted for providing these links in order to allow usage
of an unmodified gcov tool.

Finally there will be 4 files under /proc ie.

/proc/gcov/kernel/sched.c
/proc/gcov/kernel/sched.bb
/proc/gcov/kernel/sched.bbg
/proc/gcov/kernel/sched.da

This is the same for all the files which built with the gcov 
options(-fprofile-arcs and -ftest-coverage).

Now to see the statistics information for the sched.c, run gcov
from any of your local directory as follows:

        gcov -o /proc/gcov/kernel /proc/gcov/kernel/sched.c

This will generate results in the local directory as sched.c.gcov.

Here is a sample output from the signal.c.gcov file

                static void handle_stop_signal(int sig, struct task_struct *t)
                {
        8392            switch (sig) {
           7            case SIGKILL: case SIGCONT:
                                /* Wake up the process if stopped.  */
           7                    if (t->state == TASK_STOPPED)
      ######                            wake_up_process(t);
           7                    t->exit_code = 0;
           7                    rm_sig_from_queue(SIGSTOP, t);
           7                    rm_sig_from_queue(SIGTSTP, t);
           7                    rm_sig_from_queue(SIGTTOU, t);
           7                    rm_sig_from_queue(SIGTTIN, t);
        8385                    break;
 
                        case SIGSTOP: case SIGTSTP:
                        case SIGTTIN: case SIGTTOU:
                                /* If we're stopping again, cancel SIGCONT */
      ######                    rm_sig_from_queue(SIGCONT, t);
        8385                    break;
        8385            }
                }

where "######" represents no execution.

Here are the various arguments for invoking gcov

     gcov [-b] [-c] [-v] [-n] [-l] [-f] [-o directory] SOURCEFILE
 
-b
     Write branch frequencies to the output file, and write branch
     summary info to the standard output.  This option allows you to
     see how often each branch in your program was taken.
 
-c
     Write branch frequencies as the number of branches taken, rather
     than the percentage of branches taken.
 
-v
     Display the `gcov' version number (on the standard error stream).
 
-n
     Do not create the `gcov' output file.
 
-l
     Create long file names for included source files.  For example, if
     the header file `x.h' contains code, and was included in the file
     `a.c', then running `gcov' on the file `a.c' will produce an
     output file called `a.c.x.h.gcov' instead of `x.h.gcov'.  This can
     be useful if `x.h' is included in multiple source files.
 
-f
     Output summaries for each function in addition to the file level
     summary.
 
-o
     The directory where the object files live.  Gcov will search for
     `.bb', `.bbg', and `.da' files in this directory.           


Resetting the counters:
----------------------
        One can dynamically reset the counters of the file, by writing "0" 
to the required .da file.

For example, if you want to reset the counters in sched.c then executing
the command

        echo "0">/proc/gcov/kernel/sched.da

will reset the counters.


There will be a /proc/gcov/vmlinux file which holds the block information
of all the files compiled with gcov options.

Executing

        echo "0">/proc/gcov/vmlinux

will reset all the counters in the kernel.


To Do's
-------

Before compiling the gcov-prof kernel module, provide your exact include 
path directory in Makefile (-I{include path} in MODCFLAGS).

Tested Environment
------------------
We have tested this on RedHat 7.0 and 7.2 under gcc versions 2.91.66 and 
3.0.3. 

Problems
--------
gcc does not provide atomic operations for statistics counters. This needs to 
be supported in gcc. As a result counters value can be overridden and may
produce improper results.

What we are working on
----------------------

Currently dynamic module support is lacking. In order to support this we are
modifying insmod and rmmod, and pass their initialisation structures (.ctors) 
to the kernel.


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.17-gcov-kernel.patch"

diff -urbN linux-2.4.17-v/Documentation/Configure.help linux-2.4.17-gcov/Documentation/Configure.help
--- linux-2.4.17-v/Documentation/Configure.help	Fri Dec 21 12:41:53 2001
+++ linux-2.4.17-gcov/Documentation/Configure.help	Wed Jan 30 13:30:21 2002
@@ -24208,7 +24208,6 @@
   of these is normally used as the system console.
 
   If in doubt, press "y".
-
 Use LinuxSH standard BIOS
 CONFIG_SH_STANDARD_BIOS
   Say Y here if your target has the gdb-sh-stub
@@ -24236,6 +24235,23 @@
   If you are using GDB for remote debugging over a serial port and
   would like kernel messages to be formatted into GDB $O packets so
   that GDB prints them as program output, say 'Y'.
+
+Include GCOV coverage profiling
+CONFIG_GCOV_PROFILE
+  Provide infrastructure for coverage support for the kernel. This
+  will not compile the kernel by default with the necessary flags.
+  To obtain coverage information for the entire kernel, one should
+  enable the subsequent option (Profile entire kernel). If only
+  particular files or directories of the kernel are desired, then
+  one must provide the following compile options for such targets:
+	"-fprofile-arcs -ftest-coverage" in the CFLAGS. To obtain
+  access to the coverage data one must insmod the gcov-prof kernel
+  module.
+
+Include GCOV kernel profiler 
+CONFIG_GCOV_ALL
+  If you say Y here, it will compile the entire kernel with coverage
+  option enabled. 
 
 #
 # A couple of things I keep forgetting:
diff -urbN linux-2.4.17-v/Makefile linux-2.4.17-gcov/Makefile
--- linux-2.4.17-v/Makefile	Wed Jan 30 09:45:31 2002
+++ linux-2.4.17-gcov/Makefile	Wed Jan 30 13:30:21 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 17
-EXTRAVERSION =
+EXTRAVERSION =-gcov
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
@@ -18,7 +18,7 @@
 
 HOSTCC  	= gcc
 HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-
+LPROF_FLAGS	= -fprofile-arcs -ftest-coverage
 CROSS_COMPILE 	=
 
 #
@@ -296,7 +296,11 @@
 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))
 
 $(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h include/config/MARKER
+ifdef CONFIG_GCOV_ALL
+	$(MAKE) CFLAGS="$(CFLAGS) $(LPROF_FLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
+else
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
+endif
 
 $(TOPDIR)/include/linux/version.h: include/linux/version.h
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
@@ -412,7 +416,7 @@
 endif
 
 clean:	archclean
-	find . \( -name '*.[oas]' -o -name core -o -name '.*.flags' \) -type f -print \
+	find . \( -name '*.[oas]' -o -name core -o -name '.*.flags' -o -name '*.bb' -o -name '*.bbg' \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	rm -f $(CLEAN_FILES)
 	rm -rf $(CLEAN_DIRS)
@@ -428,7 +432,7 @@
 	rm -f core `find . \( -not -type d \) -and \
 		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
-		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags
+		-o -name '.*.rej' -o -name '.SUMS' -o -name '*.bb' -o -name '*.bbg' -o -size 0 \) -type f -print` TAGS tags
 
 backup: mrproper
 	cd .. && tar cf - linux/ | gzip -9 > backup.gz
diff -urbN linux-2.4.17-v/arch/i386/config.in linux-2.4.17-gcov/arch/i386/config.in
--- linux-2.4.17-v/arch/i386/config.in	Fri Dec 21 12:41:53 2001
+++ linux-2.4.17-gcov/arch/i386/config.in	Wed Jan 30 13:30:21 2002
@@ -414,5 +414,14 @@
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
+endmenu
+
+mainmenu_option next_comment
+comment 'GCOV coverage profiling'
+
+bool 'GCOV kernel' CONFIG_GCOV_PROFILE
+if [ "$CONFIG_GCOV_PROFILE" != "n" ]; then
+   bool '  GCOV kernel profiler' CONFIG_GCOV_ALL
+fi
 
 endmenu
diff -urbN linux-2.4.17-v/arch/i386/kernel/head.S linux-2.4.17-gcov/arch/i386/kernel/head.S
--- linux-2.4.17-v/arch/i386/kernel/head.S	Wed Jun 20 14:00:53 2001
+++ linux-2.4.17-gcov/arch/i386/kernel/head.S	Wed Jan 30 13:30:21 2002
@@ -455,3 +455,10 @@
  */
 .section .text.lock
 ENTRY(stext_lock)
+
+#ifdef CONFIG_GCOV_PROFILE
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+#endif
diff -urbN linux-2.4.17-v/kernel/Makefile linux-2.4.17-gcov/kernel/Makefile
--- linux-2.4.17-v/kernel/Makefile	Mon Sep 17 00:22:40 2001
+++ linux-2.4.17-gcov/kernel/Makefile	Fri Feb  1 09:32:29 2002
@@ -9,6 +9,7 @@
 
 O_TARGET := kernel.o
 
+
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
@@ -16,10 +17,16 @@
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o
 
+ifdef CONFIG_GCOV_PROFILE
+obj-y += gcov.o
+CFLAGS_gcov.o := -DGCOV_PATH='"$(TOPDIR)"'
+endif
+
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
 
+
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
@@ -29,4 +36,7 @@
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
+
 include $(TOPDIR)/Rules.make
+
+
diff -urbN linux-2.4.17-v/kernel/gcov.c linux-2.4.17-gcov/kernel/gcov.c
--- linux-2.4.17-v/kernel/gcov.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.17-gcov/kernel/gcov.c	Fri Feb  1 14:47:25 2002
@@ -0,0 +1,59 @@
+/*
+ *  linux/kernel/gcov.c
+ *
+ *  Kernel basic block profile / coverage data 
+ *
+ *  (C) 2002 by Hubertus Franke, IBM T.J.Watson Research Center
+ *  This software is distributed under the terms of GNU GPL                                
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/completion.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+
+struct bb
+{
+  long zero_word;
+  const char *filename;
+  long *counts;
+  long ncounts;
+  struct bb *next;
+  const unsigned long *addresses;
+
+  /* Older GCC's did not emit these fields.  */
+  long nwords;
+  const char **functions;
+  const long *line_nums;
+  const char **filenames;
+  char *flags;
+};
+
+struct bb *bb_head;
+
+#ifdef GCOV_PATH
+char *gcov_kernelpath = GCOV_PATH;
+#else
+char *gcov_kernelpath = __FILE__;
+#endif
+
+
+void
+__bb_init_func (struct bb *blocks)
+{
+  printk("bb_init_func<%s> %ld\n", blocks->filename,blocks->ncounts);
+  if (blocks->zero_word)
+    return;
+
+  /* Set up linked list.  */
+  blocks->zero_word = 1;
+  blocks->next = bb_head;
+  bb_head = blocks;
+}
+
diff -urbN linux-2.4.17-v/kernel/ksyms.c linux-2.4.17-gcov/kernel/ksyms.c
--- linux-2.4.17-v/kernel/ksyms.c	Fri Dec 21 12:42:04 2001
+++ linux-2.4.17-gcov/kernel/ksyms.c	Wed Jan 30 18:27:27 2002
@@ -65,6 +65,13 @@
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
 
+#ifdef CONFIG_GCOV_PROFILE
+extern struct bb *bb_head;
+extern void __bb_init_func(struct bb *blocks);
+extern long __CTOR_LIST__;
+extern char *gcov_kernelpath;
+#endif
+
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
 __attribute__((section("__ksymtab"))) = {
@@ -559,3 +566,10 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+#ifdef CONFIG_GCOV_PROFILE
+EXPORT_SYMBOL(bb_head);
+EXPORT_SYMBOL(__bb_init_func);
+EXPORT_SYMBOL(__CTOR_LIST__);
+EXPORT_SYMBOL(gcov_kernelpath);
+#endif

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gcov-prof.c"

/*
 *  gcov.c
 *
 *  Kernel module which produces basic block profile / coverage data
 *  for the kernel files.
 *
 *  (C) 2002 by Hubertus Franke, IBM T.J.Watson Research Center
 *  This software is distributed under the terms of GNU GPL
 */            

#if CONFIG_MODVERSIONS==1
#define MODVERSIONS
#include <linux/modversions.h>
#endif

#include <linux/config.h>
#include <linux/kernel.h>   
#include <linux/module.h>   

#include <linux/proc_fs.h>
#include <asm/uaccess.h>
#include <linux/fs.h>

#define GCOV_PROF_PROC		"gcov"

struct bb
{
  long zero_word;
  const char *filename;
  long *counts;
  long ncounts;
  struct bb *next;
  const unsigned long *addresses;

  /* Older GCC's did not emit these fields.  */
  long nwords;
  const char **functions;
  const long *line_nums;
  const char **filenames;
  char *flags;
};

extern struct bb *bb_head;
static struct file_operations proc_gcov_operations;
extern char *gcov_kernelpath;
 
static int create_bb_links = 1;
static int   kernel_path_len;

struct gcov_ftree_node
{
        int   isdir;    /* directory or file */
        char *fname;    /* only the name within the hierachy */
        struct gcov_ftree_node *sibling;   /* sibling of tree  */
        struct gcov_ftree_node *files;  /* children of tree */
        struct gcov_ftree_node *parent; /* parent of current gcov_ftree_node */
        struct proc_dir_entry  *proc[4];
	struct bb              *bb;
	/* below only valid for leaf nodes == files */
	unsigned long  offset;          /* offset in global file */
	struct gcov_ftree_node *next;   /* next leave node       */
};

static struct proc_dir_entry  *proc_vmlinux = NULL;
static struct gcov_ftree_node *leave_nodes = NULL;
static struct gcov_ftree_node *dumpall_cached_node = NULL;
static struct gcov_ftree_node tree_root  = 
	{ 1, GCOV_PROF_PROC, NULL, NULL, NULL, { NULL, NULL, NULL, NULL} , NULL, 0,NULL };
static char *endings[3] = { ".bb", ".bbg", ".c" };

static inline unsigned long hdr_ofs(struct gcov_ftree_node *tptr)
{
	return ( (8 + strlen(tptr->bb->filename)+1 + 7) & ~7);
}

static inline unsigned long dump_size(struct gcov_ftree_node *tptr)
{
	return (hdr_ofs(tptr) + (tptr->bb->ncounts+1)*8);
}

static void
store_long (long value, void *buf)
{
	const int bytes = 8;
        char dest[10];
        int upper_bit = (value < 0 ? 128 : 0);
        size_t i;
 
        if (value < 0)
        {
                long oldvalue = value;
                value = -value;
                if (oldvalue != -value)
                return;
        }
 
        for(i = 0 ; i < (sizeof (value) < bytes ? sizeof (value) : bytes) ; i++) {
                dest[i] = value & (i == (bytes - 1) ? 127 : 255);
                value = value / 256;
        }
 
        if (value && value != -1)
        return;
 
        for(; i < bytes ; i++)
                dest[i] = 0;
        dest[bytes - 1] |= upper_bit;
        memcpy(buf,dest,bytes);
}                          

int
create_dir_proc(struct gcov_ftree_node *bt, char *fname) 
{
	bt->proc[0] = proc_mkdir(fname, bt->parent->proc[0]);
	bt->proc[1] = bt->proc[2] = bt->proc[3] = NULL;
        return (bt->proc[0] == NULL);
}

static 
char* replace_ending(const char *fname,char *end, char *newend)
{
	char *newfname;
	char *cptr = strstr(fname,end);
	int len;
	if (cptr == NULL) 
		return NULL;
	len = cptr - fname;
	newfname = (char*)kmalloc(len+strlen(newend)+1,GFP_KERNEL);
	if (newfname == NULL) 
		return NULL;
	memcpy(newfname,fname,len);
	strcpy(newfname+len,newend);
	return newfname;	
} 
	
int
create_file_proc(struct gcov_ftree_node *bt, struct bb *bptr, char *fname, const char *fullname) 
{

        bt->proc[0]  = create_proc_entry(fname, S_IWUSR | S_IRUGO, 
					bt->parent->proc[0]);
        if (!bt->proc[0]) {
		printk("error creating file proc <%s>\n", fname);
		return 1;
	}

        bt->proc[0]->proc_fops = &proc_gcov_operations;
	bt->proc[0]->size = 8 + (8 * bptr->ncounts);

	if (create_bb_links) {
		int i;
		for (i=0;i<3;i++) {
			char *newfname;
			char *newfullname;
			newfname    = replace_ending(fname,".da",endings[i]);
			newfullname = replace_ending(fullname,".da",endings[i]);
			if ((newfname) && (newfullname)) {
				bt->proc[i+1]  = proc_symlink(newfname,bt->parent->proc[0],newfullname);
			}
			if (newfname) kfree(newfname);
			if (newfullname) kfree(newfullname);
		}
	} else {
		bt->proc[1] = bt->proc[2] = bt->proc[3] = NULL; 
	}
	return 0;
}

void check_proc_fs(const char *fullname, struct gcov_ftree_node *parent, 
		   char *name, struct bb *bbptr)
{
        char dirname[128];
        char *localname = name;
        char *tname;
        int  isdir;
        struct gcov_ftree_node *tptr;


        tname = strstr(name, "/");
        if ((isdir = (tname != NULL))) {
                memcpy(dirname,name,tname-name);
                dirname[tname-name] = '\0';
                localname = dirname;
        }

        /* search the list of files in gcov_ftree_node and 
	 * see whether file already exists in this directory level */
        for ( tptr = parent->files ; tptr ; tptr = tptr->sibling) {
                if (!strcmp(tptr->fname,localname))
                        break;
        }
        if (!tptr) {
                /* no entry yet */
                tptr = (struct gcov_ftree_node*)
			kmalloc(sizeof(struct gcov_ftree_node),GFP_KERNEL);
                tptr->parent  = parent;

                if (!isdir) {
                        if (create_file_proc(tptr, bbptr, localname,fullname)) {
                                kfree(tptr);
                                return;
                        }
			tptr->bb         = bbptr;
			tptr->proc[0]->data = tptr;
			tptr->next = leave_nodes;
			leave_nodes = tptr;
                } else {
                        int len = strlen(dirname)+1;
                        localname = (char*)kmalloc(len,GFP_KERNEL);
                        strncpy(localname,dirname,len);
                        if (create_dir_proc(tptr,localname)) {
                                kfree(tptr);
                                kfree(localname);
                                return;
                        }
			tptr->bb         = NULL;
			tptr->proc[0]->data = NULL;
			tptr->next       = NULL;
                }
		tptr->isdir   = isdir;
		tptr->fname   = localname;
		tptr->files   = NULL;
                tptr->sibling = parent->files;
                parent->files = tptr;
        }
        if (isdir)
                check_proc_fs(fullname,tptr,tname+1,bbptr);
}

void walk_tree(struct gcov_ftree_node *root,char *buf,int depth)
{
        struct gcov_ftree_node *bptr;
        char lbuf[128];

        if (!root->isdir) {
#if 0
		int len = dump_size(root);
                printk("%d> %s/%s %d [%ld - %ld]\n",
                        depth,buf,root->fname,len,
                        root->offset,root->offset+len);
#endif
                return;
        }
        sprintf(lbuf,"%s/%s",buf,root->fname);
        sprintf(lbuf,"%s/%s",buf,root->fname);
        for (bptr = root->files; bptr; bptr = bptr->sibling) {
                walk_tree(bptr,lbuf,depth+1);
        }
}


static ssize_t read_gcov(struct file *file, char *buf,
                         size_t count, loff_t *ppos)
{
        unsigned long p = *ppos;
        ssize_t read;
	long ncnt;
	struct bb *bbptr;
	long  slen;
	long *wptr;
	struct gcov_ftree_node *treeptr; 
        struct proc_dir_entry * de;
        struct inode *inode;
	int dumpall;
	int hdrofs;
	unsigned long poffs;

	MOD_INC_USE_COUNT;

	read   = 0;
	hdrofs = 0;
	poffs  = 0;
	inode  = file->f_dentry->d_inode;
        de = (struct proc_dir_entry *) inode->u.generic_ip;
	dumpall = (de == proc_vmlinux);


	if (!dumpall)
		treeptr = (struct gcov_ftree_node*) (de ? de->data : NULL);
	else {
		if (dumpall_cached_node && (p >= dumpall_cached_node->offset)) {
			treeptr = dumpall_cached_node;
		}
		else
			treeptr = leave_nodes;

		while (treeptr) {
			struct gcov_ftree_node *next = treeptr->next;
			if ((next == NULL) || (p < next->offset)) {
				hdrofs = hdr_ofs(treeptr);
				poffs  = treeptr->offset;
				break;
			}
			treeptr = next;
		}
		dumpall_cached_node = treeptr;
	}

	bbptr = treeptr ? treeptr->bb : NULL;

	if (bbptr == NULL)
		goto out;

	ncnt = bbptr->ncounts;
	p -= poffs;

	do { 
		if (p < (hdrofs)) {
			slen = (strlen(treeptr->bb->filename)+8) & ~7;
			if (p >= 8) { 
				if (slen > count) slen = count;
				memcpy(buf,&treeptr->bb->filename[p-8],slen);
				count-=slen;buf+= slen;read+=slen;p+= slen;
				continue;
			}
			wptr = &slen;
		} 
		else if (p < (hdrofs + 8)) 
			wptr = &ncnt;
		else if (p < (hdrofs) + (ncnt+1)*2*sizeof(long)) 
			wptr = &bbptr->counts[(p/8)-1];
		else
			break;
	
		/* do we have to write partial word */	

		if ((count < 8) || (p & 0x7)) {
			/* partial write */	
			printk("screw partial writes now\n");
			break;
		} else {
			store_long(*wptr,buf);
			buf+=8;p+=8,count-=8;read+=8;
		}
	} while (count > 0);
	*ppos = p + poffs;
out:
	MOD_DEC_USE_COUNT;
        return read;
}

static ssize_t write_gcov(struct file * file, const char * buf,
                             size_t count, loff_t *ppos)
{
        struct bb *ptr;
        struct proc_dir_entry * de;
        struct inode *inode;
	int resetall, i;
	struct gcov_ftree_node *tptr; 

	MOD_INC_USE_COUNT;

	inode  = file->f_dentry->d_inode;
        de = (struct proc_dir_entry *) inode->u.generic_ip;
	if (de == NULL) { 
		MOD_DEC_USE_COUNT;
		return 0;
	}
	resetall = (de == proc_vmlinux);

	if (resetall) {
		for (ptr = bb_head; ptr != (struct bb *) 0; ptr = ptr->next)
	        {
       	        	int i;
		        if (ptr->counts == NULL) continue;
			for (i = 0; i < ptr->ncounts; i++) 
				ptr->counts[i]=0;
		}
	} else {
		tptr = (struct gcov_ftree_node*)(de->data);
		if (tptr == NULL) {
			MOD_DEC_USE_COUNT;
			return count;
		}
		ptr = tptr->bb; 
	        if (ptr->ncounts != 0) {
                	for (i = 0; i < ptr->ncounts; i++) 
				ptr->counts[i]=0;
		}
	}
	MOD_DEC_USE_COUNT;
        return count;
}

void do_create_bb (void)
{
        extern long __CTOR_LIST__;
 
        typedef void (*func_ptr)(void) ;
 
        func_ptr *p = (func_ptr*) &__CTOR_LIST__;
 
        if ( p == NULL) {
                printk("No CTORS\n");
                return;
        }
        for ( ; *p != (func_ptr) 0; p++) {
                printk("do_create_bb:   %p\n", p);
                (*p) ();
        }
}             

static struct file_operations proc_gcov_operations = {
        read:           read_gcov,
	write:		write_gcov
};

int nctr = 1;

int init_module()
{
        const char *tmp;
	struct bb *bbptr;
	unsigned long offset = 0;
	struct gcov_ftree_node *tptr; 

	printk("init module <%s>\n", GCOV_PROF_PROC);

	if (!bb_head)
		do_create_bb();
	
        tree_root.proc[0] = proc_mkdir(GCOV_PROF_PROC, 0);
        kernel_path_len = strlen(gcov_kernelpath);

	for (bbptr = bb_head; bbptr ; bbptr = bbptr->next) {

                const char *filename = bbptr->filename;

                if (!strncmp (filename, gcov_kernelpath, kernel_path_len))
                {
//			printk("%03d <%s>\n", nctr++, bbptr->filename);
                        tmp =filename + kernel_path_len+1;
                        if (*tmp == '0') continue;

                        check_proc_fs(filename,&tree_root, (char*)tmp, bbptr);
                }
        }

	/* now inverse the pointers of the leave_nodes for caching purposes */
	for (tptr = leave_nodes; tptr; tptr = tptr->next) {
		tptr->offset = offset; 
		offset = dump_size(leave_nodes);
	}
		

	proc_vmlinux = create_proc_entry("vmlinux",S_IWUSR | S_IRUGO, 
					 tree_root.proc[0]);
	if (proc_vmlinux)
		proc_vmlinux->proc_fops = &proc_gcov_operations;

	walk_tree(&tree_root,"",0);
	return 0;
}

void cleanup_node(struct gcov_ftree_node *node, int delname)
{
	struct gcov_ftree_node *next,*tptr;
	struct proc_dir_entry *par_proc;

	if (node->parent) 
		par_proc = (struct proc_dir_entry*)(node->parent->proc[0]);
	else
		par_proc = &proc_root;

	if (node->isdir) {
		next = node->files;
		node->files = NULL;
		for (tptr = next ; tptr; ) {
			next = tptr->sibling;
			cleanup_node(tptr,1);
			kfree(tptr);
			tptr = next;
		}
		remove_proc_entry(node->fname, par_proc);
		if (delname) kfree(node->fname);
	} else {
		remove_proc_entry(node->fname, par_proc);
        	if (create_bb_links) {
	                int i;
        	        for (i=0;i<3;i++) {
                	        char *newfname;
				if (node->proc[i+1] == NULL) continue;
	                        newfname    = replace_ending(node->fname,".da",endings[i]);
                	        if (newfname) {
					remove_proc_entry(newfname, par_proc);
                        		kfree(newfname);
				}
			}
                }     
	}
	node->proc[0]->data = NULL;
}

void cleanup_module()
{
	printk("remove module <%s>\n", GCOV_PROF_PROC);
	cleanup_node(&tree_root,0); 
}


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

#Makefile for GCOV profiling kernel module
CC=gcc
CFLAGS = -DMODULE -Wall -D__KERNEL__ -DLINUX -DCONFIG_SMP
MODCFLAGS := -I/usr/src/linux-2.4.17-gcov/include  $(CFLAGS)

gcov-prof.o:   
		$(CC) $(MODCFLAGS) -c gcov-prof.c

clean:
	rm *.o

--CE+1k2dSO48ffgeK--
