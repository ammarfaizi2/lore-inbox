Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbSKBIIR>; Sat, 2 Nov 2002 03:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSKBIIR>; Sat, 2 Nov 2002 03:08:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7691 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262681AbSKBIIF>;
	Sat, 2 Nov 2002 03:08:05 -0500
Message-ID: <3DC38939.90001@pobox.com>
Date: Sat, 02 Nov 2002 03:13:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>, hpa@zytor.com, viro@math.psu.edu
Subject: [BK PATCHES] initramfs merge, part 1 of N
Content-Type: multipart/mixed;
 boundary="------------000707010508000408000004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707010508000408000004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,

The attached below is the first of several changes for initramfs / early 
userspace.

This change is intentionally very simple, not really proving its worth 
until next week when patches 2 and 3 in this series arrive in your 
inbox.  A description of "the future" follows description of this 
specific cset.

1) Introduce init/initramfs.c itself, which is a module that 
uncompresses a .cpio.gz archive, and uses it to populate rootfs with 
files early very in the bootup process (between signals_init and 
proc_root_init in init/main.c).  People will see a small listing in 
dmesg of unpacked files.  We need to keep this for now (and for now it's 
small), but we may want to remove this output or turn the knob down to 
KERN_DEBUG before 2.6.x release:
    -> file1
    -> file2
    -> etc...

(architecture maintainers note!)
2) Introduce ARCHBLOBLFLAGS in arch/$arch/Makefile, for turning an 
arbitrary binary object into a .o file using objcopy.

3) Link the initramfs cpio archive in vmlinux image via 
arch/$arch/vmlinux.lds.S, in the init section.

4) Introduce the new linux/usr directory.  Currently it is not very 
interesting, only containing a small host-built proggie that generates 
the initial cpio archive, gen_init_cpio.  This program will go away when 
early userspace is further along.  It currently exists to show initramfs 
is working, by allowing us to remove three simple lines from 
init/do_mounts.c.



The Future.

Early userspace is going to be merged in a series of evolutionary 
changes, following what I call "The Al Viro model."  NO KERNEL BEHAVIOR 
SHOULD CHANGE.  [that's for the lkml listeners, not you <g>]  "make" 
will continue to simply Do The Right Thing(tm) on all platforms, while 
the kernel image continues to get progressively smaller.  Here is the 
initial plan for early userspace, i.e. the patches you are going to be 
seeing next week:

#2 - merge klibc.

As I said earlier, I am not sure if we will wind up removing klibc just 
before 2.6.x release or not.  Comments welcome.  But for now, klibc will 
be merged into the kernel tarball, because otherwise version drift 
during the evolution of early userspace will be a huge PITA, and slow 
things down.  It is a tiny libc written specifically for the kernel.

This patch will add klibc to the build system, and create a tiny, 
statically-linked binary "kinit".  kinit is the beginnings of early 
userspace.  Some tiny, token amount of do_mounts.c code will be moving 
into kinit in patch #2, only enough to prove the system is working.

#3 - move initrd to userspace

Unfortunately we don't start seeing tangible benefits to early userspace 
until this patch, but that's how evolution works :)  Here, initrd 
unpacking code is moved to userspace, as much as possible.  Some initrd 
code will inevitably stay in the kernel, because it is arch-specific how 
to grab the initrd image from bootmem [or whereever], but the vast 
majority of initrd code goes poof (yay!).  No initrd behavior will 
change at all, from current kernels.  It is simply getting moved to 
early userspace.  Users will not need to do anything on their end to 
make sure their existing setups continue to work -- any such actions are 
a bug on my part.

This patch will also turn "kinit" into a shared binary, and introduce 
the gzip binary into early userspace.  [see "Items For Discussion" 
below, too, WRT this.]

#4 - move mounting root to userspace

People probably breathed a sigh of relief at patch #3, they will heave a 
bigger sigh for this patch :)   This moves mounting of the root 
filesystem to early userspace, including getting rid of 
NFSroot/bootp/dhcp code in the kernel.

#N - to infinity... and beyond!

I, and hopefully others, will continue in the series of evolutionary 
patches, moving more and more stuff to early userspace.  There are a lot 
of possibilities, and I will be looking for input from others on useful 
things to move, as well as continuing my own work of finding items that 
can be moved.



Items For Discussion

#1 - shared kinit

