Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313272AbSC3OT2>; Sat, 30 Mar 2002 09:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSC3OTS>; Sat, 30 Mar 2002 09:19:18 -0500
Received: from smtp.polyu.edu.hk ([158.132.14.103]:22545 "EHLO
	hkpa04.polyu.edu.hk") by vger.kernel.org with ESMTP
	id <S313065AbSC3OTI>; Sat, 30 Mar 2002 09:19:08 -0500
Message-ID: <001401c1d7f5$d896b7c0$0100a8c0@winxp>
From: "Anthony Chee" <anthony.chee@polyu.edu.hk>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@vger.kernel.org>,
        <kernelnewbies@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <21554.1017121798@kao2.melbourne.sgi.com>
Subject: Re: undefined reference 
Date: Sat, 30 Mar 2002 22:19:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >Then I use "make bzImage", I got no error message on compiling inode.c,
but
> >I got
> >
> >"fs/fs.o(.text+0x1377d): undefined reference to `func'"
>
> You cannot do that.  The kernel must be self contained.  The only way
> for the kernel to access module code and data is for the module to
> register that code and data when the module is loaded and for the
> kernel to access the module via the registration list.
>
> See any module that handles a filesystem.  sys_open() does not call the
> module directly.  A module registers its file operations on load.  The
> kernel (dentry_open) calls the module via f->f_op->open.
>
>

Thanks for your help. I use another apporach to communicate with module,
similiar to the method you stated above.

What I did in the kernel source,

1. In fs.h, I added one line in struct super_operations
            int (*query_module) (struct inode *);

2. In write_inode() of inode.c, added
            result = inode->i_sb->s_op->query_module(inode);

What I did in the module,

1. Build up my own function, kernel_query_module(struct inode *inode)

2. In init_module(), added
            struct super_block *sb_ptr;
            sb_ptr = get_super(MKDEV(8,1));          /* suppose I want to
get super_block of /dev/sda1 */
            sb_ptr -> s_op -> query_module = &kernel_query_module;

Then, I compile the module and didi not get error message
When I compile the kernel, I got the follow error message,

inode.c:195: structure has no member named `query_module'

It made me crazy. Why the module can access the s_op and register the
address of kernel_query_module, but not the kernel source? I already added
one more item in the struct super_operation, but got the error message the
struct has no such member.

Any thing I missed? Thanks.

