Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWIRVYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWIRVYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWIRVYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:24:19 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:39834 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964990AbWIRVYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:24:18 -0400
Date: Mon, 18 Sep 2006 23:24:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Alignment of fields in struct dentry
Message-ID: <20060918212423.GB6899@wohnheim.fh-wedel.de>
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <20060914215545.GC6441@schatzie.adilger.int> <20060915102736.GA767@wohnheim.fh-wedel.de> <200609152244.07889.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609152244.07889.arnd@arndb.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 September 2006 22:44:07 +0200, Arnd Bergmann wrote:
> Am Friday 15 September 2006 12:27 schrieb Jörn Engel:
> > -};
> > +}__attribute__((aligned(64))); /* make sure the dentry is 128/192 bytes
> > +                                  on 32/64 bit independently of config
> > +                                  options.  d_iname will vary in length
> > +                                  a bit. */

Wow.  Mutt really didn't like quoting this.

> I'd guess that a 32 byte alignment is much better here, 64 byte sounds
> excessive. It should have the same effect with the current dentry layout
> and default config options, but would keep the d_iname length in the
> 16-44 byte range instead of 16-76 byte as your patch does.
> 
> Since all important fields are supposed to be kept in 32 bytes anyway,
> they are still either at the start or the end of a given cache line,
> but never cross two.

Another take would be to use a cacheline.  But I guess the difference
between 32/64/cacheline is mostly academic, given the rate of changes
to struct dentry.

Unless the minimum length for inline names is configurable, as in the
patch below.  (Note to self: I really should finish my test setup
before posting any further patches without performance numbers.)

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979

--- slab/include/linux/dcache.h~dentry_size	2006-09-14 22:19:51.000000000 +0200
+++ slab/include/linux/dcache.h	2006-09-18 23:22:44.000000000 +0200
@@ -77,8 +77,6 @@ full_name_hash(const unsigned char *name
 
 struct dcookie_struct;
 
-#define DNAME_INLINE_LEN_MIN 36
-
 struct dentry {
 	atomic_t d_count;
 	unsigned int d_flags;		/* protected by d_lock */
@@ -111,8 +109,8 @@ struct dentry {
 	struct dcookie_struct *d_cookie; /* cookie, if any */
 #endif
 	int d_mounted;
-	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
-};
+	unsigned char d_iname[CONFIG_DCACHE_INLINE_LEN]; /* small names */
+}__cacheline_aligned;
 
 /*
  * dentry->d_lock spinlock nesting subclasses:
--- slab/fs/Kconfig~dentry_size	2006-08-11 13:03:43.000000000 +0200
+++ slab/fs/Kconfig	2006-09-18 23:22:44.000000000 +0200
@@ -1931,5 +1931,18 @@ endmenu
 
 source "fs/nls/Kconfig"
 
+config DCACHE_INLINE_LEN
+	int "Length of inline filenames"
+	depends on EXPERIMENTAL
+	default 20
+	help
+	  Filenames up to this length are stored inline in a struct dentry.
+	  For most people something short like 20 is ok.  Developers with
+	  extensive use of git or ccache may want to set this to 38 or 44,
+	  respectively, as those programs create and often access thousands
+	  of files of that length.
+
+	  If unsure, choose 20.
+
 endmenu
 
