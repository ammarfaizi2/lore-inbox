Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTJEKkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 06:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTJEKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 06:40:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51329
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263061AbTJEKkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 06:40:04 -0400
Date: Sun, 5 Oct 2003 12:40:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org, thomas@winischhofer.net
Subject: Re: 2.4.23pre6aa2 - some problems [with patches]
Message-ID: <20031005104008.GC1561@velociraptor.random>
References: <20031004105731.GA1343@velociraptor.random> <3F7EE96C.4AC99553@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7EE96C.4AC99553@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 01:38:20AM +1000, Eyal Lebedinsky wrote:
> This is most unusual as -aa patches usually apply clean, but I am
> encountering a number of build problems.
> 
> "PCMCIA SCSI adapter support" build is broken. I deselected the whole
> section.

can you double check you can reproduce it in 2.4.23pre6 vanilla? It
doesn't seem introduced by my patches.

> I now have this failure:
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
> -Wstrict-
> prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-poi
> nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
> -malign-functio
> ns=4 -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre-aa/inclu
> de/linux/modversions.h  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=ip_vs_c
> onn  -c -o ip_vs_conn.o ip_vs_conn.c
> ip_vs_conn.c: In function `ip_vs_tunnel_xmit':
> ip_vs_conn.c:895: too many arguments to function
> `ip_select_ident_Rd603b6c5'
> make[2]: *** [ip_vs_conn.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/net/ipv4/ipvs'
> 
> Seems that ip_select_ident() only wants the first argument.

this isn't new, we simplified the ip_select_ident a long time ago.
Not sure it triggers only now. Your fix is correct thanks.

> Next I get
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
> -Wstrict-
> prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-poi
> nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
> -malign-functio
> ns=4 -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre-aa/inclu
> de/linux/modversions.h  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=addrcon
> f  -c -o addrconf.o addrconf.c
> addrconf.c: In function `ipv6_store_devconf':
> addrconf.c:1996: structure has no member named `rtr_solicit_interval'
> addrconf.c:1997: structure has no member named `rtr_solicit_delay'
> make[2]: *** [addrconf.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/net/ipv6'
> 
> I think that these members were renamed, my patch is just a guess.

this one is related to dynamic-hz so you're right it's a new thing.
But careful, your fix is wrong. The rename was done for a reason, that
is exactly to catch those at compile time. This will fix it right:

--- xx/net/ipv6/addrconf.c.~1~	2003-10-05 12:23:08.000000000 +0200
+++ xx/net/ipv6/addrconf.c	2003-10-05 12:23:33.000000000 +0200
@@ -1993,8 +1993,8 @@ static void inline ipv6_store_devconf(st
 	array[DEVCONF_AUTOCONF] = cnf->autoconf;
 	array[DEVCONF_DAD_TRANSMITS] = cnf->dad_transmits;
 	array[DEVCONF_RTR_SOLICITS] = cnf->rtr_solicits;
-	array[DEVCONF_RTR_SOLICIT_INTERVAL] = cnf->rtr_solicit_interval;
-	array[DEVCONF_RTR_SOLICIT_DELAY] = cnf->rtr_solicit_delay;
+	array[DEVCONF_RTR_SOLICIT_INTERVAL] = user_to_kernel_hz_overflow(cnf->__rtr_solicit_interval);
+	array[DEVCONF_RTR_SOLICIT_DELAY] = user_to_kernel_hz_overflow(cnf->__rtr_solicit_delay);
 #ifdef CONFIG_IPV6_PRIVACY
 	array[DEVCONF_USE_TEMPADDR] = cnf->use_tempaddr;
 	array[DEVCONF_TEMP_VALID_LFT] = cnf->temp_valid_lft;

> Next
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
> -Wstrict-
> prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-poi
> nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
> -malign-functio
> ns=4 -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre-aa/inclu
> de/linux/modversions.h  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=protoco
> l  -c -o protocol.o protocol.c
> protocol.c: In function `sctp_v4_create_accept_sk':
> protocol.c:537: structure has no member named `id'
> make[2]: *** [protocol.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre-aa/net/sctp'
> 
> Member .id was removed, so my patch removes the offending line (a
> guess).

Well SCPT is a new feature, introduced in 2.4.23pre, this had nothing to
do with my tree, but thanks for the fix, merged.

> Finally I get
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
> 2.4.23-pre6-aa2; fi
> depmod: /lib/modules/2.4.23-pre6-aa2/ksyms is not an ELF file
> depmod: /lib/modules/2.4.23-pre6-aa2/soundconf is not an ELF file
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.23-pre6-aa2/kernel/drivers/vi
> deo/sis/sisfb.o
> depmod:         __floatsidf
> depmod:         __divdf3
> depmod:         __fixunsdfsi
> depmod:         __muldf3
> depmod:         __adddf3

those drivers are buggy, and had always been buggy, it's just that you
couldn't notice it before. I added an option in my new tree to catch
those longstanding bugs. They *must* not compile. Driver
authors can audit their 2.4 drivers by grabbing my tree or by applying
this patch alone:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa2/9999900_soft-float-1

see drivers/video/sis/init.c:

      divider = (sr2b & 0x80) ? 2.0 : 1.0;
      postscalar = (sr2c & 0x80) ?
              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6.0 : 8.0) : (((sr2c >> 5) & 0x03) + 1.0);
      num = (sr2b & 0x7f) + 1.0;
      denum = (sr2c & 0x1f) + 1.0;

there would be a slight chance to find false positives too, but those
aren't false positives, there's no fpu save at all there.


Ironically all the float numbers seems to end with .0, I fixed it a bit
but I've no idea if I catched all them, so Eyal, you can try to apply
this patch and follow the code to see if you can spot more of these
longstanding bugs (those could corrupt the fpu state and segfault
userspace at the very least):

--- xx/drivers/video/sis/init.c.~1~	2003-10-02 00:09:44.000000000 +0200
+++ xx/drivers/video/sis/init.c	2003-10-05 12:36:03.000000000 +0200
@@ -3940,11 +3940,11 @@ SiSBuildBuiltInModeList(ScrnInfoPtr pScr
       sr2b = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2B;
       sr2c = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2C;
 
-      divider = (sr2b & 0x80) ? 2.0 : 1.0;
+      divider = (sr2b & 0x80) ? 2 : 1;
       postscalar = (sr2c & 0x80) ?
-              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6.0 : 8.0) : (((sr2c >> 5) & 0x03) + 1.0);
-      num = (sr2b & 0x7f) + 1.0;
-      denum = (sr2c & 0x1f) + 1.0;
+              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6 : 8) : (((sr2c >> 5) & 0x03) + 1);
+      num = (sr2b & 0x7f) + 1;
+      denum = (sr2c & 0x1f) + 1;
 
 #ifdef TWDEBUG
       xf86DrvMsg(0, X_INFO, "------------\n");

> And building i2c-2.7.0 (which I need for sensors) is failing.
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.23-pre6-aa2/kernel/drivers/ie
> ee1394/pcilynx.o
> depmod:         i2c_bit_add_bus_Rca543f36
> depmod:         i2c_transfer_R1dea91d1
> depmod:         i2c_bit_del_bus_Rdf920b11
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.23-pre6-aa2/kernel/drivers/me
> dia/video/bttv.o
> depmod:         i2c_bit_add_bus_Rca543f36
> depmod:         i2c_master_recv_R67b29cc4
> depmod:         i2c_bit_del_bus_Rdf920b11
> depmod:         i2c_master_send_Rb692cb0e
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.23-pre6-aa2/kernel/drivers/me
> dia/video/msp3400.o
> depmod:         i2c_probe_R4e2acbec
> depmod:         i2c_add_driver_Racf22304
> depmod:         i2c_transfer_R1dea91d1
> depmod:         i2c_attach_client_Ra861362d
> depmod:         i2c_master_send_Rb692cb0e
> depmod:         i2c_detach_client_R0cfb40b4
> depmod:         i2c_del_driver_R57837012
> .... more following, all in  kernel/drivers/media/video/* ...

this looks like if you didn't compile the needed i2c (or maybe it was
due the lack of a `make dep` first), the above modules (pcilynx bttv
msp3400) looks innocent.

Thanks for the help in tracking and fixing those bits!

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
