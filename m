Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWDKIGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWDKIGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWDKIGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:06:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49729 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932353AbWDKIGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:06:48 -0400
Date: Tue, 11 Apr 2006 10:07:06 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: sys_tee
Message-ID: <20060411080705.GB3439@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here follows an implementation of sys_tee. It works a little differently
that one might expect from the name (hence it might need a change).
Basically what it does is duplicate one pipe to another - not by copying
the contents, but merely linking it. sys_tee doesn't consume the input
pipe, so you are free to read the same data from that as you just teed
to the output pipe.

So to implement an efficient tee, one would do something like:

        /*
         * Duplicate stdin to stdout
         */
        len = tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);

        /*
         * Splice stdin to file
         */
        splice(STDIN_FILENO, file_fd, len, 0);

and none of that data would touch user space. I'm attaching a sample
ktee.c implementation as a reference. The "meat" of that file is the two
lines I showed above.

Patch applies on top of current splice branch, it wont apply to
2.6.17-rc1.

------

Basically an in-kernel implementation of tee, which uses splice and the
pipe buffers as an intelligent way to pass data around by reference.

Where the user space tee consumes the input and produces a stdout and
file output, this syscall merely duplicates the data inside a pipe to
another pipe. No data is copied, the output just grabs a reference to the
input pipe data.

Signed-off-by: Jens Axboe <axboe@suse.de>

---

 arch/i386/kernel/syscall_table.S |    1 
 arch/ia64/kernel/entry.S         |    1 
 arch/powerpc/kernel/systbl.S     |    1 
 fs/pipe.c                        |    7 +
 fs/splice.c                      |  186 ++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h        |    3 -
 include/asm-ia64/unistd.h        |    3 -
 include/asm-powerpc/unistd.h     |    3 -
 include/asm-x86_64/unistd.h      |    4 +
 include/linux/pipe_fs_i.h        |    1 
 include/linux/syscalls.h         |    1 
 11 files changed, 207 insertions(+), 4 deletions(-)

3c81754e333add4bd05ffb015ad8960006757b6e
diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index 4f58b9c..f48bef1 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -314,3 +314,4 @@ ENTRY(sys_call_table)
 	.long sys_get_robust_list
 	.long sys_splice
 	.long sys_sync_file_range
+	.long sys_tee			/* 315 */
diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index 750e8e7..766155c 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -1606,5 +1606,6 @@ sys_call_table:
 	data8 sys_ni_syscall			// 1295 reserved for ppoll
 	data8 sys_unshare
 	data8 sys_splice
+	data8 sys_tee
 
 	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 1424eab..a14c964 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -323,3 +323,4 @@ COMPAT_SYS(pselect6)
 COMPAT_SYS(ppoll)
 SYSCALL(unshare)
 SYSCALL(splice)
+SYSCALL(tee)
diff --git a/fs/pipe.c b/fs/pipe.c
index e984beb..7fefb10 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -131,12 +131,19 @@ static int anon_pipe_buf_steal(struct pi
 	return 0;
 }
 
+static void anon_pipe_buf_get(struct pipe_inode_info *info,
+			      struct pipe_buffer *buf)
+{
+	page_cache_get(buf->page);
+}
+
 static struct pipe_buf_operations anon_pipe_buf_ops = {
 	.can_merge = 1,
 	.map = anon_pipe_buf_map,
 	.unmap = anon_pipe_buf_unmap,
 	.release = anon_pipe_buf_release,
 	.steal = anon_pipe_buf_steal,
+	.get = anon_pipe_buf_get,
 };
 
 static ssize_t
diff --git a/fs/splice.c b/fs/splice.c
index 78b8b9a..b63fb2f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -125,12 +125,19 @@ static void page_cache_pipe_buf_unmap(st
 	kunmap(buf->page);
 }
 
