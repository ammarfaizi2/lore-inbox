Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143424AbRAHH5S>; Mon, 8 Jan 2001 02:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143421AbRAHH5K>; Mon, 8 Jan 2001 02:57:10 -0500
Received: from dsl081-146-215-chi1.dsl-isp.net ([64.81.146.215]:32263 "EHLO
	manetheren.eigenray.com") by vger.kernel.org with ESMTP
	id <S137125AbRAHH4y>; Mon, 8 Jan 2001 02:56:54 -0500
Date: Mon, 8 Jan 2001 01:54:25 -0600 (CST)
From: Paul Cassella <pwc@speakeasy.net>
To: Andi Kleen <ak@suse.de>, davem@redhat.com
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:
 "No such process")
In-Reply-To: <20010108073512.A29905@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0101080116330.2261-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Andi Kleen wrote:

> On Sun, Jan 07, 2001 at 11:55:28PM -0600, Paul Cassella wrote:

> > write() returns -1 and sets errno non-sensically.  2.4.0{,-ac[23]}

> Would it be possible to provide a compiling test case that shows these
> errors ? 

The CVS version (perhaps even version 0.12) of gtk-gnutella should do it,
though it's not exactly what I'm running.  After the crash I posted about,
I've been running it for another three and a half hours under similar
load, and it hasn't crashed again yet; nor have I seen any other
unexpected ret's (besides those noted below) get logged.

http://gtk-gnutella.sourceforge.net/cvs/

Though I don't think gtk-gnutella is special.  It doesn't do anything
programmatically unusual with sockets, it just has a bunch of connections
to a bunch of different machines, which are probably running a bunch of
different os's, etc.  And it aborts when write() returns unexpected
values.

I've appended the actual kernel diffs that I'm using; I'd just pasted them
from an xterm before.  I probably should have added ECONNREFUSED and
ERESTARTSYS to the list.


> Also over what interface do you run it? 

eth0 (tulip):
01:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)


In answer to David's questions, I don't think I'm doing anything out of
the ordinary.  I'm running over DSL with the above card on an external DSL
router.  No netfilter, no tunneling, just IP.

CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=m
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6=m
# CONFIG_IPV6_EUI64 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

CONFIG_DUMMY=m
CONFIG_TULIP=y

I have these set, but I haven't used them:
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m


eth0      Link encap:Ethernet  HWaddr 00:A0:CC:3E:E6:63  
          inet addr:64.81.146.215  Bcast:64.81.146.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:674842 errors:0 dropped:0 overruns:0 frame:0
          TX packets:791977 errors:0 dropped:0 overruns:0 carrier:0
          collisions:490 txqueuelen:100 
          Interrupt:11 Base address:0xd800 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3856  Metric:1
          RX packets:1138 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1138 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
64.81.146.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
0.0.0.0         64.81.146.1     0.0.0.0         UG    0      0        0 eth0


Is there a list somewhere of network options I should report (such as
filtering and tunneling)?

Should one of linux-kernel or linux-net be pruned from the Cc: list?

-- 
Paul Cassella


--- fs/read_write.c~	Sat Nov 11 18:07:38 2000
+++ fs/read_write.c	Sun Jan  7 14:00:25 2001
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
+	if(ret < 0 && file && file->f_op == &socket_file_ops ) {
+	  switch(-ret) {
+		case EAGAIN: case EBADF: case EPIPE: case ENOSPC: case EIO: case ECONNRESET:
+		case EINTR: case ETIMEDOUT: case EFAULT: case EINVAL: case EMSGSIZE: case ENOMEM:
+		case ENOBUFS: case ENOTCONN: 
+		  break;
+
+		default:
+		printk(KERN_ERR "sys_write: ret is unexpectedly %d.\n", ret);
+	  }
+	}
+
 	return ret;
 }
 
--- net/socket.c~	Mon Jan  8 01:26:55 2001
+++ net/socket.c	Sun Jan  7 13:58:55 2001
@@ -111,7 +111,7 @@
  *	in the operation structures but are done directly via the socketcall() multiplexor.
  */
 
-static struct file_operations socket_file_ops = {
+struct file_operations socket_file_ops = {
 llseek:		sock_lseek,
 read:		sock_read,
 write:		sock_write,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
