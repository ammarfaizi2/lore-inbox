Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTDOSxA (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTDOSxA 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:53:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28671 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264029AbTDOSw4 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 14:52:56 -0400
Date: Tue, 15 Apr 2003 12:00:00 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Gert Vervoort <gert.vervoort@hccnet.nl>, tconnors@astro.swin.edu.au
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-ID: <20030415120000.A30422@beaverton.ibm.com>
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E99A1E4.30904@hccnet.nl>; from gert.vervoort@hccnet.nl on Sun, Apr 13, 2003 at 07:44:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 07:44:04PM +0200, Gert Vervoort wrote:

Here is a patch against 2.5.67, can you try it out?

I did not compile let alone run with this patch.

We never hold the host_lock while calling the detect function (unlike the
io_request_lock, see the bizzare 2.4 code), so acquiring it inside
ppa_detect is very wrong. I don't know why your scsi scan did not hang.

--- linux-2.5.67/drivers/scsi/ppa.c-orig	Mon Apr  7 10:31:47 2003
+++ linux-2.5.67/drivers/scsi/ppa.c	Tue Apr 15 11:54:34 2003
@@ -219,15 +219,12 @@
 	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
 	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
 	    printk("  happened.\n");
-	    spin_lock_irq(hreg->host_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
-    } else {
-	spin_lock_irq(hreg->host_lock);
+    } else
 	return 1;		/* return number of hosts detected */
-    }
 }
 
 /* This is to give the ppa driver a way to modify the timings (and other
