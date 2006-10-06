Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWJFLRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWJFLRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWJFLRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:17:47 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:8378 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750706AbWJFLRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:17:46 -0400
Subject: Re: [PATCH 4/5] ioremap balanced with iounmap for
	drivers/char/rio/rio_linux.c
From: Amol Lad <amol@verismonetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1160133715.1607.64.camel@localhost.localdomain>
References: <1160110628.19143.89.camel@amol.verismonetworks.com>
	 <1160133715.1607.64.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 16:51:06 +0530
Message-Id: <1160133666.19143.150.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +		if (hp->Caddr)
> > +			iounmap(hp->Caddr);
> >  	}
> 
> I don't think this is sufficient because it may be unmapped earlier on
> error but hp->Caddr is not then cleared .

Is this fine ?

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 rio_linux.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/rio/rio_linux.c linux-2.6.19-rc1/drivers/char/rio/rio_linux.c
--- linux-2.6.19-rc1-orig/drivers/char/rio/rio_linux.c	2006-10-05 14:00:43.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/rio/rio_linux.c	2006-10-06 16:42:19.000000000 +0530
@@ -1022,6 +1022,7 @@ static int __init rio_init(void)
 			found++;
 		} else {
 			iounmap(p->RIOHosts[p->RIONumHosts].Caddr);
+			p->RIOHosts[p->RIONumHosts].Caddr = NULL;
 		}
 	}
 
@@ -1071,6 +1072,7 @@ static int __init rio_init(void)
 			found++;
 		} else {
 			iounmap(p->RIOHosts[p->RIONumHosts].Caddr);
+			p->RIOHosts[p->RIONumHosts].Caddr = NULL;
 		}
 #else
 		printk(KERN_ERR "Found an older RIO PCI card, but the driver is not " "compiled to support it.\n");
@@ -1110,8 +1112,10 @@ static int __init rio_init(void)
 				}
 			}
 
-			if (!okboard)
+			if (!okboard) {
 				iounmap(hp->Caddr);
+				hp->Caddr = NULL;
+			}
 		}
 	}
 
@@ -1181,6 +1185,9 @@ static void __exit rio_exit(void)
 		}
 		/* It is safe/allowed to del_timer a non-active timer */
 		del_timer(&hp->timer);
+
+		if (hp->Caddr)
+			iounmap(hp->Caddr);
 	}
 
 	if (misc_deregister(&rio_fw_device) < 0) {


