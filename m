Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTDWTOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTDWTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:14:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7395 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264536AbTDWTOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:14:21 -0400
Date: Wed, 23 Apr 2003 16:26:40 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for net_proto_family
Message-ID: <20030423192640.GD26052@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Max Krasnyansky <maxk@qualcomm.com>, linux-kernel@vger.kernel.org,
	davem@redhat.com
References: <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 23, 2003 at 12:13:37PM -0700, Max Krasnyansky escreveu:
> Hi Folks,
> 
> Can somebody (DaveM perhaps) please explain to me what the hell the following 
> changset is doing in 2.5.68 
>         http://linux.bkbits.net:8080/linux-2.5/cset@1.1118.1.1?nav=index.html|ChangeSet@-7d
> ??
> 
> I've spent quite a bit of time looking into what's needed to fix socket module refcounting
> issues and convicting DaveM and Alex that we need to fix them.
> Here is the original thread
>         http://marc.theaimsgroup.com/?l=linux-kernel&m=104308300808557&w=2

I was not aware of this thread, will read it
 
> My patch was rejected without giving any technical explanation. I was waiting for Rusty's
> __module_get() patch to get in, to release a new patch which addresses some issues that
> came up during discussion.
> Next thing you know, incomplete patch (changeset mentioned above) shows up in the BK and
> 2.5.68. Without even a simple note on the lkm. And completely ignoring discussion that 
> we had about this very issue just a few weeks ago.

This is just the first part, DaveM already merged the second part, that deals with struct
sock
 
> I don't mind of course if some other (better) patch is accepted instead of mine. But patch 
> that went in is incomplete and buggy. It doesn't handle accept case properly and doesn't 
> address the issue of the 'struct sock' ownership (read original thread for more details).

This is dealt with the following patch, and these patches were discussed on the netdev
mailing list. Considerations? I'll be sending today patches converting the net protocols
that I maintain and then for some others that are ummaintained, etc.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1180, 2003-04-23 02:53:59-03:00, acme@conectiva.com.br
  o net: module refcounting for sk_alloc/sk_free
  
  I had to move the rtnetlink_init and init_netlink calls to af_netlink init time, so that
  the sk_alloc called down the rtnetlink_init callchain is done after the PF_NETLINK
  net_proto_family is sock_registered, and because of that the af_netlink init function
  call had to be moved to earlier by means of subsys_initcall (DaveM's suggestion).


 include/linux/net.h      |    3 +++
 net/core/sock.c          |   13 +++++++++----
 net/netlink/af_netlink.c |    8 +++++++-
 net/socket.c             |   42 +++++++++++++++++++++++++++---------------
 4 files changed, 46 insertions(+), 20 deletions(-)


diff -Nru a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h	Wed Apr 23 02:57:58 2003
+++ b/include/linux/net.h	Wed Apr 23 02:57:58 2003
@@ -140,6 +140,9 @@
 	struct module	*owner;
 };
 
+extern int	     net_family_get(int family);
+extern void	     net_family_put(int family);
+
 struct iovec;
 
 extern int	     sock_wake_async(struct socket *sk, int how, int band);
diff -Nru a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	Wed Apr 23 02:57:58 2003
+++ b/net/core/sock.c	Wed Apr 23 02:57:58 2003
@@ -589,8 +589,10 @@
  */
 struct sock *sk_alloc(int family, int priority, int zero_it, kmem_cache_t *slab)
 {
-	struct sock *sk;
-       
+	struct sock *sk = NULL;
+
+	if (!net_family_get(family))
+		goto out;
 	if (!slab)
 		slab = sk_cachep;
 	sk = kmem_cache_alloc(slab, priority);
@@ -602,14 +604,16 @@
 			sock_lock_init(sk);
 		}
 		sk->slab = slab;
-	}
-
+	} else
+		net_family_put(family);
+out:
 	return sk;
 }
 
 void sk_free(struct sock *sk)
 {
 	struct sk_filter *filter;
+	const int family = sk->family;
 
 	if (sk->destruct)
 		sk->destruct(sk);
@@ -624,6 +628,7 @@
 		printk(KERN_DEBUG "sk_free: optmem leakage (%d bytes) detected.\n", atomic_read(&sk->omem_alloc));
 
 	kmem_cache_free(sk->slab, sk);
+	net_family_put(family);
 }
 
 void __init sk_init(void)
