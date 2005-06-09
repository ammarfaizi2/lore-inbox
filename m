Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVFIP5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVFIP5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVFIP5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:57:43 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:14596 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262021AbVFIP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:57:40 -0400
Date: Thu, 9 Jun 2005 17:57:44 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Greg KH" <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: BUG in i2c_detach_client
Message-Id: <20050609175744.6f950b4f.khali@linux-fr.org>
In-Reply-To: <200506090932.59679.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <JctXv2LZ.1118303243.5186830.khali@localhost>
	<200506090932.59679.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Mystery solved.
> 
> ERROR3:
> 	i2c_detach_client(data->lm75[1]); <-- HERE
> 	i2c_detach_client(data->lm75[0]);
> 	kfree(data->lm75[1]);
> 	kfree(data->lm75[0]);
> 
> The missing i2c_detach_client call meant that data->lm75[1] was still
> on the list of i2c devices when it was freed. This was corrupting the
> list. The ERROR3 path now works on my kernel.

Oh my, I had it right under my nose and didn't see it ;) Thanks for the
clarification.

Greg, please apply the following patch on top of the hwmon patches until
Mark submits an updated version of the whole thing.

----------------------------------

Fix a broken error path in the asb100 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc6/drivers/i2c/chips/asb100.c.orig	Wed Jun  8 09:47:53 2005
+++ linux-2.6.12-rc6/drivers/i2c/chips/asb100.c	Thu Jun  9 11:58:34 2005
@@ -859,6 +859,7 @@
 	return 0;
 
 ERROR3:
+	i2c_detach_client(data->lm75[1]);
 	i2c_detach_client(data->lm75[0]);
 	kfree(data->lm75[1]);
 	kfree(data->lm75[0]);


-- 
Jean Delvare
