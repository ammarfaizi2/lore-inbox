Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUGHJQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUGHJQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUGHJQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:16:51 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:13726 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265422AbUGHJQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:16:19 -0400
Message-ID: <cc723f5904070802165c127e62@mail.gmail.com>
Date: Thu, 8 Jul 2004 14:46:17 +0530
From: Aneesh Kumar <aneesh.kumar@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Alpha print the symbol name in Oops
Cc: rth@redhat.com, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20040708001547.0fa78731.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_112_928627.1089278177942"
References: <cc723f5904070722341dcde1af@mail.gmail.com> <20040708001547.0fa78731.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_112_928627.1089278177942
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 8 Jul 2004 00:15:47 -0700, Andrew Morton <akpm@osdl.org> wrote:
> Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> >
> >  +            printk("[<%lx>]", tmp);
> >  +            print_symbol(" %s\n", tmp);
> 
> print_symbol() does nothing at all if CONFIG_KALLSYMS=n.  You probably want:
> 
>         printk("[<%lx>]", tmp);
>         print_symbol(" %s", tmp);
>         printk("\n");
> 

Patch attached. 

-aneesh

------=_Part_112_928627.1089278177942
Content-Type: text/x-patch; name="ci.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ci.diff"

Only in linux-2.6.6: .config
Only in linux-2.6.6: .config.old
Only in linux-2.6.6: .version
diff -ru5 linux-2.6.6-brian/Makefile linux-2.6.6/Makefile
--- linux-2.6.6-brian/Makefile=092004-06-25 19:58:16.000000000 +0530
+++ linux-2.6.6/Makefile=092004-07-02 13:48:19.000000000 +0530
@@ -436,22 +436,22 @@
 # If .config needs to be updated, it will be done via the dependency
 # that autoconf has on .config.
 # To avoid any implicit rule to kick in, define an empty command
 .config: ;
=20
-#Add OpenSSI directory if CONFIG_CLUSTER
-cluster-$(CONFIG_CLUSTER)=09:=3D cluster/
+
=20
 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
 include/linux/autoconf.h: .config
 =09$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
 # Dummy target needed, because used as prerequisite
 include/linux/autoconf.h: ;
 endif
=20
+
 include $(srctree)/arch/$(ARCH)/Makefile
=20
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS=09=09+=3D -Os
 else
@@ -485,12 +485,11 @@
 MODLIB=09:=3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 export MODLIB
=20
=20
 ifeq ($(KBUILD_EXTMOD),)
-core-y=09=09+=3D kernel/ mm/ fs/ ipc/ security/ crypto/
-core-y=09=09+=3D $(cluster-y)
+core-y=09=09+=3D kernel/ mm/ fs/ ipc/ security/ crypto/ cluster/
=20
 vmlinux-dirs=09:=3D $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 =09=09     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 =09=09     $(net-y) $(net-m) $(libs-y) $(libs-m)))
=20
@@ -634,13 +633,10 @@
 endif
=20
 ifdef CONFIG_CLUSTER
 # All OpenSSI cluster relation preparation of code goes here
 #
-
-MRPROPER_FILES +=3D include/cluster/arch include/cluster/gen/ics_proto_gen=
.h
-
 preparecluster: clustersymlinks clustergen
=20
 clustersymlinks: include/cluster/arch=20
=20
 include/cluster/arch: $(srctree)/scripts/openssi/lnrel.sh
@@ -652,10 +648,11 @@
 clustergen: include/cluster/gen/ics_proto_gen.h openssirpcgen
=20
 include/cluster/gen/ics_proto_gen.h: $(srctree)/scripts/openssi/type_templ=
ate.awk
 =09@echo ' Generating....  $@'
 =09$(Q)if [ ! -d include/cluster/gen ]; then mkdir -p include/cluster/gen;=
 fi;
+=09$(Q)if [ ! -x /usr/bin/gawk ]; then echo "/usr/bin/gawk not found" ; ex=
it 1; fi;
 =09@gawk -f $(srctree)/scripts/openssi/type_template.awk \
 =09$(srctree)/include/cluster/gen/ics_proto_gen.h.template=09\
 =09$(srctree)/include/cluster/gen/ics_proto_gen.h.list >$@
=20
 openssirpcgen:
@@ -840,10 +837,13 @@
 MRPROPER_DIRS  +=3D include/config include2
 MRPROPER_FILES +=3D .config .config.old include/asm .version \
                   include/linux/autoconf.h include/linux/version.h \
                   Module.symvers tags TAGS cscope*
=20
+#OpenSSI files that need to be cleaned
+MRPROPER_FILES +=3D include/cluster/arch include/cluster/gen/ics_proto_gen=
.h
+
 # clean - Delete most, but leave enough to build external modules
 #
 clean: rm-dirs  :=3D $(CLEAN_DIRS)
 clean: rm-files :=3D $(CLEAN_FILES)
 clean-dirs      :=3D $(addprefix _clean_,$(vmlinux-alldirs))
