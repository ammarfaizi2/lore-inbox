Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbSJHDDm>; Mon, 7 Oct 2002 23:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbSJHDDm>; Mon, 7 Oct 2002 23:03:42 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:36113 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262716AbSJHDDg>; Mon, 7 Oct 2002 23:03:36 -0400
Date: Tue, 8 Oct 2002 00:09:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Appletalk: convert some spinlocks to rwlocks
Message-ID: <20021008030908.GA10196@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please pull from:

master.kernel.org:/home/acme/BK/llc-2.5

	Now there is only this changeset outstanding.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.633, 2002-10-08 00:05:45-03:00, acme@conectiva.com.br
  o Appletalk: convert some spinlocks to rwlocks
  
  - Remove uneeded #ifdef CONFIG_SYSCTL
  - Make __init strings __initdata, saving some more bytes after init.


 include/linux/atalk.h            |    4 +-
 net/appletalk/atalk_proc.c       |    8 ++--
 net/appletalk/ddp.c              |   65 +++++++++++++++++++--------------------
 net/appletalk/sysctl_net_atalk.c |    8 ++--
 4 files changed, 42 insertions(+), 43 deletions(-)


diff -Nru a/include/linux/atalk.h b/include/linux/atalk.h
--- a/include/linux/atalk.h	Tue Oct  8 00:06:24 2002
+++ b/include/linux/atalk.h	Tue Oct  8 00:06:24 2002
@@ -199,13 +199,13 @@
 #define at_sk(__sk) ((struct atalk_sock *)(__sk)->protinfo)
 
 extern struct sock *atalk_sockets;
-extern spinlock_t atalk_sockets_lock;
+extern rwlock_t atalk_sockets_lock;
 
 extern struct atalk_route *atalk_routes;
 extern rwlock_t atalk_routes_lock;
 
 extern struct atalk_iface *atalk_interfaces;
-extern spinlock_t atalk_interfaces_lock;
+extern rwlock_t atalk_interfaces_lock;
 
 extern struct atalk_route atrtr_default;
 
diff -Nru a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
--- a/net/appletalk/atalk_proc.c	Tue Oct  8 00:06:24 2002
+++ b/net/appletalk/atalk_proc.c	Tue Oct  8 00:06:24 2002
@@ -30,7 +30,7 @@
 {
 	loff_t l = *pos;
 
-	spin_lock_bh(&atalk_interfaces_lock);
+	read_lock_bh(&atalk_interfaces_lock);
 	return l ? atalk_get_interface_idx(--l) : (void *)1;
 }
 
@@ -53,7 +53,7 @@
 
 static void atalk_seq_interface_stop(struct seq_file *seq, void *v)
 {
-	spin_unlock_bh(&atalk_interfaces_lock);
+	read_unlock_bh(&atalk_interfaces_lock);
 }
 
 static int atalk_seq_interface_show(struct seq_file *seq, void *v)
@@ -154,7 +154,7 @@
 {
 	loff_t l = *pos;
 
-	spin_lock_bh(&atalk_sockets_lock);
+	read_lock_bh(&atalk_sockets_lock);
 	return l ? atalk_get_socket_idx(--l) : (void *)1;
 }
 
@@ -177,7 +177,7 @@
 
 static void atalk_seq_socket_stop(struct seq_file *seq, void *v)
 {
-	spin_unlock_bh(&atalk_sockets_lock);
+	read_unlock_bh(&atalk_sockets_lock);
 }
 
 static int atalk_seq_socket_show(struct seq_file *seq, void *v)
diff -Nru a/net/appletalk/ddp.c b/net/appletalk/ddp.c
--- a/net/appletalk/ddp.c	Tue Oct  8 00:06:24 2002
+++ b/net/appletalk/ddp.c	Tue Oct  8 00:06:24 2002
@@ -73,10 +73,8 @@
 				     struct atalk_addr *sa);
 extern void aarp_proxy_remove(struct net_device *dev, struct atalk_addr *sa);
 
-#ifdef CONFIG_SYSCTL
-extern inline void atalk_register_sysctl(void);
-extern inline void atalk_unregister_sysctl(void);
-#endif /* CONFIG_SYSCTL */
+extern void atalk_register_sysctl(void);
+extern void atalk_unregister_sysctl(void);
 
 struct datalink_proto *ddp_dl, *aarp_dl;
 static struct proto_ops atalk_dgram_ops;
@@ -88,29 +86,29 @@
 \**************************************************************************/
 
 struct sock *atalk_sockets;
