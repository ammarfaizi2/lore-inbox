Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131846AbRA0W4J>; Sat, 27 Jan 2001 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbRA0W4A>; Sat, 27 Jan 2001 17:56:00 -0500
Received: from m361-mp1-cvx1b.col.ntl.com ([213.104.73.105]:17156 "EHLO
	[213.104.73.105]") by vger.kernel.org with ESMTP id <S130934AbRA0Wzx>;
	Sat, 27 Jan 2001 17:55:53 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <netdev@oss.sgi.com>, <paulus@linuxcare.com>, <linux-ppp@vger.kernel.org>,
        <linux-net@vger.kernel.org>
Subject: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
From: "John Fremlin" <vii@altern.org>
Date: 27 Jan 2001 22:54:51 +0000
Message-ID: <m2d7d838sj.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

When the IP address of an interface changes, TCP connections with the
old source address are useless. Applications are not notified of this
and time out ordinarily, just as if nothing had happened. This is
behaviour isn't very helpful when you have a dynamic IP and know
you're probably not going to get the old one back. In that case, you
want processes to get errors when they try to use one of the dead
connections, so they can handle the disconnect more cleanly. Otherwise
fetchmail, etc. can just hang waiting for ages. Andi Kleen implemented
this functionality with a per interface flag in 2.2. See
ftp.suse.com:/pub/people/ak/v2.2/iff-dynamic*.

The following patch against 2.4.0 does it a different way. It
introduces a new ioctl, called SIOCKILLADDR. When this ioctl is
called, it makes all IPv4 sockets with the specified source address
return -ENETRESET when they are used.

Is this the right error number? I wasn't quite sure where the ioctl
should go to be in keeping with convention - I bunged it in
devinet_ioctl.

I patched userspace ppp-2.4.0 to use this functionality. It would be
better if SIOCKILLADDR were not used until we are sure that the new IP
is in fact different from the old one, but pppd in demand mode would
not notice that there were extant connections and so would not bring
up the link - so the problem would not be alleviated. Therefore
SIOCKILLADDR is used on disconnect. The functionality is activated
with the killoldaddr option. I would be happy to document it in the
manpage if it were accepted. Further the build process is cleaned up
slightly, as in the patch I sent on or around 8 October 2000.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.0-dynip-3.patch

diff -u --exclude *~ --recursive linux-2.4.0-orig/include/linux/sockios.h linux-hacked-dynip/include/linux/sockios.h
--- linux-2.4.0-orig/include/linux/sockios.h	Sat Dec 30 00:20:32 2000
+++ linux-hacked-dynip/include/linux/sockios.h	Sat Jan 27 17:04:34 2001
@@ -65,6 +65,7 @@
 #define SIOCDIFADDR	0x8936		/* delete PA address		*/
 #define	SIOCSIFHWBROADCAST	0x8937	/* set hardware broadcast addr	*/
 #define SIOCGIFCOUNT	0x8938		/* get number of devices */
+#define SIOCKILLADDR	0x8939		/* kill all connections with this local address */
 
 #define SIOCGIFBR	0x8940		/* Bridging support		*/
 #define SIOCSIFBR	0x8941		/* Set bridging options 	*/
diff -u --exclude *~ --recursive linux-2.4.0-orig/include/net/tcp.h linux-hacked-dynip/include/net/tcp.h
--- linux-2.4.0-orig/include/net/tcp.h	Fri Jan  5 21:41:37 2001
+++ linux-hacked-dynip/include/net/tcp.h	Sat Jan 27 18:02:21 2001
@@ -787,9 +787,8 @@
 extern int			tcp_disconnect(struct sock *sk, int flags);
 
 extern void			tcp_unhash(struct sock *sk);
-
 extern int			tcp_v4_hash_connecting(struct sock *sk);
-
+extern void		tcp_v4_zap_saddr(u32 saddr);
 
 /* From syncookies.c */
 extern struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb, 
diff -u --exclude *~ --recursive linux-2.4.0-orig/net/ipv4/af_inet.c linux-hacked-dynip/net/ipv4/af_inet.c
--- linux-2.4.0-orig/net/ipv4/af_inet.c	Tue Jan  2 09:26:19 2001
+++ linux-hacked-dynip/net/ipv4/af_inet.c	Sat Jan 27 18:27:38 2001
@@ -854,6 +854,7 @@
 		case SIOCSIFPFLAGS:	
 		case SIOCGIFPFLAGS:	
 		case SIOCSIFFLAGS:
+		case SIOCKILLADDR:
 			return(devinet_ioctl(cmd,(void *) arg));
 		case SIOCGIFBR:
 		case SIOCSIFBR:
diff -u --exclude *~ --recursive linux-2.4.0-orig/net/ipv4/devinet.c linux-hacked-dynip/net/ipv4/devinet.c
--- linux-2.4.0-orig/net/ipv4/devinet.c	Sat Dec 30 00:22:05 2000
+++ linux-hacked-dynip/net/ipv4/devinet.c	Sat Jan 27 21:09:48 2001
@@ -510,6 +510,7 @@
 	case SIOCSIFBRDADDR:	/* Set the broadcast address */
 	case SIOCSIFDSTADDR:	/* Set the destination address */
 	case SIOCSIFNETMASK: 	/* Set the netmask for the interface */
+	case SIOCKILLADDR:	/* Kill all connections with this local address */
 		if (!capable(CAP_NET_ADMIN))
 			return -EACCES;
 		if (sin->sin_family != AF_INET)
@@ -536,7 +537,10 @@
 				break;
 	}
 
