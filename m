Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVCHBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVCHBzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVCHBvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:51:16 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62392 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261891AbVCHBqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:46:46 -0500
Date: Mon, 7 Mar 2005 17:46:41 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: [UPDATE PATCH 8/many] acrypto: crypto_dev.c
Message-ID: <20050308014641.GA10675@us.ibm.com>
References: <11102278542733@2ka.mipt.ru> <1110227854480@2ka.mipt.ru> <29495f1d0503071440562f054@mail.gmail.com> <20050308021431.1313971a@zanzibar.2ka.mipt.ru> <29495f1d05030714515c44caf2@mail.gmail.com> <20050308022720.023a7a2b@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308022720.023a7a2b@zanzibar.2ka.mipt.ru>
X-Operating-System: Linux 2.6.11 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 02:27:20AM +0300, Evgeniy Polyakov wrote:
> On Mon, 7 Mar 2005 14:51:21 -0800
> Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> 
> > On Tue, 8 Mar 2005 02:14:31 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > On Mon, 7 Mar 2005 14:40:52 -0800
> > > Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> > > 
> > > > On Mon, 7 Mar 2005 23:37:34 +0300, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > > --- /tmp/empty/crypto_dev.c     1970-01-01 03:00:00.000000000 +0300
> > > > > +++ ./acrypto/crypto_dev.c      2005-03-07 20:35:36.000000000 +0300
> > > > > @@ -0,0 +1,421 @@
> > > > > +/*
> > > > > + *     crypto_dev.c
> > > >
> > > > <snip>
> > > >
> > > > > +                       while (atomic_read(&__dev->refcnt)) {
> > 
> > <snip>
> > 
> > > > > +                               set_current_state(TASK_UNINTERRUPTIBLE);
> > > > > +                               schedule_timeout(HZ);
> > > >
> > > > I don't see any wait-queues in the immediate area of this code. Can
> > > > this be an ssleep(1)?
> > > 
> > > Yes, you are right, this loop just spins until all pending sessions
> > > are removed from given crypto device, so it can just ssleep(1) here.
> > 
> > Would you like me to send an incremental patch or will you be changing
> > it yourself?
> 
> That would be nice to see your changes in the acrypto.
> If it will be commited...

Well, here is an incremental patch, then:

Description: Use ssleep() instead of schedule_timeout() to guarantee the
task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-v/acrypto/crypto_dev.c	2005-03-07 17:41:31.000000000 -0800
+++ 2.6.11/acrypto/crypto_dev.c	2005-03-07 17:41:57.000000000 -0800
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 
 #include "acrypto.h"
 
@@ -399,8 +400,7 @@ void crypto_device_remove(struct crypto_
 				 */
 
 				__dev->data_ready(__dev);
-				set_current_state(TASK_UNINTERRUPTIBLE);
-				schedule_timeout(HZ);
+				ssleep(1);
 			}
 
 			dprintk(KERN_ERR "Crypto device %s was unregistered.\n",
