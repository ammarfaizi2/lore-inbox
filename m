Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSDCXJs>; Wed, 3 Apr 2002 18:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDCXJl>; Wed, 3 Apr 2002 18:09:41 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:17030 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S312466AbSDCXJc>; Wed, 3 Apr 2002 18:09:32 -0500
Date: Wed, 3 Apr 2002 18:09:30 -0500 (EST)
From: Craig <penguin@wombat.ca>
X-X-Sender: carsnau@wombat
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4: BOOTPC /proc info.
In-Reply-To: <1017802992.2940.602.camel@phantasy>
Message-ID: <Pine.LNX.4.42.0204031759090.711-100000@wombat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
  This patch is against 2.4.19-pre5, please apply.

  The following change would primarily interest people using linux on
embedded boards, but should be usable by any system.
This patch creates one new entry in the proc filesystem.
"/proc/net/bootpc" is now created and contains information if the
kernel received a bootp packet during bootup.  The output format is
identical to the "bootpc" userspace program.  On an embedded system,
this can save 10-15 seconds from boot time (if running 'bootpc' as one
of your init scripts).  Also, this removes a possible point of failure
during bootup.
   We think this patch would be useful to put in the 2.4.x stream.
But there's no reason it can't also go in 2.5.x as well.  We also have
a 2.2.x version availble if there's any interest in that as well.
So what do people think?  Should this go in 2.4 or 2.5?
Is this worthwhile to pursue putting this in (it's very useful to us,
so we figured others could use it)?
Should i send this to Linus for 2.5 inclusion as well?

Here's some sample output from the code:

bash-2.04$ cat /proc/net/bootpc
SERVER='10.40.4.101'
IPADDR='10.40.14.83'
BOOTFILE='/tftpboot/core_24work'
NETMASK='255.255.255.0'
GATEWAYS_1='10.40.14.1'
GATEWAYS='10.40.14.1'
YPDOMAIN='locoland'
HOSTNAME='somecard'
T129='configfile_1a'
NTPSRVS_1='10.40.4.101'
NTPSRVS='10.40.4.101'

Patch is below. Thanks.

--
Craig Arsenault.
+------------------------------------------------------+
http://www.wombat.ca               Why? Why not.
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.42*=--------------------+


diff -Nur linux-2.4.19-pre5/Documentation/Configure.help linux-2.4.19-pre5_NEW/Documentation/Configure.help
--- linux-2.4.19-pre5/Documentation/Configure.help	Wed Apr  3 17:51:42 2002
+++ linux-2.4.19-pre5_NEW/Documentation/Configure.help	Wed Apr  3 18:00:14 2002
@@ -5241,6 +5241,12 @@
   want to use BOOTP, a BOOTP server must be operating on your network.
   Read <file:Documentation/nfsroot.txt> for details.