diff -ru5 linux-2.6.6-brian/arch/alpha/kernel/entry.S linux-2.6.6/arch/alph=
a/kernel/entry.S
--- linux-2.6.6-brian/arch/alpha/kernel/entry.S=092004-06-26 11:23:47.00000=
0000 +0530
+++ linux-2.6.6/arch/alpha/kernel/entry.S=092004-07-06 18:54:23.000000000 +=
0530
@@ -643,13 +643,13 @@
 =09ldq=09$2, alpha_mv+HAE_CACHE
 =09stq=09$2, 152($sp)=09=09/* HAE */
=20
 =09/* Shuffle FLAGS to the front; add CLONE_VM.  */
 #ifdef CONFIG_SSI
-=09ldi=09$1, CLONE_VM|CLONE_UNTRACED
+=09ldi=09$1, KTHREAD_FLAGS | CLONE_UNTRACED
 #else
-=09ldi=09$1, KTHREAD_FLAGS
+=09ldi=09$1, CLONE_VM|CLONE_UNTRACED
 #endif=20
 =09or=09$18, $1, $16
 =09bsr=09$26, sys_clone
=20
 =09/* We don't actually care for a3 success widgetry in the kernel.
@@ -708,11 +708,11 @@
 =09/* Avoid the HAE being gratuitously wrong, to avoid restoring it.  */
 =09ldq=09$2, alpha_mv+HAE_CACHE
 =09stq=09$2, 152($sp)=09=09/* HAE */
=20
 =09/* Shuffle FLAGS to the front */
-=09ldi=09$1, KTHREAD_FLAGS
+=09ldi=09$1, KTHREAD_FLAGS | CLONE_UNTRACED
 =09or=09$18, $1, $16
 =09mov =09$31, $17=09=09/* second argument =3D 0 */
 =09mov =09$31, $18=09=09/* third  argument =3D 0 */
 =09mov =09$31, $19=09=09/* fourth argument =3D 0 */
 =09mov =09$31, $20=09=09/* fifth argument =3D 0 */
@@ -722,11 +722,12 @@
 =09/* We don't actually care for a3 success widgetry in the kernel.
 =09 * Not for positive errno values.
 =09 */
 =09stq=09$0, 0($sp)=09=09/* $0 */
 =09br=09restore_all
-.end kernel_thread
+.end kernel_thread_with_pid
+#endif
 /*
  * execve(path, argv, envp)
  */
 =09.align=094
 =09.globl=09execve
diff -ru5 linux-2.6.6-brian/arch/alpha/kernel/systbls.S linux-2.6.6/arch/al=
pha/kernel/systbls.S
--- linux-2.6.6-brian/arch/alpha/kernel/systbls.S=092004-05-10 08:02:52.000=
000000 +0530
+++ linux-2.6.6/arch/alpha/kernel/systbls.S=092004-07-06 16:39:53.000000000=
 +0530
@@ -455,10 +455,25 @@
 =09.quad sys_mq_unlink
 =09.quad sys_mq_timedsend
 =09.quad sys_mq_timedreceive=09=09/* 435 */
 =09.quad sys_mq_notify
 =09.quad sys_mq_getsetattr
+#ifdef CONFIG_CLUSTER
+=09.quad sys_ssisys=09=09=09/* 438 */
+#else=20
+=09.quad alpha_ni_syscall
+#endif
+#ifdef CONFIG_SSI
+=09.quad sys_rfork
+=09.quad sys_rexecve
+=09.quad sys_migrate=09=09=09/* 441 */
+#else=20
+=09.quad alpha_ni_syscall
+=09.quad alpha_ni_syscall
+=09.quad alpha_ni_syscall
+#endif
+
=20
 =09.size sys_call_table, . - sys_call_table
 =09.type sys_call_table, @object
=20
 /* Remember to update everything, kids.  */
diff -ru5 linux-2.6.6-brian/arch/alpha/kernel/traps.c linux-2.6.6/arch/alph=
a/kernel/traps.c
--- linux-2.6.6-brian/arch/alpha/kernel/traps.c=092004-05-10 08:03:13.00000=
0000 +0530
+++ linux-2.6.6/arch/alpha/kernel/traps.c=091916-06-01 23:47:26.000000000 +=
0553
@@ -14,10 +14,11 @@
 #include <linux/tty.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kallsyms.h>
=20
 #include <asm/gentrap.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 #include <asm/sysinfo.h>
