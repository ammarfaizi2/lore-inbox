Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132594AbRC2LeO>; Thu, 29 Mar 2001 06:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRC2LeE>; Thu, 29 Mar 2001 06:34:04 -0500
Received: from u-156-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.156]:22766
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S132594AbRC2LeC>; Thu, 29 Mar 2001 06:34:02 -0500
Date: Thu, 29 Mar 2001 13:32:21 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Green" <greeen@iii.org.tw>
Cc: "LinuxEmbeddedMailList" <linux-embedded@waste.org>,
   "LinuxKernelMailList" <linux-kernel@vger.kernel.org>,
   "MipsMailList" <linux-mips@fnet.fr>
Subject: Re: Pcmcia driver on Mips r39xx.
Message-ID: <20010329133221.A1444@bacchus.dhis.org>
In-Reply-To: <001301c0b833$736add00$4c0c5c8c@trd.iii.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001301c0b833$736add00$4c0c5c8c@trd.iii.org.tw>; from greeen@iii.org.tw on Thu, Mar 29, 2001 at 05:34:25PM +0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 05:34:25PM +0800, Green wrote:
> From: "Green" <greeen@iii.org.tw>
> To: "LinuxEmbeddedMailList" <linux-embedded@waste.org>,
>         "LinuxKernelMailList" <linux-kernel@vger.kernel.org>,
>         "MipsMailList" <linux-mips@fnet.fr>
> Subject: Pcmcia driver on Mips r39xx.
> Date: Thu, 29 Mar 2001 17:34:25 +0800
> 
> Hi all,
> 
> I want to port pcmcia driver to my MIPS box.
> How could I begin?
> 
> I find that there is a line in the /init/main.c such like the following:
> 
> #ifdef CONFIG_PCMCIA
>  init_pcmcia_ds();  /* Do this last */
> #endif
> 
> The init_pcmcia_ds() function is implemented at /drivers/pcmcia/ds.c.
> Should I add a CONFIG_PCMCIA label to the .config file and enable this config ?

This was a bug in our config.in which I just fixed.  Patch below and in
CVS.

  Ralf

Index: arch/mips/config.in
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/config.in,v
retrieving revision 1.97
diff -u -r1.97 config.in
--- arch/mips/config.in	2001/03/24 03:10:57	1.97
+++ arch/mips/config.in 2001/03/29 11:30:52   
@@ -261,8 +261,14 @@
 
 bool 'Networking support' CONFIG_NET
 
-if [ "$CONFIG_PCI" = "y" ]; then
-    source drivers/pci/Config.in
+source drivers/pci/Config.in
+
+bool 'Support for hot-pluggable devices' CONFIG_HOTPLUG
+
+if [ "$CONFIG_HOTPLUG" = "y" ] ; then
+   source drivers/pcmcia/Config.in
+else
+   define_bool CONFIG_PCMCIA n
 fi
 
 bool 'System V IPC' CONFIG_SYSVIPC
Index: arch/mips/defconfig
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig,v
retrieving revision 1.78
diff -u -r1.78 defconfig
--- arch/mips/defconfig	2001/03/24 03:10:57	1.78
+++ arch/mips/defconfig 2001/03/29 11:30:54   
@@ -81,6 +81,8 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-atlas
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-atlas,v
retrieving revision 1.20
diff -u -r1.20 defconfig-atlas
--- arch/mips/defconfig-atlas	2001/03/24 03:10:57	1.20
+++ arch/mips/defconfig-atlas 2001/03/29 11:30:54   
@@ -76,6 +76,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 # CONFIG_PCI_NAMES is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
Index: arch/mips/defconfig-ddb5476
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-ddb5476,v
retrieving revision 1.20
diff -u -r1.20 defconfig-ddb5476
--- arch/mips/defconfig-ddb5476	2001/03/24 03:10:57	1.20
+++ arch/mips/defconfig-ddb5476 2001/03/29 11:30:54   
@@ -76,6 +76,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 # CONFIG_PCI_NAMES is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-decstation
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-decstation,v
retrieving revision 1.42
diff -u -r1.42 defconfig-decstation
--- arch/mips/defconfig-decstation	2001/03/24 03:10:57	1.42
+++ arch/mips/defconfig-decstation 2001/03/29 11:30:54   
@@ -74,6 +74,8 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-ev64120
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-ev64120,v
retrieving revision 1.15
diff -u -r1.15 defconfig-ev64120
--- arch/mips/defconfig-ev64120	2001/03/24 03:10:57	1.15
+++ arch/mips/defconfig-ev64120 2001/03/29 11:30:54   
@@ -83,6 +83,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 # CONFIG_PCI_NAMES is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-ev96100
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-ev96100,v
retrieving revision 1.20
diff -u -r1.20 defconfig-ev96100
--- arch/mips/defconfig-ev96100	2001/03/24 03:10:57	1.20
+++ arch/mips/defconfig-ev96100 2001/03/29 11:30:54   
@@ -79,6 +79,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 # CONFIG_PCI_NAMES is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 # CONFIG_SYSVIPC is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
Index: arch/mips/defconfig-ip22
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-ip22,v
retrieving revision 1.53
diff -u -r1.53 defconfig-ip22
--- arch/mips/defconfig-ip22	2001/03/24 03:10:57	1.53
+++ arch/mips/defconfig-ip22 2001/03/29 11:30:54   
@@ -81,6 +81,8 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-it8172
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-it8172,v
retrieving revision 1.4
diff -u -r1.4 defconfig-it8172
--- arch/mips/defconfig-it8172	2001/03/24 03:10:57	1.4
+++ arch/mips/defconfig-it8172 2001/03/29 11:30:56   
@@ -82,6 +82,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 CONFIG_PCI_NAMES=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-malta
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-malta,v
retrieving revision 1.22
diff -u -r1.22 defconfig-malta
--- arch/mips/defconfig-malta	2001/03/24 03:10:57	1.22
+++ arch/mips/defconfig-malta 2001/03/29 11:30:56   
@@ -75,6 +75,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 # CONFIG_PCI_NAMES is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
Index: arch/mips/defconfig-ocelot
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-ocelot,v
retrieving revision 1.6
diff -u -r1.6 defconfig-ocelot
--- arch/mips/defconfig-ocelot	2001/03/24 03:10:57	1.6
+++ arch/mips/defconfig-ocelot 2001/03/29 11:30:56   
@@ -77,6 +77,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 CONFIG_PCI_NAMES=y
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
Index: arch/mips/defconfig-rm200
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-rm200,v
retrieving revision 1.36
diff -u -r1.36 defconfig-rm200
--- arch/mips/defconfig-rm200	2001/03/24 03:10:57	1.36
+++ arch/mips/defconfig-rm200 2001/03/29 11:30:56   
@@ -79,6 +79,8 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_NET=y
 # CONFIG_PCI_NAMES is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
 # CONFIG_SYSVIPC is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
