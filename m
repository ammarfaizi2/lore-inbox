Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131932AbQKRXMV>; Sat, 18 Nov 2000 18:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131933AbQKRXML>; Sat, 18 Nov 2000 18:12:11 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:43790 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131932AbQKRXL6>;
	Sat, 18 Nov 2000 18:11:58 -0500
Date: Sat, 18 Nov 2000 14:41:55 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001118144155.B19804@valinux.com>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com> <20001118192542.B24555@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001118192542.B24555@athlon.random>; from andrea@suse.de on Sat, Nov 18, 2000 at 07:25:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 07:25:42PM +0100, Andrea Arcangeli wrote:
> On Fri, Nov 17, 2000 at 04:09:00PM -0800, H . J . Lu wrote:
> > On Fri, Nov 17, 2000 at 03:59:13PM -0800, H . J . Lu wrote:
> > > # gcc x.c
> > > # ./a.out
> > > lseek on -100000: -100000
> > > write: File too large
> > > 
> > > Should kernel allow negative offsets for lseek/llseek?
> > > 
> > > 
> > 
> > Never mind. I was running the wrong kernel.
> 
> With 2.2.18pre21aa2 this little proggy:
> 
> main()
> {
> 	int fd = creat("x", 0600);
> 	lseek(fd, 0x80000000, 0);
> }
> 
> get confused this way:
> 
> lseek(3, 2147483648, SEEK_SET)          = -1 ERRNO_0 (Success)
> _exit(-2147483648)                      = ?
> 
> I fixed it this way:
> 
> diff -urN 2.2.18pre21/fs/read_write.c lseek/fs/read_write.c
> --- 2.2.18pre21/fs/read_write.c	Tue Sep  5 02:28:49 2000
> +++ lseek/fs/read_write.c	Sat Nov 18 18:42:55 2000
> @@ -53,6 +53,10 @@
>  	struct dentry * dentry;
>  	struct inode * inode;
>  
> +	retval = -EINVAL;
> +	if (offset < 0)
> +		goto out_nolock;
> +

offset shouldn't be < 0 to begin with. There may be a bug somewhere
else. In my case,

	if (offset < 0)
		return -EINVAL;

is missing from those FS lseek functions.

H.J.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
