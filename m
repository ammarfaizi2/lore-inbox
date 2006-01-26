Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWAZAA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWAZAA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWAZAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:00:56 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:22178 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751241AbWAZAAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:00:55 -0500
Message-ID: <0a3101c6229a$3cc7c1b0$cfa0220a@WeiYJ>
From: "Wei Yongjun" <weiyj@soft.fujitsu.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH]ip_options_fragment() has no effect on fragmentation
Date: Thu, 26 Jan 2006 09:02:06 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0A2E_01C62257.2E8C17B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0A2E_01C62257.2E8C17B0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

[1]Summary of the problem:
ip_options_fragment() has no effect on fragmentation

[2]Full description of the problem:
When I send IPv4 packet(contain Record Route Option) which need to be 
fragmented to the router, the router can not fragment it correctly.
After fragmented by router, the second fragmentation still contain Record 
Route Option. Refer to RFC791, Record Route Option must Not be copied on 
fragmentation, goes in first fragment only.
ip_options_fragment() is the implemental function, but there are some BUGs 
in it:

ip_option.c: line 207:
void ip_options_fragment(struct sk_buff * skb)
{
 unsigned char * optptr = skb->nh.raw;
 struct ip_options * opt = &(IPCB(skb)->opt);
...

optptr get a error pointer to the ipv4 options, correct is as following:

unsigned char * optptr = skb->nh.raw + sizeof(struct iphdr);

By the way, ip_options_fragment() just fill options not allowed in fragments 
with NOOPs, does not delete the space of the options, following patch has 
corrected the problem.

--- linux-2.6.15.1/net/ipv4/ip_options.c.orig 2006-01-23 08:55:15.045904912 
+0900
+++ linux-2.6.15.1/net/ipv4/ip_options.c 2006-01-23 09:04:28.885708464 +0900
@@ -207,33 +207,63 @@

 void ip_options_fragment(struct sk_buff * skb)
 {
- unsigned char * optptr = skb->nh.raw;
+ unsigned char * optptr = skb->nh.raw + sizeof(struct iphdr);
  struct ip_options * opt = &(IPCB(skb)->opt);
  int  l = opt->optlen;
  int  optlen;
+ int  optneed = 0;
+ unsigned char * pp_ptr = optptr;

  while (l > 0) {
   switch (*optptr) {
   case IPOPT_END:
-   return;
+   goto end;
   case IPOPT_NOOP:
    l--;
+   if(optptr != pp_ptr)
+    memcpy(pp_ptr, optptr, 1);
    optptr++;
+   pp_ptr++;
    continue;
   }
   optlen = optptr[1];
-  if (optlen<2 || optlen>l)
-    return;
-  if (!IPOPT_COPIED(*optptr))
-   memset(optptr, IPOPT_NOOP, optlen);
+  if (optlen<2 || optlen>l) {
+   if(optptr != pp_ptr)
+    memcpy(pp_ptr, optptr, l);
+   optptr += l;
+   pp_ptr += l;
+   optneed = 1;
+   goto error;
+  }
+  if (IPOPT_COPIED(*optptr)) {
+   if(optptr != pp_ptr)
+    memcpy(pp_ptr, optptr, optlen);
+   pp_ptr += optlen;
+   optneed = 1;
+  }
   l -= optlen;
   optptr += optlen;
  }
+end:
  opt->ts = 0;
  opt->rr = 0;
  opt->rr_needaddr = 0;
  opt->ts_needaddr = 0;
  opt->ts_needtime = 0;
+error:
+ if (pp_ptr != optptr) {
+  if (optneed == 1) {
+   opt->optlen -= optptr - pp_ptr;
+   if (opt->optlen & 0x03) {
+    for (l = 0; l < 4 - (opt->optlen & 0x03); l++)
+     *pp_ptr++ = IPOPT_END;
+    opt->optlen = (opt->optlen + 3) & ~3;
+   }
+  } else {
+   opt->optlen = 0;
+  }
+  skb->nh.iph->ihl = 5 + (opt->optlen >> 2);
+ }
  return;
 }

--- linux-2.6.15.1/net/ipv4/ip_output.c.orig 2006-01-23 08:54:57.516569776 
+0900
+++ linux-2.6.15.1/net/ipv4/ip_output.c 2006-01-23 09:09:13.531435736 +0900
@@ -503,12 +503,19 @@
     frag->h.raw = frag->data;
     frag->nh.raw = __skb_push(frag, hlen);
     memcpy(frag->nh.raw, iph, hlen);
+    offset += skb->len - hlen;
+    if (offset == skb->len - hlen) {
+     ip_options_fragment(frag);
+     len = frag->nh.iph->ihl * 4;
+     if (hlen != len) {
+      memmove(frag->nh.raw, frag->h.raw - len, len);
+      frag->nh.raw = __skb_pull(frag, hlen - len);
+      hlen = len;
+     }
+    }
     iph = frag->nh.iph;
     iph->tot_len = htons(frag->len);
     ip_copy_metadata(frag, skb);
-    if (offset == 0)
-     ip_options_fragment(frag);
-    offset += skb->len - hlen;
     iph->frag_off = htons(offset>>3);
     if (frag->next != NULL)
      iph->frag_off |= htons(IP_MF);
@@ -619,6 +626,7 @@
    */
   iph = skb2->nh.iph;
   iph->frag_off = htons((offset >> 3));
+  iph->tot_len = htons(len + hlen);

   /* ANK: dirty, but effective trick. Upgrade options only if
    * the segment to be fragmented was THE FIRST (otherwise,
@@ -626,8 +634,11 @@
    * on the initial skb, so that all the following fragments
    * will inherit fixed options.
    */
-  if (offset == 0)
+  if (offset == 0) {
    ip_options_fragment(skb);
+   hlen = skb->nh.iph->ihl * 4;
+   mtu = dst_pmtu(&rt->u.dst) - hlen;
+  }

   /*
    * Added AC : If we are fragmenting a fragment that's not the
@@ -644,8 +655,6 @@

   IP_INC_STATS(IPSTATS_MIB_FRAGCREATES);

-  iph->tot_len = htons(len + hlen);
-
   ip_send_check(iph);

   err = output(skb2);

Best Regard
Wei Yongjun

------=_NextPart_000_0A2E_01C62257.2E8C17B0
Content-Type: application/octet-stream;
	name="fix-a-bug-in-ip_options_fragment.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fix-a-bug-in-ip_options_fragment.patch"

--- linux-2.6.15.1/net/ipv4/ip_options.c.orig	2006-01-23 =
08:55:15.045904912 +0900=0A=
+++ linux-2.6.15.1/net/ipv4/ip_options.c	2006-01-23 09:04:28.885708464 =
+0900=0A=
@@ -207,33 +207,63 @@=0A=
 =0A=
 void ip_options_fragment(struct sk_buff * skb) =0A=
 {=0A=
-	unsigned char * optptr =3D skb->nh.raw;=0A=
+	unsigned char * optptr =3D skb->nh.raw + sizeof(struct iphdr);=0A=
 	struct ip_options * opt =3D &(IPCB(skb)->opt);=0A=
 	int  l =3D opt->optlen;=0A=
 	int  optlen;=0A=
+	int  optneed =3D 0;=0A=
+	unsigned char * pp_ptr =3D optptr;=0A=
 =0A=
 	while (l > 0) {=0A=
 		switch (*optptr) {=0A=
 		case IPOPT_END:=0A=
-			return;=0A=
+			goto end;=0A=
 		case IPOPT_NOOP:=0A=
 			l--;=0A=
+			if(optptr !=3D pp_ptr)=0A=
+				memcpy(pp_ptr, optptr, 1);=0A=
 			optptr++;=0A=
+			pp_ptr++;=0A=
 			continue;=0A=
 		}=0A=
 		optlen =3D optptr[1];=0A=
-		if (optlen<2 || optlen>l)=0A=
-		  return;=0A=
-		if (!IPOPT_COPIED(*optptr))=0A=
-			memset(optptr, IPOPT_NOOP, optlen);=0A=
+		if (optlen<2 || optlen>l) {=0A=
+			if(optptr !=3D pp_ptr)=0A=
+				memcpy(pp_ptr, optptr, l);=0A=
+			optptr +=3D l;=0A=
+			pp_ptr +=3D l;=0A=
+			optneed =3D 1;=0A=
+			goto error;=0A=
+		}=0A=
+		if (IPOPT_COPIED(*optptr)) {=0A=
+			if(optptr !=3D pp_ptr)=0A=
+				memcpy(pp_ptr, optptr, optlen);=0A=
+			pp_ptr +=3D optlen;=0A=
+			optneed =3D 1;=0A=
+		}=0A=
 		l -=3D optlen;=0A=
 		optptr +=3D optlen;=0A=
 	}=0A=
+end:=0A=
 	opt->ts =3D 0;=0A=
 	opt->rr =3D 0;=0A=
 	opt->rr_needaddr =3D 0;=0A=
 	opt->ts_needaddr =3D 0;=0A=
 	opt->ts_needtime =3D 0;=0A=
+error:=0A=
+	if (pp_ptr !=3D optptr) {=0A=
+		if (optneed =3D=3D 1) {=0A=
+			opt->optlen -=3D optptr - pp_ptr;=0A=
+			if (opt->optlen & 0x03) {=0A=
+				for (l =3D 0; l < 4 - (opt->optlen & 0x03); l++)=0A=
+					*pp_ptr++ =3D IPOPT_END;=0A=
+				opt->optlen =3D (opt->optlen + 3) & ~3;=0A=
+			}=0A=
+		} else {=0A=
+			opt->optlen =3D 0;=0A=
+		}=0A=
+		skb->nh.iph->ihl =3D 5 + (opt->optlen >> 2);=0A=
+	}=0A=
 	return;=0A=
 }=0A=
 =0A=
--- linux-2.6.15.1/net/ipv4/ip_output.c.orig	2006-01-23 =
08:54:57.516569776 +0900=0A=
+++ linux-2.6.15.1/net/ipv4/ip_output.c	2006-01-23 09:09:13.531435736 =
+0900=0A=
@@ -503,12 +503,19 @@=0A=
 				frag->h.raw =3D frag->data;=0A=
 				frag->nh.raw =3D __skb_push(frag, hlen);=0A=
 				memcpy(frag->nh.raw, iph, hlen);=0A=
+				offset +=3D skb->len - hlen;=0A=
+				if (offset =3D=3D skb->len - hlen) {=0A=
+					ip_options_fragment(frag);=0A=
+					len =3D frag->nh.iph->ihl * 4;=0A=
+					if (hlen !=3D len) {=0A=
+						memmove(frag->nh.raw, frag->h.raw - len, len);=0A=
+						frag->nh.raw =3D __skb_pull(frag, hlen - len);=0A=
+						hlen =3D len;=0A=
+					}=0A=
+				}=0A=
 				iph =3D frag->nh.iph;=0A=
 				iph->tot_len =3D htons(frag->len);=0A=
 				ip_copy_metadata(frag, skb);=0A=
-				if (offset =3D=3D 0)=0A=
-					ip_options_fragment(frag);=0A=
-				offset +=3D skb->len - hlen;=0A=
 				iph->frag_off =3D htons(offset>>3);=0A=
 				if (frag->next !=3D NULL)=0A=
 					iph->frag_off |=3D htons(IP_MF);=0A=
@@ -619,6 +626,7 @@=0A=
 		 */=0A=
 		iph =3D skb2->nh.iph;=0A=
 		iph->frag_off =3D htons((offset >> 3));=0A=
+		iph->tot_len =3D htons(len + hlen);=0A=
 =0A=
 		/* ANK: dirty, but effective trick. Upgrade options only if=0A=
 		 * the segment to be fragmented was THE FIRST (otherwise,=0A=
@@ -626,8 +634,11 @@=0A=
 		 * on the initial skb, so that all the following fragments=0A=
 		 * will inherit fixed options.=0A=
 		 */=0A=
-		if (offset =3D=3D 0)=0A=
+		if (offset =3D=3D 0) {=0A=
 			ip_options_fragment(skb);=0A=
+			hlen =3D skb->nh.iph->ihl * 4;=0A=
+			mtu =3D dst_pmtu(&rt->u.dst) - hlen;=0A=
+		}=0A=
 =0A=
 		/*=0A=
 		 *	Added AC : If we are fragmenting a fragment that's not the=0A=
@@ -644,8 +655,6 @@=0A=
 =0A=
 		IP_INC_STATS(IPSTATS_MIB_FRAGCREATES);=0A=
 =0A=
-		iph->tot_len =3D htons(len + hlen);=0A=
-=0A=
 		ip_send_check(iph);=0A=
 =0A=
 		err =3D output(skb2);=0A=

------=_NextPart_000_0A2E_01C62257.2E8C17B0--

