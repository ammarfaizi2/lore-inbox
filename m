Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292092AbSBOKkw>; Fri, 15 Feb 2002 05:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292091AbSBOKkk>; Fri, 15 Feb 2002 05:40:40 -0500
Received: from mailgate.indstate.edu ([139.102.15.118]:26775 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S292087AbSBOKk0>; Fri, 15 Feb 2002 05:40:26 -0500
From: Rich Baum <richbaum@acm.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: [OOPS] Linux 2.5 and Parallel Port Zip 100
Date: Thu, 14 Feb 2002 22:21:13 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
        Tim Waugh <twaugh@redhat.com>
In-Reply-To: <3C62DABF.5040303@nyc.rr.com> <90D37E966D1@coral.indstate.edu> <3C6C4D12.4080701@nyc.rr.com>
In-Reply-To: <3C6C4D12.4080701@nyc.rr.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DB1K5INPC40A85AQGNEH"
Message-ID: <91EC2F73141@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DB1K5INPC40A85AQGNEH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: 

The following patch allows parallel port zip drives to work with 2.5 kernels. 
 This patch has been tested with both imm and ppa drives.  Thanks to John 
Weber for testing the ppa part of this patch.

Rich

--------------Boundary-00=_DB1K5INPC40A85AQGNEH
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rb2.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="rb2.diff"

diff -urN -X dontdiff linux/drivers/scsi/imm.c linux-rb/drivers/scsi/imm.c
--- linux/drivers/scsi/imm.c	Sun Feb 10 16:04:43 2002
+++ linux-rb/drivers/scsi/imm.c	Thu Feb  7 22:22:38 2002
@@ -1007,7 +1007,7 @@
 	    cmd->SCp.this_residual = cmd->request_bufflen;
 	    cmd->SCp.ptr = cmd->request_buffer;
 	}
-	cmd->SCp.buffers_residual = cmd->use_sg;
+	cmd->SCp.buffers_residual = cmd->use_sg - 1;
 	cmd->SCp.phase++;
 	if (cmd->SCp.this_residual & 0x01)
 	    cmd->SCp.this_residual++;
diff -urN -X dontdiff linux/drivers/scsi/ppa.c linux-rb/drivers/scsi/ppa.c
--- linux/drivers/scsi/ppa.c	Sun Feb 10 16:04:44 2002
+++ linux-rb/drivers/scsi/ppa.c	Sun Feb 10 22:36:20 2002
@@ -738,7 +738,7 @@
 	    if (cmd->SCp.buffers_residual--) {
 		cmd->SCp.buffer++;
 		cmd->SCp.this_residual = cmd->SCp.buffer->length;
-		cmd->SCp.ptr = cmd->SCp.buffer->address;
+		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 	    }
 	}
 	/* Now check to see if the drive is ready to comunicate */
@@ -923,14 +923,14 @@
 	    /* if many buffers are available, start filling the first */
 	    cmd->SCp.buffer = (struct scatterlist *) cmd->request_buffer;
 	    cmd->SCp.this_residual = cmd->SCp.buffer->length;
-	    cmd->SCp.ptr = cmd->SCp.buffer->address;
+	    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 	} else {
 	    /* else fill the only available buffer */
 	    cmd->SCp.buffer = NULL;
 	    cmd->SCp.this_residual = cmd->request_bufflen;
 	    cmd->SCp.ptr = cmd->request_buffer;
 	}
-	cmd->SCp.buffers_residual = cmd->use_sg;
+	cmd->SCp.buffers_residual = cmd->use_sg - 1;
 	cmd->SCp.phase++;
 
     case 5:			/* Phase 5 - Data transfer stage */

--------------Boundary-00=_DB1K5INPC40A85AQGNEH--
