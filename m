Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281037AbRKHIdn>; Thu, 8 Nov 2001 03:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281484AbRKHIdc>; Thu, 8 Nov 2001 03:33:32 -0500
Received: from host213-121-105-27.in-addr.btopenworld.com ([213.121.105.27]:3759
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S281037AbRKHIdU>; Thu, 8 Nov 2001 03:33:20 -0500
Subject: Re: SYN cookies security bugfix?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: "B. James Phillippe" <bryanxms@ecst.csuchico.edu>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0111072116350.8925-100000@uranus.terran>
In-Reply-To: <Pine.LNX.4.31.0111072116350.8925-100000@uranus.terran>
Content-Type: multipart/mixed; boundary="=-Q6ZIdFMkEcEpuOhex74F"
X-Mailer: Evolution/0.99.0+cvs.2001.11.06.15.04 (Preview Release)
Date: 08 Nov 2001 08:32:46 +0000
Message-Id: <1005208367.20435.0.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q6ZIdFMkEcEpuOhex74F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2001-11-08 at 05:20, B. James Phillippe wrote:
> Hello,
> 
> I received a forwarded message from SuSE regarding a security vulnerability
> with respect to randomization of the ISN for SYN cookies - or something to
> that effect.  I have not been able to find the patch which addresses this
> problem; if anyone can point me towards it, I would be appreciative.

Hi,

Think this is the patch you want - (backported it from 2.4.14 to 2.4.9).

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
"Every great advance in natural knowledge has involved
the absolute rejection of authority." -- Thomas H. Huxley

--=-Q6ZIdFMkEcEpuOhex74F
Content-Disposition: attachment; filename=syncookie-fix.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -urN linux.orig/include/net/sock.h linux/include/net/sock.h
--- linux.orig/include/net/sock.h	Wed Aug 15 22:21:32 2001
+++ linux/include/net/sock.h	Wed Nov  7 14:24:36 2001
@@ -416,6 +416,8 @@
 	unsigned int		keepalive_time;	  /* time before keep alive takes place */
 	unsigned int		keepalive_intvl;  /* time interval between keep alive probe=
s */
 	int			linger2;
+
+	unsigned long		last_synq_overflow;
 };
=20
  =09
diff -urN linux.orig/net/ipv4/syncookies.c linux/net/ipv4/syncookies.c
--- linux.orig/net/ipv4/syncookies.c	Wed May 16 18:31:27 2001
+++ linux/net/ipv4/syncookies.c	Wed Nov  7 14:23:54 2001
@@ -9,7 +9,7 @@
  *      as published by the Free Software Foundation; either version
  *      2 of the License, or (at your option) any later version.
  *=20
- *  $Id: syncookies.c,v 1.14 2001/05/05 01:01:55 davem Exp $
+ *  $Id: syncookies.c,v 1.17 2001/10/26 14:55:41 davem Exp $
  *
  *  Missing: IPv6 support.=20
  */
@@ -23,8 +23,6 @@
=20
 extern int sysctl_tcp_syncookies;
=20
-static unsigned long tcp_lastsynq_overflow;
-
 /*=20
  * This table has to be sorted and terminated with (__u16)-1.
  * XXX generate a better table.
@@ -53,7 +51,9 @@
 	int mssind;
 	const __u16 mss =3D *mssp;
=20
-	tcp_lastsynq_overflow =3D jiffies;
+=09
+	sk->tp_pinfo.af_tcp.last_synq_overflow =3D jiffies;
+
 	/* XXX sort msstab[] by probability?  Binary search? */
 	for (mssind =3D 0; mss > msstab[mssind + 1]; mssind++)
 		;
@@ -78,14 +78,11 @@
  * Check if a ack sequence number is a valid syncookie.=20
  * Return the decoded mss if it is, or 0 if not.
  */
-static inline int cookie_check(struct sk_buff *skb, __u32 cookie)=20
+static inline int cookie_check(struct sk_buff *skb, __u32 cookie)
 {
 	__u32 seq;=20
 	__u32 mssind;
=20
-  	if ((jiffies - tcp_lastsynq_overflow) > TCP_TIMEOUT_INIT)
-		return 0;=20
-
 	seq =3D ntohl(skb->h.th->seq)-1;=20
 	mssind =3D check_tcp_syn_cookie(cookie,
 				      skb->nh.iph->saddr, skb->nh.iph->daddr,
@@ -126,8 +123,8 @@
 	if (!sysctl_tcp_syncookies || !skb->h.th->ack)
 		goto out;
=20
-	mss =3D cookie_check(skb, cookie);
-	if (!mss) {
+  	if (time_after(jiffies, sk->tp_pinfo.af_tcp.last_synq_overflow + TCP_TI=
MEOUT_INIT) ||
+	    (mss =3D cookie_check(skb, cookie)) =3D=3D 0) {
 	 	NET_INC_STATS_BH(SyncookiesFailed);
 		goto out;
 	}
@@ -178,7 +175,7 @@
 			    opt &&=20
 			    opt->srr ? opt->faddr : req->af.v4_req.rmt_addr,
 			    req->af.v4_req.loc_addr,
-			    sk->protinfo.af_inet.tos | RTO_CONN,
+			    RT_CONN_FLAGS(sk),
 			    0)) {=20
 		tcp_openreq_free(req);
 		goto out;=20

--=-Q6ZIdFMkEcEpuOhex74F--

