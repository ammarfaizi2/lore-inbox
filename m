Return-Path: <linux-kernel-owner+w=401wt.eu-S965061AbXADSeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbXADSeG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbXADSeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:34:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55983 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965061AbXADSeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:34:03 -0500
Message-ID: <459D4897.4020408@redhat.com>
Date: Thu, 04 Jan 2007 12:33:59 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <459C4038.6020902@redhat.com>	<20070103162643.5c479836.akpm@osdl.org>	<459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org>
In-Reply-To: <20070104102659.8c61d510.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 04 Jan 2007 11:51:10 -0600
> Eric Sandeen <sandeen@redhat.com> wrote:

>> Also - is it ok to alias a function with one signature to a function with
>> another signature?
> 
> Ordinarily I'd say no wucking fay, but that's effectively what we've been
> doing in there for ages, and it seems to work.

Hmm that gives me a lot of confidence ;-)  I'd hate to carry along bad
assumptions while we try to make this all kosher... but I'm willing to
defer to popular opinion on this one....

> I'd be a bit worried if any of these functions were returning pointers,
> because one could certainly conceive of an arch+compiler combo which
> returns pointers in a different register from integers (680x0?) but that's
> not happening here.

Well, one is...

static long * return_EIO_ptr(void)
{
        return ERR_PTR(-EIO);
}
...
static struct dentry *bad_inode_lookup(struct inode * dir,
                        struct dentry *dentry, struct nameidata *nd)
        __attribute__((alias("return_EIO_ptr")));

Maybe it'd be better to lose the alias in this case then?  and go back
to this:

static struct dentry *bad_inode_lookup(struct inode * dir,
                        struct dentry *dentry, struct nameidata *nd)
{
        return ERR_PTR(-EIO);
}

Thanks,
-Eric
