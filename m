Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWJGFnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWJGFnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWJGFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:43:24 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:4290 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751742AbWJGFnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:43:24 -0400
Subject: Re: [PATCH 2/9] sound/oss/dmasound/dmasound_awacs.c: ioremap
	balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061006135410.7b4cdc24.akpm@osdl.org>
References: <1160113133.19143.130.camel@amol.verismonetworks.com>
	 <20061006135410.7b4cdc24.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 11:16:43 +0530
Message-Id: <1160200003.19143.160.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  
> >  #ifdef CONFIG_PM
> >  	pmu_register_sleep_notifier(&awacs_sleep_notifier);
> > @@ -3160,7 +3161,26 @@ printk("dmasound_pmac: Awacs/Screamer Co
> >  	 */
> >  	input_register_device(awacs_beep_dev);
> >  
> > -	return dmasound_init();
> > +	res = dmasound_init();
> > +	if (res)
> > +		goto out_unmap1;
> > +
> > +	return 0;
> > +	
> > +out_unmap1:
> > +	if (is_pbook_3X00)
> > +		iounmap(latch_base);
> > +	else if (is_pbook_g3)
> > +		iounmap(macio_base);
> > +out_unmap:
> > +	if (i2s_node)
> > +		iounmap(i2s);
> > +	else
> > +		iounmap(awacs);
> > +	iounmap(awacs_txdma);
> > +	iounmap(awacs_rxdma);
> > +
> > +	return res;
> >  }
> >  
> >  static void __exit dmasound_awacs_cleanup(void)
> > @@ -3177,8 +3197,19 @@ static void __exit dmasound_awacs_cleanu
> >  			daca_cleanup();
> >  			break;
> >  	}
> > -	dmasound_deinit();
> >  
> > +	if (is_pbook_3X00)
> > +		iounmap(latch_base);
> > +	else if (is_pbook_g3)
> > +		iounmap(macio_base);
> > +	if (i2s_node)
> > +		iounmap(i2s);
> > +	else
> > +		iounmap(awacs);
> > +	iounmap(awacs_txdma);
> > +	iounmap(awacs_rxdma);
> > +
> > +	dmasound_deinit();
> >  }
> >  
> 
> man, this is taxing my attention span to the limit.  It'd be nice if
> someone else could help out with the reviewing here..
> 
> This one could benefit from having a helper function which is called from
> both places.
> 

Sorry for that.

Including a better version

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 dmasound_awacs.c |   36 +++++++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 3 deletions(-)
---
--- linux-2.6.19-rc1-orig/sound/oss/dmasound/dmasound_awacs.c	2006-10-05 14:01:04.000000000 +0530
+++ linux-2.6.19-rc1/sound/oss/dmasound/dmasound_awacs.c	2006-10-07 11:08:54.000000000 +0530
@@ -308,6 +308,9 @@ extern void daca_get_volume(uint * left_
 extern int daca_enter_sleep(void);
 extern int daca_leave_sleep(void);
 
+/*** cleanup ***/
+static void iounmap_awacs(void);
+
 #define TRY_LOCK()	\
 	if ((rc = mutex_lock_interruptible(&dmasound_mutex)) != 0)	\
 		return rc;
@@ -3067,8 +3070,9 @@ printk("dmasound_pmac: Awacs/Screamer Co
 		udelay(1);
 
 	/* Initialize beep stuff */
-	if ((res=setup_beep()))
-		return res ;
+	res=setup_beep();
+	if (res)
+		goto out_unmap;
 
 #ifdef CONFIG_PM
 	pmu_register_sleep_notifier(&awacs_sleep_notifier);
@@ -3160,7 +3164,32 @@ printk("dmasound_pmac: Awacs/Screamer Co
 	 */
 	input_register_device(awacs_beep_dev);
 
-	return dmasound_init();
+	res = dmasound_init();
+	if (res)
+		goto out_unmap;
+
+	return 0;
+
+out_unmap:
+	iounmap_awacs();
+
+	return res;
+}
+
+static void iounmap_awacs(void)
+{
+	if (is_pbook_3X00 && latch_base)
+		iounmap(latch_base);
+	else if (is_pbook_g3 && macio_base)
+		iounmap(macio_base);
+	if (i2s_node)
+		iounmap(i2s);
+	else
+		iounmap(awacs);
+	iounmap(awacs_txdma);
+	iounmap(awacs_rxdma);
+
+	return;
 }
 
 static void __exit dmasound_awacs_cleanup(void)
@@ -3177,6 +3206,7 @@ static void __exit dmasound_awacs_cleanu
 			daca_cleanup();
 			break;
 	}
+	iounmap_awacs();
 	dmasound_deinit();
 
 }


