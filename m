Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315272AbSETJkS>; Mon, 20 May 2002 05:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315460AbSETJkR>; Mon, 20 May 2002 05:40:17 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:49292 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S315272AbSETJkQ>; Mon, 20 May 2002 05:40:16 -0400
Date: Mon, 20 May 2002 15:09:36 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH]: adding counters to count bytes read/written
Message-ID: <Pine.LNX.4.21.0205201506240.14394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	This patch adds 2 counters to the task_struct for
	counting how many bytes were read/written using
	the read()/write() system calls. 

	These counters may be useful in determining how
	many IO requests are made by each process.


diff -u -r ../temp/linux-2.5.12/fs/proc/array.c ./fs/proc/array.c
--- ../temp/linux-2.5.12/fs/proc/array.c	Wed May  1 05:38:45 2002
+++ ./fs/proc/array.c	Mon May 20 09:18:16 2002
@@ -346,7 +346,7 @@
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %d %d\n",
 		task->pid,
 		task->comm,
 		state,
@@ -388,8 +388,10 @@
 		wchan,
 		task->nswap,
 		task->cnswap,
-		task->exit_signal,
-		task->thread_info->cpu);
+ 	        task->exit_signal,
+		task->thread_info->cpu,
+		task->bytes_read,
+		task->bytes_written);
 	if(mm)
 		mmput(mm);
 	return res;
diff -u -r ../temp/linux-2.5.12/fs/read_write.c ./fs/read_write.c
--- ../temp/linux-2.5.12/fs/read_write.c	Wed May  1 05:38:59 2002
+++ ./fs/read_write.c	Mon May 20 09:48:30 2002
@@ -180,8 +180,10 @@
 					ret = read(file, buf, count, &file->f_pos);
 			}
 		}
-		if (ret > 0)
+		if (ret > 0) {
 			dnotify_parent(file->f_dentry, DN_ACCESS);
+			current->bytes_read += ret;
+		}
 		fput(file);
 	}
 	return ret;
@@ -206,8 +208,10 @@
 					ret = write(file, buf, count, &file->f_pos);
 			}
 		}
-		if (ret > 0)
+		if (ret > 0) {
 			dnotify_parent(file->f_dentry, DN_MODIFY);
+			current->bytes_written += ret;
+		}
 		fput(file);
 	}
 	return ret;
diff -u -r ../temp/linux-2.5.12/include/linux/sched.h ./include/linux/sched.h
--- ../temp/linux-2.5.12/include/linux/sched.h	Wed May  1 05:38:47 2002
+++ ./include/linux/sched.h	Mon May 20 09:25:32 2002
@@ -315,6 +315,7 @@
 	int link_count, total_link_count;
 	struct tty_struct *tty; /* NULL if no tty */
 	unsigned int locks; /* How many file locks are being held */
+	unsigned int bytes_written, bytes_read;
 /* ipc stuff */
 	struct sysv_sem sysvsem;
 /* CPU-specific state of this task */


