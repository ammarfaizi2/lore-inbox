Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTIWUQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTIWUP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:15:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:58759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbTIWUOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:14:37 -0400
Date: Tue, 23 Sep 2003 13:14:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, jt@hpl.hp.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923131430.F20572@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/net/irda/irlmp.c]
> [FUNC:  irlmp_open_lsap]
> [LINES: 161-183]
> [VAR:   self]
> START -->
>  161:	self = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
>  162:	if (self == NULL) {
>  163:		ERROR("%s: can't allocate memory", __FUNCTION__);
>  164:		return NULL;
> END -->
>  183:	ASSERT(notify->instance != NULL, return NULL;);

Yes, this is a bug.  Patch below.  Jean, look ok?

thanks,
-chris

===== net/irda/irlmp.c 1.29 vs edited =====
--- 1.29/net/irda/irlmp.c	Sat Sep 20 00:48:35 2003
+++ edited/net/irda/irlmp.c	Tue Sep 23 12:09:02 2003
@@ -178,7 +178,7 @@
 
 	init_timer(&self->watchdog_timer);
 
-	ASSERT(notify->instance != NULL, return NULL;);
+	ASSERT(notify->instance != NULL, goto error;);
 	self->notify = *notify;
 
 	self->lsap_state = LSAP_DISCONNECTED;
@@ -188,6 +188,9 @@
 		       (long) self, NULL);
 
 	return self;
+error:
+	kfree(self);
+	return NULL;
 }
 
 /*
