Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbULNNC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbULNNC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbULNNC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:02:28 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:17795 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261492AbULNNAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:00:47 -0500
Date: Tue, 14 Dec 2004 14:00:41 +0100
From: Harald Welte <laforge@netfilter.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Patrick McHardy <kaber@trash.net>, akpm@osdl.org, torvalds@osdl.org,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
Message-ID: <20041214130041.GU22577@sunbeam.de.gnumonks.org>
References: <20041114013724.GA21219@apps.cwi.nl> <41970FAD.6010501@trash.net> <20041114112610.GB8680@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CVsfbEDr348T3/Se"
Content-Disposition: inline
In-Reply-To: <20041114112610.GB8680@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CVsfbEDr348T3/Se
Content-Type: multipart/mixed; boundary="8tpUGmYwaewiPhBZ"
Content-Disposition: inline


--8tpUGmYwaewiPhBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 14, 2004 at 12:26:10PM +0100, Andries Brouwer wrote:
> On Sun, Nov 14, 2004 at 08:56:29AM +0100, Patrick McHardy wrote:
> > Andries Brouwer wrote:
> >=20
> > >Stuff marked initdata that is referenced in non-init context.
> >
> > Where ? The initial tables are replaced by ipt_register_table.
>=20
> ip_nat_rule.c:nat_initial_table was referenced in
>=20
> static struct ipt_table nat_table =3D {
>         .table          =3D &nat_initial_table.repl,
> 	...
>=20
> iptable_filter.c:initial_table was referenced in
>=20
> static struct ipt_table packet_filter =3D {
>         .table          =3D &initial_table.repl,
> 	...
>=20
> This is not to say that there is a bug here, that the .init
> data would actually be referenced by non-init stuff, but
> it is better to convince oneself by static inspection of
> the binary than by reasoning about the flow of the program.
>=20
> Where the memory savings are important, the code should
> be rewritten a bit.

We just had a discussion, and the netfilter core team really disagrees
with this change, which apparently was merged in
http://linux.bkbits.net:8080/linux-2.5/cset@1.2055.4.50

I think it's not a good idea to waste memory by removing __initrdata,
just to make it more convenient for some static inspection tools.  This
is just the wrong way around. =20

If we _know_ that it works, and there is no  bug, we could just add a
comment "This is handled correctly, since the ip_tables core copies the
data just as rulesets comming from userspace."

Pleaes pull out that change again and submit one that adds a comment, or
alternatively pick up the (incremental) change attached to this mail.  I
hope this makes your checker not spit any warnings.

Thanks.

> Andries

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--8tpUGmYwaewiPhBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.10-rc3-bk7-netfilter_initdata.patch"
Content-Transfer-Encoding: quoted-printable


[NETFILTER] re-introduce __initdata to {arp,ip,ip6}_tables

Instead of just removing the (correct) __initdata as introduced by=20
http://linux.bkbits.net:8080/linux-2.5/cset@1.2055.4.50                    =
    =20
we rework the code in order to not trigger some misinterpretation by
static code checkers.

Signed-off-by: Harald Welte <laforge@netfilter.org>


diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/include/linux/netfilter_arp/arp_table=
s.h linux-2.6.10-rc3-bk7-initdata/include/linux/netfilter_arp/arp_tables.h
--- linux-2.6.10-rc3-bk7/include/linux/netfilter_arp/arp_tables.h	2004-10-1=
8 23:53:45.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/include/linux/netfilter_arp/arp_tables.h	=
2004-12-14 12:32:06.488491120 +0100
@@ -312,9 +312,6 @@
 	/* A unique name... */
 	char name[ARPT_TABLE_MAXNAMELEN];
=20
-	/* Seed table: copied in register_table */
-	struct arpt_replace *table;
-
 	/* What hooks you will enter on */
 	unsigned int valid_hooks;
=20
@@ -328,7 +325,8 @@
 	struct module *me;
 };
=20
-extern int arpt_register_table(struct arpt_table *table);
+extern int arpt_register_table(struct arpt_table *table,
+			       const struct arpt_replace *repl);
 extern void arpt_unregister_table(struct arpt_table *table);
 extern unsigned int arpt_do_table(struct sk_buff **pskb,
 				  unsigned int hook,
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/include/linux/netfilter_ipv4/ip_table=
s.h linux-2.6.10-rc3-bk7-initdata/include/linux/netfilter_ipv4/ip_tables.h
--- linux-2.6.10-rc3-bk7/include/linux/netfilter_ipv4/ip_tables.h	2004-12-1=
4 11:29:18.000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/include/linux/netfilter_ipv4/ip_tables.h	=
2004-12-14 12:26:43.272627400 +0100
@@ -425,9 +425,6 @@
 	/* A unique name... */
 	char name[IPT_TABLE_MAXNAMELEN];
=20
-	/* Seed table: copied in register_table */
-	struct ipt_replace *table;
-
 	/* What hooks you will enter on */
 	unsigned int valid_hooks;
=20
@@ -441,7 +438,8 @@
 	struct module *me;
 };
=20
-extern int ipt_register_table(struct ipt_table *table);
+extern int ipt_register_table(struct ipt_table *table,
+			      const struct ipt_replace *repl);
 extern void ipt_unregister_table(struct ipt_table *table);
 extern unsigned int ipt_do_table(struct sk_buff **pskb,
 				 unsigned int hook,
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/include/linux/netfilter_ipv6/ip6_tabl=
es.h linux-2.6.10-rc3-bk7-initdata/include/linux/netfilter_ipv6/ip6_tables.h
--- linux-2.6.10-rc3-bk7/include/linux/netfilter_ipv6/ip6_tables.h	2004-12-=
14 11:29:18.000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/include/linux/netfilter_ipv6/ip6_tables.h=
	2004-12-14 12:33:57.966543880 +0100
@@ -429,9 +429,6 @@
 	/* A unique name... */
 	char name[IP6T_TABLE_MAXNAMELEN];
=20
-	/* Seed table: copied in register_table */
-	struct ip6t_replace *table;
-
 	/* What hooks you will enter on */
 	unsigned int valid_hooks;
=20
@@ -445,7 +442,8 @@
 	struct module *me;
 };
=20
-extern int ip6t_register_table(struct ip6t_table *table);
+extern int ip6t_register_table(struct ip6t_table *table,
+			       const struct ip6t_replace *repl);
 extern void ip6t_unregister_table(struct ip6t_table *table);
 extern unsigned int ip6t_do_table(struct sk_buff **pskb,
 				  unsigned int hook,
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/arp_tables.c linux=
-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/arp_tables.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/arp_tables.c	2004-12-14 11:29:3=
3.000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/arp_tables.c	2004-12-1=
4 12:23:25.900632504 +0100
@@ -1150,7 +1150,8 @@
 	up(&arpt_mutex);
 }
=20
-int arpt_register_table(struct arpt_table *table)
+int arpt_register_table(struct arpt_table *table,
+			const struct arpt_replace *repl)
 {
 	int ret;
 	struct arpt_table_info *newinfo;
@@ -1158,18 +1159,18 @@
 		=3D { 0, 0, 0, { 0 }, { 0 }, { } };
=20
 	newinfo =3D vmalloc(sizeof(struct arpt_table_info)
-			  + SMP_ALIGN(table->table->size) * NR_CPUS);
+			  + SMP_ALIGN(repl->size) * NR_CPUS);
 	if (!newinfo) {
 		ret =3D -ENOMEM;
 		return ret;
 	}
-	memcpy(newinfo->entries, table->table->entries, table->table->size);
+	memcpy(newinfo->entries, repl->entries, repl->size);
=20
 	ret =3D translate_table(table->name, table->valid_hooks,
-			      newinfo, table->table->size,
-			      table->table->num_entries,
-			      table->table->hook_entry,
-			      table->table->underflow);
+			      newinfo, repl->size,
+			      repl->num_entries,
+			      repl->hook_entry,
+			      repl->underflow);
 	duprintf("arpt_register_table: translate table gives %d\n", ret);
 	if (ret !=3D 0) {
 		vfree(newinfo);
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/arptable_filter.c =
linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/arptable_filter.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/arptable_filter.c	2004-10-18 23=
:53:06.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/arptable_filter.c	2004=
-12-14 12:24:04.177813488 +0100
@@ -141,7 +141,6 @@
=20
 static struct arpt_table packet_filter =3D {
 	.name		=3D "filter",
-	.table		=3D &initial_table.repl,
 	.valid_hooks	=3D FILTER_VALID_HOOKS,
 	.lock		=3D RW_LOCK_UNLOCKED,
 	.private	=3D NULL,
@@ -184,7 +183,7 @@
 	int ret, i;
=20
 	/* Register table */
-	ret =3D arpt_register_table(&packet_filter);
+	ret =3D arpt_register_table(&packet_filter, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/ip_nat_rule.c linu=
x-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/ip_nat_rule.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/ip_nat_rule.c	2004-12-14 11:29:=
33.000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/ip_nat_rule.c	2004-12-=
14 12:30:29.584222808 +0100
@@ -59,8 +59,8 @@
 	struct ipt_replace repl;
 	struct ipt_standard entries[3];
 	struct ipt_error term;
-} nat_initial_table =3D {
-    { "nat", NAT_VALID_HOOKS, 4,
+} nat_initial_table __initdata
+=3D { { "nat", NAT_VALID_HOOKS, 4,
       sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
       { [NF_IP_PRE_ROUTING] =3D 0,
 	[NF_IP_POST_ROUTING] =3D sizeof(struct ipt_standard),
@@ -110,7 +110,6 @@
=20
 static struct ipt_table nat_table =3D {
 	.name		=3D "nat",
-	.table		=3D &nat_initial_table.repl,
 	.valid_hooks	=3D NAT_VALID_HOOKS,
 	.lock		=3D RW_LOCK_UNLOCKED,
 	.me		=3D THIS_MODULE,
@@ -298,7 +297,7 @@
 {
 	int ret;
=20
-	ret =3D ipt_register_table(&nat_table);
+	ret =3D ipt_register_table(&nat_table, &nat_initial_table.repl);
 	if (ret !=3D 0)
 		return ret;
 	ret =3D ipt_register_target(&ipt_snat_reg);
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/ip_tables.c linux-=
2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/ip_tables.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/ip_tables.c	2004-12-14 11:29:33=
=2E000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/ip_tables.c	2004-12-14=
 12:16:39.799369280 +0100
@@ -1383,7 +1383,7 @@
 	up(&ipt_mutex);
 }
=20
-int ipt_register_table(struct ipt_table *table)
+int ipt_register_table(struct ipt_table *table, const struct ipt_replace *=
repl)
 {
 	int ret;
 	struct ipt_table_info *newinfo;
@@ -1391,17 +1391,17 @@
 		=3D { 0, 0, 0, { 0 }, { 0 }, { } };
=20
 	newinfo =3D vmalloc(sizeof(struct ipt_table_info)
-			  + SMP_ALIGN(table->table->size) * NR_CPUS);
+			  + SMP_ALIGN(repl->size) * NR_CPUS);
 	if (!newinfo)
 		return -ENOMEM;
=20
-	memcpy(newinfo->entries, table->table->entries, table->table->size);
+	memcpy(newinfo->entries, repl->entries, repl->size);
=20
 	ret =3D translate_table(table->name, table->valid_hooks,
-			      newinfo, table->table->size,
-			      table->table->num_entries,
-			      table->table->hook_entry,
-			      table->table->underflow);
+			      newinfo, repl->size,
+			      repl->num_entries,
+			      repl->hook_entry,
+			      repl->underflow);
 	if (ret !=3D 0) {
 		vfree(newinfo);
 		return ret;
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/iptable_filter.c l=
inux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/iptable_filter.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/iptable_filter.c	2004-12-14 11:=
29:33.000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/iptable_filter.c	2004-=
12-14 12:30:58.151879864 +0100
@@ -44,8 +44,8 @@
 	struct ipt_replace repl;
 	struct ipt_standard entries[3];
 	struct ipt_error term;
-} initial_table =3D {
-    { "filter", FILTER_VALID_HOOKS, 4,
+} initial_table __initdata=20
+=3D { { "filter", FILTER_VALID_HOOKS, 4,
       sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
       { [NF_IP_LOCAL_IN] =3D 0,
 	[NF_IP_FORWARD] =3D sizeof(struct ipt_standard),
@@ -95,7 +95,6 @@
=20
 static struct ipt_table packet_filter =3D {
 	.name		=3D "filter",
-	.table		=3D &initial_table.repl,
 	.valid_hooks	=3D FILTER_VALID_HOOKS,
 	.lock		=3D RW_LOCK_UNLOCKED,
 	.me		=3D THIS_MODULE
@@ -171,7 +170,7 @@
 	initial_table.entries[1].target.verdict =3D -forward - 1;
=20
 	/* Register table */
-	ret =3D ipt_register_table(&packet_filter);
+	ret =3D ipt_register_table(&packet_filter, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/iptable_mangle.c l=
inux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/iptable_mangle.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/iptable_mangle.c	2004-10-18 23:=
55:06.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/iptable_mangle.c	2004-=
12-14 12:18:04.940425872 +0100
@@ -125,7 +125,6 @@
=20
 static struct ipt_table packet_mangler =3D {
 	.name		=3D "mangle",
-	.table		=3D &initial_table.repl,
 	.valid_hooks	=3D MANGLE_VALID_HOOKS,
 	.lock		=3D RW_LOCK_UNLOCKED,
 	.me		=3D THIS_MODULE,
@@ -225,7 +224,7 @@
 	int ret;
=20
 	/* Register table */
-	ret =3D ipt_register_table(&packet_mangler);
+	ret =3D ipt_register_table(&packet_mangler, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv4/netfilter/iptable_raw.c linu=
x-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/iptable_raw.c
--- linux-2.6.10-rc3-bk7/net/ipv4/netfilter/iptable_raw.c	2004-10-18 23:55:=
07.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv4/netfilter/iptable_raw.c	2004-12-=
14 12:18:34.713899616 +0100
@@ -100,7 +100,6 @@
=20
 static struct ipt_table packet_raw =3D {=20
 	.name =3D "raw",=20
-	.table =3D &initial_table.repl,
 	.valid_hooks =3D  RAW_VALID_HOOKS,=20
 	.lock =3D RW_LOCK_UNLOCKED,=20
 	.me =3D THIS_MODULE
@@ -138,7 +137,7 @@
 	int ret;
=20
 	/* Register table */
-	ret =3D ipt_register_table(&packet_raw);
+	ret =3D ipt_register_table(&packet_raw, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6_tables.c linux=
-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6_tables.c
--- linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6_tables.c	2004-12-14 11:29:3=
4.000000000 +0100
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6_tables.c	2004-12-1=
4 12:20:42.441482072 +0100
@@ -1463,7 +1463,8 @@
 	up(&ip6t_mutex);
 }
=20
-int ip6t_register_table(struct ip6t_table *table)
+int ip6t_register_table(struct ip6t_table *table,
+			const struct ip6t_replace *repl)
 {
 	int ret;
 	struct ip6t_table_info *newinfo;
@@ -1471,17 +1472,17 @@
 		=3D { 0, 0, 0, { 0 }, { 0 }, { } };
=20
 	newinfo =3D vmalloc(sizeof(struct ip6t_table_info)
-			  + SMP_ALIGN(table->table->size) * NR_CPUS);
+			  + SMP_ALIGN(repl->size) * NR_CPUS);
 	if (!newinfo)
 		return -ENOMEM;
=20
-	memcpy(newinfo->entries, table->table->entries, table->table->size);
+	memcpy(newinfo->entries, repl->entries, repl->size);
=20
 	ret =3D translate_table(table->name, table->valid_hooks,
-			      newinfo, table->table->size,
-			      table->table->num_entries,
-			      table->table->hook_entry,
-			      table->table->underflow);
+			      newinfo, repl->size,
+			      repl->num_entries,
+			      repl->hook_entry,
+			      repl->underflow);
 	if (ret !=3D 0) {
 		vfree(newinfo);
 		return ret;
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6table_filter.c =
linux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6table_filter.c
--- linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6table_filter.c	2004-10-18 23=
:53:11.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6table_filter.c	2004=
-12-14 12:21:11.749026648 +0100
@@ -94,7 +94,6 @@
=20
 static struct ip6t_table packet_filter =3D {
 	.name		=3D "filter",
-	.table		=3D &initial_table.repl,
 	.valid_hooks	=3D FILTER_VALID_HOOKS,
 	.lock		=3D RW_LOCK_UNLOCKED,
 	.me		=3D THIS_MODULE,
@@ -172,7 +171,7 @@
 	initial_table.entries[1].target.verdict =3D -forward - 1;
=20
 	/* Register table */
-	ret =3D ip6t_register_table(&packet_filter);
+	ret =3D ip6t_register_table(&packet_filter, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6table_mangle.c =
linux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6table_mangle.c
--- linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6table_mangle.c	2004-10-18 23=
:53:51.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6table_mangle.c	2004=
-12-14 12:22:18.477882320 +0100
@@ -124,7 +124,6 @@
=20
 static struct ip6t_table packet_mangler =3D {
 	.name		=3D "mangle",
-	.table		=3D &initial_table.repl,
 	.valid_hooks	=3D MANGLE_VALID_HOOKS,
 	.lock		=3D RW_LOCK_UNLOCKED,
 	.me		=3D THIS_MODULE,
@@ -237,7 +236,7 @@
 	int ret;
=20
 	/* Register table */
-	ret =3D ip6t_register_table(&packet_mangler);
+	ret =3D ip6t_register_table(&packet_mangler, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20
diff -Nru --exclude-from /space/home/laforge/scripts/dontdiff --exclude .de=
pend --exclude '*.o' --exclude '*.ko' --exclude '*.ver' --exclude '.*.flags=
' --exclude '*.orig' --exclude '*.rej' --exclude '*.cmd' --exclude '*.mod.c=
' --exclude '*~' linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6table_raw.c lin=
ux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6table_raw.c
--- linux-2.6.10-rc3-bk7/net/ipv6/netfilter/ip6table_raw.c	2004-10-18 23:54=
:39.000000000 +0200
+++ linux-2.6.10-rc3-bk7-initdata/net/ipv6/netfilter/ip6table_raw.c	2004-12=
-14 12:21:51.191030552 +0100
@@ -108,7 +108,6 @@
=20
 static struct ip6t_table packet_raw =3D {=20
 	.name =3D "raw",=20
-	.table =3D &initial_table.repl,
 	.valid_hooks =3D RAW_VALID_HOOKS,=20
 	.lock =3D RW_LOCK_UNLOCKED,=20
 	.me =3D THIS_MODULE
@@ -145,7 +144,7 @@
 	int ret;
=20
 	/* Register table */
-	ret =3D ip6t_register_table(&packet_raw);
+	ret =3D ip6t_register_table(&packet_raw, &initial_table.repl);
 	if (ret < 0)
 		return ret;
=20

--8tpUGmYwaewiPhBZ--

--CVsfbEDr348T3/Se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBvuP5XaXGVTD0i/8RAp4NAJwJYa2fPGIa5GNoFLckdlPQXiyBCwCgs1GW
3oWpBdblI/n+DdzuB2WWxsA=
=65Xm
-----END PGP SIGNATURE-----

--CVsfbEDr348T3/Se--