"kinit" is _the_ early userspace binary -- but not necessarily the only 
one.  Peter Anvin and Russell King have several binaries in the klibc 
tarball, gzip, ash, and several smaller utilities.  Peter also put work 
into making klibc a shared object -- that doesn't need an shlib loader. 
 It's pretty nifty how he does it, IMO:  klibc.so becomes an ELF 
interpreter for any klibc-linked binaries.  klibc-linked binaries are, 
to the ELF system, static binaries, but they wind up sharing klibc.so 
anyway due to this trick.

Anyway, there is a certain elegance in adding coding to kinit instead of 
an explosion of binaries and shell scripts.  The other side of that coin 
is that with elegance you sacrifice some ease of making changes.  I am 
60% certain we want a shared klibc and multiple binaries, but am willing 
to be convinced in either direction.  If you think about it, there _are_ 
several benefits to leaving kinit as the lone binary in the stock kernel 
early userspace build, so the decision is not as cut-n-dry as it may 
immediately seem.

#2 - klibc in the kernel tarball

It's going in, for now.  That's not open to discussion.  However, the 
future is...   I know the old maxim of "once's it in, it never goes 
away."  Maybe that's the case, and if so, no big deal.  I know at least 
a couple people who would like to see it leave the kernel tarball before 
2.6.0 is released.  I solicit comments on this item, though I think we 
will won't be in a position to answer this question until 2.6.0 release 
is near.



That's it for now.  Questions, comments, and flames welcome.  If I 
missed some early userspace benefits, let me know.  If you know of good 
things to move to early userspace, let me know.  If there are upcoming 
bumps in the road I did not mention, let me know.

Credits:  Al Viro for the initramfs work.  hpa, rmk, Greg KH, Alan, and 
innumerable others have contributed ideas if not actual code towards 
this effort.  And thanks to our Emporer Penguin for giving me a break, 
when I blew the Halloween deadline spending 24 hours debugging an 
_incredibly_ stupid bug on my part.  I deserve not one but two brown 
paper bags for that one.



--------------000707010508000408000004
Content-Type: text/plain;
 name="minitramfs-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minitramfs-2.5.txt"

Linus, please do a

	bk pull http://gkernel.bkbits.net/minitramfs-2.5

This will update the following files:

 Makefile                |    2 
 arch/i386/Makefile      |    1 
 arch/i386/vmlinux.lds.S |    4 
 init/Makefile           |    2 
 init/do_mounts.c        |    4 
 init/initramfs.c        |  466 +++++++++++++++++++++++++++++++++++++++++++++++-
 init/main.c             |    2 
 usr/Makefile            |   18 +
 usr/gen_init_cpio.c     |  137 ++++++++++++++
 9 files changed, 629 insertions(+), 7 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (02/11/01 1.862.2.2)
   Kill stupid bug in initramfs that prevented it from working.
   (thanks to Al Viro for his patience, I owe him one)

