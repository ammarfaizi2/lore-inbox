Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWIAHYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWIAHYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWIAHYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 03:24:08 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:8165 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964883AbWIAHYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 03:24:06 -0400
Date: Fri, 1 Sep 2006 09:19:54 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 02/16] GFS2: Core locking interface
In-Reply-To: <1157030977.3384.786.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
References: <1157030977.3384.786.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+void gfs2_lm_others_may_mount(struct gfs2_sbd *sdp)

I think this could be 'const struct gfs2_sbd *sdp'. Also in other places, const
would probably be adequate.

>+void gfs2_lm_unmount(struct gfs2_sbd *sdp)

Like here

>+int gfs2_lm_withdraw(struct gfs2_sbd *sdp, char *fmt, ...)

And here.

>+	/* FIXME: suspend dm device so oustanding bio's complete
>+	   and all further io requests fail */

Would you like to fix them beforehand? :)

>+int gfs2_lm_get_lock(struct gfs2_sbd *sdp, struct lm_lockname *name,
>+		     lm_lock_t **lockp)
>+{
>+	int error;
>+	if (unlikely(test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
>+		error = -EIO;
>+	else
>+		error = sdp->sd_lockstruct.ls_ops->lm_get_lock(
>+				sdp->sd_lockstruct.ls_lockspace, name, lockp);
>+	return error;
>+}

How about

{
    int err = -EIO;
    if(likely(!test_bit(...)))
        err = sdp->...
    return err;
}?
Same applies for other similar functions, like

>+unsigned int gfs2_lm_lock(struct gfs2_sbd *sdp, lm_lock_t *lock,
>+			  unsigned int cur_state, unsigned int req_state,
>+			  unsigned int flags)
>+unsigned int gfs2_lm_unlock(struct gfs2_sbd *sdp, lm_lock_t *lock,
>+			    unsigned int cur_state)
>+int gfs2_lm_hold_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char **lvbp)
and others.


>+#if 0
>+void gfs2_lm_sync_lvb(struct gfs2_sbd *sdp, lm_lock_t *lock, char *lvb)
>+{
>+	if (likely(!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
>+		sdp->sd_lockstruct.ls_ops->lm_sync_lvb(lock, lvb);
>+}
>+#endif  /*  0  */

If this is unused, can it be removed?

>+int gfs2_lm_withdraw(struct gfs2_sbd *sdp, char *fmt, ...)
>+__attribute__ ((format(printf, 2, 3)));

Possibly indent the 2nd line a little.

>+static struct list_head lmh_list;
>+static struct mutex lmh_lock;

Is it intended that these do not have an initializer?

>+void __init gfs2_init_lmh(void)
>+{
>+	mutex_init(&lmh_lock);
>+	INIT_LIST_HEAD(&lmh_list);
>+}

I suppose so. If they were initialized statically, this function could possibly
be dropped.

>+typedef void lm_lockspace_t;
>+typedef void lm_lock_t;
>+typedef void lm_fsdata_t;

Try to avoid typedefs for
- simple types like these (int/void/etc.)
- structures

>+typedef void (*lm_callback_t) (lm_fsdata_t *fsdata, unsigned int type,
>+			       void *data);

(Function prototypes are ok for me, because writing it out everytime for
functions with a lot of args is tedious. (For recursive type uses, typedefs are
even necessary.))

>+		if (ret & LM_OUT_CANCELED)
>+			handle_callback(gl, LM_ST_UNLOCKED); /* Lame */

Hm.

>+
>+	} else {
>+		if (gfs2_assert_withdraw(sdp, 0) == -1)
>+			fs_err(sdp, "ret = 0x%.8X\n", ret);
>+	}

If you want, you can drop the {}. In fact, this is just like a "else
if(gfs2_assert..."

>+	if (gl->gl_state == LM_ST_EXCLUSIVE) {
>+		if (glops->go_sync)
>+			glops->go_sync(gl,
>+				       DIO_METADATA | DIO_DATA | DIO_RELEASE);
>+	}

if(gl->gl_state == LM_ST_EXCLUSIVE && glops->go_sync != NULL)
    glops->go_sync(...)

You might want to &&-chain other if()s too, if the if-condition lines do not
get too long. (Note that I am not trying to enforce CodingStyle at all, I am
just giving hints how I would do it.)

>+	while (gl->gl_req_gh != gh &&
>+	       !test_bit(HIF_HOLDER, &gh->gh_iflags) &&
>+	       !list_empty(&gh->gh_list)) {
>+		if (gl->gl_req_bh &&
>+		    !(gl->gl_req_gh &&
>+		      (gl->gl_req_gh->gh_flags & GL_NOCANCEL))) {
>+			spin_unlock(&gl->gl_spin);
>+			gfs2_lm_cancel(gl->gl_sbd, gl->gl_lock);
>+			msleep(100);
>+			spin_lock(&gl->gl_spin);

I'd be a little uncomfortable with the indent scheme used here.

>+	if (gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)) {
>+		spin_lock(&gl->gl_spin);
>+		if (gl->gl_req_gh != gh &&
>+		    !test_bit(HIF_HOLDER, &gh->gh_iflags) &&
>+		    !list_empty(&gh->gh_list)) {
>+			list_del_init(&gh->gh_list);

.

>+int gfs2_glock_nq(struct gfs2_holder *gh)
>+{
...
>+	if (!(gh->gh_flags & GL_ASYNC)) {
>+		error = glock_wait_internal(gh);
>+		if (error == GLR_CANCELED) {
>+			msleep(100);

msleep is a busy-waiter IIRC. Really want to do that - what about some
schedulling?

>+			borked = 1;
>+			serious = error;

This got me a laugh :)

>+static inline int gfs2_glock_is_held_excl(struct gfs2_glock *gl)
>+{
>+	return (gl->gl_state == LM_ST_EXCLUSIVE);
>+}

No need for the ().


Quite a lot of code, phew!


Jan Engelhardt
-- 
