Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUBDPkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUBDPkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:40:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:42500 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262598AbUBDPkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:40:49 -0500
Date: Wed, 4 Feb 2004 15:40:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Jim Faulkner <jfaulkne@ccs.neu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG under 2.6.1-mm5
Message-ID: <20040204154044.A19543@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
	Jim Faulkner <jfaulkne@ccs.neu.edu>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0401211708090.15123@denali.ccs.neu.edu> <20040121144804.598c2998.akpm@osdl.org> <20040201190905.GA3873@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040201190905.GA3873@localhost.localdomain>; from arvidjaar@mail.ru on Sun, Feb 01, 2004 at 10:09:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> good. here is extended version that includes the same fix + some
> cleanup. It removes dead code, removes long obsolete attempt to manage
> module refcounting, unifies bdev and cdev - they are treated equal now.
> 
> andrew please consider for -mm for testing.
> 
> More cleanup will follow.


-struct bdev_type
-{
-    dev_t dev;
-};
-
-struct cdev_type
-{
-    struct file_operations *ops;
-    dev_t dev;
-    unsigned char autogen:1;
-};

Okay, this cleanup is nice, but could you separate it from the bugfixes?

+ *	TODO it must be called asynchronously due to the fact
+ *	that devfs is initialized relatively late. Proper way
+ *	is to remove module_init from init_devfs_fs and manually
+ *	call it early enough during system init

What about doing this?  This lazy initialization scheme always
bothere me..

+    /*
+     * FIXME HACK
+     *
+     * make sure that
+     *   d_instantiate always runs under lock
+     *   we release i_sem lock before going to sleep
+     *
+     * unfortunately sometimes d_revalidate is called with
+     * and sometimes without i_sem lock held. The following checks
+     * attempt to deduce when we need to add (and drop resp.) lock
+     * here. This relies on current (2.6.2) calling coventions:
+     *
+     *   lookup_hash is always run under i_sem and is passing NULL
+     *   as nd
+     *
+     *   open(...,O_CREATE,...) calls _lookup_hash under i_sem
+     *   and sets flags to LOOKUP_OPEN|LOOKUP_CREATE
+     *
+     *   all other invocations of ->d_revalidate seem to happen
+     *   outside of i_sem
+     */
+    need_lock = nd &&
+		(!(nd->flags & LOOKUP_CREATE) || (nd->flags & LOOKUP_PARENT));
+
+    if (need_lock)
+	down(&dir->i_sem);

Yikes!  Don't do such hacks, they will stop working sooner or later.
I'd rather add i_sem to all calls to ->d_revalidate in a way that punish
filesystems not having ->d_revalidate than such a hack