-	if (ifa == NULL && cmd != SIOCSIFADDR && cmd != SIOCSIFFLAGS) {
+	if (ifa == NULL
+	    && cmd != SIOCSIFADDR
+	    && cmd != SIOCSIFFLAGS
+	    && cmd != SIOCKILLADDR) {
 		ret = -EADDRNOTAVAIL;
 		goto done;
 	}
@@ -646,6 +650,9 @@
 				ifa->ifa_prefixlen = inet_mask_len(ifa->ifa_mask);
 				inet_insert_ifa(ifa);
 			}
+			break;
+		case SIOCKILLADDR:	/* Kill all connections with this local address */
+			tcp_v4_zap_saddr(sin->sin_addr.s_addr);
 			break;
 	}
 done:
diff -u --exclude *~ --recursive linux-2.4.0-orig/net/ipv4/tcp_ipv4.c linux-hacked-dynip/net/ipv4/tcp_ipv4.c
--- linux-2.4.0-orig/net/ipv4/tcp_ipv4.c	Fri Jan  5 21:17:42 2001
+++ linux-hacked-dynip/net/ipv4/tcp_ipv4.c	Sat Jan 27 18:07:25 2001
@@ -390,6 +390,38 @@
 		wake_up(&tcp_lhash_wait);
 }
 
+/* Terminate all active connections with a local address equal to
+ * SADDR.  If sysctl_ip_dynaddr is set, connections in the SYN_SENT
+ * state are not closed, because their source address will presumably
+ * be rewritten.
+ */
+void tcp_v4_zap_saddr(u32 saddr) 
+{
+	int i;
+	rwlock_t *lock;
+	struct sock *sk;
+	
+	for (i = 0; i < (tcp_ehash_size<<1); i++) {
+		lock = &tcp_ehash[i].lock;
+		
+		read_lock(lock);
+
+		for(sk = tcp_ehash[i].chain; sk; sk = sk->next) 
+			if(sk->rcv_saddr == saddr)
+			{
+				if(sysctl_ip_dynaddr && sk->state == TCP_SYN_SENT)
+					continue;
+				
+				sk->err = ENETRESET;
+				sk->error_report(sk);
+
+				tcp_done(sk);
+			}
+		
+		read_unlock(lock);
+	}
+}
+
 /* Don't inline this cruft.  Here are some nice properties to
  * exploit here.  The BSD API does not allow a listening TCP
  * to specify the remote port nor the remote address for the

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=ppp-2.4.0-killaddr.patch

diff -u --recursive ppp-2.4.0-orig/chat/Makefile.linux ppp-2.4.0-hacked/chat/Makefile.linux
--- ppp-2.4.0-orig/chat/Makefile.linux	Fri Aug 13 02:54:32 1999
+++ ppp-2.4.0-hacked/chat/Makefile.linux	Sat Jan 27 18:34:47 2001
@@ -6,14 +6,14 @@
 CDEF4=	-DFNDELAY=O_NDELAY		# Old name value
 CDEFS=	$(CDEF1) $(CDEF2) $(CDEF3) $(CDEF4)
 
-CFLAGS=	-O2 -g -pipe $(CDEFS)
+CFLAGS=	$(COPTS) $(CDEFS)
 
 INSTALL= install
 
 all:	chat
 
 chat:	chat.o
-	$(CC) -o chat chat.o
+	$(CC) $(LDFLAGS) -o chat chat.o
 
 chat.o:	chat.c
 	$(CC) -c $(CFLAGS) -o chat.o chat.c
diff -u --recursive ppp-2.4.0-orig/pppd/options.c ppp-2.4.0-hacked/pppd/options.c
--- ppp-2.4.0-orig/pppd/options.c	Tue Aug  1 02:38:30 2000
+++ ppp-2.4.0-hacked/pppd/options.c	Sat Jan 27 18:51:30 2001
@@ -77,6 +77,9 @@
 char	user[MAXNAMELEN];	/* Username for PAP */
 char	passwd[MAXSECRETLEN];	/* Password for PAP */
 bool	persist = 0;		/* Reopen link after it goes down */
