Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUAFRb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUAFRb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:31:27 -0500
Received: from iron-c-2.tiscali.it ([212.123.84.82]:59044 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S264905AbUAFRbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:31:25 -0500
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
X-Mailing-List: linux-kernel@vger.kernel.org

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
