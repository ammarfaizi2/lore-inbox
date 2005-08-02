Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVHBHpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVHBHpt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVHBHpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:45:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65170 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261411AbVHBHpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:45:46 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <20050802071828.GA11217@redhat.com>
References: <20050802071828.GA11217@redhat.com>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 09:45:24 +0200
Message-Id: <1122968724.3247.22.camel@laptopd505.fenrus.org>
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

On Tue, 2005-08-02 at 15:18 +0800, David Teigland wrote:
> Hi, GFS (Global File System) is a cluster file system that we'd like to
> see added to the kernel.  The 14 patches total about 900K so I won't send
> them to the list unless that's requested.  Comments and suggestions are
> welcome.  Thanks
> 
> http://redhat.com/~teigland/gfs2/20050801/gfs2-full.patch
> http://redhat.com/~teigland/gfs2/20050801/broken-out/

* The on disk structures are defined in terms of uint32_t and friends,
which are NOT endian neutral. Why are they not le32/be32 and thus
endian-defined? Did you run bitwise-sparse on GFS yet ?

* None of your on disk structures are packet. Are you sure?

* 
+#define gfs2_16_to_cpu be16_to_cpu
+#define gfs2_32_to_cpu be32_to_cpu
+#define gfs2_64_to_cpu be64_to_cpu

why this pointless abstracting?

* +static const uint32_t crc_32_tab[] = .....

why do you duplicate this? The kernel has a perfectly good set of generic crc32 tables/functions just fine

* Why are you using bufferheads extensively in a new filesystem?

* +	if (create)
+		down_write(&ip->i_rw_mutex);
+	else
+		down_read(&ip->i_rw_mutex);

why do you use a rwsem and not a regular semaphore? You are aware that rwsems are far more expensive than regular ones right?
How skewed is the read/write ratio?

* Why use your own journalling layer and not say ... jbd ?

* +	while (!kthread_should_stop()) {
+		gfs2_scand_internal(sdp);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(gfs2_tune_get(sdp, gt_scand_secs) * HZ);
+	}

you probably really want to check for signals if you do interruptible sleeps
(multiple places)

* why not use msleep() and friends instead of schedule_timeout(), you're not using the complex variants anyway

* +++ b/fs/gfs2/fixed_div64.h	2005-08-01 14:13:08.009808200 +0800

ehhhh why?

* int gfs2_copy2user(struct buffer_head *bh, char **buf, unsigned int offset,
+		   unsigned int size)
+{
+	int error;
+
+	if (bh)
+		error = copy_to_user(*buf, bh->b_data + offset, size);
+	else
+		error = clear_user(*buf, size);

that looks to be missing a few kmaps.. whats the guarantee that b_data is actually, like in lowmem?

* [PATCH 08/14] GFS: diaper device

The diaper device is a block device within gfs that gets transparently
inserted between the real device the and rest of the filesystem.

hmmmm why not use device mapper or something? Is this really needed? Should it live in drivers/block ? Doesn't
this wrapper just increase the risk for memory deadlocks?

* [PATCH 06/14] GFS: logging and recovery

quoting the ren and stimpy show is nice.. but did the ren ans stimpy authors agree to license their stuff under the GPL?


* do_lock_wait

that almost screams for using wait_event and related APIs


*
+static inline void gfs2_log_lock(struct gfs2_sbd *sdp)
+{
+	spin_lock(&sdp->sd_log_lock);
+}
why the abstraction ?