+Provide bootpc style /proc file
+CONFIG_IP_BOOTP_PROC
+  If you say Y here, the file /proc/net/bootpc will output the bootp
+  record retrieved at boot time in a format identical to the bootpc
+  client program.
+
 DHCP support
 CONFIG_IP_PNP_DHCP
   If you want your Linux box to mount its whole root file system (the
diff -Nur linux-2.4.19-pre5/net/ipv4/Config.in linux-2.4.19-pre5_NEW/net/ipv4/Config.in
--- linux-2.4.19-pre5/net/ipv4/Config.in	Fri Dec 21 12:42:05 2001
+++ linux-2.4.19-pre5_NEW/net/ipv4/Config.in	Wed Apr  3 18:00:14 2002
@@ -20,6 +20,9 @@
 if [ "$CONFIG_IP_PNP" = "y" ]; then
    bool '    IP: DHCP support' CONFIG_IP_PNP_DHCP
    bool '    IP: BOOTP support' CONFIG_IP_PNP_BOOTP
+   if [ "$CONFIG_IP_PNP_BOOTP" = "y" ]; then
+      bool '      Provide bootpc style /proc file' CONFIG_IP_BOOTP_PROC
+   fi
    bool '    IP: RARP support' CONFIG_IP_PNP_RARP
 # not yet ready..
 #   bool '    IP: ARP support' CONFIG_IP_PNP_ARP
diff -Nur linux-2.4.19-pre5/net/ipv4/ipconfig.c linux-2.4.19-pre5_NEW/net/ipv4/ipconfig.c
--- linux-2.4.19-pre5/net/ipv4/ipconfig.c	Mon Feb 25 14:38:14 2002
+++ linux-2.4.19-pre5_NEW/net/ipv4/ipconfig.c	Wed Apr  3 18:00:14 2002
@@ -26,6 +26,10 @@
  *
  *  Merged changes from 2.2.19 into 2.4.3
  *              -- Eric Biederman <ebiederman@lnxi.com>, 22 April Aug 2001
+ *
+ *  Added support for "/proc/net/bootpc" for bootp requests at boottime.
+ *              -- Allan Snider <alsnider@nortelnetworks.com>, 10 March 2002
+ *
  */

 #include <linux/config.h>
@@ -525,6 +529,12 @@
 	func:	ic_bootp_recv,
 };

+#ifdef CONFIG_IP_BOOTP_PROC
+static char Bootp_vars[1024];
+static int Bootp_size;
+
+static void ic_bootp_vars( struct bootp_pkt* );
+#endif

 /*
  *  Initialize DHCP/BOOTP extension fields in the request.
@@ -917,6 +927,10 @@
 		ic_nameserver = ic_servaddr;
 	ic_got_reply = IC_BOOTP;

+#ifdef CONFIG_IP_BOOTP_PROC
+	ic_bootp_vars( b );
+#endif
+
 drop:
 	/* Show's over.  Nothing to see here.  */
 	spin_unlock(&ic_recv_lock);
@@ -1102,6 +1116,28 @@
 	return length;
 }

+#ifdef CONFIG_IP_BOOTP_PROC
+static int
+bootpc_get_info( char *buffer, char **start, off_t offset, int length )
+	{
+	char *bv;
+
+	if( offset > Bootp_size )
+		offset = Bootp_size;
+
+	bv = Bootp_vars;
+	bv += offset;
+
+	if( offset + length > Bootp_size )
+		length = Bootp_size - offset;
+
+	strncpy( buffer, bv, length );
+	*start = buffer;
+
+	return( length );
+	}
+#endif
+
 #endif /* CONFIG_PROC_FS */

 /*
@@ -1115,6 +1151,10 @@

 #ifdef CONFIG_PROC_FS
 	proc_net_create("pnp", 0, pnp_get_info);
+
+#ifdef CONFIG_IP_BOOTP_PROC
+	proc_net_create( "bootpc", 0, bootpc_get_info );
+#endif
 #endif /* CONFIG_PROC_FS */

 	if (!ic_enable)
@@ -1368,3 +1408,392 @@

 __setup("ip=", ip_auto_config_setup);
 __setup("nfsaddrs=", nfsaddrs_config_setup);
