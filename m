Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSKUASt>; Wed, 20 Nov 2002 19:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSKUASt>; Wed, 20 Nov 2002 19:18:49 -0500
Received: from auto-matic.ca ([216.209.85.42]:32266 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265063AbSKUASq>;
	Wed, 20 Nov 2002 19:18:46 -0500
Date: Wed, 20 Nov 2002 19:33:33 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021121003332.GE32715@mark.mielke.cc>
References: <20021120235135.GA32715@mark.mielke.cc> <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 03:57:26PM -0800, Davide Libenzi wrote:
> > What were you thinking? 1X64 bit or 2X32 bit?
> typedef union epoll_obj {
> 	void *ptr;
> 	__uint32_t u32[2];
> 	__uint64_t u64;
> } epoll_obj_t;
> I'm open to suggestions though. The "ptr" enable me to avoid wierd casts
> to avoid gcc screaming.

It looks fine to me for as long as we can guarantee that sizeof(void *)
will be less than or equal to sizeof(__uint64_t) (relatively safe).

I still prefer 'userdata' over 'obj', but the name of thing is not very
important to me.

I'm not sure if this is wise or not, but an 'fd' member might be
useful as well:

  typedef union epoll_obj {
  	void *ptr;
        int fd;
  	__uint32_t u32[2];
  	__uint64_t u64;
  } epoll_obj_t;

For applications that wish to store fd's (probably common due to
poll() roots), this would help them avoid casting magic as well. Also,
it allows for 64 bit file descriptors if that ever became necessary.

Since userspace applications are almost guaranteed to need to do casting
or union copying, using the union sounds like a good idea.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

