Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRCYMcw>; Sun, 25 Mar 2001 07:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131966AbRCYMcn>; Sun, 25 Mar 2001 07:32:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51861 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131958AbRCYMcf>;
	Sun, 25 Mar 2001 07:32:35 -0500
Date: Sun, 25 Mar 2001 14:31:13 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: Larger dev_t
Cc: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, linux-kernel@vger.kernel.org,
        tytso@MIT.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From torvalds@transmeta.com Sun Mar 25 05:26:51 2001

    On Sat, 24 Mar 2001 Andries.Brouwer@cwi.nl wrote:
    >
    > We need a size, and I am strongly in favor of sizeof(dev_t) = 8;
    > this is already true in glibc.

    The fact that glibc is a quivering mass of bloat, and total and utter crap
    makes you suggest that the Linux kernel should try to be as similar as
    possible?

    Not a very strong argument.

    There is no way in HELL I will ever accept a 64-bit dev_t.

    I don't care one _whit_ about the fact that Ulrich Drepper thinks that
    it's a good idea to make things too large.

Funny.

Now what I wrote is that *I* am strongly in favor of sizeof(dev_t) = 8.
You think that I want bloat - in reality sizeof(dev_t) = 8 makes life
simpler.

My system here has for example in super.c:

static dev_t next_unnamed_device = 0x10000000000ULL;

kdev_t get_unnamed_dev(void) {
        return to_kdev_t(next_unnamed_device++);
}

void put_unnamed_dev(kdev_t dev) {
}

a large name space allows one to omit checking what part can be
reused - reuse is unnecessary. That is also why I use a 64-bit pid:
upon a fork one does not have to search for pids, pgrps, sessions
with a given pid, and getpid() can be

static int get_pid(unsigned long flags) {
	if (flags & CLONE_PID)
		return current->pid;
	spin_lock(&lastpid_lock);
	++last_pid;
	spin_unlock(&lastpid_lock);
	return last_pid;
}

fast, simple, avoiding obscure security problems.
Yes, a large name space makes life simpler.

Now concerning this dev_t:
Outside the kernel we have glibc and it is 64 bits.
Inside the kernel we have a pointer to a device struct.
The kernel idea of the size of dev_t only plays a role
on the system call interface.

Really, I see no advantages at all restricting the interface
to something smaller than what user space and kernel use.
And saying "12 bits is enough for a major" somehow sounds funny.

Andries
