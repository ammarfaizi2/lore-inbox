Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSKLWnn>; Tue, 12 Nov 2002 17:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266988AbSKLWnn>; Tue, 12 Nov 2002 17:43:43 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:47836 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S266987AbSKLWnj>;
	Tue, 12 Nov 2002 17:43:39 -0500
Date: Tue, 12 Nov 2002 23:50:22 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org,
       lord@sgi.com
Subject: Re: 2.5-bk AT_GID clash
Message-ID: <20021112225022.GA10689@gagarin>
References: <20021112011858.GB19877@gagarin> <20021112172423.91C0C2C2DA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112172423.91C0C2C2DA@lists.samba.org>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 04:16:56AM +1100, Rusty Russell wrote:
> > Maybe module.h shouldn't be including elf.h, that afaik is needed by the
> > arch-specific module loaders and not by all modules. A split into
> > module.h for the modules and moduleloader.h for the arch-spec-loaders?
> 
> This might be OK too, but in practice I don't think much will be in
> moduleloader.h: asm/module.h only really defines struct
> mod_arch_specific, which is embedded in struct module, and struct
> module needs to be exposed for those inlines...

But there are things in linux/module.h that are arch-generic but not needed
for the modules if i understand it correctly, things that need elf.h:

find_symbol_internal, module_core_alloc, module_init_alloc, apply_relocate,
apply_relocate_add and module_finalize

Something like this patch...

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.858, 2002-11-12 23:44:23+01:00, andersg@0x63.nu
  Do not include elf.h into all modules via module.h


 include/linux/module.h       |   45 --------------------------------------
 include/linux/moduleloader.h |   50 +++++++++++++++++++++++++++++++++++++++++++
 kernel/module.c              |    1 
 3 files changed, 51 insertions(+), 45 deletions(-)


diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Nov 12 23:46:58 2002
+++ b/include/linux/module.h	Tue Nov 12 23:46:58 2002
@@ -10,7 +10,6 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <linux/elf.h>
 #include <linux/stat.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
@@ -143,50 +142,6 @@
 	   keeping pointers to this stuff */
 	char args[0];
 };
-
-/* Helper function for arch-specific module loaders */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **group);
-
-/* These must be implemented by the specific architecture */
-
-/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
-void *module_core_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
-
-/* vmalloc and zero (if any) for sections to be freed after init.
-   Return ERR_PTR() on error. */
-void *module_init_alloc(const Elf_Ehdr *hdr,
-			const Elf_Shdr *sechdrs,
-			const char *secstrings,
-			struct module *mod);
-
-/* Apply the given relocation to the (simplified) ELF.  Return -error
-   or 0. */
-int apply_relocate(Elf_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
-		   struct module *mod);
-
-/* Apply the given add relocation to the (simplified) ELF.  Return
-   -error or 0 */
-int apply_relocate_add(Elf_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *mod);
-
-/* Any final processing of module before access.  Return -error or 0. */
-int module_finalize(const Elf_Ehdr *hdr,
-		    const Elf_Shdr *sechdrs,
-		    struct module *mod);
 
 /* Free memory returned from module_core_alloc/module_init_alloc */
 void module_free(struct module *mod, void *module_region);
diff -Nru a/include/linux/moduleloader.h b/include/linux/moduleloader.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/moduleloader.h	Tue Nov 12 23:46:58 2002
@@ -0,0 +1,50 @@
+#ifndef _LINUX_MODULELOADER_H
+#define _LINUX_MODULELOADER_H
+
+#include <linux/elf.h>
+
+/* Helper function for arch-specific module loaders */
+unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
+				   unsigned int symindex,
+				   const char *strtab,
+				   const char *name,
+				   struct module *mod,
+				   struct kernel_symbol_group **group);
+
+/* These must be implemented by the specific architecture */
+
+/* vmalloc AND zero for the non-releasable code; return ERR_PTR() on error. */
+void *module_core_alloc(const Elf_Ehdr *hdr,
+			const Elf_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *mod);
+
+/* vmalloc and zero (if any) for sections to be freed after init.
+   Return ERR_PTR() on error. */
+void *module_init_alloc(const Elf_Ehdr *hdr,
+			const Elf_Shdr *sechdrs,
+			const char *secstrings,
+			struct module *mod);
+
+/* Apply the given relocation to the (simplified) ELF.  Return -error
+   or 0. */
+int apply_relocate(Elf_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *mod);
+
+/* Apply the given add relocation to the (simplified) ELF.  Return
+   -error or 0 */
+int apply_relocate_add(Elf_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *mod);
+
+/* Any final processing of module before access.  Return -error or 0. */
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *mod);
+
+#endif
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Tue Nov 12 23:46:58 2002
+++ b/kernel/module.c	Tue Nov 12 23:46:58 2002
@@ -17,6 +17,7 @@
 */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.858
