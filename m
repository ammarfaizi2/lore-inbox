Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVBDBi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVBDBi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVBDB2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:28:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61405 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261800AbVBDBLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:11:06 -0500
Date: Thu, 3 Feb 2005 17:11:04 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [UPDATE PATCH]: include/jiffies: fix  usecs_to_jiffies()/jiffies_to_usecs() math
Message-ID: <20050204011104.GC2635@us.ibm.com>
References: <1107446835.7087.8.camel@levlinux.boston.bmc.com> <20050203184805.GA2635@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203184805.GA2635@us.ibm.com>
X-Operating-System: Linux 2.6.10-mts (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:48:05AM -0800, Nishanth Aravamudan wrote:
> On Thu, Feb 03, 2005 at 10:07:15AM -0600, Makhlis, Lev wrote:
> > Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > 
> > > +static inline unsigned long usecs_to_jiffies(const unsigned int u)
> > > +{
> > > +	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
> > > +		return MAX_JIFFY_OFFSET;
> > > +#if HZ <= 1000 && !(1000 % HZ)
> > > +	return (u + (1000000 / HZ) - 1000) / (1000000 / HZ);
> > > +#elif HZ > 1000 && !(HZ % 1000)
> > > +	return u * (HZ / 1000000);
> > > +#else
> > > +	return (u * HZ + 999999) / 1000000;
> > > +#endif
> > > +}
> > 
> > Shouldn't this use 1000000 instead of 1000 everywhere?
> > It returns 0 if HZ=10000.
> 
> Thanks for your feedback!
> 
> I believe you are correct... Thanks for catching this! This ends up also being a
> problem for jiffies_to_usecs() actually, as it improperly converts certain
> values as it is coded. The attached patch, which overrides the previous one
> seems to be more correct. Andrew, if you would prefer an incremental patch,
> please let me know.
> 
> Description: Add a usecs_to_jiffies() function. With the potential for dynamic HZ

As was kindly pointed out to me, usecs_to_jiffies() has already exists! :) The
currently included patch is for 2.6.11-rc3 and fixes the math in that version.

Thanks,
Nish

Description: Fixes the math of both jiffies_to_usecs() and usecs_to_jiffies()
which improperly assume the same rounding point -- 1,000 -- as jiffies_to_msecs()
and msecs_to_jiffies(), when in fact it should be 1,000,000. Furthermore, the
actual math of both functions is actually wrong and will lead to more than just
rounding errors.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-kj-v/include/linux/jiffies.h	2005-02-03 17:05:13.000000000 -0800
+++ 2.6.11-rc3-kj/include/linux/jiffies.h	2005-02-03 17:01:48.000000000 -0800
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
@@ -291,9 +291,9 @@ static inline unsigned long usecs_to_jif
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
-#if HZ <= 1000 && !(1000 % HZ)
-	return (u + (1000000 / HZ) - 1000) / (1000000 / HZ);
-#elif HZ > 1000 && !(HZ % 1000)
+#if HZ <= 1000000 && !(1000000 % HZ)
+	return (u + (1000000 / HZ) - 1) / (1000000 / HZ);
+#elif HZ > 1000000 && !(HZ % 1000000)
 	return u * (HZ / 1000000);
 #else
 	return (u * HZ + 999999) / 1000000;