+
+
+#ifdef CONFIG_IP_BOOTP_PROC
+
+/*
+ *	ic_bootp_vars:
+ *		Dump the bootp packet received to a static
+ *	buffer using the same format as bootpc.  Users can
+ *	then retrieve this packet by reading:
+ *
+ *		/proc/net/bootpc
+ */
+
+/* Vendor tags
+ *
+ * Please note: These tags came directly from
+ * the user-space program 'bootpc' code, which just did
+ * the work of extracting them from the RFC 1048.
+ * The orig author of that code follows (the only code
+ * from that file that was taken was the following #define's,
+ * which were modified from 'unsigned char' to 'u8'):
+ *
+ **
+ **  Last updated : Mon Sep 16 15:20:57 1996
+ **  Modified by JSP from code by Charles Hawkins <ceh@eng.cam.ac.uk>,
+ **
+ **   J.S.Peatfield@damtp.cam.ac.uk
+ **
+ ** Copyright (c) University of Cambridge, 1993,1994,1995,1996
+ **
+ ** $Revision: 1.2 $
+ ** $Date: 1997/02/26 20:25:02 $
+ **
+ *
+ * */
+
+#define TAG_END			((u8) 255)
+#define TAG_PAD			((u8)   0)
+#define TAG_SUBNET_MASK		((u8)   1)
+#define TAG_TIME_OFFSET		((u8)   2)
+#define TAG_GATEWAY		((u8)   3)
+#define TAG_TIME_SERVER		((u8)   4)
+#define TAG_NAME_SERVER		((u8)   5)
+#define TAG_DOMAIN_SERVER	((u8)   6)
+#define TAG_LOG_SERVER		((u8)   7)
+#define TAG_COOKIE_SERVER	((u8)   8)
+#define TAG_LPR_SERVER		((u8)   9)
+#define TAG_IMPRESS_SERVER	((u8)  10)
+#define TAG_RLP_SERVER		((u8)  11)
+#define TAG_HOST_NAME		((u8)  12)
+#define TAG_BOOT_SIZE		((u8)  13)
+#define TAG_DUMP_FILE		((u8)  14)
+#define TAG_DOMAIN_NAME		((u8)  15)
+#define TAG_SWAP_SERVER		((u8)  16)
+#define TAG_ROOT_PATH		((u8)  17)
+#define TAG_EXTEN_FILE		((u8)  18)
+#define TAG_IP_FORWARD          ((u8)  19)
+#define TAG_IP_NLSR             ((u8)  20)
+#define TAG_IP_POLICY_FILTER    ((u8)  21)
+#define TAG_IP_MAX_DRS          ((u8)  22)
+#define TAG_IP_TTL              ((u8)  23)
+#define TAG_IP_MTU_AGE          ((u8)  24)
+#define TAG_IP_MTU_PLAT         ((u8)  25)
+#define TAG_IP_MTU              ((u8)  26)
+#define TAG_IP_SNARL            ((u8)  27)
+#define TAG_IP_BROADCAST        ((u8)  28)
+#define TAG_IP_SMASKDISC        ((u8)  29)
+#define TAG_IP_SMASKSUPP        ((u8)  30)
+#define TAG_IP_ROUTERDISC       ((u8)  31)
+#define TAG_IP_ROUTER_SOL_ADDR  ((u8)  32)
+#define TAG_IP_STATIC_ROUTES    ((u8)  33)
+#define TAG_IP_TRAILER_ENC      ((u8)  34)
+#define TAG_ARP_TIMEOUT         ((u8)  35)
+#define TAG_ETHER_IEEE          ((u8)  36)
+#define TAG_IP_TCP_TTL          ((u8)  37)
+#define TAG_IP_TCP_KA_INT       ((u8)  38)
+#define TAG_IP_TCP_KA_GARBAGE   ((u8)  39)
+#define TAG_NIS_DOMAIN		((u8)  40)
+#define TAG_NIS_SERVER		((u8)  41)
+#define TAG_NTP_SERVER		((u8)  42)
+#define TAG_VEND_SPECIFIC       ((u8)  43)
+#define TAG_NBNS_SERVER         ((u8)  44)
+#define TAG_NBDD_SERVER         ((u8)  45)
+#define TAG_NBOTCP_OTPION       ((u8)  46)
+#define TAG_NB_SCOPE            ((u8)  47)
+#define TAG_XFONT_SERVER        ((u8)  48)
+#define TAG_XDISPLAY_SERVER     ((u8)  49)
+
+typedef struct
+	{
+	char	*buf;		/* user buffer */
+	int	len;		/* size of buffer */
+	int	n;		/* current size */
+	} bootp_vars;
+
+static void ic_bootp_ext( bootp_vars*, struct bootp_pkt* );
+static void ic_oext( bootp_vars*, u8* );
+static void ic_oip( bootp_vars*, char*, u32 );
+static void ic_olist( bootp_vars*, char*, char*, int );
+static void ic_otag( bootp_vars*, int, char*, int );
+static void ic_ostr( bootp_vars*, char*, char*, int );
+
+
+/*
+ *	ic_bootp_vars:
+ */
+
+static void
+ic_bootp_vars( struct bootp_pkt *b )
+	{
+	bootp_vars vars, *v;
+
+	v = &vars;
+	v->buf = Bootp_vars;
+	v->len = sizeof( Bootp_vars );
+	v->n = 0;
+
+	/* standard fields, SERVER, IPADDR, and BOOTFILE */
+	ic_oip( v, "SERVER", b->server_ip );
+	ic_oip( v, "IPADDR", b->your_ip );
+	ic_ostr( v, "BOOTFILE", b->boot_file, 128 );
+
+	/* extended vendor info */
+	if( !memcmp(b->exten,ic_bootp_cookie,4) )
+		ic_bootp_ext( v, b );
+
+	v->buf[v->n] = 0;
+	Bootp_size = v->n;
+	}
+
+
+/*
+ *	ic_bootp_ext:
+ */
+
+static void
+ic_bootp_ext( bootp_vars *v, struct bootp_pkt *b )
+	{
+	u8 *end, *ext;
+
+	end = (u8*) b + ntohs( b->iph.tot_len );
+	ext = &b->exten[4];
+
+	if( ext >= end )
+		/* no extended data */
+		return;
+
+	while( *ext != TAG_END )
+		{
+		u8 *opt = ext++;
+		if( *opt == TAG_PAD )
+			continue;
+
+		ext += *ext + 1;
+		if( ext < end )
+			ic_oext( v, opt );
+		}
+	}
+
+
+/*
+ *	ic_oext:
+ *		Output extended vendor info.
+ */
+
+static void
+ic_oext( bootp_vars *v, u8 *opt )
+	{
+	u8 *tv, tn, tl;
+
+	/* tag number, tag length, tag value */
+	tn = *opt++;
+	tl = *opt++;
+	tv = opt;
+
+	switch( tn )
+		{
+		case TAG_SUBNET_MASK:
+			ic_oip( v, "NETMASK", *((u32*)tv) );
+			break;
+
+		case TAG_GATEWAY:
+			ic_olist( v, "GATEWAYS", tv, tl );
+			break;
+
+		case TAG_TIME_SERVER:
+			ic_olist( v, "TIMESRVS", tv, tl );
+			break;
+
+		case TAG_NAME_SERVER:
+			ic_olist( v, "IEN116SRVS", tv, tl );
+			break;
+
+		case TAG_DOMAIN_SERVER:
+			ic_olist( v, "DNSSRVS", tv, tl );
+			break;
+
+		case TAG_LOG_SERVER:
+			ic_olist( v, "LOGSRVS", tv, tl );
+			break;
+
+		case TAG_COOKIE_SERVER:
+			ic_olist( v, "QODSRVS", tv, tl );
+			break;
+
+		case TAG_LPR_SERVER:
+			ic_olist( v, "LPRSRVS", tv, tl );
+			break;
+
+		case TAG_IMPRESS_SERVER:
+			ic_olist( v, "IMPRESSSRVS", tv, tl );
+			break;
+
+		case TAG_RLP_SERVER:
+			ic_olist( v, "RLPSRVS", tv, tl );
+			break;
+
+		case TAG_HOST_NAME:
+			ic_ostr( v, "HOSTNAME", tv, tl );
+			break;
+
+		case TAG_DOMAIN_NAME:
+			ic_ostr( v, "DOMAIN", tv, tl );
+			break;
+
+		case TAG_SWAP_SERVER:
+			ic_olist( v, "SWAPSRVR", tv, tl );
+			break;
+
+		case TAG_ROOT_PATH:
+			ic_ostr( v, "ROOT_PATH", tv, tl );
+			break;
+
+		case TAG_EXTEN_FILE:
+			ic_ostr( v, "EXTEN_FILE", tv, tl );
+			break;
+
+		case TAG_NIS_DOMAIN:
+			ic_ostr( v, "YPDOMAIN", tv, tl );
+			break;
+
+		case TAG_NIS_SERVER:
+			ic_olist( v, "YPSRVR", tv, tl );
+			break;
+
+		case TAG_NTP_SERVER:
+			ic_olist( v, "NTPSRVS", tv, tl );
+			break;
+
+		default:
+			ic_otag( v, tn, tv, tl );
+			break;
+		}
+	}
+
+
+/*
+ *	ic_oip:
+ *		Output an IP address.
+ */
+
+static void
+ic_oip( bootp_vars *v, char *var, u32 val )
+	{
+	ic_ostr( v, var, in_ntoa(val), -1 );
+	}
+
+
+/*
+ *	ic_olist:
+ *		Output a list of IP addresses
+ *	of the form:
+ *
+ *		VAR='ip_1 ip_2 ... ip_n'
+ *		VAR_1='ip_1'
+ *		VAR_2='ip_2'
+ *		...
+ *		VAR_n='ip_n'
+ *
+ *	Process at most 10 IPs.
+ */
+
+static void
+ic_olist( bootp_vars *v, char *var, char *tv, int tl )
+	{
+	char buf[200], *b;
+	char vn[40], *ip;
+	u32 *t;
+	int n, i;
+
+	n = tl / 4;
+	if( n > 10 )
+		n = 10;
+
+	b = buf;
+	t = (u32*) tv;
+
+	for( i=0; i<n; i++, t++ )
+		{
+		sprintf( vn, "%s_%d", var, i+1 );
+
+		ip = in_ntoa( *t );
+		ic_ostr( v, vn, ip, -1 );
+
+		if( i )
+			*b++ = ' ';
+
+		while( *ip )
+			*b++ = *ip++;
+		}
+
+	*b = 0;
+	ic_ostr( v, var, buf, -1 );
+	}
+
+
+/*
+ *	ic_otag:
+ *		Output a generic tag value.
+ */
+
+static void
+ic_otag( bootp_vars *v, int tn, char *tv, int tl )
+	{
+	char var[10];
+
+	sprintf( var, "T%d", tn );
+	ic_ostr( v, var, tv, tl );
+	}
+
+
+/*
+ *	ic_ostr:
+ *		Output a variable and its value to the buffer
+ *	of the form:
+ *
+ *		var='val'\n
+ *
+ *	Ensure that we do not overwrite the supplied buffer.
+ *	If the given tag length (tl) is < 0, then we use
+ *	strlen() to determine length.
+ */
+
+static void
+ic_ostr( bootp_vars *v, char *var, char *tv, int tl )
+	{
+	char *p;
+	int lv, l;
+	int t, i;
+
+	/* determine the lengths of var and val */
+	lv = strlen( var );
+	if( tl < 0 )
+		l = strlen( tv );
+	else
+		{
+		p = tv;
+		for( l=0; l<tl; l++ )
+			if( !*p++ )
+				break;
+		}
+
+	/* total length */
+	t = lv + l + 4;
+
+	/* room to add string? */
+	if( v->n + t >= v->len )
+		/* nope */
+		return;
+
+	/* add it */
+	p = v->buf + v->n;
+	while( *var )
+		*p++ = *var++;
+
+	*p++ = '=';
+
+	*p++ = '\'';
+	for( i=0; i<l; i++ )
+		*p++ = *tv++;
+	*p++ = '\'';
+
+	*p = '\n';
+
+	/* update buffer length */
+	v->n += t;
+	}
+
+#endif





