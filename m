Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJIJhA>; Wed, 9 Oct 2002 05:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbSJIJhA>; Wed, 9 Oct 2002 05:37:00 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:12682 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261432AbSJIJg7>;
	Wed, 9 Oct 2002 05:36:59 -0400
Date: Wed, 9 Oct 2002 11:42:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Maciej Babinski <maciej@imsa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uinput oops in 2.5.41
Message-ID: <20021009114238.A11161@ucw.cz>
References: <20021009035041.A6226@imsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009035041.A6226@imsa.edu>; from maciej@imsa.edu on Wed, Oct 09, 2002 at 03:50:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 03:50:41AM -0500, Maciej Babinski wrote:
> I get a NULL pointer dereference by running "cat" on /dev/misc/uinput
> I'm a newbie, but I think the patch at the bottom fixes it.

> --- linux-2.5.41/drivers/input/misc/uinput.c	Mon Oct  7 13:24:50 2002
> +++ linux-2.5.41.new/drivers/input/misc/uinput.c	Wed Oct  9 03:47:15 2002
> @@ -224,15 +224,14 @@
>  
>  	udev = (struct uinput_device *)file->private_data;
>  
> +	if (!(udev->state & UIST_CREATED))
> +		return -ENODEV;
> +
>  	if (udev->head == udev->tail) {
>  		add_wait_queue(&udev->waitq, &waitq);
>  		current->state = TASK_INTERRUPTIBLE;
>  
>  		while (udev->head == udev->tail) {
> -			if (!(udev->state & UIST_CREATED)) {
> -				retval = -ENODEV;
> -				break;
> -			}
>  			if (file->f_flags & O_NONBLOCK) {
>  				retval = -EAGAIN;
>  				break;

Your patch is almost correct - you have to keep both the checks. The
first could happen when the device disappears while being waited for.

-- 
Vojtech Pavlik
SuSE Labs