-spinlock_t atalk_sockets_lock = SPIN_LOCK_UNLOCKED;
+rwlock_t atalk_sockets_lock = RW_LOCK_UNLOCKED;
 
 extern inline void atalk_insert_socket(struct sock *sk)
 {
-	spin_lock_bh(&atalk_sockets_lock);
+	write_lock_bh(&atalk_sockets_lock);
 	sk->next = atalk_sockets;
 	if (sk->next)
 		atalk_sockets->pprev = &sk->next;
 	atalk_sockets = sk;
 	sk->pprev = &atalk_sockets;
-	spin_unlock_bh(&atalk_sockets_lock);
+	write_unlock_bh(&atalk_sockets_lock);
 }
 
 extern inline void atalk_remove_socket(struct sock *sk)
 {
-	spin_lock_bh(&atalk_sockets_lock);
+	write_lock_bh(&atalk_sockets_lock);
 	if (sk->pprev) {
 		if (sk->next)
 			sk->next->pprev = sk->pprev;
 		*sk->pprev = sk->next;
 		sk->pprev = NULL;
 	}
-	spin_unlock_bh(&atalk_sockets_lock);
+	write_unlock_bh(&atalk_sockets_lock);
 }
 
 static struct sock *atalk_search_socket(struct sockaddr_at *to,
@@ -118,7 +116,7 @@
 {
 	struct sock *s;
 
-	spin_lock_bh(&atalk_sockets_lock);
+	read_lock_bh(&atalk_sockets_lock);
 	for (s = atalk_sockets; s; s = s->next) {
 		struct atalk_sock *at = at_sk(s);
 
@@ -145,7 +143,7 @@
 			break; 
 		}
 	}
-	spin_unlock_bh(&atalk_sockets_lock);
+	read_unlock_bh(&atalk_sockets_lock);
 	return s;
 }
 
@@ -164,7 +162,7 @@
 {
 	struct sock *s;
 
-	spin_lock_bh(&atalk_sockets_lock);
+	write_lock_bh(&atalk_sockets_lock);
 	for (s = atalk_sockets; s; s = s->next) {
 		struct atalk_sock *at = at_sk(s);
 
@@ -183,7 +181,7 @@
 		sk->pprev = &atalk_sockets;
 	}
 
-	spin_unlock_bh(&atalk_sockets_lock);
+	write_unlock_bh(&atalk_sockets_lock);
 	return s;
 }
 
@@ -225,12 +223,12 @@
 *                                                                          *
 \**************************************************************************/
 
-/* Anti-deadlock ordering is router_lock --> iface_lock -DaveM */
+/* Anti-deadlock ordering is atalk_routes_lock --> iface_lock -DaveM */
 struct atalk_route *atalk_routes;
 rwlock_t atalk_routes_lock = RW_LOCK_UNLOCKED;
 
 struct atalk_iface *atalk_interfaces;
-spinlock_t atalk_interfaces_lock = SPIN_LOCK_UNLOCKED;
+rwlock_t atalk_interfaces_lock = RW_LOCK_UNLOCKED;
 
 /* For probing devices or in a routerless network */
 struct atalk_route atrtr_default;
@@ -245,7 +243,7 @@
 	struct atalk_iface **iface = &atalk_interfaces;
 	struct atalk_iface *tmp;
 
-	spin_lock_bh(&atalk_interfaces_lock);
+	write_lock_bh(&atalk_interfaces_lock);
 	while ((tmp = *iface) != NULL) {
 		if (tmp->dev == dev) {
 			*iface = tmp->next;
@@ -255,7 +253,7 @@
 		} else
 			iface = &tmp->next;
 	}
