Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbREUWXJ>; Mon, 21 May 2001 18:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262511AbREUWW6>; Mon, 21 May 2001 18:22:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14589 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262515AbREUWWn>;
	Mon, 21 May 2001 18:22:43 -0400
Date: Mon, 21 May 2001 18:22:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.LNX.4.31.0105211503560.10331-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105211814130.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Linus Torvalds wrote:

> It shouldn't be impossible to do the same thing to ioctl numbers. Nastier,
> yes. No question about it. But we don't necessarily have to redesign the
> whole approach - we only want to re-design the internal kernel interfaces.
> 
> That, in turn, might be as simple as changing the ioctl incoming arguments
> of <cmd,arg> into a structure like <type,cmd,inbuf,inlen,outbuf,outlen>.

drivers/net/ppp_generic.c:
ppp_set_compress(struct ppp *ppp, unsigned long arg)
{
        int err;
        struct compressor *cp;
        struct ppp_option_data data;
        void *state;
        unsigned char ccp_option[CCP_MAX_OPTION_LENGTH];
#ifdef CONFIG_KMOD
        char modname[32];
#endif

        err = -EFAULT;
        if (copy_from_user(&data, (void *) arg, sizeof(data))
            || (data.length <= CCP_MAX_OPTION_LENGTH
                && copy_from_user(ccp_option, data.ptr, data.length)))
                goto out;

And that's far from being uncommon. They _do_ follow pointers. Some - more
than once.

We _will_ have to support ioctls for long. No questions about that. And
there is no magic trick that would work for all of them, simply because
many are too disgusting to be left alive. Let's clean the groups that can
be cleaned and see what's left.

