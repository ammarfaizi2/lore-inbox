Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSJ3Db4>; Tue, 29 Oct 2002 22:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSJ3Db4>; Tue, 29 Oct 2002 22:31:56 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:25870 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S263362AbSJ3Dbx>; Tue, 29 Oct 2002 22:31:53 -0500
Date: Wed, 30 Oct 2002 00:38:00 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, Maciej Babinski <maciej@imsa.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] llc: fix seq_file support
Message-ID: <20021030033800.GA25217@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Maciej Babinski <maciej@imsa.edu>,
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

kernel.bkbits.net:/home/acme/net-2.5

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.822, 2002-10-30 00:33:12-03:00, acme@conectiva.com.br
  o llc: fix seq_file support
  
  Thanks to Maciej Babinski for reporting this on lkml.
  
  This one also uninlines llc_get_sk_idx and turns the error message
  in snap_init an __initdata.


 802/psnap.c    |    5 ++++-
 llc/llc_proc.c |   37 ++++++++++++++++++-------------------
 2 files changed, 22 insertions(+), 20 deletions(-)


diff -Nru a/net/802/psnap.c b/net/802/psnap.c
--- a/net/802/psnap.c	Wed Oct 30 00:34:48 2002
+++ b/net/802/psnap.c	Wed Oct 30 00:34:48 2002
@@ -91,12 +91,15 @@
 EXPORT_SYMBOL(register_snap_client);
 EXPORT_SYMBOL(unregister_snap_client);
 
+static char snap_err_msg[] __initdata =
+	KERN_CRIT "SNAP - unable to register with 802.2\n";
+
 static int __init snap_init(void)
 {
 	snap_sap = llc_sap_open(0xAA, snap_rcv);
 
 	if (!snap_sap)
-		printk(KERN_CRIT "SNAP - unable to register with 802.2\n");
+		printk(snap_err_msg);
 
 	return 0;
 }
diff -Nru a/net/llc/llc_proc.c b/net/llc/llc_proc.c
--- a/net/llc/llc_proc.c	Wed Oct 30 00:34:48 2002
+++ b/net/llc/llc_proc.c	Wed Oct 30 00:34:48 2002
@@ -13,10 +13,11 @@
  */
 
 #include <linux/config.h>
+#include <linux/init.h>
+#ifdef CONFIG_PROC_FS
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/errno.h>
-#include <linux/init.h>
 #include <linux/seq_file.h>
 #include <net/sock.h>
 #include <net/llc_c_ac.h>
@@ -27,14 +28,13 @@
 #include <net/llc_main.h>
 #include <net/llc_sap.h>
 
-#ifdef CONFIG_PROC_FS
 static void llc_ui_format_mac(struct seq_file *seq, unsigned char *mac)
 {
 	seq_printf(seq, "%02X:%02X:%02X:%02X:%02X:%02X",
 		   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 }
 
-static __inline__ struct sock *llc_get_sk_idx(loff_t pos)
+static struct sock *llc_get_sk_idx(loff_t pos)
 {
 	struct list_head *sap_entry;
 	struct llc_sap *sap;
@@ -44,15 +44,15 @@
 		sap = list_entry(sap_entry, struct llc_sap, node);
 
 		read_lock_bh(&sap->sk_list.lock);
-		for (sk = sap->sk_list.list; pos && sk; sk = sk->next)
-			--pos;
-		if (!pos) {
-			if (!sk)
-				read_unlock_bh(&sap->sk_list.lock);
-			break;
-		}
+		for (sk = sap->sk_list.list; sk; sk = sk->next)
+			if (!pos--) {
+				if (!sk)
+					read_unlock_bh(&sap->sk_list.lock);
+				goto out;
+			}
 		read_unlock_bh(&sap->sk_list.lock);
 	}
+out:
 	return sk;
 }
 
@@ -72,15 +72,7 @@
 
 	++*pos;
 	if (v == (void *)1) {
-		if (list_empty(&llc_main_station.sap_list.list)) {
-			sk = NULL;
-			goto out;
-		}
-		sap = list_entry(llc_main_station.sap_list.list.next,
-				 struct llc_sap, node);
-
-		read_lock_bh(&sap->sk_list.lock);
-		sk = sap->sk_list.list;
+		sk = llc_get_sk_idx(0);
 		goto out;
 	}
 	sk = v;
