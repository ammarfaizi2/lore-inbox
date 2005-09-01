Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVIALf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVIALf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVIALf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:35:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37820 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932437AbVIALf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:35:27 -0400
Subject: Re: GFS, what's remaining
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20050901104620.GA22482@redhat.com>
References: <20050901104620.GA22482@redhat.com>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 13:35:23 +0200
Message-Id: <1125574523.5025.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 18:46 +0800, David Teigland wrote:
> Hi, this is the latest set of gfs patches, it includes some minor munging
> since the previous set.  Andrew, could this be added to -mm? there's not
> much in the way of pending changes.
> 
> http://redhat.com/~teigland/gfs2/20050901/gfs2-full.patch
> http://redhat.com/~teigland/gfs2/20050901/broken-out/

+static inline void glock_put(struct gfs2_glock *gl)
+{
+	if (atomic_read(&gl->gl_count) == 1)
+		gfs2_glock_schedule_for_reclaim(gl);
+	gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0,);
+	atomic_dec(&gl->gl_count);
+}

this code has a race

what is gfs2_assert() about anyway? please just use BUG_ON directly everywhere

+static inline int queue_empty(struct gfs2_glock *gl, struct list_head *head)
+{
+	int empty;
+	spin_lock(&gl->gl_spin);
+	empty = list_empty(head);
+	spin_unlock(&gl->gl_spin);
+	return empty;
+}

that looks like a racey interface to me... if so.. why bother locking at all?
+void gfs2_glock_hold(struct gfs2_glock *gl)
+{
+	glock_hold(gl);
+}

eh why?

+struct gfs2_holder *gfs2_holder_get(struct gfs2_glock *gl, unsigned int state,
+				    int flags, int gfp_flags)
+{
+	struct gfs2_holder *gh;
+
+	gh = kmalloc(sizeof(struct gfs2_holder), GFP_KERNEL | gfp_flags);

this looks odd. Either you take flags or you don't.. this looks really half arsed and thus is really surprising 
to all callers


static int gi_skeleton(struct gfs2_inode *ip, struct gfs2_ioctl *gi,
+		       gi_filler_t filler)
+{
+	unsigned int size = gfs2_tune_get(ip->i_sbd, gt_lockdump_size);
+	char *buf;
+	unsigned int count = 0;
+	int error;
+
+	if (size > gi->gi_size)
+		size = gi->gi_size;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	error = filler(ip, gi, buf, size, &count);
+	if (error)
+		goto out;
+
+	if (copy_to_user(gi->gi_data, buf, count + 1))
+		error = -EFAULT;

where does count get a sensible value?

+static unsigned int handle_roll(atomic_t *a)
+{
+	int x = atomic_read(a);
+	if (x < 0) {
+		atomic_set(a, 0);
+		return 0;
+	}
+	return (unsigned int)x;
+}

this is just plain scary.


you'll have to post the rest of your patches if you want anyone to look at them...



