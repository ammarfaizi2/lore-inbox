Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTFDVbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTFDVbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:31:18 -0400
Received: from aneto.able.es ([212.97.163.22]:8854 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264144AbTFDVbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:31:15 -0400
Date: Wed, 4 Jun 2003 23:44:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linas@austin.ibm.com
Cc: lnz@dandelion.com, mike@i-connect.net, eric@andante.org,
       linux-kernel@vger.kernel.org, olh@suse.de, groudier@free.fr,
       axboe@suse.de, acme@conectiva.com.br, linas@linas.org
Subject: Re: Patches for SCSI timeout bug
Message-ID: <20030604214442.GI4939@werewolf.able.es>
References: <20030604163415.A41236@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030604163415.A41236@forte.austin.ibm.com>; from linas@austin.ibm.com on Wed, Jun 04, 2003 at 23:34:16 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.04, linas@austin.ibm.com wrote:
> 
> 
> Hi,
> 
> I've got a SCSI timeout bug in kernels 2.4 and 2.5, and several 
> different patches (appended) that fix it.  I'm not sure which way 
> of fixing it is best.
> 
[...]

Can you try with this:

--- linux-2.4.18-18mdk/drivers/scsi/scsi_error.c.scsi-eh-timeout	Thu May 30 16:22:37 2002
+++ linux-2.4.18-18mdk/drivers/scsi/scsi_error.c	Sun Jun  9 19:18:11 2002
@@ -1103,6 +1103,8 @@
  */
 STATIC int scsi_eh_completed_normally(Scsi_Cmnd * SCpnt)
 {
+	int rtn;
+
 	/*
 	 * First check the host byte, to see if there is anything in there
 	 * that would indicate what we need to do.
@@ -1116,14 +1118,18 @@
 			 * otherwise we just flag it as success.
 			 */
 			SCpnt->flags &= ~IS_RESETTING;
-			return NEEDS_RETRY;
+			goto maybe_retry;
 		}
 		/*
 		 * Rats.  We are already in the error handler, so we now get to try
 		 * and figure out what to do next.  If the sense is valid, we have
 		 * a pretty good idea of what to do.  If not, we mark it as failed.
 		 */
-		return scsi_check_sense(SCpnt);
+		rtn = scsi_check_sense(SCpnt);
+		if (rtn == NEEDS_RETRY) {
+			goto maybe_retry;
+		}
+		return rtn;
 	}
 	if (host_byte(SCpnt->result) != DID_OK) {
 		return FAILED;
@@ -1142,7 +1148,11 @@
 	case COMMAND_TERMINATED:
 		return SUCCESS;
 	case CHECK_CONDITION:
-		return scsi_check_sense(SCpnt);
+		rtn = scsi_check_sense(SCpnt);
+		if (rtn == NEEDS_RETRY) {
+			goto maybe_retry;
+		}
+		return rtn;
 	case CONDITION_GOOD:
 	case INTERMEDIATE_GOOD:
 	case INTERMEDIATE_C_GOOD:
@@ -1157,6 +1167,17 @@
 		return FAILED;
 	}
 	return FAILED;
+
+      maybe_retry:
+
+	if ((++SCpnt->retries) < SCpnt->allowed) {
+		return NEEDS_RETRY;
+	} else {
+                /*
+                 * No more retries - report this one back to upper level.
+                 */
+		return SUCCESS;
+	}
 }
 
 /*


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
