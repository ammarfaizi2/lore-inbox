Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269951AbUJNDjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269951AbUJNDjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269953AbUJNDjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:39:39 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:2197 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269951AbUJNDjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:39:36 -0400
Message-ID: <b2fa632f041013203968418d9f@mail.gmail.com>
Date: Thu, 14 Oct 2004 09:09:36 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: eshwar <eshwar@moschip.com>
Subject: Re: Write USB Device Driver entry not called
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <004f01c4b8a1$9ee2b6c0$41c8a8c0@Eshwar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
	 <b2fa632f0410122315753f8886@mail.gmail.com>
	 <001401c4b796$abcddfb0$41c8a8c0@Eshwar>
	 <1097663878.4440.0.camel@localhost.localdomain>
	 <004f01c4b8a1$9ee2b6c0$41c8a8c0@Eshwar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 07:12:56 +0530, eshwar <eshwar@moschip.com> wrote:
> I agree but the return value from the vfs_write should not be the -EBADF
> (Bad File descriptor) it might be -EACCES (premission denied)... Correct me
> if I am wrong...
> 
> this can be code in fs/read_write.c vfs_write()
> 
>  if (!(file->f_mode & FMODE_WRITE))
>   return -EACCES;

Wrong. You are confused between file perms & mode of access to files. 
If you cannot open a file due to insufficient perms, then EACCESS is
what you get.
If you opened a file for reading, but you tried to write, the you get a EBADF.

Run the following code, after you create two files, 'foo' ( perms 0400
) and 'bar' ( 0700 ).

#include <fcntl.h>

int main()
{
        int fd;

        fd = open("foo",O_WRONLY);

        if(fd < 0)
                perror("Opening foo:");
        else
                close (fd);

        fd = open("bar",O_RDONLY);

        if(fd < 0)
                perror("Opening bar: ");
        else {
                if(write(fd,'a',1) < 0)
                        perror("Write to bar failed: ");
                close(fd);
        }

}

Output would be:
Opening foo:: Permission denied
Write to bar failed: : Bad file descriptor
-- 
######
raj
######
