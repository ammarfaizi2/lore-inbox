Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132913AbRDQWoP>; Tue, 17 Apr 2001 18:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132853AbRDQWoE>; Tue, 17 Apr 2001 18:44:04 -0400
Received: from suntan.tandem.com ([192.216.221.8]:2761 "EHLO suntan.tandem.com")
	by vger.kernel.org with ESMTP id <S132710AbRDQWnz>;
	Tue, 17 Apr 2001 18:43:55 -0400
Message-ID: <3ADCC707.449F7B05@compaq.com>
Date: Tue, 17 Apr 2001 15:43:19 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mike@bangstate.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel space getcwd()? (using current() to find out cwd)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is probably a stupid question, and probably directed to the wrong
> list. Apologies in advance, but I'm stumped
> 
> I've been working on a kernel module to report on "changed files". It
> works just fine -- I wrap the orignal system calls with my
> [...]


At least in the 2.4 kernels, there's already a __d_path() routine (fs/dcache.c)
that builds the pathname using the mechanism you discussed.

Here's one way you could use it:

char *
kgetcwd()
{
	char *path = (char *) __get_free_page(GFP_USER);
        struct vfsmnt *pwdmnt;
        struct dentry *pwd;

        if (!path)
                return ERR_PTR(-ENOMEM);

        read_lock(&current->fs->lock);
        pwdmnt = mntget(current->fs->pwdmnt);
        pwd = dget(current->fs->pwd);
        read_unlock(&current->fs->lock);

        spin_lock(&dcache_lock);
        path = __d_path(pwd, pwdmnt, NULL, NULL, path, PAGE_SIZE);
        spin_unlock(&dcache_lock);

        mntput(pwdmnt);
        dput(pwd);

        return path;
}


If you only want the pathname back to the process root, use d_path() instead
(and don't grab the dcache_lock).

When you're done with path, free it with free_page() and not kfree().

BTW, I'm not subscribed to the kernel mailing list (I just read it on the web),
so please copy me on any response.


--
Brian Watson
Compaq Computer
