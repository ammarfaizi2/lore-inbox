Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWEYOA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWEYOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWEYOA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:00:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030186AbWEYOA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:00:57 -0400
Date: Thu, 25 May 2006 07:00:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi@mandriva.org>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
Message-Id: <20060525070017.16344c97.akpm@osdl.org>
In-Reply-To: <44757246.9010300@mandriva.org>
References: <20060515211229.521198000@gmail.com>
	<20060515211506.783939000@gmail.com>
	<20060517222007.2b606b1b.akpm@osdl.org>
	<44757246.9010300@mandriva.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi@mandriva.org> wrote:
>
>  >>+int input_ff_erase(struct input_dev *dev, int id)
>  >>+{
>  >>+	struct ff_device *ff;
>  >>+	unsigned long flags = 0;
>  >>+	int ret;
>  >>+	if (!test_bit(EV_FF, dev->evbit))
>  >>+		return -EINVAL;
>  >>+	mutex_lock(&dev->ff_lock);
>  >>+	ff = dev->ff;
>  >>+	if (!ff) {
>  >>+		mutex_unlock(&dev->ff_lock);
>  >>+		return -ENODEV;
>  >>+	}
>  >>+	spin_ff_cond_lock(ff, flags);
>  >>+	ret = _input_ff_erase(dev, id, current->pid == 0);
>  >>+	spin_ff_cond_unlock(ff, flags);
>  >>+
>  >>+	mutex_unlock(&dev->ff_lock);
>  >>+	return ret;
>  >>+}
>  > 
>  > 
>  > Perhaps you meant `current->uid == 0' here.  There's no way in which pid
>  > 0 will call this code.
> 
>  Right, a silly mistake.
> 
>  > What's happening here anyway?  Why does this code need to know about pids?
>  > 
>  > Checking for uid==0 woud be a fishy thing to do as well.
> 
>  User ID 0 is allowed to delete effects of other users. Pids are used to
>  keep a track of what process owns what effects. This is the same
>  behaviour as before.

Oh dear.

Whatever we do here should remain 100%-compatible with "before".  Which
rather limits our options.

>  There is a problem with this, though:
>  When a process closes any fd to this device, all pid-matching effects
>  are deleted whether the process has another fd using the device or not.
> 
>  One solution would probably be to add some handle parameter to
>  input_ff_upload() and input_ff_erase(), and then in
>  evdev_ioctl_handler() pass an id unique to this fd. Then effects would
>  be fd-specific, not pid-specific. I think the uid == 0 thing can also be
>  dropped... I don't think the root user needs ability to override user
>  effects (it can delete them anyway, just kill the user process owning
>  the effects).
> 

Generally we use file descriptors (and driver-specific state at
file.f_private) to manage things like that.  But I'd imagine that we
couldn't retain the existing semantics with any such scheme.

A pragmatic approach would be to put a big fat comment in there explaining
how it all works and leave it at that.
