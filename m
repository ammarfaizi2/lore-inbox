Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131354AbQKZOZC>; Sun, 26 Nov 2000 09:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131535AbQKZOYw>; Sun, 26 Nov 2000 09:24:52 -0500
Received: from mailf.telia.com ([194.22.194.25]:20754 "EHLO mailf.telia.com")
        by vger.kernel.org with ESMTP id <S131354AbQKZOYf>;
        Sun, 26 Nov 2000 09:24:35 -0500
From: Anders Torger <torger@ludd.luth.se>
Reply-To: torger@ludd.luth.se
Organization: -
To: aprasad@in.ibm.com
Subject: Re: How to transfer memory from PCI memory directly to user space safely and portable?
Date: Sun, 26 Nov 2000 14:54:08 +0100
X-Mailer: KMail [version 1.1.61]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <CA2569A3.004A8A41.00@d73mta05.au.ibm.com>
In-Reply-To: <CA2569A3.004A8A41.00@d73mta05.au.ibm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00112614540807.05228@paganini>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, you wrote:
> >have an intermediate buffer in kernel memory. I have implemented the copy
> >functions like this:
> >
> >From user space to the sound card:
> >
> >    if (verify_area(VERIFY_READ, user_space_src, count) != 0) {
> >        return -EFAULT;
> >    }
> >    memcpy_toio(iobase, user_space_src, count);
> >    return 0;
> >
> >From the sound card to user space:
> >
> >    if (verify_area(VERIFY_WRITE, user_space_dst, count) != 0) {
> >        return -EFAULT;
> >    }
> >    memcpy_fromio(user_space_dst, iobase, count);
> >    return 0;
> >
> >
> >These functions are called on the behalf of the user, so the current
>
> process
>
> >should be the correct one. The iobase is ioremapped:
> >
> >    iobase = ioremap(sound_card_port, sound_card_io_size);

> The best solution will be to let the user mmap the device memory to his
> address space.The driver need to provide the interface through ioctl cmd or
> mmap file operations.

I have learnt that it is not portable to mmap the IO memory, since some 
architectures (for example Alpha) cannot access IO memory the same was as 
physical RAM. That is why I am using memcpy_to/fromio instead of 
copy_to/from_user. If I am correctly informed, when mmaping is used, the card 
use to have some sort of DMA mechanism, so the mmaping is done on ordinary 
RAM, not IO memory. Unfortunately, on this sound card (RME Audio Digi96), I 
have to access the on-board buffers directly, using the CPU. Thus, to be 
portable, I cannot use mmap directly on the ioremap'd memory, right?

/Anders Torger
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
