Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTIKAP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbTIKAP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:15:56 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:8964 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S262758AbTIKAPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:15:48 -0400
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20030910154608.14ad0ac8.akpm@osdl.org>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
	 <20030910154608.14ad0ac8.akpm@osdl.org>
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1063239544.1328.22.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Sep 2003 17:19:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 15:46, Andrew Morton wrote:
> Ranjeet Shetye <ranjeet.shetye2@zultys.com> wrote:
> >
> > Unable to handle kernel paging request at virtual address ffffffef
> >  printing eip:
> > c027184c
> > *pde = 00001067
> > *pte = 00000000
> > Oops: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c027184c>]    Not tainted
> > EFLAGS: 00010282
> > EIP is at atomic_dec_and_lock+0x8/0x54
> > eax: ffffffef   ebx: ffffffef   ecx: ffffffef   edx: cf372254
> > esi: ffffffef   edi: cf743e20   ebp: c12efea8   esp: c12efea0
> > ds: 007b   es: 007b   ss: 0068
> > Process swapper (pid: 1, threadinfo=c12ee000 task=c12ed8c0)
> > Stack: ffffffef ffffffef c12efec4 c01675e4 ffffffef c05a21b0 ffffffef cf7469b4 
> >        cf743e20 c12efee4 c018aa52 ffffffef 000041ed c018a998 c05f0f80 00000000 
> >        c05f0f80 c12eff00 c018aab1 c05f0f80 cf743e20 c05f0f84 00000000 c05f0f80 
> > Call Trace:
> >  [<c01675e4>] dput+0x24/0x227
> >  [<c018aa52>] create_dir+0x9e/0xa4
> >  [<c018a998>] init_dir+0x0/0x1c
> >  [<c018aab1>] sysfs_create_dir+0x36/0x6c
> >  [<c026eee0>] create_dir+0x1f/0x49
> >  [<c026f331>] kobject_add+0x4d/0x124
> 
> Bug in fs/sysfs/dir.c:create_dir() - sysfs_create() returned -EEXIST and we
> turned that into a pointer and did a dput() on it.  
> 
> Something like this should fix it.  The -EEXIST return may be another bug?
> 
> 
> 
> diff -puN fs/sysfs/dir.c~sysfs-create_dir-oops-fix fs/sysfs/dir.c
> --- 25/fs/sysfs/dir.c~sysfs-create_dir-oops-fix	Wed Sep 10 15:41:35 2003
> +++ 25-akpm/fs/sysfs/dir.c	Wed Sep 10 15:44:42 2003
> @@ -24,10 +24,11 @@ static int init_dir(struct inode * inode
>  static struct dentry * 
>  create_dir(struct kobject * k, struct dentry * p, const char * n)
>  {
> -	struct dentry * dentry;
> +	struct dentry *dentry, *ret;
>  
>  	down(&p->d_inode->i_sem);
>  	dentry = sysfs_get_dentry(p,n);
> +	ret = dentry;
>  	if (!IS_ERR(dentry)) {
>  		int error = sysfs_create(dentry,
>  					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
> @@ -36,11 +37,11 @@ create_dir(struct kobject * k, struct de
>  			dentry->d_fsdata = k;
>  			p->d_inode->i_nlink++;
>  		} else
> -			dentry = ERR_PTR(error);
> +			ret = ERR_PTR(error);
>  		dput(dentry);
>  	}
>  	up(&p->d_inode->i_sem);
> -	return dentry;
> +	return ret;
>  }
>  
> 
> 
> _

Hi Andrew,

Your changes fixed the issue. Thanks a lot for your help. I still get
this call trace, but no more OOPS on bootup.

kobject_register failed for Ensoniq AudioPCI (-17)
Call Trace:
 [<c026f45c>] kobject_register+0x50/0x59
 [<c02f8003>] bus_add_driver+0x4c/0xaf
 [<c02f8453>] driver_register+0x31/0x35
 [<c027c3bf>] pci_populate_driver_dir+0x29/0x2b
 [<c027c491>] pci_register_driver+0x5e/0x83
 [<c06a145f>] alsa_card_ens137x_init+0x15/0x41
 [<c068475a>] do_initcalls+0x2a/0x97
 [<c012e920>] init_workqueues+0x12/0x2a
 [<c01050a3>] init+0x39/0x196
 [<c010506a>] init+0x0/0x196
 [<c0108f31>] kernel_thread_helper+0x5/0xb


Also, I wanted to ask one more thing:

In the top level Makefile, I have replaced

EXTRAVERSION = -test5

with 

TESTVERSION = -test5
BKVERSION = $(shell if [ -d "./BitKeeper" ]; then echo '-bk-`bk changes
| head -1 | cut -f 2 -d @ | cut -f 1 -d ,`' ; else echo ''; fi)
EXTRAVERSION = $(TESTVERSION)$(BKVERSION)

As a result 'uname -r' on a bk-based kernel now returns a more useful
'2.6.0-test5-bk-1.1227.1.49' instead of just '2.6.0-test5'. For non-bk
based source code trees, the version is still '2.6.0-test5'. This is
very useful to me because I have 2 seperate 2.6 trees (bk and vanilla),
and this lets me figure out where I got my kernel from and esp. at what
bk changeset it was built.

I am not very familiar with bk (still stumbling around) and hence I
couldn't generate a bk diff or do a bk send etc; if you think this
change is useful, please send it over to be included in the main tree.

thanks again,
Ranjeet.

-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