@@ -109,6 +101,13 @@
 
 static void llc_seq_stop(struct seq_file *seq, void *v)
 {
+	if (v) {
+		struct sock *sk = v;
+		struct llc_opt *llc = llc_sk(sk);
+		struct llc_sap *sap = llc->sap;
+
+		read_unlock_bh(&sap->sk_list.lock);
+	}
 	read_unlock_bh(&llc_main_station.sap_list.lock);
 }
 

===================================================================


This BitKeeper patch contains the following changesets:
1.822
## Wrapped with gzip_uu ##


begin 664 bkpatch4703
M'XL(`%A3OST``^U6;6_;-A#^+/Z*6P,,R0;)I*A79P[2V&UG9$L"I_VT#@)#
M4;8F6=)$VLTP][_OI+1N7MQV"?JQMG2PCL?GGKOCG;P';[1JAY:02T7VX-=:
MFZ$EZTI)DZ^%(^NE<]7BPJRN<6&PJ)=J<'(ZJ)2Q7<<GN'(AC%S`6K5Z:#&'
M;S7FGT8-K=F+5V]^>SXC9#2"\4)4<W6I#(Q&Q-3M6I2I/A9F4=:58UI1Z:4R
MO<_-UG3C4NKBUV<AIWZP80'UPHUD*6/"8RJEKA<%'NGH']^G?0^%43=FG#,O
MVKA!%(5D`LR)7!>H.V!TP"E0.N1\R%R;\B&EL!,4?G;!IN0$OFT`8R*AAK*4
M0\CR:]#J[R3+2P5ZU31U:W`5K]<(6FCT#+\+F:N_X$1<Y94N<LCJ%EK56>;5
M',PBUU!74!;+TOFXM5<I$*6N857E59E72G<>D[DRB2Z2/+T&4:5@5FV%3A8*
M5-LB[E)I+>8*0?(*="6:)*]R@Z:0]+]2@3&34W"#F/KDXE.9B?W(#R%44'+T
ME=3BV1M$6+.FX^+(VPF._7!#HTYZ@9]%2H8J"[(K&K/=Q=R)Q2BGE'-.XPT+
M&0V0T.<W8_ZZ.VG:6F[W4]]EON_3#?<\2C=!'(:1'[II$*8N5_RQ<%LZ;HA\
M^E9Z:-OUU+>E25*Q5LOC:F6T@^>E$`XB?1Z->2ST./,[M.!#<]UO+1I_N;58
M!#:+OS?7CN;J2W\.=ONNO[!9+G:<@B>TW)3YX)*]O)+E*E7P"U)?70\ZW\[B
M"/59JC(8GY^]G+Y*+F;GX^3E)9FP&!B98%T[&:*<]E(;87()VK0K:4#7LH"?
M[B9AOZRS+#'0U/J`3+P00C+U.03$LKHT[^L"1J!%8Q^A?9EKXW3B$'31W=U:
M81]5ZMH<X`XKSV#_!X2R[0/XMU/<:'31KUI6JT2:K*H2B217B_T?[P*C]N"P
M-YS76/9Z9?JG]\C(QV#P>4@FH0\QF48<%9;5,[@7$$6,*6,,(^F]KV^HW,E!
MOV]]^$G=8=2-Z;/S`5(7&/S!/1LDC+M1]#;(732'Y"WYGY&]W\Z*6S/NZR_?
M)PW8+PR?!UBQBWWJ<1IM&,.AT\^*\+&SPL-1\7U2/)P4-^^L'9/B5AF>,B9B
M#OQC@\N%:&\X(+=DJ>=__'F+!8R(=?IB=I:,9]/7\.SR[/D%V!BLN,),8M9:
M-<=3JEIXEYL%("W'?5L]Z\[U).[FRK27EM6T>66P*V[YP5.]_8,I%TH6>K4<
0R4QR5^([YS]^YD_US0H`````
`
end