@@ -117,20 +118,22 @@
=20
 static void
 dik_show_trace(unsigned long *sp)
 {
 =09long i =3D 0;
-=09printk("Trace:");
+=09printk("Trace:\n");
 =09while (0x1ff8 & (unsigned long) sp) {
 =09=09extern char _stext[], _etext[];
 =09=09unsigned long tmp =3D *sp;
 =09=09sp++;
 =09=09if (tmp < (unsigned long) &_stext)
 =09=09=09continue;
 =09=09if (tmp >=3D (unsigned long) &_etext)
 =09=09=09continue;
-=09=09printk("%lx%c", tmp, ' ');
+=09=09//printk("%lx%c", tmp, ' ');
+=09=09printk("[<%lx>]", tmp);
+=09=09print_symbol(" %s\n", tmp);
 =09=09if (i > 40) {
 =09=09=09printk(" ...");
 =09=09=09break;
 =09=09}
 =09}
diff -ru5 linux-2.6.6-brian/arch/i386/kernel/entry.S linux-2.6.6/arch/i386/=
kernel/entry.S
--- linux-2.6.6-brian/arch/i386/kernel/entry.S=092004-06-25 19:58:14.000000=
000 +0530
+++ linux-2.6.6/arch/i386/kernel/entry.S=092004-07-06 16:42:02.000000000 +0=
530
@@ -933,14 +933,20 @@
 =09.long sys_mq_notify
 =09.long sys_mq_getsetattr
 # SSI_XXX: might need asmlinkage declaration in include/linux/syscalls.h
 #ifdef CONFIG_CLUSTER
 =09.long sys_ssisys
+#else=20
+=09.long sys_ni_syscall
+#endif
 #ifdef CONFIG_SSI
 =09/* BEGIN SSI SYSTEM CALLS */
 =09.long sys_rfork
 =09.long sys_rexecve=09=09/* 285 */
 =09.long sys_migrate
+#else=20
+=09.long sys_ni_syscall
+=09.long sys_ni_syscall
+=09.long sys_ni_syscall
 #endif /* CONFIG_SSI */
-#endif /* CONFIG_CLUSTER */
=20
 syscall_table_size=3D(.-sys_call_table)
diff -ru5 linux-2.6.6-brian/cluster/Kconfig linux-2.6.6/cluster/Kconfig
--- linux-2.6.6-brian/cluster/Kconfig=092004-06-25 19:58:14.000000000 +0530
+++ linux-2.6.6/cluster/Kconfig=092004-06-26 17:26:42.000000000 +0530
@@ -65,10 +65,18 @@
 =09  This value specifies how many "imalive" packets to send out per timeo=
ut
 =09  period.
=20
 =09  The default is set to the value 3.
=20
+config NODE_MONITOR_LOG_THRESHOLD
+=09int "Node Monitor log threshold"
+=09default 1
+=09---help---
+=09  FIXME!! write down what it is=20
+
+=09  The default is set to the value 1.
+
 config CPID
 =09bool "Clusterwide PIDs"
 =09---help---
 =09  Saying Y here enables a clusterwide PID space.
=20
diff -ru5 linux-2.6.6-brian/cluster/Makefile linux-2.6.6/cluster/Makefile
--- linux-2.6.6-brian/cluster/Makefile=092004-06-25 19:58:14.000000000 +053=
0
+++ linux-2.6.6/cluster/Makefile=092004-07-02 11:23:31.000000000 +0530
@@ -1,8 +1,6 @@
 #
 # Top level Makefile for the linux OpenSSI cluster implementation.
 #
=20
-obj-y=09=09=09:=3D
-obj-$(CONFIG_SSI) =09+=3D  ssi/
-obj-$(CONFIG_CLUSTER) =09+=3D  clms/ ics/ util/
-
+obj-$(CONFIG_CLUSTER) =09:=3D  clms/ ics/ util/
+#obj-$(CONFIG_SSI) =09+=3D  ssi/
diff -ru5 linux-2.6.6-brian/cluster/clms/Makefile linux-2.6.6/cluster/clms/=
Makefile
--- linux-2.6.6-brian/cluster/clms/Makefile=092004-06-26 11:23:47.000000000=
 +0530
+++ linux-2.6.6/cluster/clms/Makefile=092004-07-02 11:18:51.000000000 +0530
@@ -19,6 +19,5 @@
=20
 clean-files  :=3D  icscli_clms_gen.c  icssvr_clms_gen.c  icssvr_clms_table=
s_gen.c
 clean-files  +=3D  ics_clms_macros_gen.h  ics_clms_protos_gen.h
=20
 SVCFILES :=3D clms.svc
-
diff -ru5 linux-2.6.6-brian/cluster/clms/clms_client.c linux-2.6.6/cluster/=
clms/clms_client.c
--- linux-2.6.6-brian/cluster/clms/clms_client.c=092004-06-25 19:58:14.0000=
00000 +0530
+++ linux-2.6.6/cluster/clms/clms_client.c=092004-07-05 12:55:44.000000000 =
+0530
@@ -392,12 +392,12 @@
 =09=09=09=09   &key_servers,
 =09=09=09=09   &num_key_servers,
 =09=09=09=09   &key_icsinfo,
 =09=09=09=09   &num_key_servers_ics,
 =09=09=09=09   this_node,
-=09=09=09=09   cpucount+1,
-=09=09=09=09   cpucount+1,
+=09=09=09=09   num_possible_cpus(),
+=09=09=09=09   num_online_cpus(),
 =09=09=09=09   loops_per_jiffy,
 =09=09=09=09   num_physpages);
 =09if ( (error) || (rval) ) {
 =09=09panic("clms_client_join_cluster: rpc to clms master failed error %d =
rval %d\n", error, rval);
 =09}
diff -ru5 linux-2.6.6-brian/cluster/clms/clms_master.c linux-2.6.6/cluster/=
clms/clms_master.c
--- linux-2.6.6-brian/cluster/clms/clms_master.c=092004-06-25 19:58:14.0000=
00000 +0530
+++ linux-2.6.6/cluster/clms/clms_master.c=092004-07-05 12:56:21.000000000 =
+0530
@@ -73,12 +73,12 @@
=20
 void
 clms_initialize_node_info(clusternode_t node)
 {
=20
-=09clms.clms_node_info[node].online_cpus =3D
-=09=09clms.clms_node_info[node].total_cpus =3D cpucount + 1;
+=09clms.clms_node_info[node].online_cpus =3D  num_online_cpus();
+=09clms.clms_node_info[node].total_cpus =3D num_possible_cpus();
 =09clms.clms_node_info[node].cpu_power =3D loops_per_jiffy;
 =09clms.clms_node_info[node].total_memory =3D num_physpages;
 }
=20
 /*
diff -ru5 linux-2.6.6-brian/cluster/ics/Makefile linux-2.6.6/cluster/ics/Ma=
kefile
--- linux-2.6.6-brian/cluster/ics/Makefile=092004-06-26 11:23:47.000000000 =
+0530
+++ linux-2.6.6/cluster/ics/Makefile=092004-07-02 11:19:01.000000000 +0530
@@ -13,9 +13,9 @@
 $(obj)/ics_svr.o: $(obj)/ics_icssig_protos_gen.h
 $(obj)/ics_svr_mgmt.o: $(obj)/ics_icssig_protos_gen.h
 $(obj)/icssig_ics.o: $(obj)/ics_icssig_protos_gen.h $(obj)/icscli_icssig_g=
en.c $(obj)/icssvr_icssig_gen.c
=20
 clean-files  :=3D  icscli_icssig_gen.c  icssvr_icssig_gen.c  icssvr_icssig=
_tables_gen.c
-clean-files  :=3D  ics_icssig_macros_gen.h  ics_icssig_protos_gen.h
+clean-files  +=3D  ics_icssig_macros_gen.h  ics_icssig_protos_gen.h
=20
=20
 SVCFILES :=3D icssig.svc
Only in linux-2.6.6/cluster/rpcgen: openssirpcgen
diff -ru5 linux-2.6.6-brian/cluster/util/Makefile linux-2.6.6/cluster/util/=
Makefile
--- linux-2.6.6-brian/cluster/util/Makefile=092004-06-26 11:23:47.000000000=
 +0530
+++ linux-2.6.6/cluster/util/Makefile=092004-06-26 17:41:12.000000000 +0530
@@ -4,12 +4,11 @@
 #
 #
=20
=20
 obj-$(CONFIG_CLUSTER) :=3D assert.o cluster_ksyms.o cluster_api_ics.o nsc_=
async.o nsc_daemon.o
-#obj-$(CONFIG_CLUSTER) +=3D nsc_ics.o nsc_init.o nsc_log.o nsc_nodelist.o =
nsc_scalls.o nsc_xdr.o=20
-obj-$(CONFIG_CLUSTER) +=3D  nsc_init.o nsc_log.o nsc_nodelist.o=20
+obj-$(CONFIG_CLUSTER) +=3D nsc_ics.o nsc_init.o nsc_log.o nsc_nodelist.o n=
sc_scalls.o nsc_xdr.o=20
 obj-$(CONFIG_CLUSTER) +=3D nsc_callback.o nsc_ndreg.o xdr_msghdr.o xdr.o a=
ssert.o node_monitor.o
=20
 $(obj)/cluster_api_ics.o: $(obj)/ics_cluster_api_protos_gen.h $(obj)/icscl=
i_cluster_api_gen.c $(obj)/icssvr_cluster_api_gen.c
 $(obj)/nsc_scalls..o: $(obj)/ics_cluster_api_protos_gen.h $(obj)/ics_clust=
er_api_macros_gen.h
=20
diff -ru5 linux-2.6.6-brian/cluster/util/node_monitor.c linux-2.6.6/cluster=
/util/node_monitor.c
--- linux-2.6.6-brian/cluster/util/node_monitor.c=092004-06-25 19:58:15.000=
000000 +0530
+++ linux-2.6.6/cluster/util/node_monitor.c=091916-06-02 02:05:00.000000000=
 +0553
@@ -128,12 +128,11 @@
 /*
  * Initialize Node Monitoring on Master node.
  * reinit_flag is set if this is a CLMS secondary becoming the Master.
  */
=20
-static void __init
-nm_do_init(void)
+static void nm_do_init(void)
 {
 =09int error;
 =09struct nm_settings nm_settings;
=20
 =09INIT_EVENT(&nm_nodedown_event);
diff -ru5 linux-2.6.6-brian/cluster/util/nsc_ics.c linux-2.6.6/cluster/util=
/nsc_ics.c
--- linux-2.6.6-brian/cluster/util/nsc_ics.c=092004-06-25 19:58:15.00000000=
0 +0530
+++ linux-2.6.6/cluster/util/nsc_ics.c=092004-06-26 17:42:51.000000000 +053=
0
@@ -741,11 +741,11 @@
 =09/*
 =09 * Using the given xdr routine encode the arguments into
 =09 * a msghdr.
 =09 */
 =09if (!icsxdr_encode_msghdr(&x, xargs, argsp, &margsp)) {
-=09=09ics_stat =3D RPC_CANTENCODEARGS;
+=09=09ics_stat =3D CLUSTER_RPC_CANTENCODEARGS;
 =09=09freemsghdr(margsp);
 =09=09ICSXDRLOG(ICSXDR_DBG_RCALL,
 =09=09=09  "nsc_rcall: returning %d\n", ics_stat);
 =09=09goto out;
 =09}
@@ -782,11 +782,11 @@
 =09=09=09/*
 =09=09=09 * Decode results and free the returned msghdr.
 =09=09=09 */
 =09=09=09ASSERT(mresp !=3D NULL);
 =09=09=09if (!icsxdr_decode_msghdr(&x, xresults, resultsp, mresp))
-=09=09=09=09ics_stat =3D RPC_CANTDECODERES;
+=09=09=09=09ics_stat =3D CLUSTER_RPC_CANTDECODERES;
 =09=09=09freemsghdr(mresp);
 =09=09}
 =09} else {
 =09=09ics_stat =3D cli_icsnsc_rcall_msg(node,
 =09=09=09=09=09=09svc,
@@ -857,11 +857,11 @@
 =09 * Decode any arguments and free the associated mblks.
 =09 */
 =09if (margsp) {
 =09=09if (!icsxdr_decode_msghdr(xdrs, funcinfoptr->trpc_xargs,
 =09=09=09=09=09argp, margsp)) {
-=09=09=09error =3D RPC_CANTDECODEARGS;
+=09=09=09error =3D CLUSTER_RPC_CANTDECODEARGS;
 =09=09=09freemsghdr(margsp);
 =09=09=09goto out;
 =09=09}
 =09=09freemsghdr(margsp);
 =09}
@@ -893,11 +893,11 @@
 =09=09 * if this fails.
 =09=09 */
 =09=09if (funcinfoptr->trpc_xresults !=3D (xdrproc_t)xdr_void &&
 =09=09    !icsxdr_encode_msghdr(xdrs,funcinfoptr->trpc_xresults,
 =09=09=09=09=09resp,mrespp)) {
-=09=09=09error =3D RPC_SYSTEMERROR;
+=09=09=09error =3D CLUSTER_RPC_SYSTEMERROR;
 =09=09=09freemsghdr(*mrespp);
 =09=09=09*mrespp =3D NULL;
 =09=09}
         }
=20
diff -ru5 linux-2.6.6-brian/cluster/util/nsc_scalls.c linux-2.6.6/cluster/u=
til/nsc_scalls.c
--- linux-2.6.6-brian/cluster/util/nsc_scalls.c=092004-06-25 19:58:15.00000=
0000 +0530
+++ linux-2.6.6/cluster/util/nsc_scalls.c=092004-07-05 12:58:15.000000000 +=
0530
@@ -1148,11 +1148,11 @@
 =09clusternode_info_t outargs;
 =09clusternode_t node;
 =09int error =3D 0;
 =09int online =3D 0;
 =09int cpus =3D 0;
-=09int status, i;
+=09int status;
 =09clms_api_state_t info;
 =09int info_size;
=20
 =09if (uaddrin_len <=3D 0 ||
 =09    uaddrin_len > sizeof(inargs) ||
@@ -1193,20 +1193,13 @@
 =09/*
 =09 * Get information about the CPU's
 =09 * This should be function ship to the specified node
 =09 */
 =09if (this_node =3D=3D node) {
-#ifdef CONFIG_SMP
-=09=09for (i =3D 0; i < NR_CPUS; i++)
-=09=09=09if (cpu_online_map & (1UL << i))
-=09=09=09=09cpus++;
-=09=09online =3D cpucount + 1;
-#else /* CONFIG_SMP */
-=09=09cpus =3D online =3D 1;
-#endif /* CONFIG_SMP */
-=09}
-=09else {
+=09=09cpus =3D  num_possible_cpus();
+=09=09online =3D num_online_cpus();
+=09} else {
 =09=09error =3D RCLUSTER_API_GETCPUINFO(node, &status,
 =09=09=09=09=09=09this_node, &cpus, &online);
=20
 =09=09if (error =3D=3D -EREMOTE) {
 =09=09=09cpus =3D online =3D 0;
@@ -1370,23 +1363,12 @@
 =09=09=09int=09*rval,
 =09=09=09clusternode_t =09my_node,
 =09=09=09int=09*num_cpus,
 =09=09=09int =09*onlinecpus)
 {
-#ifdef CONFIG_SMP
-=09int cpus =3D 0;
-=09int i;
-
-=09for (i =3D 0; i < NR_CPUS; i++)
-=09=09if (cpu_online_map & (1UL << i))
-=09=09=09cpus++;
-=09*num_cpus =3D cpus;
-=09*onlinecpus =3D cpucount + 1;
-#else /* CONFIG_SMP */
-=09*num_cpus =3D *onlinecpus =3D 1;
-#endif /* CONFIG_SMP */
-
+=09*num_cpus   =3D  num_possible_cpus();
+=09*onlinecpus =3D  num_online_cpus();
 =09return 0;
 }
=20
 /*
  * cluster_maxnodes()
diff -ru5 linux-2.6.6-brian/cluster/util/xdr.c linux-2.6.6/cluster/util/xdr=
.c
--- linux-2.6.6-brian/cluster/util/xdr.c=092004-06-25 19:58:15.000000000 +0=
530
+++ linux-2.6.6/cluster/util/xdr.c=092004-06-26 17:20:32.000000000 +0530
@@ -88,11 +88,11 @@
 #define LASTUNSIGNED=09((u_int) 0-1)
=20
 /*
  * for unit alignment
  */
-static const char xdr_zero[BYTES_PER_XDR_UNIT] =3D {0, 0, 0, 0};
+static const char xdrzero[BYTES_PER_XDR_UNIT] =3D {0, 0, 0, 0};
=20
 /*
  * Free a data structure using XDR
  * Not a filter, but a convenient utility nonetheless
  */
@@ -182,11 +182,11 @@
 =09{
 =09  return FALSE;
 =09}
       if (rndup =3D=3D 0)
 =09return TRUE;
-      return XDR_PUTBYTES (xdrs, xdr_zero, rndup);
+      return XDR_PUTBYTES (xdrs, xdrzero, rndup);
=20
     case XDR_FREE:
       return TRUE;
     }
   return FALSE;
Only in linux-2.6.6/include: asm
diff -ru5 linux-2.6.6-brian/include/asm-i386/unistd.h linux-2.6.6/include/a=
sm-i386/unistd.h
--- linux-2.6.6-brian/include/asm-i386/unistd.h=092004-06-25 19:58:15.00000=
0000 +0530
+++ linux-2.6.6/include/asm-i386/unistd.h=092004-07-06 16:42:28.000000000 +=
0530
@@ -297,19 +297,11 @@
 #define __NR_ssisys=09=09283
 #define __NR_rfork=09=09284
 #define __NR_rexecve=09=09285
 #define __NR_migrate=09=09286
=20
-#ifdef CONFIG_CLUSTER
-#ifdef CONFIG_SSI
 #define NR_syscalls 287
-#else
-#define NR_syscalls 284
-#endif
-#else
-#define NR_syscalls 283
-#endif
=20
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/er=
rno.h> */
=20
 #define __syscall_return(type, res) \
 do { \
Only in linux-2.6.6/include/cluster: arch
diff -ru5 linux-2.6.6-brian/include/cluster/clms.h linux-2.6.6/include/clus=
ter/clms.h
--- linux-2.6.6-brian/include/cluster/clms.h=092004-06-25 19:58:15.00000000=
0 +0530
+++ linux-2.6.6/include/cluster/clms.h=092004-07-05 12:38:20.000000000 +053=
0
@@ -41,16 +41,10 @@
 #define CLMS_NODEDOWN_HALT =091
 #define CLMS_NODEDOWN_DEBUG =092
=20
 #if defined(__KERNEL__)
=20
-/* This may not work with the Voyager SMP architecture for x86, since it h=
as=20
- * its own static definition of cpucount, but it's old so it probably=20
- * doesn't matter
- */
-extern int cpucount;
-
 /*
  * Interface to CLMS Subsystems
  */
 #define CLMS_MAX_SUBSYSTEMS=0915
 typedef int=09clms_subsys_t;
Only in linux-2.6.6/include/cluster/gen: ics_proto_gen.h
diff -ru5 linux-2.6.6-brian/include/cluster/rpc/clnt.h linux-2.6.6/include/=
cluster/rpc/clnt.h
--- linux-2.6.6-brian/include/cluster/rpc/clnt.h=092004-06-25 19:58:15.0000=
00000 +0530
+++ linux-2.6.6/include/cluster/rpc/clnt.h=092004-06-26 17:13:17.000000000 =
+0530
@@ -48,56 +48,56 @@
  * Rpc calls return an enum clnt_stat.  This should be looked at more,
  * since each implementation is required to live with this (implementation
  * independent) list of errors.
  */
 enum clnt_stat {
-=09RPC_SUCCESS=3D0,=09=09=09/* call succeeded */
+=09CLUSTER_RPC_SUCCESS=3D0,=09=09=09/* call succeeded */
 =09/*
 =09 * local errors
 =09 */
-=09RPC_CANTENCODEARGS=3D1,=09=09/* can't encode arguments */
-=09RPC_CANTDECODERES=3D2,=09=09/* can't decode results */
-=09RPC_CANTSEND=3D3,=09=09=09/* failure in sending call */
-=09RPC_CANTRECV=3D4,=09=09=09/* failure in receiving result */
-=09RPC_TIMEDOUT=3D5,=09=09=09/* call timed out */
+=09CLUSTER_RPC_CANTENCODEARGS=3D1,=09=09/* can't encode arguments */
+=09CLUSTER_RPC_CANTDECODERES=3D2,=09=09/* can't decode results */
+=09CLUSTER_RPC_CANTSEND=3D3,=09=09=09/* failure in sending call */
+=09CLUSTER_RPC_CANTRECV=3D4,=09=09=09/* failure in receiving result */
+=09CLUSTER_RPC_TIMEDOUT=3D5,=09=09=09/* call timed out */
 =09/*
 =09 * remote errors
 =09 */
-=09RPC_VERSMISMATCH=3D6,=09=09/* rpc versions not compatible */
-=09RPC_AUTHERROR=3D7,=09=09/* authentication error */
-=09RPC_PROGUNAVAIL=3D8,=09=09/* program not available */
-=09RPC_PROGVERSMISMATCH=3D9,=09=09/* program version mismatched */
-=09RPC_PROCUNAVAIL=3D10,=09=09/* procedure unavailable */
-=09RPC_CANTDECODEARGS=3D11,=09=09/* decode arguments error */
-=09RPC_SYSTEMERROR=3D12,=09=09/* generic "other problem" */
-=09RPC_NOBROADCAST =3D 21,=09=09/* Broadcasting not supported */
+=09CLUSTER_RPC_VERSMISMATCH=3D6,=09=09/* rpc versions not compatible */
+=09CLUSTER_RPC_AUTHERROR=3D7,=09=09/* authentication error */
+=09CLUSTER_RPC_PROGUNAVAIL=3D8,=09=09/* program not available */
+=09CLUSTER_RPC_PROGVERSMISMATCH=3D9,=09=09/* program version mismatched */
+=09CLUSTER_RPC_PROCUNAVAIL=3D10,=09=09/* procedure unavailable */
+=09CLUSTER_RPC_CANTDECODEARGS=3D11,=09=09/* decode arguments error */
+=09CLUSTER_RPC_SYSTEMERROR=3D12,=09=09/* generic "other problem" */
+=09CLUSTER_RPC_NOBROADCAST =3D 21,=09=09/* Broadcasting not supported */
 =09/*
 =09 * callrpc & clnt_create errors
 =09 */
-=09RPC_UNKNOWNHOST=3D13,=09=09/* unknown host name */
-=09RPC_UNKNOWNPROTO=3D17,=09=09/* unknown protocol */
-=09RPC_UNKNOWNADDR =3D 19,=09=09/* Remote address unknown */
+=09CLUSTER_RPC_UNKNOWNHOST=3D13,=09=09/* unknown host name */
+=09CLUSTER_RPC_UNKNOWNPROTO=3D17,=09=09/* unknown protocol */
+=09CLUSTER_RPC_UNKNOWNADDR =3D 19,=09=09/* Remote address unknown */
=20
 =09/*
 =09 * rpcbind errors
 =09 */
-=09RPC_RPCBFAILURE=3D14,=09=09/* portmapper failed in its call */
-#define RPC_PMAPFAILURE RPC_RPCBFAILURE
-=09RPC_PROGNOTREGISTERED=3D15,=09/* remote program is not registered */
-=09RPC_N2AXLATEFAILURE =3D 22,=09/* Name to addr translation failed */
+=09CLUSTER_RPC_RPCBFAILURE=3D14,=09=09/* portmapper failed in its call */
+#define CLUSTER_RPC_PMAPFAILURE CLUSTER_RPC_RPCBFAILURE
+=09CLUSTER_RPC_PROGNOTREGISTERED=3D15,=09/* remote program is not register=
ed */
+=09CLUSTER_RPC_N2AXLATEFAILURE =3D 22,=09/* Name to addr translation faile=
d */
 =09/*
 =09 * unspecified error
 =09 */
-=09RPC_FAILED=3D16,
-=09RPC_INTR=3D18,
-=09RPC_TLIERROR=3D20,
-=09RPC_UDERROR=3D23,
+=09CLUSTER_RPC_FAILED=3D16,
+=09CLUSTER_RPC_INTR=3D18,
+=09CLUSTER_RPC_TLIERROR=3D20,
+=09CLUSTER_RPC_UDERROR=3D23,
         /*
          * asynchronous errors
          */
-        RPC_INPROGRESS =3D 24,
-        RPC_STALERACHANDLE =3D 25
+        CLUSTER_RPC_INPROGRESS =3D 24,
+        CLUSTER_RPC_STALERACHANDLE =3D 25
 };
=20
=20
 /*
  * Error info.
@@ -390,11 +390,11 @@
 /*
  * If a creation fails, the following allows the user to figure out why.
  */
 struct rpc_createerr {
 =09enum clnt_stat cf_stat;
-=09struct rpc_err cf_error; /* useful when cf_stat =3D=3D RPC_PMAPFAILURE =
*/
+=09struct rpc_err cf_error; /* useful when cf_stat =3D=3D CLUSTER_RPC_PMAP=
FAILURE */
 };
=20
 extern struct rpc_createerr rpc_createerr;
=20
=20
diff -ru5 linux-2.6.6-brian/include/cluster/rpc/rpc_msg.h linux-2.6.6/inclu=
de/cluster/rpc/rpc_msg.h
--- linux-2.6.6-brian/include/cluster/rpc/rpc_msg.h=092004-06-25 19:58:15.0=
00000000 +0530
+++ linux-2.6.6/include/cluster/rpc/rpc_msg.h=092004-06-26 17:14:06.0000000=
00 +0530
@@ -71,11 +71,11 @@
 =09GARBAGE_ARGS=3D4,
 =09SYSTEM_ERR=3D5
 };
=20
 enum reject_stat {
-=09RPC_MISMATCH=3D0,
+=09CLUSTER_RPC_MISMATCH=3D0,
 =09AUTH_ERROR=3D1
 };
=20
 /*
  * Reply part of an rpc exchange
Only in linux-2.6.6/include: config
Only in linux-2.6.6/include/linux: autoconf.h
Only in linux-2.6.6/include/linux: version.h
diff -ru5 linux-2.6.6-brian/net/ipv4/tcp.c linux-2.6.6/net/ipv4/tcp.c
--- linux-2.6.6-brian/net/ipv4/tcp.c=092004-06-25 19:58:16.000000000 +0530
+++ linux-2.6.6/net/ipv4/tcp.c=092004-06-26 17:36:39.000000000 +0530
@@ -1813,11 +1813,11 @@
  * =09There is no particular user process reading from this socket
  * =09(we select an ICS daemon to process the packet) and we can
  * =09assume urgent data is never sent on this stream.
  */
 void ics_recvmsg(struct sock *sk, struct sk_buff *skb) {
-=09struct tcp_opt *tp =3D &(sk->tp_pinfo.af_tcp);
+=09struct tcp_opt *tp =3D tcp_sk(sk);
 =09u32 adjust;
=20
 =09/*
 =09 * Handle retransmits which can back the sequence number up.
 =09 * and we must not reprocess the data.
Only in linux-2.6.6/scripts/basic: docproc
Only in linux-2.6.6/scripts/basic: fixdep
Only in linux-2.6.6/scripts/basic: split-include
Only in linux-2.6.6/scripts: bin2c
Only in linux-2.6.6/scripts: conmakehash
Only in linux-2.6.6/scripts: elfconfig.h
Only in linux-2.6.6/scripts/genksyms: genksyms
Only in linux-2.6.6/scripts/genksyms: keywords.c
Only in linux-2.6.6/scripts/genksyms: lex.c
Only in linux-2.6.6/scripts/genksyms: parse.c
Only in linux-2.6.6/scripts/genksyms: parse.h
Only in linux-2.6.6/scripts: kallsyms
Only in linux-2.6.6/scripts/kconfig: lex.zconf.c
Only in linux-2.6.6/scripts/kconfig: libkconfig.so
Only in linux-2.6.6/scripts/kconfig: mconf
Only in linux-2.6.6/scripts/kconfig: zconf.tab.c
Only in linux-2.6.6/scripts/kconfig: zconf.tab.h
Only in linux-2.6.6/scripts/lxdialog: lxdialog
Only in linux-2.6.6/scripts: mk_elfconfig
Only in linux-2.6.6/scripts: modpost
diff -ru5 linux-2.6.6-brian/scripts/openssi/Makefile linux-2.6.6/scripts/op=
enssi/Makefile
--- linux-2.6.6-brian/scripts/openssi/Makefile=092004-06-26 11:23:48.000000=
000 +0530
+++ linux-2.6.6/scripts/openssi/Makefile=092004-07-02 12:35:35.000000000 +0=
530
@@ -2,24 +2,24 @@
 # Makefile  with OpenSSI specific rules
 #
 #Authors: Aneesh Kumar K.V <aneesh.kumar@digital.com>
 #
=20
-NSCICSGEN :=3D $(objtree)/cluster/util/icsgen
+NSCICSGEN :=3D $(srctree)/cluster/util/icsgen
=20
 # Rule for generating files from .svc
 # One should have SVCFILES and NSCDEFS defined in the Makefile=20
 %_gen.c: $(patsubst %,$(src)/%,$(SVCFILES))
 =09@chmod +x $(NSCICSGEN)
 =09$(Q)for svc_file in $< ;=09=09=09=09=09=09\
 =09do=09=09=09=09=09=09=09=09\
-=09CPP=3D"$(CC) -E $(CPPFLAGS) -include $(objtree)/include/linux/config.h"=
 OUT_DIR=3D$(obj) \
+=09CPP=3D"$(CC) -E $(CPPFLAGS) -include $(srctree)/include/linux/config.h"=
 OUT_DIR=3D$(obj) \
 =09     $(NSCICSGEN) $(NSCDEFS) $$svc_file; =09=09=09\
 =09done
=20
 %_gen.h: $(patsubst %,$(src)/%,$(SVCFILES))
 =09@chmod +x $(NSCICSGEN)
 =09$(Q)for svc_file in $< ;=09=09=09=09=09=09\
 =09do=09=09=09=09=09=09=09=09\
-=09CPP=3D"$(CC) -E $(CPPFLAGS) -include $(objtree)/include/linux/config.h"=
 OUT_DIR=3D$(obj) \
+=09CPP=3D"$(CC) -E $(CPPFLAGS) -include $(srctree)/include/linux/config.h"=
 OUT_DIR=3D$(obj) \
 =09     $(NSCICSGEN) $(NSCDEFS) $$svc_file; =09=09=09\
 =09done
Only in linux-2.6.6/scripts: pnmtologo
Only in linux-2.6.6: vmlinux.gz

------=_Part_112_928627.1089278177942--
