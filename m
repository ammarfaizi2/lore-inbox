Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280670AbRKBMyv>; Fri, 2 Nov 2001 07:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280674AbRKBMyl>; Fri, 2 Nov 2001 07:54:41 -0500
Received: from [195.66.192.167] ([195.66.192.167]:25862 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280670AbRKBMyY>; Fri, 2 Nov 2001 07:54:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Benjamin LaHaise <bcrl@redhat.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Date: Fri, 2 Nov 2001 14:46:59 +0000
X-Mailer: KMail [version 1.2]
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
In-Reply-To: <20011101120222.B11773@redhat.com> <Pine.LNX.3.95.1011101125206.1496A-100000@chaos.analogic.com> <20011101133441.E11773@redhat.com>
In-Reply-To: <20011101133441.E11773@redhat.com>
MIME-Version: 1.0
Message-Id: <01110214465900.00784@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 18:34, Benjamin LaHaise wrote:
> > So, if you leave jiffies alone, but bump another variable when it
> > wraps, you get to eat your cake and keep it too.
>
> As Linus pointed out, using casting tricks with a long long will just
> work for this case.  Sounds good to me.

I'm using these dirty tricks often. Too often in fact, it hurts readability
and violates "make it simple if you can" principle.
Look at this diff of "simple" and "optimized" version:

-unsigned long jiffies = INITIAL_JIFFIES;
-unsigned long jiffies_hi = 0;
+/* vda: need to enforce 8 byte alignment - how??? */
+#if defined(__LITTLE_ENDIAN) && (BITS_PER_LONG == 32)
+	unsigned long jiffies = INITIAL_JIFFIES;
+	unsigned long jiffies_hi = 0;
+#elif defined(__BIG_ENDIAN) && (BITS_PER_LONG == 32)
+	unsigned long jiffies_hi = 0;
+	unsigned long jiffies = INITIAL_JIFFIES;
+#elif (BITS_PER_LONG == 64)
+	unsigned long jiffies = INITIAL_JIFFIES;
+#else
+#error Fix me somebody please....
+#endif

...

+	if(++jiffies==0) jiffies_hi++;
+#if defined(__LITTLE_ENDIAN) && (BITS_PER_LONG == 32)
+	(*(unsigned long long*)&jiffies)++;
+#elif defined(__BIG_ENDIAN) && (BITS_PER_LONG == 32)
+	(*(unsigned long long*)&jiffies_hi)++;
+#elif (BITS_PER_LONG == 64)
+	jiffies++;
+#else
+#error Fix me somebody please....
+#endif

Does saving 600 CPU cycles per second (0.000001 of your CPU power)
worth this mess?
I think not. Let's hope gcc will get smarter some day :-)
--
vda
