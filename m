Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129588AbQKXVed>; Fri, 24 Nov 2000 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130134AbQKXVeY>; Fri, 24 Nov 2000 16:34:24 -0500
Received: from pc101-gui2.cable.ntl.com ([62.252.3.101]:48912 "EHLO
        cyberelk.elk.co.uk") by vger.kernel.org with ESMTP
        id <S129588AbQKXVeK>; Fri, 24 Nov 2000 16:34:10 -0500
Date: Fri, 24 Nov 2000 21:04:00 +0000
From: Tim Waugh <tim@cyberelk.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.2.18pre23: user access checking in pipe_read/pipe_write
Message-ID: <20001124210400.A27115@cyberelk.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an untested patch intended to fix the following behaviour:

$ cat a.c
#include <unistd.h>
int main (int argc, char **arghhh)
{
  int fd[2];
  pipe (fd);
  write (fd[1], NULL, 1);
}
$ gcc -o a a.c
$ strace -ewrite ./a
write(4, NULL, 1)                       = 1
$ 

Tim.
*/

--- linux-2.2.18pre23/fs/pipe.c.cfu	Fri Nov 24 20:55:11 2000
+++ linux-2.2.18pre23/fs/pipe.c	Fri Nov 24 21:00:11 2000
@@ -31,7 +31,7 @@
 			 size_t count, loff_t *ppos)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	ssize_t chars = 0, size = 0, read = 0;
+	ssize_t chars = 0, size = 0, read = 0, err = 0;
         char *pipebuf;
 
 
@@ -67,11 +67,14 @@
 			chars = size;
 		read += chars;
                 pipebuf = PIPE_BASE(*inode)+PIPE_START(*inode);
+		if (copy_to_user(buf, pipebuf, chars )) {
+			err = -EFAULT;
+			break;
+		}
 		PIPE_START(*inode) += chars;
 		PIPE_START(*inode) &= (PIPE_BUF-1);
 		PIPE_LEN(*inode) -= chars;
 		count -= chars;
-		copy_to_user(buf, pipebuf, chars );
 		buf += chars;
 	}
 	PIPE_LOCK(*inode)--;
@@ -80,9 +83,9 @@
 		UPDATE_ATIME(inode);
 		return read;
 	}
-	if (PIPE_WRITERS(*inode))
+	if (!err && PIPE_WRITERS(*inode))
 		return -EAGAIN;
-	return 0;
+	return err;
 }
 	
 static ssize_t pipe_write(struct file * filp, const char * buf,
@@ -109,7 +112,7 @@
 		down(&inode->i_sem);
 		return -ERESTARTSYS;
 	}
-	while (count>0) {
+	while (count>0 && !err) {
 		while ((PIPE_FREE(*inode) < free) || PIPE_LOCK(*inode)) {
 			if (!PIPE_READERS(*inode)) { /* no readers */
 				send_sig(SIGPIPE,current,0);
@@ -134,10 +137,13 @@
 			if (chars > free)
 				chars = free;
                         pipebuf = PIPE_BASE(*inode)+PIPE_END(*inode);
+			if (copy_from_user(pipebuf, buf, chars )) {
+				err = -EFAULT;
+				break;
+			}
 			written += chars;
 			PIPE_LEN(*inode) += chars;
 			count -= chars;
-			copy_from_user(pipebuf, buf, chars );
 			buf += chars;
 		}
 		PIPE_LOCK(*inode)--;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
