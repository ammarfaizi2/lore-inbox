Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSGBHs6>; Tue, 2 Jul 2002 03:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSGBHs5>; Tue, 2 Jul 2002 03:48:57 -0400
Received: from smtp02.web.de ([217.72.192.151]:59150 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S316667AbSGBHs4>;
	Tue, 2 Jul 2002 03:48:56 -0400
Date: Tue, 2 Jul 2002 09:51:17 +0200
From: Timo Benk <t_benk@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timo Benk <t_benk@web.de>
Subject: Re: allocate memory in userspace (Answer)
Message-ID: <20020702075117.GA5604@toshiba>
Reply-To: Timo Benk <t_benk@web.de>
References: <20020701172659.GA4431@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020701172659.GA4431@toshiba>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the following function in arch/i386/kernel/sys_i386.c:

---<snip>---
/* common code for old and new mmaps */
long do_mmap2
	(
		unsigned long addr, unsigned long len,
		unsigned long prot, unsigned long flags,
		unsigned long fd,   unsigned long pgoff
	)
{
	int error = -EBADF;
	struct file * file = NULL;

	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
	if (!(flags & MAP_ANONYMOUS)) {
		file = fget(fd);
		if (!file)
			goto out;
	}

	down_write(&current->mm->mmap_sem);
	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
	up_write(&current->mm->mmap_sem);

	if (file)
		fput(file);
out:
	return error;
}
---<snap>---

the following code works for me(of course
don't forget to munmap the memory).
---<snip>---	
	char *userspace;
	char kernelspace[2048];

	userspace = (char*)do_mmap2
			(
				0, 
				2048, 
				PROT_READ|PROT_WRITE, 
				MAP_PRIVATE|MAP_ANON, 
				-1, 
				0
			);
			
	copy_to_user( userspace, "/dev/hda", 9 );
	
	copy_from_user( kernelspace, userspace, 9 );
	printk("%s\n",kernelspace);
---<snap>---	

Hope that helps any other struggling newbie:-)

-timo

-- 
gpg key fingerprint = 6832 C8EC D823 4059 0CD1  6FBF 9383 7DBD 109E 98DC

