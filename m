Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUAFS2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUAFS06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:26:58 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40427 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265079AbUAFS0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:26:45 -0500
Date: Tue, 6 Jan 2004 19:26:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jan Kokoska <kokoska.jan@globe.cz>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.25-pre4
Message-ID: <20040106182636.GI11523@fs.tum.de>
References: <Pine.LNX.4.58L.0401061159090.1207@logos.cnet> <1073405784.880.410.camel@marigold>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073405784.880.410.camel@marigold>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 05:16:24PM +0100, Jan Kokoska wrote:

> Hi,

Hi Jan,

> Trying to compile $subj with following config (these options seem to
> cause the problem, full config attached):
> 
> CONFIG_SCSI_MEGARAID=y
> CONFIG_SCSI_MEGARAID2=y
> 
> gives me this result:
>...
> Is this a known issue and megaraids can't live together, or am I
> supposed to be able to compile both drivers in and this is a bug?
>...

They can't live together.

Below is a patch to tell the config system not to alllow illegal 
configurations.

> Jan Kokoska
>...

cu
Adrian

--- linux-2.4.25-pre4-full/drivers/scsi/Config.in.old	2004-01-06 18:06:29.000000000 +0100
+++ linux-2.4.25-pre4-full/drivers/scsi/Config.in	2004-01-06 18:08:00.000000000 +0100
@@ -67,7 +67,16 @@
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
-dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+if [ "$CONFIG_SCSI_MEGARAID" = "y" ]; then
+  define_tristate CONFIG_SCSI_MEGARAID2_DEP n
+else
+  if [ "$CONFIG_SCSI_MEGARAID" = "m" ]; then
+    define_tristate CONFIG_SCSI_MEGARAID2_DEP m $CONFIG_SCSI
+  else
+    define_tristate CONFIG_SCSI_MEGARAID2_DEP $CONFIG_SCSI
+  fi
+fi
+dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI_MEGARAID2_DEP
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then
