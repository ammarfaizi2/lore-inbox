Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265293AbSJXCzs>; Wed, 23 Oct 2002 22:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265294AbSJXCzs>; Wed, 23 Oct 2002 22:55:48 -0400
Received: from mail.eskimo.com ([204.122.16.4]:21007 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S265293AbSJXCzr>;
	Wed, 23 Oct 2002 22:55:47 -0400
Date: Wed, 23 Oct 2002 20:01:43 -0700
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] CONFIG_TINY
Message-ID: <20021024030143.GA13661@eskimo.com>
References: <20021023215117.A29134@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023215117.A29134@jaquet.dk>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 09:51:17PM +0200, Rasmus Andersen wrote:
> Hi,
> 
> Inspired by the recent lowmem threads on l-k and in loose
> conjunction with acme, I am trying to do a CONFIG_TINY
> patchset which would reduce the kernel image size and memory
> footprint. Below is my list of ideas, collected from the
> aforementioned threads and from acme's input. Note that some
> of these are already being persued by other people (notably
> [by me] Andrew Morton).
> 
> [...]
>
> o reduce usage of prinkt in kernel by #defining iprintk for
>   INFO messages etc and let the desired (minimum) logging 
>   level be decided at compile time.

Instead of doing it this way, why not use a preprocessor scheme like
this one which doesn't require you to patch anything (my apologies for
it being somewhat obtuse):

#define DBG_LVL 1
#define UNTAGGED_DBG_LVL 0

#define KERN_MSG_LVL 5
#define KERN_MSG_STRING "<5>"


#define printk(a, arg...) do { \
        { \
		if(DBG_LVL < UNTAGGED_DBG_LVL) \
			switch(UNTAGGED_DBG_LVL) { \
				default: \
					_printk("" a, ##arg); \
			} \
		} \
	} while(0)

#define KERN_WARNING 				); \
				case UNTAGGED_DBG_LVL: \
			} \
			if(DBG_LVL < KERN_MSG_LVL) { \
				_printk(KERN_MSG_STRING


(Yes, I enjoyed writing these macros)

The strings themselves will still be included, but you should be able to
run a string pruning program on the output objects since there is no
longer any reference to them at all.

Does this make more sense?  Maintaining a patch that changes all the
printks in the world is going to hurt!

-J
