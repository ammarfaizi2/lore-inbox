Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRA3Asy>; Mon, 29 Jan 2001 19:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRA3Asp>; Mon, 29 Jan 2001 19:48:45 -0500
Received: from m67-mp1-cvx1b.col.ntl.com ([213.104.72.67]:31493 "EHLO
	[213.104.72.67]") by vger.kernel.org with ESMTP id <S131511AbRA3Asi>;
	Mon, 29 Jan 2001 19:48:38 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        <paulus@linuxcare.com>, <linux-ppp@vger.kernel.org>,
        <linux-net@vger.kernel.org>
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
In-Reply-To: <200101290245.f0T2j2Y438757@saturn.cs.uml.edu>
From: "John Fremlin" <vii@altern.org>
Date: 30 Jan 2001 00:43:32 +0000
In-Reply-To: "Albert D. Cahalan"'s message of "Sun, 28 Jan 2001 21:45:02 -0500 (EST)"
Message-ID: <m266ixuax7.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
[...]

> > I patched userspace ppp-2.4.0 to use this functionality. It would be
> > better if SIOCKILLADDR were not used until we are sure that the new IP
> > is in fact different from the old one, but pppd in demand mode would
> 
> I get the same IP about 2/3 of the time, so it is pretty important
> to avoid killing connections until after the new IP is known.

I'll try to explain again. If you have an existing (e.g. ssh)
connection to a host across the interface, and the interface comes
down then pppd _will not bring it up again_ until you try to start a
new connection, as far as I have experienced. Therefore you will get
the old behaviour and my patch will do nothing. I decided it was
better to inform ssh that the link was dead.

Like I said, the solution to this is to make pppd cleverer about
bringing the link up when there are existing
connections. Alternatively, you could have some dubious script parsing
netstat checking whether there are connections over the interface.
and pinging hosts at intervals to bring the link up again ;-)

Here is a patch for pppd-2.4.0 orig that will give you the behaviour
you want, provided you can solve the problem in the first
paragraph. It almost exactly the same as my last patch. It compiles
and everything. Note that there are no changes required to the kernel
side patch to enable this functionality.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=ppp-2.4.0-killaddr-smarter.patch

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
+
+      if(killoldaddr)
+	do_killaddr(our_old_addr);
+
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
