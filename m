Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSFFS2L>; Thu, 6 Jun 2002 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317051AbSFFS1p>; Thu, 6 Jun 2002 14:27:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39763 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317047AbSFFS0t>; Thu, 6 Jun 2002 14:26:49 -0400
Date: Thu, 6 Jun 2002 14:26:46 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br, torvalds@transmeta.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch - SCSI host numbers - please apply
Message-ID: <20020606142646.A8163@devserv.devel.redhat.com>
In-Reply-To: <mailman.1023359281.11223.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Comment/motivation:
>   This keeps max_scsi_host coherent with the length of the list
>   scsi_host_no_list. Since we never shorten the list
>   we should never decrement max_scsi_host.

I vote for Itai's patch going into both trees. Attached without
MIME is a version which applies with -p1 and inline.

-- Pete

--- linux/drivers/scsi/hosts.c	Mon Feb 25 21:38:04 2002
+++ linux-p3/drivers/scsi/hosts.c	Wed Apr 17 01:42:47 2002
@@ -81,8 +81,8 @@
 struct Scsi_Host * scsi_hostlist;
 struct Scsi_Device_Template * scsi_devicelist;
 
-int max_scsi_hosts;
-int next_scsi_host;
+int max_scsi_hosts;	/* host_no for next new host */
+int next_scsi_host;	/* count of registered scsi hosts */
 
 void
 scsi_unregister(struct Scsi_Host * sh){
@@ -107,21 +107,8 @@
     if (shn) shn->host_registered = 0;
     /* else {} : This should not happen, we should panic here... */
     
-    /* If we are removing the last host registered, it is safe to reuse
-     * its host number (this avoids "holes" at boot time) (DB) 
-     * It is also safe to reuse those of numbers directly below which have
-     * been released earlier (to avoid some holes in numbering).
-     */
-    if(sh->host_no == max_scsi_hosts - 1) {
-	while(--max_scsi_hosts >= next_scsi_host) {
-	    shpnt = scsi_hostlist;
-	    while(shpnt && shpnt->host_no != max_scsi_hosts - 1)
-		shpnt = shpnt->next;
-	    if(shpnt)
-		break;
-	}
-    }
     next_scsi_host--;
+
     kfree((char *) sh);
 }
 