## Wrapped with gzip_uu ##


begin 664 bkpatch19251
M'XL(`.*$T3T``\U8;4_;2!#^C'_%2'P!>DEV_9:7'E5ID[X(CE9I.56Z.T6;
M]3BVZNQ&MD.A\H^_\=J$PR$AI<?I'!1CSXOG>69F=YQ]N,@P'>P)%6":S:Q]
M>*>S?+#'KGRGK99T/=::KCN1GF.GUNI\Q51ATIE^[4P3_<TBK8\BEQ%<DG2P
MQ]O.ZDY^O<#!WGCT]N+L9&Q9Q\?P.A)JAI\PA^-C*]?II4B"[*7(HT2K=IX*
ME<TQ%VVIY\5*M;`9L^GC\:[#/+_@/G.[A>0!Y\+E&##;[?FN58?WL@Z^8<\Y
MIY/'."M<MVL[UA!XN^?U@-D=SCO<!ML9N.[`=IXQ/F`,&N[@F0,M9KV"?S?H
MUY:$H0:E<XB53)8!`B9A.Z*K7(-($ICK8)E@!I>QJ/]O1]8I>$ZWYU@?;PFU
M6C]X6!83S'K1!%K4<7226"VO.M4C$RU(J1VMJ+1MU^6$RNUSM_`92KLOA=WW
MO2#LXT^X[!9>U_:[%-9VGN_S6/NJ2>^[K+"[S.\7KM_W^NC[#O?8U`GY3N$U
M`_,*S^UUV8.!U<U1.Y%W(G+ZA6?;GD.N?,^6GG!\QJ:]GK,6T7U>_DD[`6.F
MG[8Q6[;8.7Z#,$YPL%73^AU<:ZV!?KX03).Q9HMQ?U.+L:=H,0FOXOP4<8&I
MH0*VK6:=K32=@L%);;=5;0QK1'P!=M6S^2.:]*G2PG=/B_<D>7EMO0%>KF2F
MX3]`*_UF_@CT`_S^.(GO&7C,VH]#@A;"Y.S]^<67R6\?AA=GH[,/)\/1>/+.
MVB=1K'"#]$^RKA?H7ZN@S#K]@@2=(WB'B2FOI9)YK!6$.@61RJB5+5#&82SK
MI1LJ#!D<=:RERN*9PH#NJ1E5I@HFV?5\JI,)K?U4E"(Y&"7AY%,4I'"4H:1S
M]HNU1P<`K(Q)%\B,K/%J)95:93G(2)26>9J+Z;TB)>:X$I#>4N8W<1[1N2FJ
M.N4FR%FJEPLX.C+GP^<5#Y\CS!#F2WK$%"&>+Q*<(Z$)8'H->82PXJ-D)\Y1
MYLL42S:,^>6<=CPMX>1\"-\QU8;'TDQIU4HQ09&)*44G=8#/(44R5C`:CR<?
M/X\/#H&(QS35:;MT>*GCP,`@.!.I4YP8WP<5`26S(\,L?1F@M_?7&;_#)TKB
M(U:S2K1.VPT7-V"HG2HP!W%(%]>'!A6Y*2LEHZ8JJ0I3)))$2(FGE,9YVR+>
MQ[L#+&W^:X`GBT5297467Z*B?-#CA:E_`E7>/\C*$J!\8W`(H[,W[16FEL%1
M@B0NF,%35K(H74YJ1WA__6^L[VUMT931(\AE+=D=H@B"'X%9XJN0&ICWHYR0
MTXU(81M:>`#QFOP.:MB.7%V7:Y)(8)%JB5E&!0$ZO%&=(A4Q#7JR%#73>C>G
M=84:9_%WW%2?MT@W<K$AVGU401QN'(>J0>CIQLE;U^5<L;MC7AX]YGENX7+'
M]LRN;*]OR]Z6:<GU_D=O)&8^WF$??]0./N0.30M#[OK@NB;7C1GYX20_:C2W
M4MK,KE^6W[2)+$I';;'\X^9)?VT:U3GO,DINP?I=NUL-7/[N$Q=_JG?-$UK`
M&F\)(@-1#2LS5)BN9I56I0$1&L5R^#6O'8T,-_`_9CCC?4IM<[RZ&^6+VY\9
89(3R:[:<'T^=/F>N[%I_`[O-$U_'$```
`
end
