Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVESUzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVESUzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVESUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:55:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:13258 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261253AbVESUza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:55:30 -0400
Date: Thu, 19 May 2005 15:55:25 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: Re: [updated patch 1/7] BSD Secure Levels: printk overhaul
Message-ID: <20050519205525.GB16215@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 12:39:45PM +0200, Bernd Petrovitsch wrote:
> On Wed, 2005-05-18 at 18:29 -0700, Dave Hansen wrote:
> > On Tue, 2005-05-17 at 10:23 -0500, Michael Halcrow wrote:
> [...]
> > > @@ -198,15 +196,15 @@
> > >  static int seclvl_sanity(int reqlvl)
> > >  {
> > >   if ((reqlvl < -1) || (reqlvl > 2)) {
> > > -         seclvl_printk(1, KERN_WARNING, "Attempt to set seclvl out of "
> > > -                       "range: [%d]\n", reqlvl);
> > > +         seclvl_printk(1, KERN_WARNING "%s: Attempt to set seclvl out "
> > > +                       "of range: [%d]\n", __FUNCTION__, reqlvl);
> >
> > Instead of changing each and every seclvl_printk() call to add
> > __FUNCTION__, why not do this:
> >
> > +static void __seclvl_printk(int verb, const char *fmt, ...)
> > ...
> >
> > #define seclvl_printk(verb, fmt, arg...) \
> >     __seclvl_printk(verb, __FUNCTION__ ": " fmt, arg)
> >
> > It requires that the fmt be a string literal, but it saves a lot
> > of code
> > duplication.  I'm sure there are some more examples of this around
> > as
>
> And it duplicates identical format strings in different functions
> (besides violating another unwritten rule). What about:
> ----  snip  ----
> #define seclvl_printk(verb, fmt, arg...) \
>       __seclvl_printk((verb), "%s: " fmt, __FUNCTION__, arg)
> ----  snip  ----

More than one person has mentioned to me that global rate limiting
does not make as much sense as per message rate limiting.  The
original macro ate up a bit of text area.  The non-patched module
occupies 22701 bytes in my build.  The recent patch, which rate-limits
globally, results in a module size of 18443.  This patch, which
rate-limits on a per message basis, results in a module size of
20733.

Signed-off by: Michael Halcrow <mhalcrow@us.ibm.com

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-19 15:44:25.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-19 15:49:02.000000000 -0500
@@ -102,21 +102,32 @@
 #define MY_NAME "seclvl"
 
 /**
- * This time-limits log writes to one per second.
+ * This time-limits log writes to one per second for every message
+ * type.
  */
-#define seclvl_printk(verb, type, fmt, arg...)			\
-	do {							\
-		if (verbosity >= verb) {			\
-			static unsigned long _prior;		\
-			unsigned long _now = jiffies;		\
-			if ((_now - _prior) > HZ) {		\
-				printk(type "%s: %s: " fmt,	\
-					MY_NAME, __FUNCTION__ ,	\
-					## arg);		\
-				_prior = _now;			\
-			}					\
-		}						\
-	} while (0)
+static void
+__seclvl_printk(unsigned long *_prior, int verb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	unsigned long _now = jiffies;
+	if (time_after(_now, (*_prior) + HZ)) {
+		vprintk(fmt, args);
+	}
+	*_prior = _now;
+	va_end(args);
+}
+
+/**
+ * Breaking the printk up into a macro and a function saves some text
+ * space.
+ */
+#define seclvl_printk(verb, type, fmt, arg...)                    \
+        if (verbosity >= verb ) {                                 \
+                static unsigned long _prior;                      \
+                __seclvl_printk(&_prior, (verb), type "%s: " fmt, \
+		                __FUNCTION__, ## arg);            \
+		}
 
 /**
  * kobject stuff
@@ -711,7 +722,7 @@
 		goto exit;
 	}
 	seclvl_printk(0, KERN_INFO, "seclvl: Successfully initialized.\n");
- exit:
+      exit:
 	if (rc) {
 		printk(KERN_ERR "seclvl: Error during initialization: rc = "
 		       "[%d]\n", rc);