diff -Nru a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c	Wed Apr 23 02:57:58 2003
+++ b/net/netlink/af_netlink.c	Wed Apr 23 02:57:58 2003
@@ -1052,6 +1052,7 @@
 struct net_proto_family netlink_family_ops = {
 	.family = PF_NETLINK,
 	.create = netlink_create,
+	.owner	= THIS_MODULE,	/* for consistency 8) */
 };
 
 static int __init netlink_proto_init(void)
@@ -1066,6 +1067,11 @@
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("net/netlink", 0, 0, netlink_read_proc, NULL);
 #endif
+	/* The netlink device handler may be needed early. */ 
+	rtnetlink_init();
+#ifdef CONFIG_NETLINK_DEV
+	init_netlink();
+#endif
 	return 0;
 }
 
@@ -1075,7 +1081,7 @@
        remove_proc_entry("net/netlink", NULL);
 }
 
-module_init(netlink_proto_init);
+subsys_initcall(netlink_proto_init);
 module_exit(netlink_proto_exit);
 
 MODULE_LICENSE("GPL");
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Wed Apr 23 02:57:58 2003
+++ b/net/socket.c	Wed Apr 23 02:57:58 2003
@@ -69,8 +69,6 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/wanrouter.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
 #include <linux/if_bridge.h>
 #include <linux/init.h>
 #include <linux/poll.h>
@@ -143,6 +141,31 @@
 
 static struct net_proto_family *net_families[NPROTO];
 
+static __inline__ void net_family_bug(int family)
+{
+	printk(KERN_ERR "%d is not yet sock_registered!\n", family);
+	BUG();
+}
+
+int net_family_get(int family)
+{
+	int rc = 1;
+
+	if (likely(net_families[family] != NULL))
+		rc = try_module_get(net_families[family]->owner);
+	else
+		net_family_bug(family);
+	return rc;
+}
+
+void net_family_put(int family)
+{
+	if (likely(net_families[family] != NULL))
+		module_put(net_families[family]->owner);
+	else
+		net_family_bug(family);
+}
+
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 static atomic_t net_family_lockct = ATOMIC_INIT(0);
 static spinlock_t net_family_lock = SPIN_LOCK_UNLOCKED;
@@ -511,7 +534,7 @@
 
 		sock->ops->release(sock);
 		sock->ops = NULL;
-		module_put(net_families[family]->owner);
+		net_family_put(family);
 	}
 
 	if (sock->fasync_list)
@@ -1064,7 +1087,7 @@
 	sock->type  = type;
 
 	i = -EBUSY;
-	if (!try_module_get(net_families[family]->owner))
+	if (!net_family_get(family))
 		goto out_release;
 
 	if ((i = net_families[family]->create(sock, protocol)) < 0) 
@@ -1953,17 +1976,6 @@
 	 *  do_initcalls is run.  
 	 */
 
-
-	/*
-	 * The netlink device handler may be needed early.
-	 */
-
-#ifdef CONFIG_NET
-	rtnetlink_init();
-#endif
-#ifdef CONFIG_NETLINK_DEV
-	init_netlink();
-#endif
 #ifdef CONFIG_NETFILTER
 	netfilter_init();
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
1.1180
## Wrapped with gzip_uu ##


