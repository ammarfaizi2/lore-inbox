Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSGTJtB>; Sat, 20 Jul 2002 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSGTJtB>; Sat, 20 Jul 2002 05:49:01 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:19073 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S314602AbSGTJs4>;
	Sat, 20 Jul 2002 05:48:56 -0400
Subject: Re: still having smp/snat problems (Re: Linux 2.4.19-rc3)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: glynis@butterfly.hjsoft.com
Cc: lkml <linux-kernel@vger.kernel.org>,
       Netfilter-devel <netfilter-devel@lists.netfilter.org>
In-Reply-To: <20020720041700.GA8172@butterfly.hjsoft.com>
References: <Pine.LNX.4.44.0207192119380.28216-100000@freak.distro.conectiva> 
	<20020720041700.GA8172@butterfly.hjsoft.com>
Content-Type: multipart/mixed; boundary="=-IkkATTX/xHMIERvmfPd7"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jul 2002 11:51:54 +0200
Message-Id: <1027158714.1840.24.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IkkATTX/xHMIERvmfPd7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-07-20 at 06:17, glynis@butterfly.hjsoft.com wrote:
> On Fri, Jul 19, 2002 at 09:20:49PM -0300, Marcelo Tosatti wrote:
> > <rusty@rustcorp.com.au> (02/07/17 1.630)
> > 	[PATCH] The real netfilter conntrack SMP overrun fix
> 
> assuming this should have fixed this:
> LIST_DELETE: ip_conntrack_core.c:165
> `&ct->tuplehash[IP_CT_DIR_REPLY]'(dd8f2e90) not in &ip_conntrack_hash
> [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].
> 
> it doesn't seem to have taken.   i see this error and the following
> crash when i use these rules:
> iptables -t nat -A POSTROUTING -j SNAT --to 64.192.31.41
> iptables -t nat -A POSTROUTING -j SNAT --to 192.168.1.1
> iptables -t nat -A POSTROUTING -j SNAT --to 127.0.0.1
> 
> when i use the masquerading instead of snat, it doesn't exhibit the
> error and crash.
> 
> here's the info for my _stable_ config on my dual athlon 1800+:

Hmm, this is something people have reported a long time but we've never
been able to reproduce it. People have even reported it on UP machines
(maybe they were running with preempt?).
Rusty has been over the locking in conntrack a few times without finding
anything that could explain it.

Could you please apply the attached patch and give it a go and send the
results to netfilter-devel@lists.netfilter.org ?
(I hope it applies, was diffed against my quite patched kernel)

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.

--=-IkkATTX/xHMIERvmfPd7
Content-Disposition: attachment; filename=listhelp.h-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=listhelp.h-patch; charset=ISO-8859-15

--- linux/include/linux/netfilter_ipv4/listhelp.h.orig	Sat Jul 20 11:46:47 =
2002
+++ linux/include/linux/netfilter_ipv4/listhelp.h	Sat Jul 20 11:48:17 2002
@@ -54,9 +54,11 @@
 #define LIST_DELETE(head, oldentry)					\
 do {									\
 	ASSERT_WRITE_LOCK(head);					\
-	if (!list_inlist(head, oldentry))				\
+	if (!list_inlist(head, oldentry)) {				\
 		printk("LIST_DELETE: %s:%u `%s'(%p) not in %s.\n",	\
 		       __FILE__, __LINE__, #oldentry, oldentry, #head);	\
+		BUG();							\
+	}								\
         else list_del((struct list_head *)oldentry);			\
 } while(0)
 #else

--=-IkkATTX/xHMIERvmfPd7--
