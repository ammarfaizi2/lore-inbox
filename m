Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRANAcT>; Sat, 13 Jan 2001 19:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbRANAcK>; Sat, 13 Jan 2001 19:32:10 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48905 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130069AbRANAcD>;
	Sat, 13 Jan 2001 19:32:03 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Werner Puschitz <werner.lx@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: HP Pavilion 8290 HANGS on boot 2.4/2.4-test9 
In-Reply-To: Your message of "Sat, 13 Jan 2001 16:12:13 CDT."
             <Pine.LNX.4.21.0101131608320.1168-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Jan 2001 11:31:48 +1100
Message-ID: <12064.979432308@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001 16:12:13 -0500 (EST), 
Werner Puschitz <werner.lx@verizon.net> wrote:
>Is there a safe way to add debug information like simple string prints in
>arch/i386/boot/compressed/head.s and in arch/i386/kernel/head.S
>so that I can see at the console where the boot process hangs?

Time for another version of my VIDEO_CHAR patch.

-----

If a kernel hangs early in the boot process (before the console has
been initialized) then printk is no use because you never see the
output.  There is a technique for using the video display to indicate
boot progress so you can localize the problem.  Reporting "my kernel
hangs during boot at line nnn in routine xyz" is a lot better than "my
kernel hangs during boot".

The idea is to write characters direct to the video screen during
booting using a macro called VIDEO_CHAR.  This macro takes a character
position and a single character value to be displayed.  Use different
positions on the screen for different levels of code and use different
characters in one position to indicate which stage that level is up to.
For example, with the patch below, the string EAC at hang indicates
parse_options(), checksetup().

The patch below is generic, except for the definition of VIDEO_CHAR
which is ix86 specific.  If this patch ever becomes part of the main
kernel then VIDEO_CHAR needs to be moved to an arch specific header.
If any arch other than ix86 uses this technique, please mail
kaos@ocs.com.au with your definition of VIDEO_CHAR.

You can plant VIDEO_CHAR calls anywhere you like, up to the call to
mem_init().  After mem_init has done its work and memory has been
remapped, VIDEO_CHAR cannot write to video memory, it will oops.
However by then the console has been initialized so you can use printk.

Demonstration patch against 2.4.0.  This only uses screen positions 0,
1, 2.  If you want to drill down into lower level routines, just use
screen positions 3 onwards.  To activate the debugging, add

#define DEBUG_VIDEO_CHAR

to the start of init/main.c.

Index: 0.1/init/main.c
--- 0.1/init/main.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/k/11_main.c 1.1 644)
+++ 0.1(w)/init/main.c Sun, 14 Jan 2001 11:27:20 +1100 kaos (linux-2.4/k/11_main.c 1.1 644)
@@ -77,6 +77,13 @@ extern int con3215_activate(void);
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
+#ifdef DEBUG_VIDEO_CHAR
+/* ix86 specific */
+#define VIDEO_CHAR(c, v) (*((volatile char *)(0xb8000 + 2*(c))) = (v))
+#else
+#define VIDEO_CHAR(c, v)
+#endif
+
 extern char _stext, _etext;
 extern char *linux_banner;
 
@@ -432,12 +439,14 @@ static void __init parse_options(char *l
 	char *next,*quote;
 	int args, envs;
 
+	VIDEO_CHAR(1, 'A');
 	if (!*line)
 		return;
 	args = 0;
 	envs = 1;	/* TERM is set to 'linux' by default */
 	next = line;
 	while ((line = next) != NULL) {
+		VIDEO_CHAR(2, 'A');
                 quote = strchr(line,'"');
                 next = strchr(line, ' ');
                 while (next != NULL && quote != NULL && quote < next) {
@@ -450,9 +459,11 @@ static void __init parse_options(char *l
                                 next = strchr(next+1, ' ');
                         }
                 }
+		VIDEO_CHAR(2, 'B');
                 if (next != NULL)
                         *next++ = 0;
 		if (!strncmp(line,"init=",5)) {
+			VIDEO_CHAR(3, 'A');
 			line += 5;
 			execute_command = line;
 			/* In case LILO is going to boot us with default command line,
@@ -463,8 +474,10 @@ static void __init parse_options(char *l
 			args = 0;
 			continue;
 		}
+		VIDEO_CHAR(2, 'C');
 		if (checksetup(line))
 			continue;
+		VIDEO_CHAR(2, 'D');
 		
 		/*
 		 * Then check if it's an environment variable or
@@ -480,9 +493,12 @@ static void __init parse_options(char *l
 			if (*line)
 				argv_init[++args] = line;
 		}
+		VIDEO_CHAR(2, 'E');
 	}
+	VIDEO_CHAR(1, 'B');
 	argv_init[args+1] = NULL;
 	envp_init[envs+1] = NULL;
+	VIDEO_CHAR(1, 'C');
 }
 
 
@@ -526,16 +542,27 @@ asmlinkage void __init start_kernel(void
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
  */
+	VIDEO_CHAR(0, 'A');
 	lock_kernel();
+	VIDEO_CHAR(0, 'B');
 	printk(linux_banner);
+	VIDEO_CHAR(0, 'C');
 	setup_arch(&command_line);
+	VIDEO_CHAR(0, 'D');
 	printk("Kernel command line: %s\n", saved_command_line);
+	VIDEO_CHAR(0, 'E');
 	parse_options(command_line);
+	VIDEO_CHAR(0, 'F');
 	trap_init();
+	VIDEO_CHAR(0, 'G');
 	init_IRQ();
+	VIDEO_CHAR(0, 'H');
 	sched_init();
+	VIDEO_CHAR(0, 'I');
 	time_init();
+	VIDEO_CHAR(0, 'J');
 	softirq_init();
+	VIDEO_CHAR(0, 'K');
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
@@ -543,8 +570,10 @@ asmlinkage void __init start_kernel(void
 	 * this. But we do want output early, in case something goes wrong.
 	 */
 	console_init();
+	VIDEO_CHAR(0, 'L');
 #ifdef CONFIG_MODULES
 	init_modules();
+	VIDEO_CHAR(0, 'M');
 #endif
 	if (prof_shift) {
 		unsigned int size;
@@ -555,10 +584,14 @@ asmlinkage void __init start_kernel(void
 		size = prof_len * sizeof(unsigned int) + PAGE_SIZE-1;
 		prof_buffer = (unsigned int *) alloc_bootmem(size);
 	}
+	VIDEO_CHAR(0, 'N');
 
 	kmem_cache_init();
+	VIDEO_CHAR(0, 'O');
 	sti();
+	VIDEO_CHAR(0, 'P');
 	calibrate_delay();
+	VIDEO_CHAR(0, 'Q');
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 			initrd_start < min_low_pfn << PAGE_SHIFT) {
@@ -566,6 +599,7 @@ asmlinkage void __init start_kernel(void
 		    "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
 		initrd_start = 0;
 	}
+	VIDEO_CHAR(0, 'R');
 #endif
 	mem_init();
 	kmem_cache_sizes_init();

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
