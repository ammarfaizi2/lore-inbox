Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWDEWVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWDEWVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWDEWVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:21:04 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:33388 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932105AbWDEWVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:21:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hGbqHJ6CakrkL4SU+joQMEFvrL2DBK9CLudo1e9164FQCUsTmxHzvaZbunSCQIzbAV4xEx1RlUQjlb7Qkp84liWz/fuUHmcLc0x1ZBWRE0MTzrt05p8cYa1CDxhIg6T1rF3HTCH5TQqw0s/gRRBjy4vlbwEXrDhkdbH37YOtk+U=
Message-ID: <bda6d13a0604051521o229de77dvb38992d6427a450c@mail.gmail.com>
Date: Wed, 5 Apr 2006 15:21:01 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: readers-writers mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are moving from semaphores to mutex, there should be a
mutex_rw. I had a try
at creating one (might as well convert from sem_rw). I'll bet somebody
here can do a
lot better, but this will do if need be.

--- linux-2.6.16.1-stock/include/linux/mutex_rw.h       1969-12-31
16:00:00.000000000 -0800
+++ linux-2.6.16.1-nvl/include/linux/mutex_rw.h 2006-04-04
18:11:56.000000000 -0700
@@ -0,0 +1,60 @@
+/* Linux RW mutex
+ * This file: GNU GPL v2 or later, Joshua Hudson <joshudson@gmail.com>
+ *
+ * Somebody else can make this fast. I just made this work.
+ *
+ * DANGER! Change of this file will break module binaries if any
+ *  rw mutex is shared between main kernel and modules or between
+ *  modules with a different version.
+ */
+
+#ifndef __KERNEL_MUTEX_RW
+#define __KERNEL_MUTEX_RW
+#ifdef __KERNEL__
+
+#include <linux/mutex.h>
+
+struct rw_mutex {
+       struct mutex r_mutex;
+       struct mutex w_mutex;
+       unsigned n_readers;
+};
+
+static inline void rw_mutex_init(struct rw_mutex *rw)
+{
+       mutex_init(&rw->r_mutex);
+       mutex_init(&rw->w_mutex);
+       rw->n_readers = 0;
+}
+
+static inline void rw_mutex_destroy(struct rw_mutex *rw)
+{
+       mutex_destroy(&rw->r_mutex);
+       mutex_destroy(&rw->w_mutex);
+}
+
+static inline void mutex_lock_w(struct rw_mutex *rw)
+{
+       mutex_lock(&rw->w_mutex);
+}
+
+static inline void mutex_unlock_w(struct rw_mutex *rw)
+{
+       mutex_unlock(&rw->w_mutex);
+}
+
+static inline void mutex_lock_r(struct rw_mutex *rw)
+{
+       mutex_lock(&rw->r_mutex);
+       if (++rw->n_readers == 1)
+               mutex_lock(&rw->w_mutex);
+       mutex_unlock(&rw->r_mutex);
+}
+
+static inline void mutex_unlock_r(struct rw_mutex *rw)
+{
+       mutex_lock(&rw->r_mutex);
+       if (--rw->n_readers == 0)
+               mutex_unlock(&rw->w_mutex);
+       mutex_unlock(&rw->r_mutex);
+}
+
+#endif
+#endif
