Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUBVM36 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 07:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUBVM36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 07:29:58 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:55020 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261238AbUBVM3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 07:29:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
Date: Sun, 22 Feb 2004 13:23:50 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200402201455.25782.arnd@arndb.de> <Pine.GSO.4.58.0402201848380.10845@Juliusz>
In-Reply-To: <Pine.GSO.4.58.0402201848380.10845@Juliusz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402221323.50887.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 February 2004 19:11, Krzysztof Benedyczak wrote:
> On Fri, 20 Feb 2004, Arnd Bergmann wrote:
> > Krzysztof Benedyczak wrote:
> > > +
> > > +struct mq_attr {
> > > +	long	mq_flags;	/* message queue flags			*/
> > > +	long	mq_maxmsg;	/* maximum number of messages		*/
> > > +	long	mq_msgsize;	/* maximum message size			*/
> > > +	long	mq_curmsgs;	/* number of messages currently queued	*/
> > > +};
> > > +
> >
> > Does POSIX mandate that these have to be 'long'? If you can change them
> > all to any of 'int', '__s32' or '__s64', the handlers for 32 bit system
> > call emulation on 64 bit machines will get a lot simpler because the
> > 32 bit user structures are then identical to the 64 bit ones.
>
> Yes, POSIX defines it to longs. And quess that compability issues should
> be handled in kernel?

Yes, compatibility can only be handled in kernel. For each system call
that passes structures with a different layout, you need to do something
like this:

struct compat_mq_attr {
	compat_long_t	mq_flags;
	compat_long_t	mq_maxmsg;
	compat_long_t	mq_msgsize;
	compat_long_t	mq_curmsgs;
};
asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
		const struct compat_mq_attr __user *u_mqstat,
		struct compat_mq_attr __user *u_omqstat)
{
	struct mq_attr mqstat, omqstat;
	mm_segment_t oldfs;
	int err, err2;

	err = get_user(mqstat.mq_flags, &u_mqstat->mq_flags)
	    | get_user(mqstat.mq_maxmsg, &u_mqstat->mq_maxmsgs)
	    | get_user(mqstat.mq_msgsize, &u_mqstat->mq_msgsize)
	    | get_user(mqstat.mq_curmsgs, &u_mqstat->mq_curmsgs);
	if (err)
		return -EFAULT;
	oldfs = get_fs();
	set_fs(KERNEL_DS);
	err2 = sys_mq_getsetattr(mqdes, &mqstat, &omqstat);
	set_fs(old_fs);
	err = get_user(omqstat.mq_flags, &u_omqstat->mq_flags)
	    | get_user(omqstat.mq_maxmsg, &u_omqstat->mq_maxmsgs)
	    | get_user(omqstat.mq_msgsize, &u_omqstat->mq_msgsize)
	    | get_user(omqstat.mq_curmsgs, &u_omqstat->mq_curmsgs);
	if (err)
		return -EFAULT;
	return err2;
}

Nothing difficult here, but slow and avoidable if you have the
structures laid out properly. Normally you can do this with padding,
but that is no good here because 'long' members need sign-extension,
not zero-extension.

	Arnd <><

