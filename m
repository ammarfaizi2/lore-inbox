Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUDHX7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUDHX7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:59:18 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:28947 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S261865AbUDHX7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:59:07 -0400
Subject: Re: [ANNOUNCE][RELEASE]: megaraid unified driver version 2.20.0.B1
From: Paul Wagland <paul@kungfoocoder.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'jgarzik@pobox.com'" <jgarzik@pobox.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C7B4@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E570230C7B4@exa-atlanta.se.lsil.com>
Content-Type: multipart/mixed; boundary="=-owmnXfLL3swEf1WPF1k2"
Organization: Kung Foo Coders!
Message-Id: <1081468618.2084.57.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Apr 2004 01:56:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-owmnXfLL3swEf1WPF1k2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

On Thu, 2004-04-08 at 01:18, Bagalkote, Sreenivas wrote:
> Hello All,
> 
> We are releasing the megaraid unified driver version 2.20.0.0.
> The source is available at our public ftp site:

OK, I have started to look at this driver, I have come across one
problem, which the attached patch fixes. This patch has been sent
through the list several times and has been accepted into 2.6.5.

If you don't set the module owner, then the module can be removed while
it is in use, with quite disastrous results.

A couple of other comments:

1. The Kconfig.megaraid and Makefile.2.6 files from the alpha release
are not in the beta.

2. In mraid_pci_blk_pool_destroy(), the caller "guarantees that no more
memory from the pool is in use", however, they don't have to guarantee
that pool is not null. Why? In fact, in the code it appears that this
guarantee is also made...

3. I am not sure what the local conventions on this are, but in
megaraid_alloc_cmd_packets() if the first allocation fails then we
return straight away, in all other cases we do a goto fail_alloc_cmds;
This is correct (of course) but personally I would prefer that they all
behave in a consistent fashion, and that the first failed alloc test
also did the goto. Otherwise, there is no need for the
alloc_common_mbox_f local, since whenever you go to fail_alloc_cmds
common_mbox will have been allocated (otherwise we have returned).

4. Also a consistency issue: In megaraid_mbox_mm_cmd() we handle the
deletion of a logical drive specially, by calling
megaraid_mbox_del_logdrv(), which just ensures that the drives are
"quiescent" and then calls megaraid_mbox_internal_command(), otherwise,
we just call megaraid_mbox_internal_command(). My preference, would be
for megaraid_mbox_del_logdrv() to just return when the drives are quiet
and then to call megaraid_mbox_internal_command() as per normal, makes
the flow easier to follow in my opinion. However, when we look at
megaraid_mbox_internal_done() it has the deleting of logical drive logic
inlined. I would prefer either that both functions have the special
logic inlined, or that they both have helper functions to deal with the
special case.

Anyway, hope that this helps,
Paul

--=-owmnXfLL3swEf1WPF1k2
Content-Disposition: attachment; filename=megaraid.b1.1.patch
Content-Type: text/x-patch; name=megaraid.b1.1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- megaraid.c.orig	2004-04-09 01:07:11.000000000 +0200
+++ megaraid.c	2004-04-09 01:09:38.000000000 +0200
@@ -342,6 +342,7 @@
  */
 #define MRAID_TEMPLATE							\
 {									\
+	.module				= THIS_MODULE,			\
 	.name				= "MegaRAID",			\
 	.proc_name			= "megaraid",			\
 	.info				= megaraid_info,		\

--=-owmnXfLL3swEf1WPF1k2--