<jgarzik@redhat.com> (02/11/01 1.858.2.1)
   Minimal initramfs support (based on Al Viro's work).


--------------000707010508000408000004
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Nov  2 02:34:50 2002
+++ b/Makefile	Sat Nov  2 02:34:50 2002
@@ -209,7 +209,7 @@
 drivers-y	:= drivers/ sound/
 net-y		:= net/
 libs-y		:= lib/
-core-y		:=
+core-y		:= usr/
 SUBDIRS		:=
 
 ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Sat Nov  2 02:34:50 2002
+++ b/arch/i386/Makefile	Sat Nov  2 02:34:50 2002
@@ -18,6 +18,7 @@
 
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
+ARCHBLOBLFLAGS	:= -I binary -O elf32-i386 -B i386
 LDFLAGS_vmlinux := -e stext
 
 CFLAGS += -pipe
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Sat Nov  2 02:34:50 2002
+++ b/arch/i386/vmlinux.lds.S	Sat Nov  2 02:34:50 2002
@@ -77,6 +77,10 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+  . = ALIGN(4096);
+  __initramfs_start = .;
+  .init.ramfs : { *(.init.initramfs) }
+  __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
diff -Nru a/init/Makefile b/init/Makefile
--- a/init/Makefile	Sat Nov  2 02:34:50 2002
+++ b/init/Makefile	Sat Nov  2 02:34:50 2002
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y    := main.o version.o do_mounts.o
+obj-y    := main.o version.o do_mounts.o initramfs.o
 
 # files to be removed upon make clean
 clean-files := ../include/linux/compile.h
diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Sat Nov  2 02:34:50 2002
+++ b/init/do_mounts.c	Sat Nov  2 02:34:50 2002
@@ -748,9 +748,7 @@
 		mount_initrd = 0;
 	real_root_dev = ROOT_DEV;
 #endif
-	sys_mkdir("/dev", 0700);
-	sys_mkdir("/root", 0700);
-	sys_mknod("/dev/console", S_IFCHR|0600, MKDEV(TTYAUX_MAJOR, 1));
+
 #ifdef CONFIG_DEVFS_FS
 	sys_mount("devfs", "/dev", "devfs", 0, NULL);
 	do_devfs = 1;
diff -Nru a/init/initramfs.c b/init/initramfs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/init/initramfs.c	Sat Nov  2 02:34:50 2002
@@ -0,0 +1,462 @@
+#define __KERNEL_SYSCALLS__
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/unistd.h>
+#include <linux/delay.h>
+
+static void __init error(char *x)
+{
+	panic("populate_root: %s\n", x);
+}
+
+static void __init *malloc(int size)
+{
+	return kmalloc(size, GFP_KERNEL);
+}
+
+static void __init free(void *where)
+{
+	kfree(where);
+}
+
+asmlinkage long sys_mkdir(char *name, int mode);
+asmlinkage long sys_mknod(char *name, int mode, dev_t dev);
+asmlinkage long sys_symlink(char *old, char *new);
+asmlinkage long sys_link(char *old, char *new);
+asmlinkage long sys_write(int fd, void *buf, ssize_t size);
+asmlinkage long sys_chown(char *name, uid_t uid, gid_t gid);
+asmlinkage long sys_lchown(char *name, uid_t uid, gid_t gid);
+asmlinkage long sys_fchown(int fd, uid_t uid, gid_t gid);
+asmlinkage long sys_chmod(char *name, mode_t mode);
+asmlinkage long sys_fchmod(int fd, mode_t mode);
+
+/* link hash */
+
+static struct hash {
+	int ino, minor, major;
+	struct hash *next;
+	char *name;
+} *head[32];
+
+static inline int hash(int major, int minor, int ino)
+{
+	unsigned long tmp = ino + minor + (major << 3);
+	tmp += tmp >> 5;
+	return tmp & 31;
+}
+
+static char __init *find_link(int major, int minor, int ino, char *name)
+{
+	struct hash **p, *q;
+	for (p = head + hash(major, minor, ino); *p; p = &(*p)->next) {
+		if ((*p)->ino != ino)
+			continue;
+		if ((*p)->minor != minor)
+			continue;
+		if ((*p)->major != major)
+			continue;
+		return (*p)->name;
+	}
+	q = (struct hash *)malloc(sizeof(struct hash));
+	if (!q)
+		error("can't allocate link hash entry");
+	q->ino = ino;
+	q->minor = minor;
+	q->major = major;
+	q->name = name;
+	q->next = NULL;
+	*p = q;
+	return NULL;
+}
+
+static void __init free_hash(void)
+{
+	struct hash **p, *q;
+	for (p = head; p < head + 32; p++) {
+		while (*p) {
+			q = *p;
+			*p = q->next;
+			free(q);
+		}
+	}
+}
+
+/* cpio header parsing */
+
+static __initdata unsigned long ino, major, minor, nlink;
+static __initdata mode_t mode;
+static __initdata unsigned long body_len, name_len;
+static __initdata uid_t uid;
+static __initdata gid_t gid;
+static __initdata dev_t rdev;
+
+static void __init parse_header(char *s)
+{
+	unsigned long parsed[12];
+	char buf[9];
+	int i;
+
+	buf[8] = '\0';
+	for (i = 0, s += 6; i < 12; i++, s += 8) {
+		memcpy(buf, s, 8);
+		parsed[i] = simple_strtoul(buf, NULL, 16);
+	}
+	ino = parsed[0];
+	mode = parsed[1];
+	uid = parsed[2];
+	gid = parsed[3];
+	nlink = parsed[4];
+	body_len = parsed[6];
+	major = parsed[7];
+	minor = parsed[8];
+	rdev = MKDEV(parsed[9], parsed[10]);
+	name_len = parsed[11];
+}
+
+/* FSM */
+
+enum state {
+	Start,
+	Collect,
+	GotHeader,
+	SkipIt,
+	GotName,
+	CopyFile,
+	GotSymlink,
+	Reset
+} state, next_state;
+
+char *victim;
+unsigned count;
+loff_t this_header, next_header;
+
+static inline void eat(unsigned n)
+{
+	victim += n;
+	this_header += n;
+	count -= n;
+}
+
+#define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
+
+static __initdata char *collected;
+static __initdata int remains;
+static __initdata char *collect;
+
+static void __init read_into(char *buf, unsigned size, enum state next)
+{
+	if (count >= size) {
+		collected = victim;
+		eat(size);
+		state = next;
+	} else {
+		collect = collected = buf;
+		remains = size;
+		next_state = next;
+		state = Collect;
+	}
+}
+
+static __initdata char *header_buf, *symlink_buf, *name_buf;
+
+static int __init do_start(void)
+{
+	read_into(header_buf, 110, GotHeader);
+	return 0;
+}
+
+static int __init do_collect(void)
+{
+	unsigned n = remains;
+	if (count < n)
+		n = count;
+	memcpy(collect, victim, n);
+	eat(n);
+	collect += n;
+	if (remains -= n)
+		return 1;
+	state = next_state;
+	return 0;
+}
+
+static int __init do_header(void)
+{
+	parse_header(collected);
+	next_header = this_header + N_ALIGN(name_len) + body_len;
+	next_header = (next_header + 3) & ~3;
+	if (name_len <= 0 || name_len > PATH_MAX)
+		state = SkipIt;
+	else if (S_ISLNK(mode)) {
+		if (body_len > PATH_MAX)
+			state = SkipIt;
+		else {
+			collect = collected = symlink_buf;
+			remains = N_ALIGN(name_len) + body_len;
+			next_state = GotSymlink;
+			state = Collect;
+		}
+	} else if (body_len && !S_ISREG(mode))
+		state = SkipIt;
+	else
+		read_into(name_buf, N_ALIGN(name_len), GotName);
+	return 0;
+}
+
+static int __init do_skip(void)
+{
+	if (this_header + count <= next_header) {
+		eat(count);
+		return 1;
+	} else {
+		eat(next_header - this_header);
+		state = next_state;
+		return 0;
+	}
+}
+
+static int __init do_reset(void)
+{
+	while(count && *victim == '\0')
+		eat(1);
+	if (count && (this_header & 3))
+		error("broken padding");
+	return 1;
+}
+
+static int __init maybe_link(void)
+{
+	if (nlink >= 2) {
+		char *old = find_link(major, minor, ino, collected);
+		if (old)
+			return (sys_link(old, collected) < 0) ? -1 : 1;
+	}
+	return 0;
+}
+
+static __initdata int wfd;
+
+static int __init do_name(void)
+{
+	state = SkipIt;
+	next_state = Start;
+	if (strcmp(collected, "TRAILER!!!") == 0) {
+		free_hash();
+		next_state = Reset;
+		return 0;
+	}
+	printk(KERN_INFO "-> %s\n", collected);
+	if (S_ISREG(mode)) {
+		if (maybe_link() >= 0) {
+			wfd = sys_open(collected, O_WRONLY|O_CREAT, mode);
+			if (wfd >= 0) {
+				sys_fchown(wfd, uid, gid);
+				sys_fchmod(wfd, mode);
+				state = CopyFile;
+			}
+		}
+	} else if (S_ISDIR(mode)) {
+		sys_mkdir(collected, mode);
+		sys_chown(collected, uid, gid);
+	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
+		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
+		if (maybe_link() == 0) {
+			sys_mknod(collected, mode, rdev);
+			sys_chown(collected, uid, gid);
+		}
+	} else
+		panic("populate_root: bogus mode: %o\n", mode);
+	return 0;
+}
+
+static int __init do_copy(void)
+{
+	if (count >= body_len) {
+		sys_write(wfd, victim, body_len);
+		sys_close(wfd);
+		eat(body_len);
+		state = SkipIt;
+		return 0;
+	} else {
+		sys_write(wfd, victim, count);
+		body_len -= count;
+		eat(count);
+		return 1;
+	}
+}
+
+static int __init do_symlink(void)
+{
+	collected[N_ALIGN(name_len) + body_len] = '\0';
+	sys_symlink(collected + N_ALIGN(name_len), collected);
+	sys_lchown(collected, uid, gid);
+	state = SkipIt;
+	next_state = Start;
+	return 0;
+}
+
+static __initdata int (*actions[])(void) = {
+	[Start]		do_start,
+	[Collect]	do_collect,
+	[GotHeader]	do_header,
+	[SkipIt]	do_skip,
+	[GotName]	do_name,
+	[CopyFile]	do_copy,
+	[GotSymlink]	do_symlink,
+	[Reset]		do_reset,
+};
+
+static int __init write_buffer(char *buf, unsigned len)
+{
+	count = len;
+	victim = buf;
+
+	while (!actions[state]())
+		;
+	return len - count;
+}
+
+static void __init flush_buffer(char *buf, unsigned len)
+{
+	int written;
+	while ((written = write_buffer(buf, len)) < len) {
+		char c = buf[written];
+		if (c == '0') {
+			buf += written;
+			len -= written;
+			state = Start;
+			continue;
+		} else
+			error("junk in compressed archive");
+	}
+}
+
+/*
+ * gzip declarations
+ */
+
+#define OF(args)  args
+
+#ifndef memzero
+#define memzero(s, n)     memset ((s), 0, (n))
+#endif
+
+typedef unsigned char  uch;
+typedef unsigned short ush;
+typedef unsigned long  ulg;
+
+#define WSIZE 0x8000    /* window size--must be a power of two, and */
+			/*  at least 32K for zip's deflate method */
+
+static uch *inbuf;
+static uch *window;
+
+static unsigned insize;  /* valid bytes in inbuf */
+static unsigned inptr;   /* index of next byte to be processed in inbuf */
+static unsigned outcnt;  /* bytes in output buffer */
+static long bytes_out;
+
+#define get_byte()  (inptr < insize ? inbuf[inptr++] : -1)
+		
+/* Diagnostic functions (stubbed out) */
+#define Assert(cond,msg)
+#define Trace(x)
+#define Tracev(x)
+#define Tracevv(x)
+#define Tracec(c,x)
+#define Tracecv(c,x)
+
+#define STATIC static
+
+static void flush_window(void);
+static void error(char *m);
+static void gzip_mark(void **);
+static void gzip_release(void **);
+
+#include "../lib/inflate.c"
+
+static void __init gzip_mark(void **ptr)
+{
+}
+
+static void __init gzip_release(void **ptr)
+{
+}
+
+/* ===========================================================================
+ * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * (Used for the decompressed data only.)
+ */
+static void __init flush_window(void)
+{
+	ulg c = crc;         /* temporary variable */
+	unsigned n;
+	uch *in, ch;
+
+	flush_buffer(window, outcnt);
+	in = window;
+	for (n = 0; n < outcnt; n++) {
+		ch = *in++;
+		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
+	}
+	crc = c;
+	bytes_out += (ulg)outcnt;
+	outcnt = 0;
+}
+
+static void __init unpack_to_rootfs(char *buf, unsigned len)
+{
+	int written;
+	header_buf = malloc(110);
+	symlink_buf = malloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1);
+	name_buf = malloc(N_ALIGN(PATH_MAX));
+	window = malloc(WSIZE);
+	if (!window || !header_buf || !symlink_buf || !name_buf)
+		error("can't allocate buffers");
+	state = Start;
+	this_header = 0;
+	while (len) {
+		loff_t saved_offset = this_header;
+		if (*buf == '0' && !(this_header & 3)) {
+			state = Start;
+			written = write_buffer(buf, len);
+			buf += written;
+			len -= written;
+			continue;
+		} else if (!*buf) {
+			buf++;
+			len--;
+			this_header++;
+			continue;
+		}
+		this_header = 0;
+		insize = len;
+		inbuf = buf;
+		inptr = 0;
+		outcnt = 0;		/* bytes in output buffer */
+		bytes_out = 0;
+		crc = (ulg)0xffffffffL; /* shift register contents */
+		makecrc();
+		if (gunzip())
+			error("ungzip failed");
+		if (state != Reset)
+			error("junk in gzipped archive");
+		this_header = saved_offset + inptr;
+		buf += inptr;
+		len -= inptr;
+	}
+	free(window);
+	free(name_buf);
+	free(symlink_buf);
+	free(header_buf);
+}
+
+extern unsigned long __initramfs_start, __initramfs_end;
+
+void __init populate_rootfs(void)
+{
+	unpack_to_rootfs((void *) &__initramfs_start,
+			 &__initramfs_end - &__initramfs_start);
+}
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Sat Nov  2 02:34:50 2002
+++ b/init/main.c	Sat Nov  2 02:34:50 2002
@@ -72,6 +72,7 @@
 extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
