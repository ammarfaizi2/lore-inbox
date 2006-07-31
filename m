Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWGaHfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWGaHfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGaHcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:32:16 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3994 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964815AbWGaHcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:08 -0400
Date: Mon, 31 Jul 2006 16:31:32 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: kmannth@us.ibm.com
Subject: Re: [Lhms-devel] [discuss] [Patch] 2/5 in support of hot-add memory x86_64 create arch_find_node
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, discuss@x86-64.org,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, darnok@us.ibm.com,
       lhms-devel@lists.sourceforge.net,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060730111747.6554f7de.kamezawa.hiroyu@jp.fujitsu.com>
References: <200607291825.16308.ak@suse.de> <20060730111747.6554f7de.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060731152552.B860.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 29 Jul 2006 18:25:15 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Saturday 29 July 2006 04:52, keith mannthey wrote:
> > >   With the advent of the new ACPI hot-plug memory driver and mechanism
> > > is needed to deal with ACPI add memory events that do not contain the
> > > pxm (node) information. I do not believe that the add-event is required
> > > to contain this information so I create a arch_find_node generic layer
> > > used in the generic add_memory function.
> > >
> > >   If add_memory is called with node < 0 arch_find_node is invoked to
> > > fine the correct node to add the memory. This created the generic
> > > construct of arch_find_node.
> > 
> > It would be cleaner to always call add_memory from architecture specific
> > code instead of such ugly hooks
> > 
> Hi,  Keith 
> 
> I don't like insert such a check (nid < 0) in add_memory(), either.
> Could you add it before calling add_memory() ?
> (for example, find_pxm parh in acpi's add memory code.)

Agree.
I think that arch_find_node() should be called in acpi_get_node().

For the time being, I would like to post folloing patch for 2.6.18
to fix returning -1 if _PXM is not defined.
Because, not only your case, but also there might be a case that
hot add code will be executed with NUMA kernel on NON-NUMA box.

Then, arch_find_node() should be add before this line.

Thanks.

-----

 drivers/acpi/numa.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: pxm_find1/drivers/acpi/numa.c
===================================================================
--- pxm_find1.orig/drivers/acpi/numa.c	2006-07-31 14:59:48.000000000 +0900
+++ pxm_find1/drivers/acpi/numa.c	2006-07-31 15:11:06.000000000 +0900
@@ -263,6 +263,10 @@ int acpi_get_node(acpi_handle *handle)
 	if (pxm >= 0)
 		node = acpi_map_pxm_to_node(pxm);
 
+	/* _PXM might not be defined by firmware. */
+	if (node < 0)
+		node = 0;
+
 	return node;
 }
 EXPORT_SYMBOL(acpi_get_node);


-- 
Yasunori Goto 


