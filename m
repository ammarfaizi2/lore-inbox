Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVA0C4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVA0C4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVAZXRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:17:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3265 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262451AbVAZRgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:36:39 -0500
Date: Wed, 26 Jan 2005 09:36:32 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH 19/34]: include/jiffies: add usecs_to_jiffies() function
Message-ID: <20050126173632.GA2758@us.ibm.com>
References: <20050125233750.GI12649@us.ibm.com> <20050125185100.64d5c935.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125185100.64d5c935.akpm@osdl.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 06:51:00PM -0800, Andrew Morton wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >
> > Please consider applying.
> > 
> >  Description: Add a usecs_to_jiffies() function.
> 
> Please cc linux-kernel on things which aren't utterly trivial?

Sorry, Andrew, I actually meant to, but forgot to change the CC line. Sorry for
the noise directly to you.

-Nish

Description: Add a usecs_to_jiffies() function. This will be used in one of my
subsequent patches. With the potential for dynamic HZ values much higher than
1000, we may need to consider times as small as usecs in terms of jiffies.
We have msecs_to_jiffies(), jiffies_to_msecs() and jiffies_to_usecs(), but no
usecs_to_jiffies(). Please check my math.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/include/linux/jiffies.h	2005-01-24 09:34:19.000000000 -0800
+++ 2.6.11-rc2-kj/include/linux/jiffies.h	2005-01-25 13:01:56.000000000 -0800
@@ -287,6 +287,19 @@ static inline unsigned long msecs_to_jif
 #endif
 }
 
+static inline unsigned long usecs_to_jiffies(const unsigned int u)
+{
+	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+#if HZ <= 1000 && !(1000 % HZ)
+	return (u + (1000000 / HZ) - 1000) / (1000000 / HZ);
+#elif HZ > 1000 && !(HZ % 1000)
+	return u * (HZ / 1000000);
+#else
+	return (u * HZ + 999999) / 1000000;
+#endif
+}
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
