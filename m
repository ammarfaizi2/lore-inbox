Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136776AbRAHF5X>; Mon, 8 Jan 2001 00:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136810AbRAHF5O>; Mon, 8 Jan 2001 00:57:14 -0500
Received: from dsl081-146-215-chi1.dsl-isp.net ([64.81.146.215]:64006 "EHLO
	manetheren.eigenray.com") by vger.kernel.org with ESMTP
	id <S136776AbRAHF5I>; Mon, 8 Jan 2001 00:57:08 -0500
Date: Sun, 7 Jan 2001 23:55:28 -0600 (CST)
From: Paul Cassella <pwc@speakeasy.net>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH: "No
 such process")
Message-ID: <Pine.LNX.4.21.0101072217440.703-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

write() returns -1 and sets errno non-sensically.  2.4.0{,-ac[23]}

[2.] Full description of the problem/report:

write() sometimes returns -1 and sets errno to one of
1 (EPERM: "Operation not permitted")
3 (ESRCH: "No such process")
8 (ENOEXEC: "Exec format error")

1 seems to be the most common.

I have verified that at least the ESRCH case is caused by the kernel.  
With the following patch to sys_write(),

--- fs/read_write.c~       Sat Nov 11 18:07:38 2000
+++ fs/read_write.c        Sun Jan  7 14:00:25 2001
@@ -146,6 +146,8 @@
        ssize_t ret;
        struct file * file;
 
+extern struct file_operations socket_file_ops;
+
        ret = -EBADF;
        file = fget(fd);
        if (file) {
@@ -165,6 +167,18 @@
                                 DN_MODIFY);
                fput(file);
        }
+       if(ret < 0 && file && file->f_op == &socket_file_ops ) {
+         switch(-ret) {
+               case EAGAIN: case EBADF: case EPIPE: case ENOSPC: case EIO: case ECONNRESET:
+               case EINTR: case ETIMEDOUT: case EFAULT: case EINVAL: case EMSGSIZE: case ENOMEM:
+               case ENOBUFS: case ENOTCONN: 
+                 break;
+
+               default:
+               printk(KERN_ERR "sys_write: ret is unexpectedly %d.\n", ret);
+         }
+       }
+
        return ret;
 }

and socket_file_ops made non-static, I eventually got this logged:

Jan  7 22:15:29 localhost kernel: sys_write: ret is unexpectedly -3.


And this user code:

r = write(fd_that_is_a_tcp_socket, ...); 

if (r > 0) { ...
} else if(r == 0) { ...
} else if (errno == EAGAIN || errno == EINTR) { ...
} else if (errno == EPIPE || errno == ENOSPC || errno == EIO || errno == ECONNRESET || errno == ETIMEDOUT) { ...
} else {
  g_error("node_write: write failed with unexpected errno: %d (%s)\n", errno, g_strerror(errno));
}

at the same time produced

** ERROR **: node_write: write failed with unexpected errno: 3 (No such process)

aborting...

This socket is O_NONBLOCK'd, as well as SO_KEEPALIVE'd and SO_REUSEADDR'd,
and was an outgoing connection.

TCP ECN is on.  Syncookies are compiled in but turned off.

This app has previously failed with the same thing for errno's 1 and 8,
but without the kernel change to verify that those values are actually
coming from the kernel.

That had happened on 2.4.0, 2.4.0-ac2, and 2.4.0-ac3.  I didn't notice it
on 2.4.0-test11-pre2, which was the last kernel I'd been running.  But
the problem's not particularly deterministic, and I may not have been
running it long enough.  At least two other people are seeing the same
thing on 2.4 kernels.

My guess is that something mistakenly thinks it's returning a positive
number.

[3.] Keywords (i.e., modules, networking, kernel):

networking


[4.] Kernel version (from /proc/version):

Linux version 2.4.0-ac3 (fortytwo@manetheren) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #4 Sun Jan 7 16:18:26 CST 2001

The machine and kernel are UP.


[6.] A small shell script or example program which triggers the
     problem (if possible)

This happens after the app runs usually for several hours with lots of
outgoing and incoming TCP connections to lots of different hosts.


[7.1.] Software (add the output of the ver_linux script here)

Linux manetheren 2.4.0-ac3 #4 Sun Jan 7 16:18:26 CST 2001 i686 unknown
Kernel modules         2.3.23
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         parport_pc lp parport rtc usbcore


[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.5.] PCI information ('lspci -vvv' as root)
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

These doesn't seem particularly relevant, so I'm putting them, as well as
.config, at

 http://manetheren.eigenray.com/~fortytwo/bad_write_info

Don't hesitate to ask me for more info or to try a patch or something.


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

In 2.4.0 and -ac2, I was getting the reset_xmit_timer() messages that -ac3
fixed.  I'm also getting TCP peer shrinks window messages, but had none
this boot before this error.

-- 
Paul Cassella

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
