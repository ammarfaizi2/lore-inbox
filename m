Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSDWX0Y>; Tue, 23 Apr 2002 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314488AbSDWX0T>; Tue, 23 Apr 2002 19:26:19 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:26053 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314485AbSDWX0K>; Tue, 23 Apr 2002 19:26:10 -0400
Date: Tue, 23 Apr 2002 21:54:19 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86-64 next sync for 2.5.9
Message-ID: <20020423215419.A7734@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes up some lose ends left over from the last x86-64 jumbo merge. 

- make it compile again. ia32_ioctl was referencing IDE ioctls that got
remove in a merge race.
- implement early_printk properly as an registered console. this requires 
an addition to init/main.c to disable the early console before the 
real console is initialized. Also add early serial console support while
I was at it. 
- Use the memset/FXRSTOR way to initialize the FPU, as discussed.
- Fix semctl/shmctl ABI (thanks to Andreas Schwab)
- Other minor fixes. 

For 2.5.9. 

diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/config.in linux-2.5.9/arch/x86_64/config.in
--- ../../v2.5/linux/arch/x86_64/config.in	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/config.in	Tue Apr 23 01:57:21 2002
@@ -15,6 +15,8 @@ define_bool CONFIG_RWSEM_GENERIC_SPINLOC
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 define_bool CONFIG_X86_CMPXCHG y
 
+define_bool CONFIG_EARLY_PRINTK y
+
 source init/Config.in
 
 mainmenu_option next_comment
@@ -210,12 +212,8 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
 #   bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
-   bool '  Early printk' CONFIG_EARLY_PRINTK
    bool '  Additional run-time checks' CONFIG_CHECKING
    bool '  Debug __init statements' CONFIG_INIT_DEBUG
-#if [ "$CONFIG_SERIAL_CONSOLE" = "y" ]; then
-#  bool 'Early serial console (ttyS0)' CONFIG_EARLY_SERIAL_CONSOLE
-#fi
 fi
 endmenu
 
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/defconfig linux-2.5.9/arch/x86_64/defconfig
--- ../../v2.5/linux/arch/x86_64/defconfig	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/defconfig	Tue Apr 23 21:39:52 2002
@@ -9,6 +9,7 @@ CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_X86_CMPXCHG=y
+CONFIG_EARLY_PRINTK=y
 
 #
 # Code maturity level options
@@ -282,7 +283,7 @@ CONFIG_IDEDMA_AUTO=y
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN is not set
+# CONFIG_ISDN_BOOL is not set
 
 #
 # Old CD-ROM drivers (not SCSI, not IDE)
@@ -430,6 +431,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_NFSD_TCP is not set
 # CONFIG_SUNRPC is not set
 # CONFIG_LOCKD is not set
+# CONFIG_EXPORTFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
@@ -484,7 +486,6 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_EARLY_PRINTK is not set
 # CONFIG_CHECKING is not set
 # CONFIG_INIT_DEBUG is not set
 
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/ia32/ia32_ioctl.c linux-2.5.9/arch/x86_64/ia32/ia32_ioctl.c
--- ../../v2.5/linux/arch/x86_64/ia32/ia32_ioctl.c	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/ia32/ia32_ioctl.c	Tue Apr 23 02:29:51 2002
@@ -3182,7 +3182,6 @@ COMPATIBLE_IOCTL(FIGETBSZ)
  */
 COMPATIBLE_IOCTL(HDIO_GET_IDENTITY)
 COMPATIBLE_IOCTL(HDIO_SET_DMA)
-COMPATIBLE_IOCTL(HDIO_SET_KEEPSETTINGS)
 COMPATIBLE_IOCTL(HDIO_SET_UNMASKINTR)
 COMPATIBLE_IOCTL(HDIO_SET_NOWERR)
 COMPATIBLE_IOCTL(HDIO_SET_32BIT)