+static void page_cache_pipe_buf_get(struct pipe_inode_info *info,
+				    struct pipe_buffer *buf)
+{
+	page_cache_get(buf->page);
+}
+
 static struct pipe_buf_operations page_cache_pipe_buf_ops = {
 	.can_merge = 0,
 	.map = page_cache_pipe_buf_map,
 	.unmap = page_cache_pipe_buf_unmap,
 	.release = page_cache_pipe_buf_release,
 	.steal = page_cache_pipe_buf_steal,
+	.get = page_cache_pipe_buf_get,
 };
 
 /*
@@ -961,7 +968,186 @@ asmlinkage long sys_splice(int fd_in, lo
 		}
 
 		fput_light(in, fput_in);
+	}
+
+	return error;
+}
+
+/*
+ * Link contents of ipipe to opipe.
+ */
+static int link_pipe(struct pipe_inode_info *ipipe,
+		     struct pipe_inode_info *opipe,
+		     size_t len, unsigned int flags)
+{
+	struct pipe_buffer *ibuf, *obuf;
+	int ret = 0, do_wakeup = 0, i;
+
+	/*
+	 * Potential ABBA deadlock, work around it by ordering lock
+	 * grabbing by inode address. Otherwise two different processes
+	 * could deadlock (one doing tee from A -> B, the other from B -> A).
+	 */
+	if (ipipe->inode < opipe->inode) {
+		mutex_lock(&ipipe->inode->i_mutex);
+		mutex_lock(&opipe->inode->i_mutex);
+	} else {
+		mutex_lock(&opipe->inode->i_mutex);
+		mutex_lock(&ipipe->inode->i_mutex);
+	}
+
+	for (i = 0;; i++) {
+		if (!opipe->readers) {
+			send_sig(SIGPIPE, current, 0);
+			if (!ret)
+				ret = -EPIPE;
+			break;
+		}
+		if (ipipe->nrbufs - i) {
+			ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (PIPE_BUFFERS - 1));
+
+			/*
+			 * If we have room, fill this buffer
+			 */
+			if (opipe->nrbufs < PIPE_BUFFERS) {
+				int nbuf = (opipe->curbuf + opipe->nrbufs) & (PIPE_BUFFERS - 1);
+
+				/*
+				 * Get a reference to this pipe buffer,
+				 * so we can copy the contents over.
+				 */
+				ibuf->ops->get(ipipe, ibuf);
+
+				obuf = opipe->bufs + nbuf;
+				*obuf = *ibuf;
+
+				if (obuf->len > len)
+					obuf->len = len;
+
+				opipe->nrbufs++;
+				do_wakeup = 1;
+				ret += obuf->len;
+				len -= obuf->len;
+
+				if (!len)
+					break;
+				if (opipe->nrbufs < PIPE_BUFFERS)
+					continue;
+			}
+
+			/*
+			 * We have input available, but no output room.
+			 * If we already copied data, return that.
+			 */
+			if (flags & SPLICE_F_NONBLOCK) {
+				if (!ret)
+					ret = -EAGAIN;
+				break;
+			}
+			if (signal_pending(current)) {
+				if (!ret)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			if (do_wakeup) {
+				smp_mb();
+				if (waitqueue_active(&opipe->wait))
+					wake_up_interruptible(&opipe->wait);
+				kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);
+				do_wakeup = 0;
+			}
+
+			opipe->waiting_writers++;
+			pipe_wait(opipe);
+			opipe->waiting_writers--;
+			continue;
+		}
+
+		/*
+		 * No input buffers, do the usual checks for available
+		 * writers and blocking and wait if necessary
+		 */
+		if (!ipipe->writers)
+			break;
+		if (!ipipe->waiting_writers) {
+			if (ret)
+				break;
+		}
+		if (flags & SPLICE_F_NONBLOCK) {
+			if (!ret)
+				ret = -EAGAIN;
+			break;
+		}
+		if (signal_pending(current)) {
+			if (!ret)
+				ret = -ERESTARTSYS;
+			break;
+		}
+
+		if (waitqueue_active(&ipipe->wait))
+			wake_up_interruptible_sync(&ipipe->wait);
+		kill_fasync(&ipipe->fasync_writers, SIGIO, POLL_OUT);
+
+		pipe_wait(ipipe);
+	}
+
+	mutex_unlock(&ipipe->inode->i_mutex);
+	mutex_unlock(&opipe->inode->i_mutex);
+
+	if (do_wakeup) {
+		smp_mb();
+		if (waitqueue_active(&opipe->wait))
+			wake_up_interruptible(&opipe->wait);
+		kill_fasync(&opipe->fasync_readers, SIGIO, POLL_IN);
 	}
+
+	return ret;
+}
+
+/*
+ * This is a tee(1) implementation that works on pipes. It doesn't copy
+ * any data, it simply references the 'in' pages on the 'out' pipe.
+ * The 'flags' used are the SPLICE_F_* variants, currently the only
+ * applicable one is SPLICE_F_NONBLOCK.
+ */
+static long do_tee(struct file *in, struct file *out, size_t len,
+		   unsigned int flags)
+{
+	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+
+	/*
+	 * Link ipipe to the two output pipes, consuming as we go along.
+	 */
+	if (ipipe && opipe)
+		return link_pipe(ipipe, opipe, len, flags);
+
+	return -EINVAL;
+}
+
+asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags)
+{
+	struct file *in;
+	int error, fput_in;
+
+	if (unlikely(!len))
+		return 0;
+
+	error = -EBADF;
+	in = fget_light(fdin, &fput_in);
+	if (in) {
+		if (in->f_mode & FMODE_READ) {
+			int fput_out;
+			struct file *out = fget_light(fdout, &fput_out);
+
+			if (out) {
+				if (out->f_mode & FMODE_WRITE)
+					error = do_tee(in, out, len, flags);
+				fput_light(out, fput_out);
+			}
+		}
+ 		fput_light(in, fput_in);
+ 	}
 
 	return error;
 }
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index 7b1ba84..26b1882 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -320,8 +320,9 @@ #define __NR_set_robust_list	311
 #define __NR_get_robust_list	312
 #define __NR_splice		313
 #define __NR_sync_file_range	314
