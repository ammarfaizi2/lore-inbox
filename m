Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWJBXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWJBXVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965521AbWJBXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:21:23 -0400
Received: from mail0.lsil.com ([147.145.40.20]:32201 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964981AbWJBXVU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:21:20 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Panic from mptspi_dv_renegotiate_work in 2.6.18-mm2
Date: Mon, 2 Oct 2006 17:21:08 -0600
Message-ID: <664A4EBB07F29743873A87CF62C26D703507DA@NAMAIL4.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Panic from mptspi_dv_renegotiate_work in 2.6.18-mm2
Thread-Index: AcbmYugOm8xui4bPTgyRUe5w3SqnAAAFKBVQ
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Andrew Morton" <akpm@osdl.org>, "Martin Bligh" <mbligh@google.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Andy Whitcroft" <apw@shadowen.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 02 Oct 2006 23:21:09.0390 (UTC) FILETIME=[715BA2E0:01C6E679]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 02, 2006 2:40 PM, Andrew Morton wrote: 

> 
> Yeah, Bryce@osdl is hitting this.  Apparently it can be worked around
> by compiling the driver as a module.
>

What I saw in Bryces trace was the driver was not receiving interrupts
for
the first command sent after interrutps were enabled.  This was a config
page
for spi port pages.  Since this command timed out, an internal timeout
handler was called,
and we issued an internal host reset.  The host reset called each
driver,
such as mptspi, mptfc, mptsas,  callback handers.  That ended with
as pacin in mptspi, due to we assume ioc->hd to be a valid pointer.  
We don't allocate ioc->hd to well after mpt_attach, which is where the
config
page that timed out.    We could prevent the panic in mptspi, but that 
doesn't fix the problem why we are not getting interrupts.   

I have a 2.6.18 gold kernel, and that works fine with modules.  
There are no changes in mpt stack since 2.6.18 that would effect
interrupts.  
Do you know of any changes in kernel effecting interrupts?   I suspect
that
modules versus linked drivers into kernel would matter, or would it?

I've been busy with SAS issues today, and not had time to replicat this.

Eric
