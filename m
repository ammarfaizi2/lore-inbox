Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTIWUVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTIWUVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:21:36 -0400
Received: from palrel10.hp.com ([156.153.255.245]:18639 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262188AbTIWUVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:21:33 -0400
Date: Tue, 23 Sep 2003 13:21:32 -0700
To: Chris Wright <chrisw@osdl.org>
Cc: David Yu Chen <dychen@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923202132.GA23796@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030923131430.F20572@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923131430.F20572@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 01:14:30PM -0700, Chris Wright wrote:
> * David Yu Chen (dychen@stanford.edu) wrote:
> > [FILE:  2.6.0-test5/net/irda/irlmp.c]
> > [FUNC:  irlmp_open_lsap]
> > [LINES: 161-183]
> > [VAR:   self]
> > START -->
> >  161:	self = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
> >  162:	if (self == NULL) {
> >  163:		ERROR("%s: can't allocate memory", __FUNCTION__);
> >  164:		return NULL;
> > END -->
> >  183:	ASSERT(notify->instance != NULL, return NULL;);
> 
> Yes, this is a bug.  Patch below.  Jean, look ok?
> 
> thanks,
> -chris

	Yep, looks like the right thing. But, I would prefer a slighly
different fix. Would you mind moving the assert at the top of the
function ?
	Just like this :
--------------------------------------------------------------------
--- linux/net/irda/irlmp.d1.c   Tue Sep 23 13:19:37 2003
+++ linux/net/irda/irlmp.c      Tue Sep 23 13:19:56 2003
@@ -146,6 +146,7 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
        ASSERT(notify != NULL, return NULL;);
        ASSERT(irlmp != NULL, return NULL;);
        ASSERT(irlmp->magic == LMP_MAGIC, return NULL;);
+       ASSERT(notify->instance != NULL, return NULL;);
 
        /*  Does the client care which Source LSAP selector it gets?  */
        if (slsap_sel == LSAP_ANY) {
@@ -178,7 +179,6 @@ struct lsap_cb *irlmp_open_lsap(__u8 sls
 
        init_timer(&self->watchdog_timer);
 
-       ASSERT(notify->instance != NULL, return NULL;);
        self->notify = *notify;
 
        self->lsap_state = LSAP_DISCONNECTED;
--------------------------------------------------------------------

	This is simpler and more efficient ;-)

	Thanks...

	Jean

