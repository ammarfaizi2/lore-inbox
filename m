Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWGYS3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWGYS3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWGYS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:29:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29125 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751470AbWGYS3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:29:21 -0400
Subject: Re: [RFC PATCH 28/33] Add Xen grant table support
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       xen-ppc-devel <xen-ppc-devel@lists.xensource.com>
In-Reply-To: <20060718091956.905130000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091956.905130000@sous-sol.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 25 Jul 2006 13:30:04 -0500
Message-Id: <1153852204.5665.10.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:

> +int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
> +{
> +	u16 flags, nflags;
> +
> +	nflags = shared[ref].flags;
> +	do {
> +		if ((flags = nflags) & (GTF_reading|GTF_writing)) {
> +			printk(KERN_ALERT "WARNING: g.e. still in use!\n");
> +			return 0;
> +		}
> +	} while ((nflags = synch_cmpxchg(&shared[ref].flags, flags, 0)) !=
> +		 flags);
> +
> +	return 1;
> +}

>From patch 06/33:
+/*
+ * A grant table comprises a packed array of grant entries in one or
more
+ * page frames shared between Xen and a guest.
+ * [XEN]: This field is written by Xen and read by the sharing guest.
+ * [GST]: This field is written by the guest and read by Xen.
+ */
+struct grant_entry {
+    /* GTF_xxx: various type and flag information.  [XEN,GST] */
+    uint16_t flags;
+    /* The domain being granted foreign privileges. [GST] */
+    domid_t  domid;
+    /*
+     * GTF_permit_access: Frame that @domid is allowed to map and
access. [GST]
+     * GTF_accept_transfer: Frame whose ownership transferred by
@domid. [XEN]
+     */
+    uint32_t frame;
+};

I object to these uses of (synch_)cmpxchg on a uint16_t in common code.
Many architectures, including PowerPC, do not support 2-byte atomic
operations, but this code is common to all Xen architectures.

-- 
Hollis Blanchard
IBM Linux Technology Center

