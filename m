Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264237AbTCXOON>; Mon, 24 Mar 2003 09:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264239AbTCXOOL>; Mon, 24 Mar 2003 09:14:11 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:28688 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264237AbTCXOOJ>;
	Mon, 24 Mar 2003 09:14:09 -0500
Date: Mon, 24 Mar 2003 15:25:15 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Message-ID: <20030324142515.GA10462@win.tue.nl>
References: <Pine.LNX.4.44.0303240023420.9053-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303240023420.9053-100000@serv>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 12:25:57AM +0100, Roman Zippel wrote:

> This patch removes Andries dev patch, which was unfortunately merged.
> It doesn't really help to manage a large number of character devices.

Hi Roman -

It still looks like you do not understand the purpose of these patches.
First of all, it is a series - code is morphed into a more desirable
state; at each point in time there are imperfections, and some of these
disappear the next stage.
The first goal is not at all handling many devices. The first goal is
having a larger dev_t. Handling many devices comes after that.

The patch that you want to revert made the kernel source and binary smaller,
made chardev handling more efficient, and enables stuff impossible so far.
But if you need hundreds of regions on the same major, yes, then this very
simplistic hash scheme requires some further work.
This is not important today.

> unregister_chrdev() function is buggy
> There is no unregister_chrdev_region function.

True. This interface that you write all your letters against is for me
just something uninteresting, something temporary, a stage we pass through.
But if you want, you can so very easily fix these particular flaws:

int unregister_chrdev(unsigned int major, const char *name)
{
        return unregister_chrdev_region(major, 0, 256, name);
}

int unregister_chrdev_region(unsigned int major, unsigned int baseminor,
                             int minorct, const char *name)
...
                if ((*cp)->major == major &&
                    (*cp)->baseminor == baseminor &&
                    (*cp)->minorct == minorct)
                        break;

together with the appropriate invocation in tty_unregister_driver()
(causing a nice cleanup there).

[Now that you complained about this, I made this change in my tree -
may submit it against 2.5.66 or so.]

> Dynamic majors have to be allocated from a fixed range

I entirely agree, and already in ancient l-k posts you can see that that
is what I do myself. But we are in transition, and dev_t has not yet
become larger, so this big free fixed range is not yet available.
We are going there, LV.

Andries

