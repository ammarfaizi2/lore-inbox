Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTFBUxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTFBUxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:53:45 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:36347 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263921AbTFBUxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:53:42 -0400
Date: Mon, 2 Jun 2003 14:03:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER][PATCH] pnpbios dereferencing user pointer
Message-Id: <20030602140355.5d3ad203.akpm@digeo.com>
In-Reply-To: <37C2C7CC-9536-11D7-BBCD-000A95A0560C@us.ibm.com>
References: <37C2C7CC-9536-11D7-BBCD-000A95A0560C@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2003 21:07:06.0438 (UTC) FILETIME=[EC3F0E60:01C3294A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard <hollisb@us.ibm.com> wrote:
>
> Another simple case of a memcpy that should be copy_from_user...

There are also a bunch of memory leaks in there.  I modified your patch
thusly:


diff -puN drivers/pnp/pnpbios/proc.c~pnpbios-oops-leak-fix drivers/pnp/pnpbios/proc.c
--- 25/drivers/pnp/pnpbios/proc.c~pnpbios-oops-leak-fix	Mon Jun  2 13:59:29 2003
+++ 25-akpm/drivers/pnp/pnpbios/proc.c	Mon Jun  2 14:02:26 2003
@@ -178,18 +178,31 @@ static int proc_write_node(struct file *
 	struct pnp_bios_node *node;
 	int boot = (long)data >> 8;
 	u8 nodenum = (long)data;
+	int ret = count;
 
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
-	if (!node) return -ENOMEM;
-	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
-		return -EIO;
-	if (count != node->size - sizeof(struct pnp_bios_node))
-		return -EINVAL;
-	memcpy(node->data, buf, count);
-	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
-	    return -EINVAL;
+	if (!node)
+		return -ENOMEM;
+	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
+		ret -EIO;
+		goto out;
+	}
+	if (count != node->size - sizeof(struct pnp_bios_node)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (copy_from_user(node->data, buf, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = count;
+out:
 	kfree(node);
-	return count;
+	return ret;
 }
 
 int pnpbios_interface_attach_device(struct pnp_bios_node * node)

_

