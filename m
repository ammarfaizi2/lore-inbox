Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSGBKWa>; Tue, 2 Jul 2002 06:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGBKW3>; Tue, 2 Jul 2002 06:22:29 -0400
Received: from smtp02.web.de ([217.72.192.151]:47878 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S316686AbSGBKW1>;
	Tue, 2 Jul 2002 06:22:27 -0400
Date: Tue, 2 Jul 2002 12:24:42 +0200
From: Timo Benk <t_benk@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timo Benk <t_benk@web.de>
Subject: Re: allocate memory in userspace (Answer)
Message-ID: <20020702102442.GB9965@toshiba>
Reply-To: Timo Benk <t_benk@web.de>
References: <20020701172659.GA4431@toshiba> <20020702075117.GA5604@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702075117.GA5604@toshiba>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As stated by Andy Kleen this is not a good solution.
This is his post to the topic:

----<snip>----
> I am a kernel newbie and i am writing a module. I 
> need to allocate some memory in userspace because
> i want to access syscalls like open(), lstat() etc.
> I need to call these methods in the kernel, and in
> my special case there is no other way, but i 
> do not want to reimplement all the syscalls.
> 
> I read that it should be possible, but i cannot
> find any example or recipe on how to do it.

mm_segment_t oldfs = get_fs();
set_fs(KERNEL_DS);
ret = sys_yoursyscall(kernelargs ...)
set_fs(oldfs);

Do not even think about using mmap or accessing sys_call_table for this.
Your other post was so tasteless that it would be good if you retracted
it with a followup because it would be very bad to have such an bad
example
in the l-k archives open to innocent search machine users uncommented.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
----<snap>-----

On Tue, Jul 02, 2002 at 09:51:17AM +0200, Timo Benk wrote:
> Hi,
> 
> I found the following function in arch/i386/kernel/sys_i386.c:
> 
> ---<snip>---
> /* common code for old and new mmaps */
> long do_mmap2
> 	(
> 		unsigned long addr, unsigned long len,
> 		unsigned long prot, unsigned long flags,
> 		unsigned long fd,   unsigned long pgoff
> 	)
> {
> 	int error = -EBADF;
> 	struct file * file = NULL;
> 
> 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
> 	if (!(flags & MAP_ANONYMOUS)) {
> 		file = fget(fd);
> 		if (!file)
> 			goto out;
> 	}
> 
> 	down_write(&current->mm->mmap_sem);
> 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
> 	up_write(&current->mm->mmap_sem);
> 
> 	if (file)
> 		fput(file);
> out:
> 	return error;
> }
> ---<snap>---
> 
> the following code works for me(of course
> don't forget to munmap the memory).
> ---<snip>---	
> 	char *userspace;
> 	char kernelspace[2048];
> 
> 	userspace = (char*)do_mmap2
> 			(
> 				0, 
> 				2048, 
> 				PROT_READ|PROT_WRITE, 
> 				MAP_PRIVATE|MAP_ANON, 
> 				-1, 
> 				0
> 			);
> 			
> 	copy_to_user( userspace, "/dev/hda", 9 );
> 	
> 	copy_from_user( kernelspace, userspace, 9 );
> 	printk("%s\n",kernelspace);
> ---<snap>---	
> 
> Hope that helps any other struggling newbie:-)
> 
> -timo
> 
> -- 
> gpg key fingerprint = 6832 C8EC D823 4059 0CD1  6FBF 9383 7DBD 109E 98DC
> 

-- 
gpg key fingerprint = 6832 C8EC D823 4059 0CD1  6FBF 9383 7DBD 109E 98DC

