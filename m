Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUDJIUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 04:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUDJIUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 04:20:33 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:32268 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261982AbUDJIUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 04:20:31 -0400
Date: Sat, 10 Apr 2004 10:20:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alfred Arnold <aarnold@elsa.de>
Subject: [BUG 2.2/2.4/2.6] broken memsets in net/sk_mca.c (multicast)
Message-Id: <20040410102040.022ffb3c.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC: me on reply, I'm not subscribed (yet)]

Hi all,

I just found two very weird memsets in drivers/net/sk_mca.c. I am not
working on that driver at all, but some grepping of the kernel source
pointed me to it so I thought I wouldn't keep quiet about it.

Here is the offending code:

static void skmca_set_multicast_list(struct net_device *dev)
{
	(...)
	if (dev->flags & IFF_ALLMULTI) {	/* get all multicasts */
		memset(block.LAdrF, 8, 0xff);
	} else {		/* get selected/no multicasts */
		(...)
		memset(block.LAdrF, 8, 0x00);
		(...)
	}
	(...)
}

Is it just me, or are these two memsets just plain broken? Not only the
size is hardcoded, but the parameters are swapped! I guess that this
driver never worked in multicast mode. The correct memsets are
obviously:
		memset(block.LAdrF, 0xff, sizeof(block.LAdrF));
and
		memset(block.LAdrF, 0x00, sizeof(block.LAdrF));
respectively.

The odd thing is that the bug is there since the driver was introduced
in the 2.2.10 kernel. So, 2.2, 2.4 and 2.6 kernels are all affected.

I admit I'm a bit surprized that this could survive until today, so just
tell me if it's me missing the point ;)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