@@ -3742,7 +3741,6 @@ HANDLE_IOCTL(BLKSECTGET, w_long)
 HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
 HANDLE_IOCTL(FBIOGETCMAP, fb_ioctl_trans)
 HANDLE_IOCTL(FBIOPUTCMAP, fb_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_KEEPSETTINGS, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_UNMASKINTR, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
 HANDLE_IOCTL(HDIO_GET_32BIT, hdio_ioctl_trans)
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/kernel/early_printk.c linux-2.5.9/arch/x86_64/kernel/early_printk.c
--- ../../v2.5/linux/arch/x86_64/kernel/early_printk.c	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/kernel/early_printk.c	Tue Apr 23 01:56:50 2002
@@ -1,34 +1,25 @@
-#define printk real_printk
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
 #include <asm/io.h>
-#undef printk
 
+/* Simple VGA output */
 
-#define VGABASE		0xffffffff800b8000ul	/* This is "wrong" address to access it, we should access it using 0xffff8000000b8000ul; but 0xffff8000000b8000ul is not available early at boot. */
+#define VGABASE		0xffffffff800b8000UL
 
 #define MAX_YPOS	25
 #define MAX_XPOS	80
 
-static int current_ypos = 1, current_xpos = 0; /* We want to print before clearing BSS */
+static int current_ypos = 1, current_xpos = 0; 
 
-void
-early_clear (void)
-{
-	int k, i;
-	for(k = 0; k < MAX_YPOS; k++)
-		for(i = 0; i < MAX_XPOS; i++)
-			writew(0, VGABASE + 2*(MAX_XPOS*k + i));
-	current_ypos = 0;
-}
-
-void
-early_puts (const char *str)
+static void early_vga_write(struct console *con, const char *str, unsigned n)
 {
 	char c;
 	int  i, k, j;
 
-	while ((c = *str++) != '\0') {
+	while ((c = *str++) != '\0' && n-- > 0) {
 		if (current_ypos >= MAX_YPOS) {
-#if 1
 			/* scroll 1 line up */
 			for(k = 1, j = 0; k < MAX_YPOS; k++, j++) {
 				for(i = 0; i < MAX_XPOS; i++) {
@@ -40,11 +31,6 @@ early_puts (const char *str)
 				writew(0x720, VGABASE + 2*(MAX_XPOS*j + i));
 			}
 			current_ypos = MAX_YPOS-1;
-#else
-			/* MUCH faster */
-			early_clear();
-			current_ypos = 0;
-#endif
 		}
 		if (c == '\n') {
 			current_xpos = 0;
@@ -60,20 +46,144 @@ early_puts (const char *str)
 	}
 }
 
-static char buf[1024];
+static struct console early_vga_console = {
+	name:		"earlyvga",
+	write:		early_vga_write,
+	flags:		CON_PRINTBUFFER,
+	index:		-1,
+};
+
+/* Serial functions losely based on a similar package from Klaus P. Gerlicher */ 
+
+int early_serial_base = 0x3f8;  /* ttyS0 */ 
+
+#define XMTRDY          0x20
+
+#define DLAB		0x80
+
+#define TXR             0       /*  Transmit register (WRITE) */
+#define RXR             0       /*  Receive register  (READ)  */
+#define IER             1       /*  Interrupt Enable          */
+#define IIR             2       /*  Interrupt ID              */
+#define FCR             2       /*  FIFO control              */
+#define LCR             3       /*  Line control              */
+#define MCR             4       /*  Modem control             */
+#define LSR             5       /*  Line Status               */
+#define MSR             6       /*  Modem Status              */
+#define DLL             0       /*  Divisor Latch Low         */
+#define DLH             1       /*  Divisor latch High        */
 
-int printk(const char *fmt, ...) __attribute__((alias("early_printk"))); 
+static int early_serial_putc(unsigned char ch) 
+{ 
+	unsigned timeout = 0xffff; 
+	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout) 
+		rep_nop(); 
+	outb(ch, early_serial_base + TXR);
+	return timeout ? 0 : -1;
+} 
+
+static void early_serial_write(struct console *con, const char *s, unsigned n)
+{
+	while (*s && n-- > 0) { 
+		early_serial_putc(*s); 
+		if (*s == '\n') 
+			early_serial_putc('\r'); 
+		s++; 
+	} 
+} 
 
-int early_printk(const char *fmt, ...)
+static __init void early_serial_init(char *opt)
 {
-	va_list args;
-	int i;
+	static int bases[] = { 0x3f8, 0x2f8 };
+	unsigned char c; 
+	unsigned divisor, baud = 38400;
+	char *s, *e;
+
+	s = strsep(&opt, ","); 
+	if (s != NULL) { 
+		unsigned port; 
+		++s; 
+		if (!strncmp(s,"ttyS",4)) 
+			s+=4; 
+		port = simple_strtoul(s, &e, 10); 
+		if (port > 1 || s == e) 
+			port = 0; 
+		early_serial_base = bases[port];
+	}
+
+	c = inb(early_serial_base + LCR); 
+	outb(c & ~DLAB, early_serial_base + LCR); 
+	outb(0, early_serial_base + IER); /* no interrupt */ 
+	outb(0, early_serial_base + FCR); /* no fifo */ 
+	outb(0x3, early_serial_base + LCR); /* 8n1 */
+	outb(0x3, early_serial_base + MCR); /* DTR + RTS */ 
+
+	s = strsep(&opt, ","); 
+	if (s != NULL) { 
+		baud = simple_strtoul(s, &e, 0); 
+		if (baud == 0 || s == e) 
+			baud = 38400;
+	} 
+	
+	divisor = 115200 / baud; 
+	c = inb(early_serial_base + LCR); 
+	outb(c | DLAB, early_serial_base + LCR); 
+	outb(divisor & 0xff, early_serial_base + DLL); 
+	outb((divisor >> 8) & 0xff, early_serial_base + DLH); 
+	outb(c & ~DLAB, early_serial_base + LCR);
+}
 
-	va_start(args, fmt);
-	i = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf)-4 */
-	va_end(args);
+static struct console early_serial_console = {
+	name:		"earlyser",
+	write:		early_serial_write,
+	flags:		CON_PRINTBUFFER,
+	index:		-1,
+};
+
+/* Direct interface for emergencies */
+struct console *early_console = &early_vga_console;
+static int early_console_initialized = 0;
 
-	early_puts(buf);
+void early_printk(const char *fmt, ...)
+{ 
+	char buf[512]; 
+	int n; 
+	va_list ap;
+	va_start(ap,fmt); 
+	n = vsnprintf(buf,512,fmt,ap);
+	early_console->write(early_console,buf,n);
+	va_end(ap); 
+} 
 
-	return i;
+int __init setup_early_printk(char *opt) 
+{  
+	if (early_console_initialized)
+		return;
+	early_console_initialized = 1;
+
+	if (!strncmp(opt, "serial", 6)) { 
+		early_serial_init(opt+7);
+		early_console = &early_serial_console;
+	} else if (!strncmp(opt, "vga", 3))
+		early_console = &early_vga_console; 
+	else
+		return -1; 
+	register_console(early_console);       
+	return 0;
 }
+
+void __init disable_early_printk(void)
+{ 
+	if (early_console_initialized) {
+		unregister_console(early_console);
+		early_console_initialized = 0;
+	}
+} 
+
+/* syntax: earlyprintk=vga
+           earlyprintk=serial[,ttySn[,baudrate]] 
+   Only vga or serial at a time, not both.
+   Currently only ttyS0 and ttyS1 are supported. 
+   Interaction with the standard serial driver is not very good. 
+   The VGA output is eventually overwritten by the real console. */
+__setup("earlyprintk=", setup_early_printk);  
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/kernel/i387.c linux-2.5.9/arch/x86_64/kernel/i387.c
--- ../../v2.5/linux/arch/x86_64/kernel/i387.c	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/kernel/i387.c	Tue Apr 23 02:25:35 2002
@@ -42,40 +42,6 @@ void __init fpu_init(void)
 
 	write_cr0(oldcr0 & ~((1UL<<3)|(1UL<<2))); /* clear TS and EM */
 
-	asm("fninit"); 
-	load_mxcsr(0x1f80); 
-	/* initialize MMX state. normally this will be covered by fninit, but the 
-	   architecture doesn't guarantee it so do it explicitely. */ 
-	asm volatile("movq %0,%%mm0\n\t"
-	    "movq %%mm0,%%mm1\n\t"
-	    "movq %%mm0,%%mm2\n\t"
-	    "movq %%mm0,%%mm3\n\t"
-	    "movq %%mm0,%%mm4\n\t"
-	    "movq %%mm0,%%mm5\n\t"
-	    "movq %%mm0,%%mm6\n\t"
-	    "movq %%mm0,%%mm7\n\t" :: "m" (0ULL));
-	asm("emms");
-
-	/* initialize XMM state */ 
-	asm("xorpd %xmm0,%xmm0");
-	asm("xorpd %xmm1,%xmm1");
-	asm("xorpd %xmm2,%xmm2");
-	asm("xorpd %xmm3,%xmm3");
-	asm("xorpd %xmm4,%xmm4");
-	asm("xorpd %xmm5,%xmm5");
-	asm("xorpd %xmm6,%xmm6");
-	asm("xorpd %xmm7,%xmm7");
-	asm("xorpd %xmm8,%xmm8");
-	asm("xorpd %xmm9,%xmm9");
-	asm("xorpd %xmm10,%xmm10");
-	asm("xorpd %xmm11,%xmm11");
-	asm("xorpd %xmm12,%xmm12");
-	asm("xorpd %xmm13,%xmm13");
-	asm("xorpd %xmm14,%xmm14");
-	asm("xorpd %xmm15,%xmm15");
-	load_mxcsr(0x1f80);
-	asm volatile("fxsave %0" : "=m" (init_fpu_env));
-
 	/* clean state in init */
 	stts();
 	clear_thread_flag(TIF_USEDFPU);
@@ -89,13 +55,11 @@ void __init fpu_init(void)
  */
 void init_fpu(void)
 {
-#if 0
-	asm("fninit"); 
-	load_mxcsr(0x1f80);
-#else
-	asm volatile("fxrstor %0" :: "m" (init_fpu_env)); 
-#endif
-	current->used_math = 1;
+	struct task_struct *me = current;
+	memset(&me->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
+	me->thread.i387.fxsave.cwd = 0x37f;
+	me->thread.i387.fxsave.mxcsr = 0x1f80;
+	me->used_math = 1;
 }
 
 /*
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/kernel/sys_x86_64.c linux-2.5.9/arch/x86_64/kernel/sys_x86_64.c
--- ../../v2.5/linux/arch/x86_64/kernel/sys_x86_64.c	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/kernel/sys_x86_64.c	Tue Apr 23 21:21:55 2002
@@ -114,19 +114,8 @@ asmlinkage long sys_pause(void)
 	return -ERESTARTNOHAND;
 }
 
-asmlinkage long wrap_sys_shmat(int shmid, char *shmaddr, int shmflg, 
-			       unsigned long *raddr_user)
+asmlinkage long wrap_sys_shmat(int shmid, char *shmaddr, int shmflg)
 {
 	unsigned long raddr;
-	return sys_shmat(shmid,shmaddr,shmflg,&raddr) ?: put_user(raddr,raddr_user);
-} 
-
-asmlinkage long wrap_sys_semctl(int semid, int semnum, int cmd, unsigned long *ptr)
-{	
-	unsigned long val; 
-	/* XXX: for cmd==SETVAL the manpage says ptr is the value directly. i386
-	   seems to always get it via a pointer. Follow i386 here. Check this. */
-	if (get_user(val, ptr))
-		return -EFAULT;
-	return sys_semctl(semid, semnum, cmd, (union semun)(void *)val);
+	return sys_shmat(shmid,shmaddr,shmflg,&raddr) ?: raddr;
 } 
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/kernel/traps.c linux-2.5.9/arch/x86_64/kernel/traps.c
--- ../../v2.5/linux/arch/x86_64/kernel/traps.c	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/kernel/traps.c	Tue Apr 23 02:01:14 2002
@@ -736,11 +736,9 @@ asmlinkage void math_state_restore(void)
 	struct task_struct *me = current;
 	clts();			/* Allow maths ops (or we recurse) */
 
-	if (me->used_math) {
-		restore_fpu_checking(&me->thread.i387.fxsave);
-	} else {
+	if (!me->used_math)
 		init_fpu();
-	}
+	restore_fpu_checking(&me->thread.i387.fxsave);
 	set_thread_flag(TIF_USEDFPU); 
 }
 
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/arch/x86_64/mm/fault.c linux-2.5.9/arch/x86_64/mm/fault.c
--- ../../v2.5/linux/arch/x86_64/mm/fault.c	Tue Apr 23 21:43:52 2002
+++ linux-2.5.9/arch/x86_64/mm/fault.c	Tue Apr 23 21:44:35 2002
@@ -85,7 +85,7 @@ void dump_pagetable(unsigned long addres
 }
 
 int page_fault_trace; 
-int exception_trace = 1;
+int exception_trace;
 
 /*
  * This routine handles page faults.  It determines the address,
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/include/asm-x86_64/unistd.h linux-2.5.9/include/asm-x86_64/unistd.h
--- ../../v2.5/linux/include/asm-x86_64/unistd.h	Tue Apr 23 21:43:53 2002
+++ linux-2.5.9/include/asm-x86_64/unistd.h	Tue Apr 23 21:21:55 2002
@@ -153,7 +153,7 @@ __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semop                              65
 __SYSCALL(__NR_semop, sys_semop)
 #define __NR_semctl                             66
-__SYSCALL(__NR_semctl, wrap_sys_semctl)
+__SYSCALL(__NR_semctl, sys_semctl)
 #define __NR_shmdt                              67
 __SYSCALL(__NR_shmdt, sys_shmdt)
 #define __NR_msgget                             68
diff -x *-o -burpN -X ../../KDIFX ../../v2.5/linux/init/main.c linux-2.5.9/init/main.c
--- ../../v2.5/linux/init/main.c	Tue Apr 23 21:43:53 2002
+++ linux-2.5.9/init/main.c	Tue Apr 23 01:56:06 2002
@@ -260,6 +260,7 @@ static void __init parse_options(char *l
 
 extern void setup_arch(char **);
 extern void cpu_idle(void);
+extern void disable_early_printk(void);
 
 #ifndef CONFIG_SMP
 
@@ -361,6 +362,9 @@ asmlinkage void __init start_kernel(void
 	 * we've done PCI setups etc, and console_init() must be aware of
 	 * this. But we do want output early, in case something goes wrong.
 	 */
+#ifdef CONFIG_EARLY_PRINTK
+	disable_early_printk();
+#endif
 	console_init();
 #ifdef CONFIG_MODULES
 	init_modules();
