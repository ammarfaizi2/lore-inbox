Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbSJPRwB>; Wed, 16 Oct 2002 13:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbSJPRwB>; Wed, 16 Oct 2002 13:52:01 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60738 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261309AbSJPRv7>; Wed, 16 Oct 2002 13:51:59 -0400
Date: Wed, 16 Oct 2002 13:57:54 -0400
From: Doug Ledford <dledford@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.43 oops in adaptec driver
Message-ID: <20021016175754.GA8112@redhat.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021016184122.J15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20021016184122.J15163@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2002 at 06:41:22PM +0100, Matthew Wilcox wrote:
> 
> >>EIP; c021723c <aic7xxx_slave_attach+68/d0>   <=====
> 

Duh, forgot to add INIT_LIST_HEAD(&p->aic_devs); to aic7xxx_register() so 
the list_add() is oopsing.  Patch attached.  Let me know if this *doesn't* 
solve the problem (I'm not at work where I can test this yet).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aic_oops.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.857   -> 1.858  
#	drivers/scsi/aic7xxx_old.c	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/16	dledford@aladin.rdu.redhat.com	1.858
# aic7xxx_old.c:
#   Fix mistake with list_head structs
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c	Wed Oct 16 13:57:12 2002
+++ b/drivers/scsi/aic7xxx_old.c	Wed Oct 16 13:57:12 2002
@@ -6723,7 +6723,7 @@
   struct aic7xxx_host *p = (struct aic7xxx_host *) sdpnt->host->hostdata;
   struct aic_dev_data *aic_dev;
   int scbnum;
-  struct list_head *list_ptr, *list_head;
+  struct list_head *list_ptr;
 
   if(!sdpnt->hostdata) {
     sdpnt->hostdata = kmalloc(sizeof(struct aic_dev_data), GFP_ATOMIC);
@@ -6742,8 +6742,7 @@
   aic7xxx_device_queue_depth(p, sdpnt);
 
   scbnum = 0;
-  list_head = &p->aic_devs;
-  list_for_each(list_ptr, list_head) {
+  list_for_each(list_ptr, &p->aic_devs) {
     aic_dev = list_entry(list_ptr, struct aic_dev_data, list);
     scbnum += aic_dev->max_q_depth;
   }
@@ -7879,6 +7878,7 @@
   p->completeq.tail = NULL;
   scbq_init(&p->scb_data->free_scbs);
   scbq_init(&p->waiting_scbs);
+  INIT_LIST_HEAD(&p->aic_devs);
 
   /*
    * We currently have no commands of any type

--ikeVEW9yuYc//A+q--