-	spin_unlock_bh(&atalk_interfaces_lock);
+	write_unlock_bh(&atalk_interfaces_lock);
 }
 
 static struct atalk_iface *atif_add_device(struct net_device *dev,
@@ -274,10 +272,10 @@
 	iface->address = *sa;
 	iface->status = 0;
 
-	spin_lock_bh(&atalk_interfaces_lock);
+	write_lock_bh(&atalk_interfaces_lock);
 	iface->next = atalk_interfaces;
 	atalk_interfaces = iface;
-	spin_unlock_bh(&atalk_interfaces_lock);
+	write_unlock_bh(&atalk_interfaces_lock);
 out:
 	return iface;
 out_mem:
@@ -394,7 +392,7 @@
 	 * Return a point-to-point interface only if
 	 * there is no non-ptp interface available.
 	 */
-	spin_lock_bh(&atalk_interfaces_lock);
+	read_lock_bh(&atalk_interfaces_lock);
 	for (iface = atalk_interfaces; iface; iface = iface->next) {
 		if (!fiface && !(iface->dev->flags & IFF_LOOPBACK))
 			fiface = iface;
@@ -411,7 +409,7 @@
 	else
 		retval = NULL;
 out:
-	spin_unlock_bh(&atalk_interfaces_lock);
+	read_unlock_bh(&atalk_interfaces_lock);
 	return retval;
 }
 
@@ -442,7 +440,7 @@
 {
 	struct atalk_iface *iface;
 
-	spin_lock_bh(&atalk_interfaces_lock);
+	read_lock_bh(&atalk_interfaces_lock);
 	for (iface = atalk_interfaces; iface; iface = iface->next) {
 		if ((node == ATADDR_BCAST ||
 		     node == ATADDR_ANYNODE ||
@@ -457,7 +455,7 @@
 		    ntohs(net) <= ntohs(iface->nets.nr_lastnet))
 		        break;
 	}
-	spin_unlock_bh(&atalk_interfaces_lock);
+	read_unlock_bh(&atalk_interfaces_lock);
 	return iface;
 }
 
@@ -574,7 +572,7 @@
 	if (!devhint) {
 		riface = NULL;
 
-		spin_lock_bh(&atalk_interfaces_lock);
+		read_lock_bh(&atalk_interfaces_lock);
 		for (iface = atalk_interfaces; iface; iface = iface->next) {
 			if (!riface &&
 			    ntohs(ga->sat_addr.s_net) >=
@@ -587,7 +585,7 @@
 			    ga->sat_addr.s_node == iface->address.s_node)
 				riface = iface;
 		}		
-		spin_unlock_bh(&atalk_interfaces_lock);
+		read_unlock_bh(&atalk_interfaces_lock);
 
 		retval = -ENETUNREACH;
 		if (!riface)
@@ -1042,7 +1040,7 @@
 	struct sock *s;
 	int retval;
 
-	spin_lock_bh(&atalk_sockets_lock);
+	write_lock_bh(&atalk_sockets_lock);
 
 	for (sat->sat_port = ATPORT_RESERVED;
 	     sat->sat_port < ATPORT_LAST;
@@ -1071,7 +1069,7 @@
 
 	retval = -EBUSY;
 out:
-	spin_unlock_bh(&atalk_sockets_lock);
+	write_unlock_bh(&atalk_sockets_lock);
 	return retval;
 }
 
@@ -1831,13 +1829,18 @@
 EXPORT_SYMBOL(atrtr_get_dev);
 EXPORT_SYMBOL(atalk_find_dev_addr);
 
+static char atalk_banner[] __initdata =
+	KERN_INFO "NET4: AppleTalk 0.20 for Linux NET4.0\n";
+static char atalk_err_snap[] __initdata =
+	KERN_CRIT "Unable to register DDP with SNAP.\n";
+
 /* Called by proto.c on kernel start up */
 static int __init atalk_init(void)
 {
 	(void)sock_register(&atalk_family_ops);
 	ddp_dl = register_snap_client(ddp_snap_id, atalk_rcv);
 	if (!ddp_dl)
-		printk(KERN_CRIT "Unable to register DDP with SNAP.\n");
+		printk(atalk_err_snap);
 
 	dev_add_pack(&ltalk_packet_type);
 	dev_add_pack(&ppptalk_packet_type);
@@ -1848,15 +1851,12 @@
 #ifdef CONFIG_PROC_FS
 	aarp_register_proc_fs();
 #endif /* CONFIG_PROC_FS */
-#ifdef CONFIG_SYSCTL
 	atalk_register_sysctl();
-#endif /* CONFIG_SYSCTL */
-	printk(KERN_INFO "NET4: AppleTalk 0.20 for Linux NET4.0\n");
+	printk(atalk_banner);
 	return 0;
 }
 module_init(atalk_init);
 
-#ifdef MODULE
 /*
  * Note on MOD_{INC,DEC}_USE_COUNT:
  *
@@ -1886,7 +1886,6 @@
 	sock_unregister(PF_APPLETALK);
 }
 module_exit(atalk_exit);
-#endif  /* MODULE */
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alan Cox <Alan.Cox@linux.org>");
diff -Nru a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
--- a/net/appletalk/sysctl_net_atalk.c	Tue Oct  8 00:06:24 2002
+++ b/net/appletalk/sysctl_net_atalk.c	Tue Oct  8 00:06:24 2002
@@ -7,14 +7,14 @@
  */
 
 #include <linux/config.h>
-#include <linux/sysctl.h>
 
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
 extern int sysctl_aarp_expiry_time;
 extern int sysctl_aarp_tick_time;
 extern int sysctl_aarp_retransmit_limit;
 extern int sysctl_aarp_resolve_time;
 
-#ifdef CONFIG_SYSCTL
 static struct ctl_table atalk_table[] = {
 	{
 		.ctl_name	= NET_ATALK_AARP_EXPIRY_TIME,
@@ -83,7 +83,7 @@
 	unregister_sysctl_table(atalk_table_header);
 }
 
-#else
+#else /* CONFIG_PROC_FS */
 void atalk_register_sysctl(void)
 {
 }
@@ -91,4 +91,4 @@
 void atalk_unregister_sysctl(void)
 {
 }
-#endif
+#endif /* CONFIG_PROC_FS */ 

===================================================================


This BitKeeper patch contains the following changesets:
1.633
## Wrapped with gzip_uu ##


begin 664 bkpatch25064
M'XL(`+!+HCT``^U8ZV_B1A#_C/^*T46J[J[%[*[7+U*BRT%RC9)+(I*HJGJ5
MM=CKPPK8R#;D3N*/[SZ<R\N`H>VG-*"=8.\\=^8W8^_!3<'S;HN%4V[LP6]9
M479;89;RL$P6S`RSJ3G*Q8UAEHD;G7$VY1VYM_/QM#.9A&UBVH:X?<G*<`P+
MGA?=%C:M'U?*[S/>;0V//MV<'0X-H]>#_IBE7_D5+Z'7,\HL7[!)5'Q@Y7B2
MI6:9L[28\E(I7O[8NB0($?&QL6LAVUEB!U%W&>((8T8QCQ"AGD,-:=>'Y[8_
MDX(1<I%#7-M=.L@ER!@`-AW+`D0Z&'60!PAUD=VE=AM9782@5BC\3*&-C(_P
M[SK0-T+(X'`VFP@)D]LN"+TBIB44(NQ0S))TDH6WA=`*^9WZ5S"(;QN&?)HM
M.,Q3SB,>P5X21SR&_L7Y\<FGX.J/J_[UF=KWF=UR"((D3830,D_2KT7U,V(E
M^P4*MA#7M+YIEG,8?2]Y`2PN>0YRFVF<@H,<GQB7#T=IM+?\,PS$D'&P(7PI
M+SOL/AB=XGL1EI-`7`R8O&"&CZ/JBP.U,+7P,L:VST9VZ&(\XIC0^A-L)EQD
MBX?$B5&RM!R"G"U-CJ)9C96(VG@9NC3VN,_CV+*LR,*-K'R0]\@PZGN8",.:
M"%"^!;,\"Q_DB'+`R+*7R/.IM71#;Q1[D<]=C]O.J)E==6+OS;,=S]U\U$D:
M3N81[TR2=/Y-RS/'3R)'T9)05]1.&-FQZX^XA1AFR%]AX&J!C\^4^)0J5%KM
MCX2I_R:T_U"L(T+K^QK`R`OX(AOAB[Y6^-(9>0'M_$Y]!1Q=KDF`'<!M(/H)
M-D[4VLHYBP+I;3`:O_U)2TY285#,0EZH.^_VC8'M2!:U:I9YNID)VZ[DTJ16
M4R%^\O(1AX<4AR(K%#WCD?516TZ;._CN9;VB.-:6M6[LUE(@JD-47=C;U@6!
M-GFM=:'1\%E=U`9\EY(0<9*)IPG_)A2GE;=!"2_S;E]R>)K#6\GQK"3V:[!<
M]<S-F;ISXVZ$XD\:]WV:4L_#EDI3O'6>6B)1+>NU9JH>>=8BN(KX+GGJ.D"-
M$]<'<I]SBRR)JGS+^=>D$!<#/2^^E;<$0K[<.$]7;!WX6":U6M>D/_1@^'MP
M=M$_#6[.)3D:2%Y;\<JU=9<G)=^(]DAITZ1BV03W@LG13$YS/5@U/$T:ZR':
M.$6:-2^J$$&39LUK@!W=(A5IZ(VG`^`Y6WA#B$8K13KOX3`MDW8D3%3'F>41
ME\D.27&?2MF\K&`+VNT#2"2,53\';,$_P_N.D*HG"4W6@U]]RA`=,DWJW:^9
M*XBMN6QO303J^%P5;$V::],SB29;:+-\I4V3IG,6Q50R:=)\TJ)4U9XFC74Y
MRC%-FNNR=10U:34>('VE3)/6%C,DTJY5M"FPN%0S*=JP2$1)B42VC:)D91)"
M.&9YE<LCEJ8\__.O1[T`>D;K]&AX'IR<'U_`F_.C:]K5K>E:<``R"8(XR^%,
M3B8@;YOH2_IFOT8ZSP4,IVQ6+[\_/+F&-S<I&TVXZFP5<L-@<`EW23F&J_/#
M2U/)_B+1@58C--61GHG"+F_?/E6E<<26T":I)=J)X+!5L)XP:,^K[;[>[DGZ
M<I1Y^9)BV[EFUW<HC8:<U>]0'@9S2CTU\=#_'UBW&,S5JZ>UX\[+V.\R^V"=
MV%@D:ZU'>]73`/RJ'P>T5G-\(%@E5@UTXU3K'I\4'$0CK$1<#B_ZP?&5ZFJ^
EP@ZU[O$T2N+:??#P8CD<<Q'\^;1''!_'S(V-OP$P8FC-N!8`````
`
end
