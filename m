Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSKKX1y>; Mon, 11 Nov 2002 18:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265448AbSKKX1y>; Mon, 11 Nov 2002 18:27:54 -0500
Received: from webmail.topspin.com ([12.162.17.3]:64079 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S265380AbSKKX1g>; Mon, 11 Nov 2002 18:27:36 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] increase MAX_ADDR_LEN
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Nov 2002 15:34:23 -0800
In-Reply-To: <20021111.151929.31543489.davem@redhat.com>
Message-ID: <52r8drn0jk.fsf_-_@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Nov 2002 23:34:20.0437 (UTC) FILETIME=[DBDD1450:01C289DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I posted this to lkml last week and didn't get any response, positive
or negative, so I'm sending this directly to you.  Would you include
these patches (or something that solves the same problem) in 2.5?
This will make it possible to add IP-over-InfiniBand when the driver
is ready without changes to the core kernel.  Since the driver will
not be ready until 2.6 time, I would very much like to get all the
core changes required into the kernel now, before it's too late.

I'm very open to a suggestion of a better way to handle the fact that
IPoIB has a 20 byte hardware address, and I'd be happy to implement a
patch for an alternative approach if that's what it will take to get
support into the kernel.

Thanks,
  Roland <roland@topspin.com>

Here's my previous email:

Included below are some changes that I would like to see included (in
some form) in the standard kernel.  They will make future support for
InfiniBand much simpler; while the code at <http://infiniband.sf.net>
is nowhere near ready for widespread use (let alone inclusion in the
kernel), if we can get these small changes in the kernel then it will
be much simpler to distribute and use InfiniBand drivers in the future.

Note that I am definitely not asking that these patches be included
as-is in the kernel.  I would just like to open discussion by raising
an issue and proposing one possible solution.

These patches (against Linus's BK tree of a few days ago):

  1. Add ARPHRD_INFINIBAND to if_arp.h.  This is extremely minor, but
     does make an IP-over-InfiniBand driver cleaner.  My feeling is we
     might as well do this.

  2. Increase MAX_ADDR_LEN to 32 (from 8) and make some small changes
     to prevent this from causing problems for existing code.

  3. Get rid of suspicious-looking uses of MAX_ADDR_LEN in the sungem
     and s390/net/lcs drivers.  I have no idea whether these changes
     are necessary but I wanted to call this code to the maintainer's
     attention.

I expect #2 to be somewhat controversial, so let me give my motivation
for proposing this.  The IETF draft for IP-over-InfiniBand (which
seems very unlikely to change at this point) defines the IPoIB
hardware address to be 20 bytes long.  Of course, not everyone feels
this was the best way to define the encapsulation, but the issue was
extensively debated in the IETF ipoib working group, and the 20 byte
hardware address seems to be the least bad option.

(By the way, I have no particular attachment to the exact number 32.
As long as we raise MAX_ADDR_LEN to at least 20, I'll be happy.  It
does seem desirable for MAX_ADDR_LEN to be a multiple of 8.  With this
in mind, 24 would be perfectly acceptable for IPoIB; I just chose 32
becase I had to choose something!)

There are two ways to implement an IPoIB network driver:

  1. The driver can tell the kernel that the hardware address length
     is less than it really is, and rewrite packets as they pass into
     and out of the driver.  I've actually implemented this, and while
     it works, it is ugly, complex, and implies that special tools are
     required in userspace (for example, creating an ARP entry
     requires a special mechanism for passing the hardware address
     directly to the driver, and then creating a corresponding entry
     in the kernel's ARP table).

  2. The driver can give the real 20-byte hardware address length to
     the kernel.  This seems much cleaner, but of course it requires
     the value of MAX_ADDR_LEN to be increased.

Since the second option seems so much better, I would like to get the
needed changes into the kernel before the 2.6 release.  If this change
is not in the standard kernel, then vendor kernels will likely not
pick it up.  This will substantially complicate the task of developing
an IPoIB driver, since anyone who wants to test or use the driver will
have to patch their kernel.  If these changes go into the standard
kernel, then an IPoIB driver can simply be distributed as a module
that is compiled and loaded into any 2.6 kernel.

Please try these patches and let me know if they cause any problems
for you.  I am currently running these patches and a small dummy net
driver that registers a device with type ARPHRD_INFINIBAND and
hardware address length 20 on my workstation without trouble.
ifconfig does produce bogus output for the dummy network device but
that is another battle.  (I would be interested in ideas for how to
resolve the fact that the sa_data member of struct sockaddr is only 14
bytes long)

Of course I am also eager to find out other developers' thoughts on
how to implement IPoIB on Linux.

Thanks,
  Roland <roland@topspin.com>

===================================================================

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.874, 2002-11-07 11:37:37-08:00, roland@topspin.com
  Increase MAX_ADDR_LEN from 8 to 32 (to support
  IP-over-InfiniBand hardware addresses)

ChangeSet@1.873, 2002-11-07 11:35:31-08:00, roland@topspin.com
  Add IANA-assigned ARPHRD_INFINIBAND value for IP-over-InfiniBand to if_arp.h


 drivers/net/sungem.c      |    2 +-
 drivers/s390/net/lcs.c    |    2 +-
 include/linux/if_arp.h    |    1 +
 include/linux/netdevice.h |    2 +-
 net/core/dev.c            |    4 ++--
 5 files changed, 6 insertions(+), 5 deletions(-)


diff -Nru a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c	Thu Nov  7 12:47:32 2002
+++ b/drivers/net/sungem.c	Thu Nov  7 12:47:32 2002
@@ -2858,7 +2858,7 @@
 		printk(KERN_ERR "%s: can't get mac-address\n", dev->name);
 		return -1;
 	}
-	memcpy(dev->dev_addr, addr, MAX_ADDR_LEN);
+	memcpy(dev->dev_addr, addr, 6);
 #else
 	get_gem_mac_nonobp(gp->pdev, gp->dev->dev_addr);
 #endif
diff -Nru a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c	Thu Nov  7 12:47:32 2002
+++ b/drivers/s390/net/lcs.c	Thu Nov  7 12:47:32 2002
@@ -3569,7 +3569,7 @@
 	struct ifmcaddr6 *im6;
 	struct inet6_dev *in6_dev;
 #endif
-	char buf[MAX_ADDR_LEN];
+	char buf[LCS_ADDR_LEN];
 	lcs_ipm_list *curr_lmem, *new_lmem;
 	lcs_state oldstate;
 
diff -Nru a/include/linux/if_arp.h b/include/linux/if_arp.h
--- a/include/linux/if_arp.h	Thu Nov  7 12:47:32 2002
+++ b/include/linux/if_arp.h	Thu Nov  7 12:47:32 2002
@@ -40,6 +40,7 @@
 #define ARPHRD_METRICOM	23		/* Metricom STRIP (new IANA id)	*/
 #define	ARPHRD_IEEE1394	24		/* IEEE 1394 IPv4 - RFC 2734	*/
 #define ARPHRD_EUI64	27		/* EUI-64                       */
+#define ARPHRD_INFINIBAND 32		/* InfiniBand			*/
 
 /* Dummy types for non ARP hardware */
 #define ARPHRD_SLIP	256
diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	Thu Nov  7 12:47:32 2002
+++ b/include/linux/netdevice.h	Thu Nov  7 12:47:32 2002
@@ -65,7 +65,7 @@
 
 #endif
 
-#define MAX_ADDR_LEN	8		/* Largest hardware address length */
+#define MAX_ADDR_LEN	32		/* Largest hardware address length */
 
 /*
  *	Compute the worst case header length according to the protocols
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Thu Nov  7 12:47:32 2002
+++ b/net/core/dev.c	Thu Nov  7 12:47:32 2002
@@ -2062,7 +2062,7 @@
 
 		case SIOCGIFHWADDR:
 			memcpy(ifr->ifr_hwaddr.sa_data, dev->dev_addr,
-			       MAX_ADDR_LEN);
+			       min(sizeof ifr->ifr_hwaddr.sa_data, dev->addr_len));
 			ifr->ifr_hwaddr.sa_family = dev->type;
 			return 0;
 
@@ -2083,7 +2083,7 @@
 			if (ifr->ifr_hwaddr.sa_family != dev->type)
 				return -EINVAL;
 			memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-			       MAX_ADDR_LEN);
+			       min(sizeof ifr->ifr_hwaddr.sa_data, dev->addr_len));
 			notifier_call_chain(&netdev_chain,
 					    NETDEV_CHANGEADDR, dev);
 			return 0;
