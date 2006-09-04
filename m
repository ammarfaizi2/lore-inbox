Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWIDI42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWIDI42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIDI42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:56:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751244AbWIDI41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:56:27 -0400
Subject: Re: [PATCH 02/16] GFS2: Core locking interface
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
References: <1157030977.3384.786.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Sep 2006 10:01:37 +0100
Message-Id: <1157360497.3384.888.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-09-01 at 09:19 +0200, Jan Engelhardt wrote:
> >+void gfs2_lm_others_may_mount(struct gfs2_sbd *sdp)
> 
> I think this could be 'const struct gfs2_sbd *sdp'. Also in other places, const
> would probably be adequate.
> 
> >+void gfs2_lm_unmount(struct gfs2_sbd *sdp)
> 
> Like here
> 
> >+int gfs2_lm_withdraw(struct gfs2_sbd *sdp, char *fmt, ...)
> 
> And here.
> 
Unfortunately thats not possible as the struct gfs2_sbd is actually
changed lower down the call chain, but only in the lock_dlm module.

> >+	/* FIXME: suspend dm device so oustanding bio's complete
> >+	   and all further io requests fail */
> 
> Would you like to fix them beforehand? :)
> 
Well we have a patch that we've been discussing recently. The question
has been how to avoid making GFS2 depend on dm. This function is not
required for using GFS2 as a local filesystem at all, its only required
for the cluster case and it allows for withdrawing a node gracefully
without fencing it. Its not an essential feature, but a "nice to have"
and it will probably be fixed up fairly shortly.

> >+int gfs2_lm_get_lock(struct gfs2_sbd *sdp, struct lm_lockname *name,
> >+		     lm_lock_t **lockp)
> >+{
> >+	int error;
> >+	if (unlikely(test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
> >+		error = -EIO;
> >+	else
> >+		error = sdp->sd_lockstruct.ls_ops->lm_get_lock(
> >+				sdp->sd_lockstruct.ls_lockspace, name, lockp);
> >+	return error;
> >+}
> 
> How about
> 
> {
>     int err = -EIO;
>     if(likely(!test_bit(...)))
>         err = sdp->...
>     return err;
> }?
> Same applies for other similar functions, like
> 
Ok, all changed now.

> >+#if 0
> >+void gfs2_lm_sync_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char *lvb)
> >+{
> >+	if (likely(!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
> >+		sdp->sd_lockstruct.ls_ops->lm_sync_lvb(lock, lvb);
> >+}
> >+#endif  /*  0  */
> 
> If this is unused, can it be removed?
Yes, now done.

> 
> >+int gfs2_lm_withdraw(struct gfs2_sbd *sdp, char *fmt, ...)
> >+__attribute__ ((format(printf, 2, 3)));
> 
> Possibly indent the 2nd line a little.
> 
> >+static struct list_head lmh_list;
> >+static struct mutex lmh_lock;
> 
> Is it intended that these do not have an initializer?
> 
> >+void __init gfs2_init_lmh(void)
> >+{
> >+	mutex_init(&lmh_lock);
> >+	INIT_LIST_HEAD(&lmh_list);
> >+}
> 
> I suppose so. If they were initialized statically, this function could possibly
> be dropped.
> 
Ok. Now done.

> >+typedef void lm_lockspace_t;
> >+typedef void lm_lock_t;
> >+typedef void lm_fsdata_t;
> 
> Try to avoid typedefs for
> - simple types like these (int/void/etc.)
> - structures
> 
I'll talk to Dave Teigland and we'll try and fix this shortly.

> >+typedef void (*lm_callback_t) (lm_fsdata_t *fsdata, unsigned int type,
> >+			       void *data);
> 
> (Function prototypes are ok for me, because writing it out everytime for
> functions with a lot of args is tedious. (For recursive type uses, typedefs are
> even necessary.))
> 
> >+		if (ret & LM_OUT_CANCELED)
> >+			handle_callback(gl, LM_ST_UNLOCKED); /* Lame */
> 
> Hm.
> 
I'm not sure what the comment is referring to - the code looks fine to
me, so I've removed the comment since its confusing.

[various other style comments snipped]

The other changes you suggest have all be done in the latest patch:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=5029996547a9f3988459e11955c13259495308ef

> 
> >+int gfs2_glock_nq(struct gfs2_holder *gh)
> >+{
> ...
> >+	if (!(gh->gh_flags & GL_ASYNC)) {
> >+		error = glock_wait_internal(gh);
> >+		if (error == GLR_CANCELED) {
> >+			msleep(100);
> 
> msleep is a busy-waiter IIRC. Really want to do that - what about some
> schedulling?
> 
This very rarely happens, its on the failure path rather than something
that you'd see during normal operation. As Ingo says, its a scheduling
based wait. You could argue that we ought to use an exponential back-off
rather than a fixed delay, but it seems to work fine in practice and has
the advantage of being simple.

> >+			borked = 1;
> >+			serious = error;
> 
> This got me a laugh :)
> 
Well I think thats a Ken Preslan original variable name - I can't take
credit for that one :-)

> >+static inline int gfs2_glock_is_held_excl(struct gfs2_glock *gl)
> >+{
> >+	return (gl->gl_state == LM_ST_EXCLUSIVE);
> >+}
> 
> No need for the ().
> 
> 
> Quite a lot of code, phew!
> 
> 
> Jan Engelhardt

The glock code is the largest single file in GFS2. I'm looking at ways
of reducing that a bit over the medium term as I think that ought to be
possible. The main thing which that requires is looking at how we deal
with cached locks. I'd also like to use RCU for the glock hash table
eventually as well,

Steve.



-- 
VGER BF report: U 0.5
