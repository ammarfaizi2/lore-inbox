Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbRETMqW>; Sun, 20 May 2001 08:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261870AbRETMqL>; Sun, 20 May 2001 08:46:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34240 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261861AbRETMp4>;
	Sun, 20 May 2001 08:45:56 -0400
Date: Sun, 20 May 2001 08:45:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: abramo@alsa-project.org, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
        jgarzik@mandrakesoft.com, jsimmons@transvirtual.com,
        linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, pavel@suse.cz,
        torvalds@transmeta.com
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending
 DeviceNumberRegistrants]
In-Reply-To: <UTC200105201232.OAA55488.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105200833270.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001 Andries.Brouwer@cwi.nl wrote:

> > Getting a list of all ioctls in the tree, along with types of their arguments
> > would be a great start. Anyone willing to help with that?
> 
> % man 2 ioctl_list
> 
> gives a very outdated list. Collecting the present list is trivial
> but time-consuming. If anyone does I would be happy if he also
> sent me an updated ioctl_list.2

Andries, I wouldn't call it trivial. Consider the following:
                default:
                        if ((cmd & ~(_IOC_SIZEMASK << _IOC_SIZESHIFT)) == JSIOCGNAME(0)) {
                                int len;
                                if (!dev->name) return 0;
                                len = strlen(dev->name) + 1;
                                if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
                                if (copy_to_user((char *) arg, dev->name, len)) return -EFAULT;
                                return len;
                        }

Real-world example. From drivers/input/joydev.c::joydev_ioctl(). And it's far
from the worst ones - just one I'm currently looking at.

We have ~180 first-order ioctl() methods. Several (my guess would be 8--15)
subsystems of the second order and hell knows how many instances in each
of them. And I'm afraid that we have some third-order families. Each instance
of each family got some ioctls in it. I think that we have several thousands
of these beasts.  And that's several thousands of undocumented system calls
hidden in bowels of sys_ioctl(). Undocumented == for most of them we have
no information of argument types, which arguments are in-, out- or in-out,
which contain pointers to other userland structures, etc.

