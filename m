Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129626AbQKZNwS>; Sun, 26 Nov 2000 08:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129873AbQKZNwI>; Sun, 26 Nov 2000 08:52:08 -0500
Received: from mailb.telia.com ([194.22.194.6]:21011 "EHLO mailb.telia.com")
        by vger.kernel.org with ESMTP id <S129626AbQKZNv5>;
        Sun, 26 Nov 2000 08:51:57 -0500
From: Anders Torger <torger@ludd.luth.se>
Reply-To: torger@ludd.luth.se
Organization: -
To: linux-kernel@vger.kernel.org
Subject: How to transfer memory from PCI memory directly to user space safely and portable?
Date: Sun, 26 Nov 2000 14:21:31 +0100
X-Mailer: KMail [version 1.1.61]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00112614213105.05228@paganini>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm writing a sound card driver where I need to transfer memory from the card 
to user space using the CPU. Ideally I'd like to do that without needing to 
have an intermediate buffer in kernel memory. I have implemented the copy 
functions like this:

>From user space to the sound card:

	if (verify_area(VERIFY_READ, user_space_src, count) != 0) {
	    return -EFAULT;
	}
	memcpy_toio(iobase, user_space_src, count);
	return 0;

>From the sound card to user space:

	if (verify_area(VERIFY_WRITE, user_space_dst, count) != 0) {
	    return -EFAULT;
	}
	memcpy_fromio(user_space_dst, iobase, count);
	return 0;


These functions are called on the behalf of the user, so the current process 
should be the correct one. The iobase is ioremapped: 

	iobase = ioremap(sound_card_port, sound_card_io_size);

Now, this code works, I have a working driver. However, some questions have 
been raised about the code, namely the following:

1. What happens if the user space memory is swapped to disk? Will 
verify_area() make sure that the memory is in physical RAM when it returns, 
or will it return -EFAULT, or will something even worse happen?

2. Is this code really portable? I currently have an I386 architecture, and I 
could use copy_to/from_user on that instead, but that is not portable. Now, 
by using memcpy_to/fromio instead, is this code fully portable?

3. Will the current process always be the correct one? The copy functions is 
directly initiated by the user, and not through an interrupt, so I think the 
user space mapping will always be to the correct process. Is that correct?

Since I'm not on the list, I'd like to have answers CC'd to my address. Thank 
you.

/Anders Torger
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
