Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278214AbRJ1MDs>; Sun, 28 Oct 2001 07:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278215AbRJ1MDi>; Sun, 28 Oct 2001 07:03:38 -0500
Received: from torvi.fmi.fi ([193.166.211.16]:50948 "EHLO torvi.fmi.fi")
	by vger.kernel.org with ESMTP id <S278214AbRJ1MDc>;
	Sun, 28 Oct 2001 07:03:32 -0500
From: Kari Hurtta <hurtta@leija.mh.fmi.fi>
Message-Id: <200110281203.f9SC3soW005371@leija.fmi.fi>
Subject: [2.4.13] [devfs 0.119 (20011009)] base.c: devfsd_ioctl
To: rgooch@atnf.csiro.au
Date: Sun, 28 Oct 2001 14:03:54 +0200 (EET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
X-Filter: torvi: 2 received headers rewritten with id 20011028/26775/01
X-Filter: torvi: ID 25378, 1 parts scanned for known viruses
X-Filter: leija.fmi.fi: ID 23635, 1 parts scanned for known viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you say where I have wrong?

Code on devfsd_ioctl() [base.c]:

        if (fs_info->devfsd_task == NULL)
        {
            if ( !spin_trylock (&lock) ) return -EBUSY;
            fs_info->devfsd_task = current;
            spin_unlock (&lock);

To me that spinlock looks like it is useless.
Either

	1) If it is mean that lock protects two CPUs settting
            fs_info->devfsd_task when another is set it,
	    then test about fs_info->devfsd_task == NULL
	    should be inside of locked code
or     2) this is protected with some other lock as comment
          perhaps indicates:

        /*  Ensure only one reader has access to the queue. This scheme will
            work even if the global kernel lock were to be removed, because it
            doesn't matter who gets in first, as long as only one gets it
        */
        if (fs_info->devfsd_task == NULL)
        {
            if ( !spin_trylock (&lock) ) return -EBUSY;

Should this be:

--- fs/devfs/base.c.old	Thu Oct 11 09:23:24 2001
+++ fs/devfs/base.c	Sun Oct 28 14:59:03 2001
@@ -3227,6 +3227,11 @@
 	if (fs_info->devfsd_task == NULL)
 	{
 	    if ( !spin_trylock (&lock) ) return -EBUSY;
+	    if (fs_info->devfsd_task != NULL) {
+	         /* We lost race ... */
+	         spin_unlock (&lock);
+		 return -EBUSY;
+	    }
 	    fs_info->devfsd_task = current;
 	    spin_unlock (&lock);
 	    fs_info->devfsd_file = file;


-- 
          /"\                           |  Kari 
          \ /     ASCII Ribbon Campaign |    Hurtta
           X      Against HTML Mail     |
          / \                           |
