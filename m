Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132810AbRC2R4Z>; Thu, 29 Mar 2001 12:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRC2R4P>; Thu, 29 Mar 2001 12:56:15 -0500
Received: from h24-66-58-104.wp.shawcable.net ([24.66.58.104]:22280 "EHLO
	mozart.scola.dhs.org") by vger.kernel.org with ESMTP
	id <S132810AbRC2R4L>; Thu, 29 Mar 2001 12:56:11 -0500
Date: Thu, 29 Mar 2001 11:55:24 -0600 (CST)
From: "S. Shore" <sshore@escape.ca>
To: Deja User <amarnder@my-deja.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: question on ip_masq_irc.c
In-Reply-To: <200103291148.DAA28629@mail22.bigmailbox.com>
Message-ID: <Pine.LNX.4.30.0103290759440.8816-100000@mozart.scola.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Deja User wrote:
> I am working on a NAT product and trying provide mIRC support in it. I am looking into ip_masq_irc.c file of Linux 2.2.12 for reference, and have some doubts.
> 1. In 2.2.12 ip_masq_irc.c, DCC RESUME protocol is not supported. In which patch can I find it?
> 2. I have pre-patch-2.2.18-5 linux.18p5/net/ipv4/ip_masq_irc.c, which has support for DCC RESUME. Is this the final patch? I have checked with documentation in mIRC help files about DCC RESUME command string. It says the command string in the pay load looks
>    DCC RESUME filename port position
>    But, in the above file, the string hunted is
>    "\1DCC RESUME chat AAAAAAAA P\1\n"

You're right, it's broken. I submitted a patch for people to test, but
somehow it got into the production kernel without testing.

I created a second patch shortly after realizing the problem, tested and
submitted it, but it doesn't look like it ever made it in.

I'm including the patch. It's a diff against the ip_masq_irc.c from 2.2.17
(which was current at the time), so you may have to get this file
seperately if you're not using 2.2.17. Many apologies.

Scottie Shore                | "Experience is the worst teacher -
<sshore@escape.ca>           |  it teaches you what you need to know
			     |  after you needed to know it."

--- ip_masq_irc.c.orig	Wed Sep 27 22:07:15 2000
+++ ip_masq_irc.c	Sun Oct  1 21:30:41 2000
@@ -20,9 +20,11 @@
  *	Juan Jose Ciarlante	:  put new ms entry to listen()
  *	Scottie Shore		:  added support for clients that add extra args
  *	  <sshore@escape.ca>
+ *	Scottie Shore		:  added support for mIRC DCC resume negotiation
+ *	  <sshore@escape.ca>
  *
- * FIXME:
- *	- detect also previous "PRIVMSG" string ?.
+ * FIXME: take common code from ip_masq_in and ip_masq_out, put into seperate
+ *        function
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -78,22 +80,24 @@
  * List of supported DCC protocols
  */

-#define NUM_DCCPROTO 5
+#define NUM_DCCPROTO 6

 struct dccproto
 {
   char *match;
   int matchlen;
+  int addr;
 };

 struct dccproto dccprotos[NUM_DCCPROTO] = {
- { "SEND ", 5 },
- { "CHAT ", 5 },
- { "MOVE ", 5 },
- { "TSEND ", 6 },
- { "SCHAT ", 6 }
+ { "SEND ", 5, 1 },
+ { "CHAT ", 5, 1 },
+ { "MOVE ", 5, 1 },
+ { "TSEND ", 6, 1 },
+ { "SCHAT ", 6, 1 },
+ { "ACCEPT ", 7, 0 },
 };
-#define MAXMATCHLEN 6
+#define MAXMATCHLEN 7

 static int
 masq_irc_init_1 (struct ip_masq_app *mapp, struct ip_masq *ms)
@@ -118,7 +122,7 @@
 	char *data, *data_limit;
 	__u32 s_addr;
 	__u16 s_port;
-	struct ip_masq *n_ms;
+	struct ip_masq *n_ms = NULL;
 	char buf[20];		/* "m_addr m_port" (dec base)*/
         unsigned buf_len;
 	int diff;
@@ -137,16 +141,18 @@
 	 *	strlen("\1DCC SEND F AAAAAAAA P S\1\n")=26
 	 *	strlen("\1DCC MOVE F AAAAAAAA P S\1\n")=26
 	 *	strlen("\1DCC TSEND F AAAAAAAA P S\1\n")=27
+	 *	strlen("\1DCC ACCEPT F P O\1\n")=19
 	 *		AAAAAAAAA: bound addr (1.0.0.0==16777216, min 8 digits)
 	 *		P:         bound port (min 1 d )
 	 *		F:         filename   (min 1 d )
 	 *		S:         size       (min 1 d )
+	 *		O:	   offset     (min 1 d )
 	 *		0x01, \n:  terminators
          */

         data_limit = skb->h.raw + skb->len;

-	while (data < (data_limit - ( 22 + MAXMATCHLEN ) ) )
+	while (data < (data_limit - ( 12 + MAXMATCHLEN ) ) )
 	{
 		int i;
 		if (memcmp(data,"\1DCC ",5))  {
@@ -171,52 +177,60 @@
 				 *	skip next string.
 				 */

-				while( *data++ != ' ')
+				while ( *data++ != ' ')
+					if (data > (data_limit-5)) return 0;
+				addr_beg_p = data;

+				if (dccprotos[i].addr == 1)
+				{
 					/*
-					 *	must still parse, at least, "AAAAAAAA P\1\n",
-					 *      12 bytes left.
+					 *	client bound address in dec base
 					 */
-					if (data > (data_limit-12)) return 0;
-
-
-				addr_beg_p = data;

-				/*
-				 *	client bound address in dec base
-				 */
-
-				s_addr = simple_strtoul(data,&data,10);
-				if (*data++ !=' ')
-					continue;
+					s_addr = simple_strtoul(data,&data,10);
+					if (*data++ !=' ')
+						continue;

-				/*
-				 *	client bound port in dec base
-				 */
+					/*
+					 *	client bound port in dec base
+					 */

-				s_port = simple_strtoul(data,&data,10);
-				addr_end_p = data;
+					s_port = simple_strtoul(data,&data,10);
+					addr_end_p = data;

-				/*
-				 *	Now create an masquerade entry for it
-				 * 	must set NO_DPORT and NO_DADDR because
-				 *	connection is requested by another client.
-				 */
+					/*
+					 * 	We must set NO_DPORT and NO_DADDR because
+					 *	connection is requested by another client.
+					 */

-				n_ms = ip_masq_new(IPPROTO_TCP,
+					n_ms = ip_masq_new(IPPROTO_TCP,
 						maddr, 0,
 						htonl(s_addr),htons(s_port),
 						0, 0,
 						IP_MASQ_F_NO_DPORT|IP_MASQ_F_NO_DADDR);
-				if (n_ms==NULL)
-					return 0;

-				/*
-				 * Replace the old "address port" with the new one
-				 */
+					if (n_ms==NULL)
+						return 0;
+					ip_masq_listen(n_ms);

-				buf_len = sprintf(buf,"%lu %u",
+					/*
+					 * Replace the old "address port" with the new one
+					 */
+					buf_len = sprintf(buf,"%lu %u",
 						ntohl(n_ms->maddr),ntohs(n_ms->mport));
+				} else {
+					/* client bound port in decimal */
+					s_port = simple_strtoul(data,&data,10);
+					addr_end_p = data;
+
+					n_ms = ip_masq_out_get (IPPROTO_TCP,
+						ms->saddr,htons(s_port),
+						0, 0);
+					if (n_ms == NULL)
+						return 0;
+
+					buf_len = sprintf(buf,"%u",ntohs(n_ms->mport));
+				}

 				/*
 				 * Calculate required delta-offset to keep TCP happy
@@ -242,7 +256,6 @@
 							addr_beg_p, addr_end_p-addr_beg_p,
 							buf, buf_len);
 				}
-				ip_masq_listen(n_ms);
 				ip_masq_put(n_ms);
 				return diff;
 			}
@@ -252,6 +265,122 @@

 }

+int
+masq_irc_in (struct ip_masq_app *mapp, struct ip_masq *ms, struct sk_buff **skb_p, __u32 maddr)
+{
+        struct sk_buff *skb;
+	struct iphdr *iph;
+	struct tcphdr *th;
+	char *data, *data_limit;
+	__u32 s_addr;
+	__u16 s_port;
+	struct ip_masq *n_ms;
+	char buf[20];		/* "m_addr m_port" (dec base)*/
+        unsigned buf_len;
+	int diff;
+        char *dcc_p, *addr_beg_p, *addr_end_p;
+
+        skb = *skb_p;
+	iph = skb->nh.iph;
+        th = (struct tcphdr *)&(((char *)iph)[iph->ihl*4]);
+        data = (char *)&th[1];
+
+        /*
+	 *	Hunt irc DCC RESUME string:
+	 *
+	 *	strlen("\1DCC RESUME F P O\1\n")=19
+	 *		F:         filename   (min 1 c )
+	 *		P:         bound port (min 1 d )
+	 *		O:	   offset     (min 1 d )
+	 *		0x01, \n:  terminators
+         */
+
+        data_limit = skb->h.raw + skb->len;
+
+	while (data < (data_limit - 19 ) )
+	{
+		if (memcmp(data,"\1DCC RESUME ",12))  {
+			data ++;
+			continue;
+		}
+
+		dcc_p = data;
+		data += 12;
+
+		while( *data++ != ' ')
+			/*
+			 *	must still parse, at least, "F P O\1\n",
+			 *      7 bytes left.
+			 */
+			if (data > (data_limit-7)) return 0;
+
+
+		addr_beg_p = data;
+
+		/*
+		 *	masq bound port in dec base
+		 */
+
+		s_port = simple_strtoul(data,&data,10);
+		addr_end_p = data;
+
+		/*
+		 *	Find the masq entry associated with this connection.
+		 *	The entry should have no dest addr/port yet.
+		 *	If there is no entry, return 0.
+		 *
+		 *	mIRC & co. assume that a port can uniquely identify
+		 *	a connection. It's true 99% of the time, but it's still
+		 *	a stupid assumption.
+		 */
+
+		n_ms = ip_masq_in_get(IPPROTO_TCP,
+			0, 0,
+			ms->maddr, htons(s_port));
+
+		if (n_ms==NULL) {
+			return 0;
+		} else {
+			ip_masq_put(n_ms);
+		}
+
+		/*
+		 * Replace the outside address with the inside address
+		 */
+
+		buf_len = sprintf(buf,"%u",
+			ntohs(n_ms->sport));
+
+		/*
+		 * Calculate required delta-offset to keep TCP happy
+		 */
+
+		diff = buf_len - (addr_end_p-addr_beg_p);
+
+		*addr_beg_p = '\0';
+
+		/*
+		 *	No shift.
+		 */
+
+		if (diff==0) {
+			/*
+			 * simple case, just copy.
+			 */
+			memcpy(addr_beg_p,buf,buf_len);
+		} else {
+			*skb_p = ip_masq_skb_replace(skb, GFP_ATOMIC,
+				addr_beg_p, addr_end_p-addr_beg_p,
+				buf, buf_len);
+		}
+
+		return diff;
+
+	}
+	return 0;
+
+}
+
 /*
  *	Main irc object
  *     	You need 1 object per port in case you need
@@ -263,12 +392,12 @@
 struct ip_masq_app ip_masq_irc = {
         NULL,			/* next */
 	"irc",			/* name */
-        0,                      /* type */
-        0,                      /* n_attach */
-        masq_irc_init_1,        /* init_1 */
-        masq_irc_done_1,        /* done_1 */
-        masq_irc_out,           /* pkt_out */
-        NULL                    /* pkt_in */
+        0,			/* type */
+        0,			/* n_attach */
+        masq_irc_init_1,	/* init_1 */
+        masq_irc_done_1,	/* done_1 */
+        masq_irc_out,		/* pkt_out */
+        masq_irc_in		/* pkt_in */
 };

 /*


