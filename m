Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbTH3DGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 23:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTH3DGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 23:06:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:61403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262421AbTH3DFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 23:05:53 -0400
Date: Fri, 29 Aug 2003 20:09:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: OOps in 2.6.0-test4-mm3-1
Message-Id: <20030829200926.3e2b7eb6.akpm@osdl.org>
In-Reply-To: <20030830014309.GA898@matchmail.com>
References: <20030828235649.61074690.akpm@osdl.org>
	<20030830014309.GA898@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> It's vanilla mm3-1 with this one patch added from Neil Brown.  I don't think
> it has anything to do with it (it looks like a driver issue to me).  But it
> can't hurt to mention it.
> 

No, it is not an MD thing.

You need two patches.  It's up to the scsi guys to decide if they're the
right way to go.  I think they are.




Some drivers such as aha1542 and aic7xxx_old will call scsi_register() and
then, if some succeeding operations fails they will call scsi_unregister(),
without an intervening scsi_set_host().

This causes an oops in scsi_put_device(), because kobj->parent is NULL.

In other words, scsi_register() immediately followed by scsi_unregister()
is guaranteed to oops.

The patch makes scsi_host_dev_release() more robust against this usage
pattern.


 drivers/scsi/hosts.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -puN drivers/scsi/hosts.c~aha1542-oops-fix drivers/scsi/hosts.c
--- 25/drivers/scsi/hosts.c~aha1542-oops-fix	2003-08-29 19:48:37.000000000 -0700
+++ 25-akpm/drivers/scsi/hosts.c	2003-08-29 20:02:49.000000000 -0700
@@ -158,7 +158,13 @@ static void scsi_host_dev_release(struct
 	scsi_proc_hostdir_rm(shost->hostt);
 	scsi_destroy_command_freelist(shost);
 
-	put_device(parent);
+	/*
+	 * Some drivers (eg aha1542) do scsi_register()/scsi_unregister()
+	 * during probing without performing a scsi_set_device() in between.
+	 * In this case dev->parent is NULL.
+	 */
+	if (parent)
+		put_device(parent);
 	kfree(shost);
 }
 

_



and





scsi_unregister() unconditionally does list_del(&shost->sht_legacy_list).

But scsi_register() leaves that list_head uninitialised if scsi_host_alloc()
returned NULL.

In other words: scsi_unregister() is guaranteed to oops if scsi_host_alloc()
fails.

Fix it by initialising the list_head in scsi_register().


 drivers/scsi/hosts.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/scsi/hosts.c~scsi_unregister-oops-fix drivers/scsi/hosts.c
--- 25/drivers/scsi/hosts.c~scsi_unregister-oops-fix	2003-08-29 20:02:53.000000000 -0700
+++ 25-akpm/drivers/scsi/hosts.c	2003-08-29 20:02:53.000000000 -0700
@@ -297,8 +297,12 @@ struct Scsi_Host *scsi_register(struct s
 		dump_stack();
 	}
 
-	if (shost)
+	if (shost) {
 		list_add_tail(&shost->sht_legacy_list, &sht->legacy_hosts);
+	} else {
+		/* Do this to keep scsi_unregister() happy */
+		INIT_LIST_HEAD(&shost->sht_legacy_list);
+	}
 	return shost;
 }
 

_

