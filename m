Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVBCSua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVBCSua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVBCSu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:50:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12681 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263415AbVBCSsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:48:08 -0500
Date: Thu, 3 Feb 2005 10:48:05 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [UPDATE PATCH 19/34]: include/jiffies: add usecs_to_jiffies() function
Message-ID: <20050203184805.GA2635@us.ibm.com>
References: <1107446835.7087.8.camel@levlinux.boston.bmc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107446835.7087.8.camel@levlinux.boston.bmc.com>
X-Operating-System: Linux 2.6.10-mts (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:07:15AM -0600, Makhlis, Lev wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> 
> > +static inline unsigned long usecs_to_jiffies(const unsigned int u)
> > +{
> > +	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
> > +		return MAX_JIFFY_OFFSET;
> > +#if HZ <= 1000 && !(1000 % HZ)
> > +	return (u + (1000000 / HZ) - 1000) / (1000000 / HZ);
> > +#elif HZ > 1000 && !(HZ % 1000)
> > +	return u * (HZ / 1000000);
> > +#else
> > +	return (u * HZ + 999999) / 1000000;
> > +#endif
> > +}
> 
> Shouldn't this use 1000000 instead of 1000 everywhere?
> It returns 0 if HZ=10000.

Thanks for your feedback!

I believe you are correct... Thanks for catching this! This ends up also being a
problem for jiffies_to_usecs() actually, as it improperly converts certain
values as it is coded. The attached patch, which overrides the previous one
seems to be more correct. Andrew, if you would prefer an incremental patch,
please let me know.

Description: Add a usecs_to_jiffies() function. With the potential for dynamic HZ
values much higher than 1000, we may need to consider times as small as usecs in
terms of jiffies. We have msecs_to_jiffies(), jiffies_to_msecs() and
jiffies_to_usecs(), but no usecs_to_jiffies(). Additionally, the
usecs_to_jiffies() conversion is wrong. The function currently is just a linear
translation of the jiffies_to_msecs() macro, but this is incorrect, as it
changes the rounding point. Please check my math.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/include/linux/jiffies.h	2005-01-24 09:34:19.000000000 -0800
+++ 2.6.11-rc2-kj/include/linux/jiffies.h	2005-02-03 10:44:22.000000000 -0800
@@ -265,10 +265,10 @@ static inline unsigned int jiffies_to_ms
 
 static inline unsigned int jiffies_to_usecs(const unsigned long j)
 {
-#if HZ <= 1000 && !(1000 % HZ)
+#if HZ <= 1000000 && !(1000000 % HZ)
 	return (1000000 / HZ) * j;
-#elif HZ > 1000 && !(HZ % 1000)
-	return (j*1000 + (HZ - 1000))/(HZ / 1000);
+#elif HZ > 1000000 && !(HZ % 1000000)
+	return (j + (HZ / 1000000) - 1)/(HZ / 1000000);
 #else
 	return (j * 1000000) / HZ;
 #endif
@@ -287,6 +287,19 @@ static inline unsigned long msecs_to_jif
 #endif
 }
 
+static inline unsigned long usecs_to_jiffies(const unsigned int u)
+{
+	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+#if HZ <= 1000000 && !(1000000 % HZ)
+	return (u + (1000000 / HZ) - 1) / (1000000 / HZ);
+#elif HZ > 1000000 && !(HZ % 1000000)
+	return u * (HZ / 1000000);
+#else
+	return (u * HZ + 999999) / 1000000;
+#endif
+}
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
