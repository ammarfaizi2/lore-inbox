Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUAGPeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265612AbUAGPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:34:23 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:22044 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S265607AbUAGPeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:34:19 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200401071534.i07FY8IY032449@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.25-pre4
To: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org (kernel list)
Date: Wed, 7 Jan 2004 16:34:08 +0100 (CET)
Cc: marcelo.tosatti@cyclades.com (Marcello Tosatti)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
>From ankry@sunrise.pg.gda.pl  Wed Jan  7 16:31:11 2004
Return-Path: <ankry@sunrise.pg.gda.pl>
Received: from sunrise.pg.gda.pl (root@sunrise.pg.gda.pl [153.19.40.230])
	by green.mif.pg.gda.pl (8.12.10/8.12.6) with ESMTP id i07FVBo0032429
	for <ankry@green.mif.pg.gda.pl>; Wed, 7 Jan 2004 16:31:11 +0100
Received: from sunrise.pg.gda.pl (localhost [127.0.0.1])
	by sunrise.pg.gda.pl (8.12.10/8.12.9) with ESMTP id i07FV6DJ005180
	for <ankry@green.mif.pg.gda.pl>; Wed, 7 Jan 2004 16:31:06 +0100 (CET)
Received: (from ankry@localhost)
	by sunrise.pg.gda.pl (8.12.10/8.12.9/Submit) id i07FV4VW005179
	for ankry@green.mif.pg.gda.pl; Wed, 7 Jan 2004 16:31:04 +0100 (CET)
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200401071531.i07FV4VW005179@sunrise.pg.gda.pl>
Subject: Re: Linux 2.4.25-pre4 (fwd)
To: ankry@green.mif.pg.gda.pl
Date: Wed, 7 Jan 104 16:31:04 +0100 (CET)
Content-Type: text

"F wrote:"
>From linux-kernel-owner+ankry=40pg.gda.pl@vger.kernel.org  Tue Jan  6 18:34:02 2004
X-BrightmailFiltered: true
Date: Tue, 6 Jan 2004 18:30:17 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Matt Domsch <Matt_Domsch@dell.com>,
        Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.25-pre4
Message-ID: <20040106173017.GA10755@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106102819.A12626@lists.us.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-Spam-Checker-Version: SpamAssassin 2.70-cvs (1.218-2003-11-09-exp) on 
	mordred.oi.pg.gda.pl
X-Spam-Level: 
X-Spam-Status: No, hits=0.3 required=5.0 tests=UPPERCASE_25_50 autolearn=no 
	version=2.70-cvs

Matt Domsch <Matt_Domsch@dell.com> ha scritto:
>> Trying to compile $subj with following config (these options seem to
>> cause the problem, full config attached):
>> 
>> CONFIG_SCSI_MEGARAID=y
>> CONFIG_SCSI_MEGARAID2=y
>>
>> Is this a known issue and megaraids can't live together, or am I
>> supposed to be able to compile both drivers in and this is a bug?
> 
> yes, this is known and expected.  You can build both as modules, but
> they're not intended to both be loaded simultaneously (either built-in
> or as modules).  They're mutually exclusive.

Ok, what about this patch (against 2.4.25-pre4):

--- linux-2.4/drivers/scsi/Config.in.orig	Tue Jan  6 18:11:10 2004
+++ linux-2.4/drivers/scsi/Config.in	Tue Jan  6 18:23:29 2004
@@ -66,8 +66,13 @@
 dep_tristate 'AdvanSys SCSI support' CONFIG_SCSI_ADVANSYS $CONFIG_SCSI
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
-dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
-dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+
+if [ "$CONFIG_SCSI_MEGARAID2" == "n" -o "$CONFIG_SCSI_MEGARAID2" == "" ]; then
+  dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
+fi
+if [ "$CONFIG_SCSI_MEGARAID" == "n" -o "$CONFIG_SCSI_MEGARAID" == "" ]; then
+  dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+fi
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then


I'm not very familiar with 2.4 config language, maybe there's a better
way to do it.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
