Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266191AbSLISrV>; Mon, 9 Dec 2002 13:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbSLISrV>; Mon, 9 Dec 2002 13:47:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47041 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266191AbSLISrT>;
	Mon, 9 Dec 2002 13:47:19 -0500
Subject: Re: [PATCH] aacraid 2.5
From: Mark Haverkamp <markh@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021207003011.A21628@infradead.org>
References: <1039189541.6401.8.camel@markh1.pdx.osdl.net>
	 <20021207003011.A21628@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1039460128.28649.21.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Dec 2002 10:55:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 16:30, Christoph Hellwig wrote:
> On Fri, Dec 06, 2002 at 07:45:42AM -0800, Mark Haverkamp wrote:
> > +/**
> > + * 	Convert capacity to cylinders
> > + *  	accounting for the fact capacity could be a 64 bit value
> > + *
> > + */
> > +static inline u32 cap_to_cyls(sector_t capacity, u32 divisor)
> > +{
> > +#ifdef CONFIG_LBD
> > +	do_div(capacity, divisor);
> > +#else
> > +	capacity /= divisor;
> > +#endif
> > +	return (u32) capacity;
> > +}
> 
> Please use sector_div() instead.  It exists for a reason.


Thanks for finding this.  I have enclosed a change using your
suggestion.

Mark.


===== drivers/scsi/aacraid/aacraid.h 1.3 vs edited =====
--- 1.3/drivers/scsi/aacraid/aacraid.h	Fri Dec  6 00:30:25 2002
+++ edited/drivers/scsi/aacraid/aacraid.h	Mon Dec  9 08:57:06 2002
@@ -1369,21 +1369,6 @@
 	return (struct hw_fib *)addr;
 }
 
-/**
- * 	Convert capacity to cylinders
- *  	accounting for the fact capacity could be a 64 bit value
- *
- */
-static inline u32 cap_to_cyls(sector_t capacity, u32 divisor)
-{
-#ifdef CONFIG_LBD
-	do_div(capacity, divisor);
-#else
-	capacity /= divisor;
-#endif
-	return (u32) capacity;
-}
-
 const char *aac_driverinfo(struct Scsi_Host *);
 struct fib *fib_alloc(struct aac_dev *dev);
 int fib_setup(struct aac_dev *dev);
===== drivers/scsi/aacraid/linit.c 1.7 vs edited =====
--- 1.7/drivers/scsi/aacraid/linit.c	Fri Dec  6 00:26:58 2002
+++ edited/drivers/scsi/aacraid/linit.c	Mon Dec  9 08:56:43 2002
@@ -443,7 +443,7 @@
 		param->sectors = 32;
 	}
 
-	param->cylinders = cap_to_cyls(capacity,
+	param->cylinders = sector_div(capacity,
 			(param->heads * param->sectors));
 
 	/*
@@ -498,7 +498,7 @@
 			end_sec = first->end_sector & 0x3f;
 		}
 
-		param->cylinders = cap_to_cyls(capacity,
+		param->cylinders = sector_div(capacity,
 				(param->heads * param->sectors));
 
 		if(num < 4 && end_sec == param->sectors)


-- 
Mark Haverkamp <markh@osdl.org>

