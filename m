Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265997AbRF2PxD>; Fri, 29 Jun 2001 11:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbRF2Pwx>; Fri, 29 Jun 2001 11:52:53 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:59066 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265997AbRF2Pwp>; Fri, 29 Jun 2001 11:52:45 -0400
Message-ID: <3B3CA443.12C731E5@uow.edu.au>
Date: Sat, 30 Jun 2001 01:52:35 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VFS locking & HFS problems (2.4.6pre6)
In-Reply-To: <20010629150942.1359@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> I've had a deadlock twice with 2.4.6pre6 today. It's an SMP kernel
> running on an UP box (a PowerBook Pismo).
> 
> The deadlock happen in the HFS filesystem in hfs_cat_put(), apparently
> (quickly looking at addresses) in spin_lock().
> 

Please test this:

Index: fs/hfs/catalog.c
===================================================================
RCS file: /opt/cvs/lk/fs/hfs/catalog.c,v
retrieving revision 1.2
diff -u -r1.2 catalog.c
--- fs/hfs/catalog.c	2001/02/17 01:44:39	1.2
+++ fs/hfs/catalog.c	2001/06/29 15:54:17
@@ -549,7 +549,7 @@
 		   entry->state &= ~HFS_LOCK;
 		   hfs_wake_up(&entry->wait);
 		}
-
+		spin_lock(&entry_lock);
 		return entry;
 	}
 
@@ -559,7 +559,6 @@
 	if (grow_entries())
 	        goto add_new_entry;
 
-	spin_unlock(&entry_lock);
 	return NULL;
 
 read_fail: 
@@ -570,7 +569,6 @@
 	init_entry(entry);
 	list_add(&entry->list, &entry_unused);
 	entries_stat.nr_free_entries++;
-	spin_unlock(&entry_lock);
 	return NULL;
 }
