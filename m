Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUAGQQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUAGQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:16:39 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:32028 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S266239AbUAGQPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:15:21 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200401071615.i07GF9Nl032585@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.25-pre4
To: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org (kernel list)
Date: Wed, 7 Jan 2004 17:15:09 +0100 (CET)
Cc: marcelo.tosatti@cyclades.com (Marcello Tosatti)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for previous bogus messge.

> --- linux-2.4/drivers/scsi/Config.in.orig	Tue Jan  6 18:11:10 2004
> +++ linux-2.4/drivers/scsi/Config.in	Tue Jan  6 18:23:29 2004
> @@ -66,8 +66,13 @@
>  dep_tristate 'AdvanSys SCSI support' CONFIG_SCSI_ADVANSYS $CONFIG_SCSI
>  dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
>  dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
> -dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
> -dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
> +
> +if [ "$CONFIG_SCSI_MEGARAID2" == "n" -o "$CONFIG_SCSI_MEGARAID2" == "" ]; then
> +  dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
> +fi
> +if [ "$CONFIG_SCSI_MEGARAID" == "n" -o "$CONFIG_SCSI_MEGARAID" == "" ]; then
> +  dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
> +fi
>  
>  dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
>  if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then

This way you disallow using both as modules.
2.4 config language generally does not support back references, so it is
safer to do sth like this:


dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
if [ "$CONFIG_SCSI_MEGARAID" = "m" ]  
   define_tristate CONFIG_SCSI_MEGARAID2_DEP m
else
   define_tristate CONFIG_SCSI_MEGARAID2_DEP y
fi
if [ "$CONFIG_SCSI_MEGARAID" != "y" ]
   dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI_MEGARAID2_DEP $CONFIG_SCSI
fi



Using the same variable name in many interactive definitions breaks xconfig.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
