Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWDSRGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWDSRGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDSRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:06:53 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:55638 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750983AbWDSRGw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:06:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lF0JZM8lYomsiYHLfBmnQHreD2zzW6Vu9zGwAGtjCR8B9gYmDrQbBINdT3J/AFrXgsHDx5rQa1Zt2ySp86la2lyO0awEcEuqZMVn6CxRI5ae9YYm2qpTJbNHHU51t9ljOU6dYhoylNuAEibBlnE7LbiQnccWnir9gEoUJHf5M5Q=
Message-ID: <82ecf08e0604191006r26d8eab0n2c0a425809dea6ac@mail.gmail.com>
Date: Wed, 19 Apr 2006 14:06:50 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Jim Ramsay" <kernel@jimramsay.com>
Subject: Possible MTD bug in 2.6.15
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <4789af9e0604190949t42677b35mcba4ee57b92ffff9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e0604190949t42677b35mcba4ee57b92ffff9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, a couple of comments/questions

1 - Wouldn't it be better to map all flash, and leave the unneeded
part as read only?

2 - Please follow  Documentation/SubmittingPatches format for sending
patches (especially the signed-off part and sending patches inline)

3 - No C++ style comments, please

Thiago


On 4/19/06, Jim Ramsay <kernel@jimramsay.com> wrote:
> We have an interesting problem with MTD and a flash chip on an
> embedded board.  The problem stems from the fact that due to hardware
> constraints we can only access up to 32M of address space on an
> attached flash device.  However, the actual part attached to the board
> is 64M.  Yes, I know this is not likely to happen, but it points at a
> kernel bug which will happen if you ever specify a MTD map->size which
> is less than the actual size of the CFI flash chip.
>
> When we specify the map->size as 32M (0x02000000) and do the CFI
> probe, the chip is properly detected, but then in gen_probe.c the
> following happens:
>
> - genprobe_ident_chips is run
>   - It sets cfi.chipshift based on the cfi.cfiq->DevSize, which gets
> properly set to 0x1a (64M flash chip).
>   - It then sets the local "max_chips" variable by shifting down
> map->size by this chipshift, which shifts our size (0x02000000 = 32M)
> down all the way to 0.
>   - Since 'max_chips' is zero, no memory is allocated for this chip,
> and the waitqueue is not initialized.  The will cause a kernel panic
> later, if you ever try to read from this chip.
>
> The routine completes and you are left with a seemingly valid MTD
> device.  However, if you ever try to read or write this device, the
> waitqueue is uninitialized, which causes a nasty kernel panic.
>
> My proposed fix is attached (a patch against 2.6.15).  After shifting
> the map->size down by cfi.chipshift, I just ensure that max_chips is
> at least one.  Does this seem like a reasonable fix?
>
> Note: Please CC my email address in reply, as I am not currently
> subscribed to the linux-kernel list.
>
> --
> Jim Ramsay
> "Me fail English?  That's unpossible!"
>
>
>
