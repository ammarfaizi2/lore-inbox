Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265604AbSJXTIx>; Thu, 24 Oct 2002 15:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265609AbSJXTIx>; Thu, 24 Oct 2002 15:08:53 -0400
Received: from bozo.vmware.com ([65.113.40.131]:50182 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265604AbSJXTIp>; Thu, 24 Oct 2002 15:08:45 -0400
Date: Thu, 24 Oct 2002 12:15:32 -0700
From: chrisl@vmware.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024191531.GD1398@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20021024183327.GS3354@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2002 at 08:33:27PM +0200, Andrea Arcangeli wrote:
> On Thu, Oct 24, 2002 at 10:57:18AM -0700, chrisl@vmware.com wrote:
> > 			if ((gfp_mask & __GFP_FS) && writepage) {
> > +                               unsigned long flags = page->flags;
> > 
> > 				ClearPageDirty(page);
> > 				SetPageLaunder(page);
> > 				page_cache_get(page);
> > 				spin_unlock(&pagemap_lru_lock);
> > 
> > -				writepage(page);
> > +				if (writepage(page))
> > +					page->flags = flags;
> > 
> > 				page_cache_release(page);
> > 
> > 				spin_lock(&pagemap_lru_lock);
> > 				continue;
> >                         }
> 
> side note, you should use atomic bitflag operations here or you risk to
> lose a bit set by another cpu between the read and the write. you

Thanks. I am just shooting in dark.

> basically meant SetPageDirty() if writepage fails. That is supposed to
> happen in the lowlevel layer (like in fail_writepage) but the problem
> here is that this isn't ramfs, and block_write_full_page could left
> locked in ram lots of pages if it would disallow these pages to be
> discared from the vm.

Exactly.

> 
> > > A few fixes have been discussed.  One way would be to allocate
> > > the space for the page when it is first faulted into reality and
> > > deliver SIGBUS if backing store for it could not be allocated.
> > 
> > I am not sure how the user program handle that signal...
> > 
> > >  
> > > Ayup.  MAP_SHARED is a crock.  If you want to write to a file, use write().
> > > 
> > > View MAP_SHARED as a tool by which separate processes can attach
> > > to some shared memory which is identified by the filesystem namespace.
> > > It's not a very good way of performing I/O.
> > 
> > That is exactly the case for vmware ram file. VMware only use it to share
> > memory. Those are the virtual machine's memory. We don't want to write
> > it back to disk and we don't care what is left on the file system because
> > when vmware exit, we will throw the guest ram data away just like a real
> > machine power off ram will lost. We are not talking about machine using
> > flash ram :-). 
> > 
> > It is kswapd try to flush the data and it should take response to handle
> > the error. If it fail, one thing it should do is keep the page dirty
> > if write back fail. At least not corrupt memory like that.
> > 
> > If we can deliver the error to user program that would be a plus.
> > But this need to be fix frist.
> 
> as said this cannot be fixed easily in kernel, or it would be trivial to
> lockup a machine by filling the fs changing the i_size of a file and by
> marking all ram in the machine dirty in the hole, the vm must be allowed

Yes, but even now days it will able to lockup machine by doing that.

Try the test bigmm program I attach to this mail. It will simulate vmware's
memory mapping. It can easily lockup the machine even though there is
enough disk space.

See the comment at the source for parameter. basically, if you want
3 virtual machine, each have 2 process, using 1 G ram each you can do:

bigmm -i 3 -t 2 -c 1024

I run it on two 4G and 8G smp machine. Both can dead lock if I mmap
enough memory.

I haven't try it on the latest kernel yet. But last time I try it,
it works every time. I have to reset the machine. I mean ram file
create on normal file system.

But if I create it on /dev/shm, the kernel can correctly kill
some of the process and free the memory.

Prepare to reset the machine if you try that, you have been warned :-)


> to discard those pages and invaliding those posted writes. At least
> until a true solution will be available you should change vmware to
> preallocate the file, then it will work fine because you will catch the
> ENOSPC error during the preallocation. If you work on shmfs that will be
> very quick indeed.

Yes, shmfs seems to be the only choice so far.

Chris

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bigmm.c"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

int pagesize = 4096;
int instance = 1;
int thread = 1;
int blocksize = 1024*1024; // 1M
int blocks = 1024;	// total 1 G
char *filename="myram";
char *memblock[1024*256];

int memmap(char *argv[], int ppid)
{
	int i,j,fd,err=0,pid,k;
	char file[256];
	sprintf(argv[0],"a%d",ppid);
	sprintf(file,"%s.%d",filename,ppid);
	fd = open(file,O_CREAT|O_TRUNC|O_RDWR,00644);
	if (fd<0) {
		perror("open");
		err = fd;
		goto exit;
	}
	err = unlink(file);
	if (err<0) {
		perror("unlink");
		goto exit_close;
	}
	err = ftruncate(fd,blocksize*blocks);
	if (err<0) {
		perror("ftruncate");
		goto exit_close;
	}
	/* fork more process(thread) to use same share mem file */
	for (i=1;i<thread;i++) {
		pid = fork();
		if (pid <0) {
			perror("fork");
			exit(1);
		}
		if(pid) {
			printf("%d fork  child %d\n",ppid,pid);
		}else {
			sprintf(argv[0],"a%d.%d",ppid,i);
			break;
		}
	}
	for (i=0;i<blocks;i++) {
		void * ptr;
		ptr = mmap(NULL,blocksize, PROT_READ|PROT_WRITE,
			MAP_SHARED, fd, i*blocksize);
		if (ptr==MAP_FAILED) {
			perror("mmap");
			break;
		}
		memblock[i] = ptr;
	}
	/* touch all the share memory like a guest vm */
	while (1) {
		sleep(1);
		for (i=0;i<blocks;i++)
			for (j=0;j<blocksize;j+=pagesize)
				memblock[i][j]=i&0xff;
	}
	err = 0;
exit_close:
	close(fd);
exit:
	return err;
}


int main (int argc, char *argv[])
{
	int i,pid;
	int c;
	while (1) {
		c = getopt(argc,argv,"b:c:i:t:");
		if (c<=0) break;
		switch (c) {
			case 'i':
				/* number of virtual machine */
				instance = strtol(optarg,NULL,0);
				break;
			case 't':
				/* number of process per virtual machine */
				thread = strtol(optarg,NULL,0);
				break;
			case 'c':
				/* number of memory blocks in each virtual machine */
				blocks = strtol(optarg,NULL,0);
				break;
			case 'b':
				/* size of a memory block */
				blocksize = strtol(optarg,NULL,0);
				break;
		}
	}
	printf("i:%d t:%d b:%d c:%d\n",instance,thread,blocksize,blocks);
	for (i=0;i<instance;i++) {
		pid = fork();
		if (pid <0) {
			perror("mainfork");
			exit(1);
		}
		if(pid) {
			printf("mainfork  child %d\n",pid);
		}else {
			return memmap(argv,i);
		}
	}
	return 0;
}

--/9DWx/yDrRhgMJTb--


