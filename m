Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUEFOkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUEFOkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEFOkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:40:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:26557 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262381AbUEFOj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:39:59 -0400
Date: Thu, 6 May 2004 20:11:21 +0530
From: Raghavan <raghav@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes in 32 bit ioctl emulation code
Message-ID: <20040506144121.GA5207@in.ibm.com>
Reply-To: raghav@in.ibm.com
References: <20040430131107.GA13126@in.ibm.com> <20040430203042.3a28dc70.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430203042.3a28dc70.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I went thru the modified patch and it looks fine. Please include
it in the kernel tree.

Thanks 
Raghav

 Fri, Apr 30, 2004 at 08:30:42PM -0700, Andrew Morton wrote:
> Raghavan <raghav@in.ibm.com> wrote:
> >
> > I am submitting a patch that fixes 2 race conditions in the 32 bit ioctl
> >  emulation code.(fs/compat.c) Since the search is not locked; when a 
> >  ioctl_trans structure is deleted, corruption can occur.
> > 
> >  The following scenarios discuss the race conditions:
> > 
> >  1) When the search is hapenning, if any ioctl_trans structure gets deleted; then
> >  rather than searching the hash table, the code will start searching the free
> >  list.
> > 
> >  while (t && t->cmd != cmd)
> >          ---->Deletion of t happens here; t->next points to ioctl_free_list
> >          t = (struct ioctl_trans *)t->next;
> >          ---->Now t will point to the ioctl_free_list
> > 
> >  2) Another race is when  the delete happens while the search holds the pointer
> >   to ioctl_trans. In this case the ioctl_trans structure is added to head of
> >  the ioctl_free_list. In the meanwhile if another module is registering, then
> >  the ioctl_trans from the head of the queue is given. This causes corruption.
> > 
> >  if (t) {
> >          -----> t gets deleted, added to free list and gets alloted again
> >          if (t->handler) {
> >          ------> t is corrupted
> > 
> > 
> 
> OK.  There's still a race in register_ioctl32_conversion().  It is
> performing a GFP_KERNEL memory allocation under lock_kernel().  That
> allocation can drop the lock and schedule away, allowing another process to
> come in and register the same ioctl.
> 
> Pretty unlikely, but easy to prevent: allocate the ioctl_trans before
> taking the lock, throw it away again if we ended up not using it.  See the
> below reworking of your patch.
> 
> >  The solution as I see it is to protect the search too. Since anyway the BKL
> >  needs to be used while calling the emulation handler, it can be pushed above
> >  to protect the searching. The fallout of this solution is that ioctl_free_list
> >  is not required any more.
> 
> yes, I agree: we can remove the "deliberate leak" now.  In
> compat_sys_ioctl() local variable `t' is dead after we call t->handler,
> because the handler may drop BKL.  The function handles that correctly.
> 
> btw, please ensure that your patches are in `patch -p1' format, as below. 
> Thanks.
> 
> fs/compat.c is bizarre.  What's all this unnecessary typecasting for?
> 
> 	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
> 
> and this gem:
> 
> -		t1 = (struct ioctl_trans *)(long)t->next;
> +		t1 = t->next;
> 
> hrm.
> 
> 
> 
> diff -puN fs/compat.c~fixes-in-32-bit-ioctl-emulation-code fs/compat.c
> --- 25/fs/compat.c~fixes-in-32-bit-ioctl-emulation-code	2004-04-30 20:18:31.920004168 -0700
> +++ 25-akpm/fs/compat.c	2004-04-30 20:18:31.925003408 -0700
> @@ -282,53 +282,36 @@ static int __init init_sys32_ioctl(void)
>  
>  __initcall(init_sys32_ioctl);
>  
> -static struct ioctl_trans *ioctl_free_list;
> -
> -/* Never free them really. This avoids SMP races. With a Read-Copy-Update
> -   enabled kernel we could just use the RCU infrastructure for this. */
> -static void free_ioctl(struct ioctl_trans *t) 
> -{ 
> -	t->cmd = 0; 
> -	mb();
> -	t->next = ioctl_free_list;
> -	ioctl_free_list = t;
> -} 
> -
> -int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
> +int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int,
> +				unsigned int, unsigned long, struct file *))
>  {
>  	struct ioctl_trans *t;
> +	struct ioctl_trans *new_t;
>  	unsigned long hash = ioctl32_hash(cmd);
>  
> +	new_t = kmalloc(sizeof(*new_t), GFP_KERNEL);
> +	if (!new_t)
> +		return -ENOMEM;
> +
>  	lock_kernel(); 
> -	for (t = (struct ioctl_trans *)ioctl32_hash_table[hash];
> -	     t;
> -	     t = t->next) { 
> +	for (t = ioctl32_hash_table[hash]; t; t = t->next) {
>  		if (t->cmd == cmd) {
> -			printk("Trying to register duplicated ioctl32 handler %x\n", cmd);
> +			printk(KERN_ERR "Trying to register duplicated ioctl32 "
> +					"handler %x\n", cmd);
>  			unlock_kernel();
> +			kfree(new_t);
>  			return -EINVAL; 
>  		}
> -	} 
> -
> -	if (ioctl_free_list) { 
> -		t = ioctl_free_list; 
> -		ioctl_free_list = t->next; 
> -	} else { 
> -		t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
> -		if (!t) { 
> -			unlock_kernel();
> -			return -ENOMEM;
> -		}
>  	}
> -	
> -	t->next = NULL;
> -	t->cmd = cmd;
> -	t->handler = handler; 
> -	ioctl32_insert_translation(t);
> +	new_t->next = NULL;
> +	new_t->cmd = cmd;
> +	new_t->handler = handler;
> +	ioctl32_insert_translation(new_t);
>  
>  	unlock_kernel();
>  	return 0;
>  }
> +EXPORT_SYMBOL(register_ioctl32_conversion);
>  
>  static inline int builtin_ioctl(struct ioctl_trans *t)
>  { 
> @@ -347,7 +330,7 @@ int unregister_ioctl32_conversion(unsign
>  
>  	lock_kernel(); 
>  
> -	t = (struct ioctl_trans *)ioctl32_hash_table[hash];
> +	t = ioctl32_hash_table[hash];
>  	if (!t) { 
>  		unlock_kernel();
>  		return -EINVAL;
> @@ -358,38 +341,39 @@ int unregister_ioctl32_conversion(unsign
>  			printk("%p tried to unregister builtin ioctl %x\n",
>  			       __builtin_return_address(0), cmd);
>  		} else { 
> -		ioctl32_hash_table[hash] = t->next;
> -			free_ioctl(t); 
> +			ioctl32_hash_table[hash] = t->next;
>  			unlock_kernel();
> -		return 0;
> +			kfree(t);
> +			return 0;
>  		}
>  	} 
>  	while (t->next) {
> -		t1 = (struct ioctl_trans *)(long)t->next;
> +		t1 = t->next;
>  		if (t1->cmd == cmd) { 
>  			if (builtin_ioctl(t1)) {
> -				printk("%p tried to unregister builtin ioctl %x\n",
> -				       __builtin_return_address(0), cmd);
> +				printk("%p tried to unregister builtin "
> +					"ioctl %x\n",
> +					__builtin_return_address(0), cmd);
>  				goto out;
>  			} else { 
> -			t->next = t1->next;
> -				free_ioctl(t1); 
> +				t->next = t1->next;
>  				unlock_kernel();
> -			return 0;
> +				kfree(t1);
> +				return 0;
>  			}
>  		}
>  		t = t1;
>  	}
> -	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n", cmd);
> - out:
> +	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n",
> +				cmd);
> +out:
>  	unlock_kernel();
>  	return -EINVAL;
>  }
> -
> -EXPORT_SYMBOL(register_ioctl32_conversion); 
>  EXPORT_SYMBOL(unregister_ioctl32_conversion); 
>  
> -asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
> +asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
> +				unsigned long arg)
>  {
>  	struct file * filp;
>  	int error = -EBADF;
> @@ -404,43 +388,53 @@ asmlinkage long compat_sys_ioctl(unsigne
>  		goto out;
>  	}
>  
> -	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
> +	lock_kernel();
> +
> +	t = ioctl32_hash_table[ioctl32_hash (cmd)];
>  
>  	while (t && t->cmd != cmd)
> -		t = (struct ioctl_trans *)t->next;
> +		t = t->next;
>  	if (t) {
>  		if (t->handler) { 
> -			lock_kernel();
>  			error = t->handler(fd, cmd, arg, filp);
>  			unlock_kernel();
> -		} else
> +		} else {
> +			unlock_kernel();
>  			error = sys_ioctl(fd, cmd, arg);
> -	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
> -		error = siocdevprivate_ioctl(fd, cmd, arg);
> +		}
>  	} else {
> -		static int count;
> -		if (++count <= 50) { 
> -			char buf[10];
> -			char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
> -
> -			/* find the name of the device. */
> -			if (path) {
> -		       		fn = d_path(filp->f_dentry, filp->f_vfsmnt, 
> -					    path, PAGE_SIZE);
> +		unlock_kernel();
> +		if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
> +			error = siocdevprivate_ioctl(fd, cmd, arg);
> +		} else {
> +			static int count;
> +			if (++count <= 50) {
> +				char buf[10];
> +				char *fn = "?";
> +				char *path;
> +
> +				path = (char *)__get_free_page(GFP_KERNEL);
> +
> +				/* find the name of the device. */
> +				if (path) {
> +			       		fn = d_path(filp->f_dentry,
> +						filp->f_vfsmnt, path,
> +						PAGE_SIZE);
> +				}
> +
> +				sprintf(buf,"'%c'", (cmd>>24) & 0x3f);
> +				if (!isprint(buf[1]))
> +				    sprintf(buf, "%02x", buf[1]);
> +				printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
> +					"cmd(%08x){%s} arg(%08x) on %s\n",
> +					current->comm, current->pid,
> +					(int)fd, (unsigned int)cmd, buf,
> +					(unsigned int)arg, fn);
> +				if (path)
> +					free_page((unsigned long)path);
>  			}
> -
> -			sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
> -			if (!isprint(buf[1]))
> -			    sprintf(buf, "%02x", buf[1]);
> -			printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
> -			       "cmd(%08x){%s} arg(%08x) on %s\n",
> -			       current->comm, current->pid,
> -			       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
> -			       fn);
> -			if (path) 
> -				free_page((unsigned long)path); 
> +			error = -EINVAL;
>  		}
> -		error = -EINVAL;
>  	}
>  out:
>  	fput(filp);
> 
> _
> 
