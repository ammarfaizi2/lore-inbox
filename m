Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313572AbSDPD1q>; Mon, 15 Apr 2002 23:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313573AbSDPD1p>; Mon, 15 Apr 2002 23:27:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9990 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313572AbSDPD1o>;
	Mon, 15 Apr 2002 23:27:44 -0400
Message-ID: <3CBB9A15.E04FDA10@zip.com.au>
Date: Mon, 15 Apr 2002 20:27:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: OOPS caused by ext2 changes
In-Reply-To: <3CBB7B73.8090104@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Andrew Morton and I discused this earlier.  I have some more information
> now.  The problem: "dbench 64" run on a small (~120meg) partition with
> 1k block sizes produces Oopses.
> 
> This changeset:
> http://linus.bkbits.net:8080/linux-2.5/patch@1.248.2.6?nav=index.html|ChangeSet|cset@1.248.2.6
> is the culprit.  Without it applied, none of this happens.
> 


It's vaguely surprising that that chunk is associated with the
problem.

However it seems that there's potential for a buffer reference
leak in ext2_get_branch:

        while (--depth) {
                bh = sb_bread(sb, le32_to_cpu(p->key));
                if (!bh)
                        goto failure;
                /* Reader: pointers */
                if (!verify_chain(chain, p))
                        goto changed;
                add_chain(++p, bh, (u32*)bh->b_data + *++offsets);
                /* Reader: end */
                if (!p->key)
                        goto no_block;
        }
        return NULL;

changed:
        *err = -EAGAIN;
        goto no_block;
failure:
        *err = -EIO;
no_block:
        return p;
}


See, sb_bread() bumps b_count, but on the `goto changed;'
branch we lose track of that buffer.

b_count is only 16 bits, so it's conceivable that the
count wraps to zero, and that is fatal.

It would be interesting to replace that `goto changed;' 
with { __brelse(bh); goto changed; }.  Plus maybe a
debug printk to see if we are indeed hitting that path.

I don't think this is the bug actually - if we were
leaking bh refs that easily we'd get `busy buffer'
whines at unmount.  But it merits investigation.

-