+#define __NR_tee		315
 
-#define NR_syscalls 315
+#define NR_syscalls 316
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff --git a/include/asm-ia64/unistd.h b/include/asm-ia64/unistd.h
index 36070c1..3e122f1 100644
--- a/include/asm-ia64/unistd.h
+++ b/include/asm-ia64/unistd.h
@@ -286,12 +286,13 @@ #define __NR_faccessat			1293
 /* 1294, 1295 reserved for pselect/ppoll */
 #define __NR_unshare			1296
 #define __NR_splice			1297
+#define __NR_tee			1298
 
 #ifdef __KERNEL__
 
 #include <linux/config.h>
 
-#define NR_syscalls			274 /* length of syscall table */
+#define NR_syscalls			275 /* length of syscall table */
 
 #define __ARCH_WANT_SYS_RT_SIGACTION
 
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 536ba08..c612f1a 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -302,8 +302,9 @@ #define __NR_pselect6		280
 #define __NR_ppoll		281
 #define __NR_unshare		282
 #define __NR_splice		283
+#define __NR_tee		284
 
-#define __NR_syscalls		284
+#define __NR_syscalls		285
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index f21ff2c..d86494e 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -611,8 +611,10 @@ #define __NR_get_robust_list	274
 __SYSCALL(__NR_get_robust_list, sys_get_robust_list)
 #define __NR_splice		275
 __SYSCALL(__NR_splice, sys_splice)
+#define __NR_tee		276
+__SYSCALL(__NR_tee, sys_tee)
 
-#define __NR_syscall_max __NR_splice
+#define __NR_syscall_max __NR_tee
 
 #ifndef __NO_STUBS
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 123a7c2..ef7f33c 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -21,6 +21,7 @@ struct pipe_buf_operations {
 	void (*unmap)(struct pipe_inode_info *, struct pipe_buffer *);
 	void (*release)(struct pipe_inode_info *, struct pipe_buffer *);
 	int (*steal)(struct pipe_inode_info *, struct pipe_buffer *);
+	void (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
 struct pipe_inode_info {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4c292fa..a60d8d4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -576,5 +576,6 @@ asmlinkage long sys_splice(int fd_in, lo
 
 asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 					int flags);
+asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
 
 #endif
-- 
1.3.0.rc1.g384e


-- 
Jens Axboe


--yEPQxsgoJgBvi8ip
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="ktee.c"

/*
 * A tee implementation using sys_tee.
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <assert.h>
#include <limits.h>

#if defined(__i386__)
#define __NR_splice	313
#define __NR_tee	315
#elif defined(__x86_64__)
#define __NR_splice	275
#define __NR_tee	276
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice	283
#define __NR_tee	284
#else
#error unsupported arch
#endif

#define SPLICE_F_NONBLOCK (0x02)

static inline int splice(int fdin, loff_t *off_in, int fdout, loff_t *off_out,
			 size_t len, unsigned int flags)
{
	return syscall(__NR_splice, fdin, off_in, fdout, off_out, len, flags);
}

static inline int tee(int fdin, int fdout, size_t len, unsigned int flags)
{
	return syscall(__NR_tee, fdin, fdout, len, flags);
}

static int error(const char *n)
{
	perror(n);
	return -1;
}

static int do_splice(int infd, int outfd, unsigned int len, char *msg)
{
	while (len) {
		int written = splice(infd, NULL, outfd, NULL, len, 0);

		if (written <= 0)
			return error(msg);

		len -= written;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	struct stat sb;
	int fd;

	if (argc < 2) {
		fprintf(stderr, "%s: outfile\n", argv[0]);
		return 1;
	}

	if (fstat(STDIN_FILENO, &sb) < 0)
		return error("stat");
	if (!S_ISFIFO(sb.st_mode)) {
		fprintf(stderr, "stdout must be a pipe\n");
		return 1;
	}

	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd < 0)
		return error("open output");

	do {
		int tee_len = tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);

		if (tee_len < 0) {
			if (errno == EAGAIN) {
				usleep(1000);
				continue;
			}
			return error("tee");
		} else if (!tee_len)
			break;

		/*
		 * Send output to file, also consumes input pipe.
		 */
		if (do_splice(STDIN_FILENO, fd, tee_len, "splice-file"))
			break;
	} while (1);

	return 0;
}

--yEPQxsgoJgBvi8ip--
