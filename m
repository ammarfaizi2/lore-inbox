Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUJQRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUJQRPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUJQRPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:15:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:55006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266216AbUJQRPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:15:18 -0400
Date: Sun, 17 Oct 2004 10:14:36 -0700
From: Greg KH <greg@kroah.com>
To: Andrew <cmkrnl@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-2.6.9.rc4 lib/kobject.c
Message-ID: <20041017171436.GA23454@kroah.com>
References: <4171EB60.50800@speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4171EB60.50800@speakeasy.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 11:47:44PM -0400, Andrew wrote:
> 
> --- lib/kobject.c.orig    2004-10-16 20:51:01.450973973 -0400
> +++ lib/kobject.c    2004-10-16 21:08:19.961602269 -0400
> @@ -177,6 +177,10 @@ static void kset_hotplug(const char *act
>    envp [i++] = scratch;
>    scratch += sprintf(scratch, "ACTION=%s", action) + 1;
> 
> +    kobj_path = kobject_get_path(kset, kobj, GFP_KERNEL);
> +    if (!kobj_path)
> +        goto exit;
> +

Your email client ate the tabs :(

>    spin_lock(&sequence_lock);
>    seq = sequence_num++;
>    spin_unlock(&sequence_lock);
> @@ -184,10 +188,6 @@ static void kset_hotplug(const char *act
>    envp [i++] = scratch;
>    scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
> 
> -    kobj_path = kobject_get_path(kset, kobj, GFP_KERNEL);
> -    if (!kobj_path)
> -        goto exit;
> -
>    envp [i++] = scratch;
>    scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
> 
> @@ -199,6 +199,13 @@ static void kset_hotplug(const char *act
>        if (retval) {
>            pr_debug ("%s - hotplug() returned %d\n",
>                  __FUNCTION__, retval);
> +            /* decr sequence_num since no event will happen
> +               but only if it is consistent */
> +            spin_lock(&sequence_lock);
> +            if (sequence_num == seq+1)
> +               sequence_num--;
> +            spin_unlock(&sequence_lock);
> +

This could cause the same sequence number to be given to more than one
event.  That would really mess userspace up.  It can handle gaps in
sequence numbers, as long as they are constantly incrementing.

Care to redo this to give out the sequence number as the last thing
before calling call_usermodehelper()?  That should fix the issue, right?

Oh, and this portion of the kernel has been pretty much reworked a lot
recently.  Check out the -mm kernel release for what it now looks like
(and what will be sent to Linus after 2.6.9 is released.)

thanks,

greg k-h
