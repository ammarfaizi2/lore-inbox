Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266007AbRF1QJJ>; Thu, 28 Jun 2001 12:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266008AbRF1QI7>; Thu, 28 Jun 2001 12:08:59 -0400
Received: from spc.esa.lanl.gov ([128.165.46.232]:6272 "HELO spc.esa.lanl.gov")
	by vger.kernel.org with SMTP id <S266007AbRF1QIw>;
	Thu, 28 Jun 2001 12:08:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: alan@lxorguk.ukuu.org.uk
Subject: 2.4.5-ac20 problems with drivers/net/Config.in and make xconfig
Date: Thu, 28 Jun 2001 10:05:58 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01062810055901.01131@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this familiar error with make xconfig and 2.4.5-ac20 (same as 2.4.6-pre6)

drivers/net/Config.in: 149: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.5-ac20/scripts'
make: *** [xconfig] Error 2

I applied this patch written by Keith Owens (thanks Keith):

--- linux/drivers/net/Config.in.original	Thu Jun 28 09:52:02 2001
+++ linux/drivers/net/Config.in	Thu Jun 28 09:52:25 2001
@@ -146,7 +146,11 @@
       tristate '  NE/2 (ne2000 MCA version) support' CONFIG_NE2_MCA
       tristate '  IBM LAN Adapter/A support' CONFIG_IBMLANA
    fi
-   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
+   if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
+     bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
+   else
+     define_bool CONFIG_NET_PCI n
+   fi
    if [ "$CONFIG_NET_PCI" = "y" ]; then
       dep_tristate '    AMD PCnet32 PCI support' CONFIG_PCNET32 $CONFIG_PCI
       dep_tristate '    Adaptec Starfire support (EXPERIMENTAL)' CONFIG_ADAPTEC_STARFIRE $CONFIG_PCI $CONFIG_EXPERIMENTAL

And then I got:

[root@spc linux]# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.5-ac20/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
make[1]: *** [kconfig.tk] Error 139
make[1]: Leaving directory `/usr/src/linux-2.4.5-ac20/scripts'
make: *** [xconfig] Error 2

So, I used the old reliable make menuconfig, and it worked OK and 
2.4.5-ac20 built successfully.

Steven