+extern void populate_rootfs(void);
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -433,6 +434,7 @@
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
+	populate_rootfs();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
diff -Nru a/usr/Makefile b/usr/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/usr/Makefile	Sat Nov  2 02:34:50 2002
@@ -0,0 +1,18 @@
+
+include arch/$(ARCH)/Makefile
+
+obj-y := initramfs_data.o
+
+host-progs := gen_init_cpio
+
+clean-files := initramfs_data.cpio.gz
+
+$(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz
+	$(OBJCOPY) $(ARCHBLOBLFLAGS) \
+		--rename-section .data=.init.initramfs \
+		$(obj)/initramfs_data.cpio.gz $(obj)/initramfs_data.o
+	$(STRIP) -s $(obj)/initramfs_data.o
+
+$(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio
+	( cd $(obj) ; ./gen_init_cpio | gzip -9c > initramfs_data.cpio.gz )
+
diff -Nru a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/usr/gen_init_cpio.c	Sat Nov  2 02:34:50 2002
@@ -0,0 +1,137 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+
+static unsigned int offset;
+static unsigned int ino = 721;
+
+static void push_rest(const char *name)
+{
+	unsigned int name_len = strlen(name) + 1;
+	unsigned int tmp_ofs;
+
+	fputs(name, stdout);
+	putchar(0);
+	offset += name_len;
+
+	tmp_ofs = name_len + 110;
+	while (tmp_ofs & 3) {
+		putchar(0);
+		offset++;
+		tmp_ofs++;
+	}
+}
+
+static void push_hdr(const char *s)
+{
+	fputs(s, stdout);
+	offset += 110;
+}
+
+static void cpio_trailer(void)
+{
+	char s[256];
+	const char *name = "TRAILER!!!";
+
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
+	       "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",		/* magic */
+		0,			/* ino */
+		0,			/* mode */
+		(long) 0,		/* uid */
+		(long) 0,		/* gid */
+		1,			/* nlink */
+		(long) 0,		/* mtime */
+		0,			/* filesize */
+		0,			/* major */
+		0,			/* minor */
+		0,			/* rmajor */
+		0,			/* rminor */
+		strlen(name) + 1,	/* namesize */
+		0);			/* chksum */
+	push_hdr(s);
+	push_rest(name);
+
+	while (offset % 512) {
+		putchar(0);
+		offset++;
+	}
+}
+
+static void cpio_mkdir(const char *name, unsigned int mode,
+		       uid_t uid, gid_t gid)
+{
+	char s[256];
+	time_t mtime = time(NULL);
+
+	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	       "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",		/* magic */
+		ino++,			/* ino */
+		S_IFDIR | mode,		/* mode */
+		(long) uid,		/* uid */
+		(long) gid,		/* gid */
+		2,			/* nlink */
+		(long) mtime,		/* mtime */
+		0,			/* filesize */
+		3,			/* major */
+		1,			/* minor */
+		0,			/* rmajor */
+		0,			/* rminor */
+		strlen(name) + 1,	/* namesize */
+		0);			/* chksum */
+	push_hdr(s);
+	push_rest(name);
+}
+
+static void cpio_mknod(const char *name, unsigned int mode,
+		       uid_t uid, gid_t gid, int dev_type,
+		       unsigned int maj, unsigned int min)
+{
+	char s[256];
+	time_t mtime = time(NULL);
+
+	if (dev_type == 'b')
+		mode |= S_IFBLK;
+	else
+		mode |= S_IFCHR;
+
+	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	       "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",		/* magic */
+		ino++,			/* ino */
+		mode,			/* mode */
+		(long) uid,		/* uid */
+		(long) gid,		/* gid */
+		1,			/* nlink */
+		(long) mtime,		/* mtime */
+		0,			/* filesize */
+		3,			/* major */
+		1,			/* minor */
+		maj,			/* rmajor */
+		min,			/* rminor */
+		strlen(name) + 1,	/* namesize */
+		0);			/* chksum */
+	push_hdr(s);
+	push_rest(name);
+}
+
+int main (int argc, char *argv[])
+{
+	cpio_mkdir("/dev", 0700, 0, 0);
+	cpio_mknod("/dev/console", 0600, 0, 0, 'c', 5, 1);
+	cpio_mkdir("/root", 0700, 0, 0);
+	cpio_trailer();
+
+	exit(0);
+
+	/* silence compiler warnings */
+	return 0;
+	(void) argc;
+	(void) argv;
+}
+

--------------000707010508000408000004--