+bool	killoldaddr = 0;		/* If our IP is reassigned on
+				    reconnect, kill active TCP
+				     connections using the old IP. */
 char	our_name[MAXNAMELEN];	/* Our name for authentication purposes */
 bool	demand = 0;		/* do dial-on-demand */
 char	*ipparam = NULL;	/* Extra parameter for ip up/down scripts */
@@ -194,6 +197,10 @@
       "Turn off persist option" },
     { "demand", o_bool, &demand,
       "Dial on demand", OPT_INITONLY | 1, &persist },
+    { "killoldaddr", o_bool, &killoldaddr,
+      "Kill connections from an old source address", 1},
+    { "nokilloldaddr", o_bool,&killoldaddr,
+      "Don't kill connections from an old source address" },
     { "--version", o_special_noarg, (void *)showversion,
       "Show version number" },
     { "--help", o_special_noarg, (void *)showhelp,
diff -u --recursive ppp-2.4.0-orig/pppd/pppd.h ppp-2.4.0-hacked/pppd/pppd.h
--- ppp-2.4.0-orig/pppd/pppd.h	Thu Jul  6 12:17:03 2000
+++ ppp-2.4.0-hacked/pppd/pppd.h	Sat Jan 27 20:13:17 2001
@@ -235,6 +235,9 @@
 extern char	remote_name[MAXNAMELEN]; /* Peer's name for authentication */
 extern bool	explicit_remote;/* remote_name specified with remotename opt */
 extern bool	demand;		/* Do dial-on-demand */
+extern bool	killoldaddr;	/* If our IP is reassigned on
+				    reconnect, kill active TCP
+				     connections using the old IP. */
 extern char	*ipparam;	/* Extra parameter for ip up/down scripts */
 extern bool	cryptpap;	/* Others' PAP passwords are encrypted */
 extern int	idle_time_limit;/* Shut down link if idle for this long */
diff -u --recursive ppp-2.4.0-orig/pppd/sys-linux.c ppp-2.4.0-hacked/pppd/sys-linux.c
--- ppp-2.4.0-orig/pppd/sys-linux.c	Wed Jul 26 05:17:12 2000
+++ ppp-2.4.0-hacked/pppd/sys-linux.c	Sat Jan 27 21:55:03 2001
@@ -115,6 +115,10 @@
 
 #endif /* INET6 */
 
+#ifndef SIOCKILLADDR
+#define SIOCKILLADDR	0x8939
+#endif
+
 /* We can get an EIO error on an ioctl if the modem has hung up */
 #define ok_error(num) ((num)==EIO)
 
@@ -152,6 +156,7 @@
 static u_int32_t proxy_arp_addr;	/* Addr for proxy arp entry added */
 static char proxy_arp_dev[16];		/* Device for proxy arp entry */
 static u_int32_t our_old_addr;		/* for detecting address changes */
+static u_int32_t our_current_addr;
 static int	dynaddr_set;		/* 1 if ip_dynaddr set */
 static int	looped;			/* 1 if using loop */
 static int	link_mtu;		/* mtu for the link (not bundle) */
@@ -491,6 +496,27 @@
     return -1;
 }
 
