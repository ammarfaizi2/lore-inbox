Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVEELiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVEELiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVEELiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:38:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262039AbVEELhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:37:35 -0400
Date: Thu, 5 May 2005 12:37:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH 3/3] add open iscsi netlink interface to iscsi transport class
Message-ID: <20050505113734.GA8985@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	netdev <netdev@oss.sgi.com>
References: <42798ADD.5070803@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42798ADD.5070803@cs.wisc.edu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Mike, can you please insert the patches inline?  I hate needing to save
 attachment first to be able to comment on the patch]

- * Copyright (C) Mike Christie, 2004
+ * Copyright (C) Mike Christie, Dmitry Yusupov, Alex Aizman, 2004 - 2005

should probably be separate Copyright lines for everyone involved.

+static struct iscsi_transport *transport_table[ISCSI_TRANSPORT_MAX];

please avoid static limits for the number of transports, e.g. use the
lib/idr.c helpers.

+static DECLARE_MUTEX(callsema);

horrible name for a lock, even a static one.

+
+struct mempool_zone {
+	mempool_t *pool;
+	volatile int allocated;

don't use volatile, either atomic_t or if it's properly locked just int

+
+#define Z_SIZE_REPLY	NLMSG_SPACE(sizeof(struct iscsi_uevent))
+#define Z_MAX_REPLY	8
+#define Z_HIWAT_REPLY	6
+
+#define Z_SIZE_PDU	NLMSG_SPACE(sizeof(struct iscsi_uevent) + \
+				    sizeof(struct iscsi_hdr) + \
+				    DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH)
+#define Z_MAX_PDU	8
+#define Z_HIWAT_PDU	6
+
+#define Z_SIZE_ERROR	NLMSG_SPACE(sizeof(struct iscsi_uevent))
+#define Z_MAX_ERROR	16
+#define Z_HIWAT_ERROR	12

At least the *_Z_SIZE defines are unneeded, just pass them to the functions
directly.  And please add some explanations for the MAX and HIWAT defines.

+struct iscsi_if_cnx {
+	struct list_head item;		/* item in cnxlist */
+	struct list_head snxitem;	/* item in snx->connections */

please rename cnx to conn and snx to session everywhere, keeps the code
a lot more readable.

+	iscsi_cnx_t cnxh;
+	volatile int active;

volatile usage again

+#define H_TYPE_TRANS	1
+#define H_TYPE_HOST	2
+static struct iscsi_if_cnx*
+iscsi_if_find_cnx(uint64_t key, int type)
+{
+	unsigned long flags;
+	struct iscsi_if_cnx *cnx;
+
+	spin_lock_irqsave(&cnxlock, flags);
+	list_for_each_entry(cnx, &cnxlist, item) {
+		if ((type == H_TYPE_TRANS && cnx->cnxh == key) ||
+		    (type == H_TYPE_HOST && cnx->host == iscsi_ptr(key))) {
+			spin_unlock_irqrestore(&cnxlock, flags);
+			return cnx;
+		}
+	}
+	spin_unlock_irqrestore(&cnxlock, flags);
+	return NULL;
 }

please use two separate helpers for transport/host instead of the H_TYPE
thing.
 
+			list_del((void*)&skb->cb);

please add some inline helpers for using skb->cb as list instead of
spreading the casts all over.

+static int zone_init(struct mempool_zone *zp, unsigned max,
+		     unsigned size, unsigned hiwat)

should probably become mempool_zone_init to match the other functions
operating on struct mempool_zone.

+static int
+iscsi_if_destroy_snx(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	struct Scsi_Host *shost;
+	struct iscsi_if_snx *snx;
+	unsigned long flags;
+	struct iscsi_if_cnx *cnx;
+
+	shost = scsi_host_lookup(ev->u.d_session.sid);
+	if (shost == ERR_PTR(-ENXIO))
+		return -EEXIST;
+	scsi_host_put(shost);

you must keep the reference until you're done.

+	spin_unlock_irqrestore(&cnxlock, flags);
+
+	scsi_remove_host(shost);
+	transport->destroy_session(ev->u.d_session.session_handle);

can we please move the scsi_remove_host into the individual ->destroy_session
methods?  dito for the scsi_host_add

+static int
+iscsi_if_create_cnx(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	struct iscsi_if_snx *snx;
+	struct Scsi_Host *shost;
+	struct iscsi_if_cnx *cnx;
+	unsigned long flags;
+	int error;
+
+	shost = scsi_host_lookup(ev->u.c_cnx.sid);
+	if (shost == ERR_PTR(-ENXIO))
+		return -EEXIST;
+	scsi_host_put(shost);

again, please keep the reference until you're done.

