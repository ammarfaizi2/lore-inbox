Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWF0If4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWF0If4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWF0If4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:35:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13741 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751212AbWF0Ify (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:35:54 -0400
Date: Tue, 27 Jun 2006 10:31:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627083104.GA550@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623150040.GA1197@infradead.org> <1151080174.3856.1606.camel@quoit.chygwyn.com> <20060623164823.GA12480@infradead.org> <20060626205824.GA16661@elte.hu> <20060627075033.GA21066@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627075033.GA21066@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5056]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> ->follow_link needs exactly the same locking as ->readlink.  The whole 
> point of using generic_readlink is to avoid having the filesystem 
> reimplement almost the same code twice, once copying to a kernel 
> buffer and once to a user buffer.

yeah, you are right, i confused it with ->follow_link() and was wrong 
about the locking: generic_readlink() is just a wrapper around 
->follow_link() and vfs_readlink().

Still, as far as i can see the gfs2 implementation of readlink is faster 
(and hence a valid solution), because it knows the length of the symlink 
buffer and hence can avoid the strlen() call in vfs_readlink():

 int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
 {
         int len;

         len = PTR_ERR(link);
         if (IS_ERR(link))
                 goto out;

         len = strlen(link); <============= [this one]

while gfs2 can do a straight copy to userspace:

        error = gfs2_readlinki(ip, &buf, &len);
        if (error)
                return error;

        if (user_size > len - 1)
                user_size = len - 1;

        if (copy_to_user(user_buf, buf, user_size))
                error = -EFAULT;
        else
                error = user_size;

btw., ocfs2 does not use generic_readlink() either.

> Please read the code before giving such useless comments.  

thank you for the encouragement to participate in VFS review activities, 
it's really appreciated! It's always a joy taking part in lkml 
discussions.

	Ingo
