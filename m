Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSLMQKq>; Fri, 13 Dec 2002 11:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSLMQKq>; Fri, 13 Dec 2002 11:10:46 -0500
Received: from dhcp-66-212-193-131.myeastern.com ([66.212.193.131]:19406 "EHLO
	mail.and.org") by vger.kernel.org with ESMTP id <S265063AbSLMQKn>;
	Fri, 13 Dec 2002 11:10:43 -0500
To: root@chaos.analogic.com
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Andrew Walrond <andrew@walrond.org>
Subject: Re: Symlink indirection
References: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 13 Dec 2002 11:17:57 -0500
In-Reply-To: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
Message-ID: <m3bs3pao5m.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Fri, 13 Dec 2002, Marc-Christian Petersen wrote:
> 
> > On Friday 13 December 2002 16:06, Andrew Walrond wrote:
> > 
> > Hi Andrew,
> > 
> > > Is the number of allowed levels of symlink indirection (if that is the
> > > right phrase; I mean symlink -> symlink -> ... -> file) dependant on the
> > > kernel, or libc ? Where is it defined, and can it be changed?
> > 
> > fs/namei.c
> > 
> >  if (current->link_count >= 5)
> > 
> > change to a higher value.
> > 
> > So, the answer is: Kernel :)
> > 
> > ciao, Marc
> 
> No, that thing (whetever it is) is different.
> 
> Script started on Fri Dec 13 10:26:30 2002
> # file *
> foo:        symbolic link to ../foo

 *sigh*, you are following one symlink at a time ... what is this
proving ?

> You can do this until you run out of string-space. Your "link-count"
> has something to do with something else.

 The link count is for recursively following symlinks, as the original
question wanted to know ... and has been discussed on lkml numerous
times.

 Andrew, one extra piece of information you might not know is that the
above value doesn't come into play when the new symlink is the last
element in the new path, then you get a higher value.
 The full code...

        if (current->link_count >= max_recursive_link)
                goto loop;
        if (current->total_link_count >= 40)
                goto loop;
[...]
        current->link_count++;
        current->total_link_count++;
        UPDATE_ATIME(dentry->d_inode);
        err = dentry->d_inode->i_op->follow_link(dentry, nd);
        current->link_count--;

...Ie. a link from /a -> /b/c where "b" is a symlink takes the
"max_recursive_link" value (5 on vanilla kernels) but if "/b/c" was a
symlink then you get to use the 40 value.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
