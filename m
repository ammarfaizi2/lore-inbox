Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263622AbVHFWIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbVHFWIF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbVHFWIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 18:08:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:62682 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261310AbVHFWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 18:08:03 -0400
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508062058200.27998@praktifix.dwd.de>
References: <91888D455306F94EBD4D168954A9457C035CB64A@nacos172.co.lsil.com>
	 <Pine.LNX.4.61.0508011537250.23481@praktifix.dwd.de>
	 <1123350790.5092.2.camel@mulgrave>
	 <Pine.LNX.4.61.0508062058200.27998@praktifix.dwd.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 06 Aug 2005 17:07:43 -0500
Message-Id: <1123366064.5102.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-06 at 21:12 +0000, Holger Kiehl wrote:
> I tried from 2.6.13-rc2-mm2 up to 2.6.13-rc4-mm1 and always get the following
> error when applying this patch:
> 
>       CC      drivers/message/fusion/mptbase.o
>       CC      drivers/message/fusion/mptscsih.o
>       CC      drivers/message/fusion/mptspi.o
>     drivers/message/fusion/mptspi.c: In function â..mptspi_target_allocâ..:
>     drivers/message/fusion/mptspi.c:113: error: invalid storage class for function â..mptspi_write_offsetâ..
>     drivers/message/fusion/mptspi.c:114: error: invalid storage class for function â..mptspi_write_widthâ..
>     drivers/message/fusion/mptspi.c:131: warning: implicit declaration of function â..mptspi_write_widthâ..
>     drivers/message/fusion/mptspi.c: At top level:
>     drivers/message/fusion/mptspi.c:453: warning: conflicting types for â..mptspi_write_widthâ..
>     drivers/message/fusion/mptspi.c:453: error: static declaration of â..mptspi_write_widthâ.. follows non-static declaration
>     drivers/message/fusion/mptspi.c:131: error: previous implicit declaration of â..mptspi_write_widthâ.. was here

This lot are all gcc-4 being silly about a declaration, as you noticed.
Still, there's no reason not to make the static functions declared at
the top of the file.

>     drivers/message/fusion/mptspi.c:505: error: unknown field â..get_hold_mcsâ.. specified in initializer
>     drivers/message/fusion/mptspi.c:505: warning: excess elements in struct initializer
>     drivers/message/fusion/mptspi.c:505: warning: (near initialization for â..mptspi_transport_functionsâ..)
>     drivers/message/fusion/mptspi.c:506: error: unknown field â..set_hold_mcsâ.. specified in initializer
>     drivers/message/fusion/mptspi.c:506: warning: excess elements in struct initializer
>     drivers/message/fusion/mptspi.c:506: warning: (near initialization for â..mptspi_transport_functionsâ..)
>     drivers/message/fusion/mptspi.c:507: error: unknown field â..show_hold_mcsâ.. specified in initializer
>     drivers/message/fusion/mptspi.c:507: warning: excess elements in struct initializer
>     drivers/message/fusion/mptspi.c:507: warning: (near initialization for â..mptspi_transport_functionsâ..)

This is actually because -mm is slightly behind the scsi-misc tree.  It
looks like the hold_mcs parameters haven't propagated into the -mm tree
yet.  You should be able to correct this by cutting these three lines:

	.get_hold_mcs	= mptspi_read_parameters,
	.set_hold_mcs	= mptspi_write_hold_mcs,
	.show_hold_mcs	= 1,

Out of the code at lines 505-507.  You'll get a warning about
mptspi_write_hold_mcs() being defined but not used which you can ignore.

James


