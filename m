Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273066AbRIOVXB>; Sat, 15 Sep 2001 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273072AbRIOVWv>; Sat, 15 Sep 2001 17:22:51 -0400
Received: from c1890829-a.stcla1.sfba.home.com ([24.5.220.226]:36617 "HELO
	luban.org") by vger.kernel.org with SMTP id <S273066AbRIOVWr>;
	Sat, 15 Sep 2001 17:22:47 -0400
Message-ID: <3BA3C61A.DED5A27A@luban.org>
Date: Sat, 15 Sep 2001 14:20:27 -0700
From: Vitaly Luban <vitaly@luban.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock_bh() usage check, please (was: [PATCH][RFC] Signal-per-fd 
 for RT signals)
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org> <3BA2E99A.1134E382@kegel.com> <3BA350A7.7D39FC23@kegel.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

> so it crashes on a uniprocessor system when an interrupt that
> causes a sigio comes in while the process was busy expanding its
> file table, to wit:

I'm checking that. My variant of patch will be posted tomorrow, after I'll
finish testing it. It will be against 2.4.9 and addresses all crashes you've
mentioned.


>
> p.s. The bug was introduced by Luban's one-signal-per-fd patch; I ran into
> it while running my variant of his patch, http://www.kegel.com/linux/onefd-dank.patch
> My variant makes the following changes:
> * it fixes an oops related to 'task->files' being null during SIGINT
> * it fixes two oopses related to signal queue overflow
> * it keeps poll data, not pointers, in struct file.  This saves space
>   and makes the consequence of screwing up less severe.
> * it overloads an existing struct file field to avoid the space penalty;
>   it doesn't bloat struct file.
> * it assumes that it's better to keep the kernel uncluttered, so it
>   changes the meaning of siginfo.si_code rather than introduces new ioctl's.
>   (I hear the Austin draft of the Posix single unix spec is deleting all mention
>    of SIGIO, so it looks like we're free to 'improve' that interface freely
>    once Austin becomes the law of the land :-)

I'm reluctant to make such changes, like f_error field overloading because
a) it may backbite in future if you'll use this mechanism for all I/O and not only
sockets,
since you are interfering with it's legitimate usage, in short, it makes patch more
dependent of possible kernel code changes
b) I want the default kernel behavior to be exactly the same, as if without this
patch, thus additional fcntl to control this feature. If you do not activate it, you
don't get it,

Keeping pointer allows for additional sanity check to make sure I'm not screwed,
and cheap update events information in siginfo.
Keeping interests strips you of this ability. And also, you have to have additional
method of gettong events information in user space, because you are not updating
siginfo,
and cannot rely on it anymore. So, to utilize signal per fd feature you have to modify
event loop and not file descriptor setup, which I'd also try to avoid.

Thanks,
    Vitaly.