M'XL( &8KICX  ^U8;7/:1A#^K/L5FV0ZQ:F!.[V+C#-N@I,P=AR/$_=+T]&(
MTPDT",DCG4AHR7_OGF0P5L OM-]L8$;2:7?UW-X^C_9X 1>%R'M:P*>"O( /
M62%[&L]2P64\"SH\FW:&.=XXSS*\T1UG4]%]<]Q-A6SK'8O@G;- \C',1%[T
M--8Q5B-R?BEZVOG1^XN3W\\).3B M^,@'8G/0L+! 9%9/@N2L#@,Y#C)TH[,
M@[28"ED]<[$R7>B4ZOBUF&-0RUXPFYK.@K.0L<!D(J2ZZ=HF22;3Y+ 8BZDH
MQIUA_/?-  8U=9W9AHFNS+8=C_2!=1AS*5"C2\VN;@#5>Y;1L[PV-7J4@LK'
M83,/\)L);4K>P/\+_BWAD &FM ?3+"P3 ;F(>%:F,DY'$&4Y%!,_2)*,=_$D
MRH5 !_P-8!R$B 6]9@+D&/TD1DGB=.+':2PA2$-0)_[5*'",4BB/(%J-598R
MGHI]*#*,$D@,K8(M'UIYB1#"[%NZZ2GJ-A\'<0IQ@4:IP.A2Y)7IV3O_].C+
MR>#T&(.BEW^99S+SHV :)W-E7V1\XN=B%!?H(L+]"O-0\* L!&11A:>*U$0<
ME2DN39:2&M\R%4-19:,Z%T&>Q AD.(>IP 52\8IR6,R+"GCEUNH',_'Q5P12
MCD:B4!'W.N08F.W8#CF[KEG2?N"'$!I0\OJ.6HE3GI2AZ.+$RN^*5IWQ>M5X
M)EWH'GX7MNE15<+,#6A@"[&Y0K?%4PS $C1=RUW8AFW<#0Q=NVIQ, *_@<AR
M$(OC6 M.(T>W@\BRG&BH>WP+HF:@=2C,9 :[%Y2KM>]>ET$3EK=@&,Q:6)QQ
M(S+,D(O 9=R^!=:VH.L0==<US'M!Y%DNJIDVD57S])#X^M!E@2N&'G<,9MP"
MK!'J1LKPPJSD=,-2WRVL.]<;>6B],4\W=,:<A66YAETKKGE#;TVW9[FWZZWQ
MI+>/0V]K4?H$[?Q;]4/]/-M4X3O(\("9.AA$?,<98\Y2J8'ZJ.S4>?%'0K9P
M'.K+O5=+VUD6AS\97Y8-XZ\5&QNTO9N)NT@&"3%[T\.TE$4GQ:4).AAEFV(P
M:ND>M1>4,48K_BG:/8Q_'K3-)_X] O[5KY4&_QJ%M0/W^I:G@TX&EF> 2;1"
MYB6751+@93&! SB].#E1%-+B"%K/&IR\HM@>T;01IA&R4KXB?9M:*J1-;62U
M]@-$4@BT:%!T14]TZJ$UTX$1M;,I)%S3%Q$4D_;K^N(5FNFV,ML6:TGT38W#
M_1B_>Q^SY05\1Q]##8:['M-"/;&86:N _E 5<*#-GE3@$:A W>QN4(%-%;;3
MJQB[6$6P#F95Y-H!?/DP^.Q__-2_.#G:U[HOJW57)%692?D<W#UXV55^M@L6
M419?,"W+G(1B%G.!64C#!*<\#>8J%:D0(>9")6+>07<@VLW%:R&57\11*")X
M^^GTW>#]<KG\_M$?*$5KQ5.9BC2,(])GU'$1_.#JV$AJ:_F$>K'5\)IB+'= 
M]U.)AVV\;E&&QL9KU9/;U+#KGMQZL!KH2@ZL)SUX!'I0[\\WZ,&RKG9I"9RJ
M(\#W$>@6*60@8PX^8L%9"=^OFN[U?GM8CM;[;?(/T2YS')BTCH_.3_VC\W-X
M_DNHLIAF$N9"-K/Y[&OZ?/^Z7=?>7+Q7K/Z!78>*NWT?H!ZE+G-D+;!5EY+$
M$Y',6RN_6!1_UAY_P;.ZHZE:ELI-YG._+N<J^B:G]NM*#!6TGUL9-?MKZ+F0
M)>Y+<E[#;Z:JL36I\#\ \!5.%>6_X538^MAN*+&L#]O;,U15VZE5M3K>W@CV
?F6=AA\:N_WCF8\$G13D]$'KHF=2FY%]2!X$WTQ8     
 