+static void do_killaddr(u_int32_t oldaddr)
+{
+    struct ifreq   ifr; 
+
+    memset(&ifr,0,sizeof ifr);
+
+    SET_SA_FAMILY (ifr.ifr_addr,    AF_INET); 
+    SET_SA_FAMILY (ifr.ifr_dstaddr, AF_INET); 
+    SET_SA_FAMILY (ifr.ifr_netmask, AF_INET); 
+    
+    SIN_ADDR(ifr.ifr_addr) = oldaddr;
+
+    strlcpy(ifr.ifr_name, ifname, sizeof (ifr.ifr_name));
+    
+    if(ioctl(sock_fd,SIOCKILLADDR,&ifr) < 0) {
+      if (!ok_error (errno))
+	error("ioctl(SIOCKILLADDR): %m(%d)", errno);
+      return;
+    }
+}
+
 /********************************************************************
  *
  * disestablish_ppp - Restore the serial port to normal operation.
@@ -534,6 +560,9 @@
 	if (!multilink)
 	    remove_fd(ppp_dev_fd);
     }
+
+    if(killoldaddr)
+      do_killaddr(our_current_addr);
 }
 
 /*
@@ -2177,10 +2206,10 @@
 {
     struct ifreq   ifr; 
     struct rtentry rt;
-    
+
     memset (&ifr, '\0', sizeof (ifr));
     memset (&rt,  '\0', sizeof (rt));
-    
+
     SET_SA_FAMILY (ifr.ifr_addr,    AF_INET); 
     SET_SA_FAMILY (ifr.ifr_dstaddr, AF_INET); 
     SET_SA_FAMILY (ifr.ifr_netmask, AF_INET); 
@@ -2247,21 +2276,29 @@
 	}
     }
 
-    /* set ip_dynaddr in demand mode if address changes */
-    if (demand && tune_kernel && !dynaddr_set
-	&& our_old_addr && our_old_addr != our_adr) {
+    if(persist && our_old_addr && our_old_addr != our_adr) {
+      /*
+      if(killoldaddr)
+	do_killaddr(our_old_addr);
+      */
+	
+      /* set ip_dynaddr in persist mode if address changes */
+      if (tune_kernel && !dynaddr_set) {
 	/* set ip_dynaddr if possible */
 	char *path;
 	int fd;
 
 	path = path_to_procfs("/sys/net/ipv4/ip_dynaddr");
 	if (path != 0 && (fd = open(path, O_WRONLY)) >= 0) {
-	    if (write(fd, "1", 1) != 1)
-		error("Couldn't enable dynamic IP addressing: %m");
-	    close(fd);
+	  if (write(fd, "1", 1) != 1)
+	    error("Couldn't enable dynamic IP addressing: %m");
+	  close(fd);
 	}
 	dynaddr_set = 1;	/* only 1 attempt */
+      }
     }
+
+    our_current_addr = our_adr;
     our_old_addr = 0;
 
     return 1;
@@ -2317,7 +2354,8 @@
     }
 
     our_old_addr = our_adr;
-
+    our_current_addr = 0;
+    
     return 1;
 }
 
diff -u --recursive ppp-2.4.0-orig/pppdump/Makefile.linux ppp-2.4.0-hacked/pppdump/Makefile.linux
--- ppp-2.4.0-orig/pppdump/Makefile.linux	Mon Jul 26 12:09:29 1999
+++ ppp-2.4.0-hacked/pppdump/Makefile.linux	Sat Jan 27 18:34:47 2001
@@ -1,4 +1,4 @@
-CFLAGS= -O -I../include/net
+CFLAGS= $(COPTS) -I../include/net
 OBJS = pppdump.o bsd-comp.o deflate.o zlib.o
 
 INSTALL= install
@@ -6,7 +6,7 @@
 all:	pppdump
 
 pppdump: $(OBJS)
-	$(CC) -o pppdump $(OBJS)
+	$(CC) $(LDFLAGS) -o pppdump $(OBJS)
 
 clean:
 	rm -f pppdump $(OBJS) *~
diff -u --recursive ppp-2.4.0-orig/pppstats/Makefile.linux ppp-2.4.0-hacked/pppstats/Makefile.linux
--- ppp-2.4.0-orig/pppstats/Makefile.linux	Wed Mar 25 02:21:19 1998
+++ ppp-2.4.0-hacked/pppstats/Makefile.linux	Sat Jan 27 18:34:48 2001
@@ -22,7 +22,7 @@
 	$(INSTALL) -c -m 444 pppstats.8 $(MANDIR)/man8/pppstats.8
 
 pppstats: $(PPPSTATSRCS)
-	$(CC) $(CFLAGS) -o pppstats pppstats.c $(LIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o pppstats pppstats.c $(LIBS)
 
 clean:
 	rm -f pppstats *~ #* core

--=-=-=


-- 

	http://www.penguinpowered.com/~vii

--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
