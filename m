Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132869AbRDQX3C>; Tue, 17 Apr 2001 19:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132863AbRDQX2n>; Tue, 17 Apr 2001 19:28:43 -0400
Received: from suntan.tandem.com ([192.216.221.8]:39114 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S132697AbRDQX2i>; Tue, 17 Apr 2001 19:28:38 -0400
Message-ID: <3ADCD187.366993BE@compaq.com>
Date: Tue, 17 Apr 2001 16:28:07 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mike@bangstate.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel space getcwd()? (using current() to find out cwd)
In-Reply-To: <3ADCC707.449F7B05@compaq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian J. Watson" wrote:
>         path = __d_path(pwd, pwdmnt, NULL, NULL, path, PAGE_SIZE);


Oops! That's no good. Here's the new and improved version:

char *
kgetcwd(char **bufp)
{
        char *path, *buf = (char *) __get_free_page(GFP_USER);
        struct vfsmnt *pwdmnt;
        struct dentry *pwd;

        *bufp = NULL;
        if (!buf)
                return ERR_PTR(-ENOMEM);

        read_lock(&current->fs->lock);
        pwdmnt = mntget(current->fs->pwdmnt);
        pwd = dget(current->fs->pwd);
        read_unlock(&current->fs->lock);

        spin_lock(&dcache_lock);
        path = __d_path(pwd, pwdmnt, NULL, NULL, buf, PAGE_SIZE);
        spin_unlock(&dcache_lock);

        mntput(pwdmnt);
        dput(pwd);

        *bufp = buf;
        return path;
}


The returned pointer is for the beginning of the path name. The pointer filled
into bufp is for the beginning of the allocated space. To deallocate, call
free_page() on the value in bufp.

The reason for the distinction is that __d_path builds the pathname from the end
of the buffer, working its way back toward the beginning. Rarely will the string
begin at the same address as the allocated buffer.


--
Brian Watson
Compaq Computer
