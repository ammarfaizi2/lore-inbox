Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317959AbSGLVAR>; Fri, 12 Jul 2002 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317988AbSGLVAQ>; Fri, 12 Jul 2002 17:00:16 -0400
Received: from mail.eskimo.com ([204.122.16.4]:6926 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S317959AbSGLVAQ>;
	Fri, 12 Jul 2002 17:00:16 -0400
Date: Fri, 12 Jul 2002 14:02:51 -0700
To: Karthikeyan Nathillvar <ntkarthik@ittc.ku.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process Memory Usage
Message-ID: <20020712210251.GA5803@eskimo.com>
References: <Pine.LNX.4.33.0207101811550.4626-100000@plato.ittc.ku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207101811550.4626-100000@plato.ittc.ku.edu>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to know heap memory utilization, probably the best way it to
shim on glibc's malloc:

volatile static int total = 0;

void *
malloc(size_t size) 
{
	void *ret = __libc_malloc(size + sizeof(size_t));
	if(ret) {
		lock();
		total += size;
		unlock();
		*((size_t*)ret = size;
		return (void*)((size_t*)ret+1);
	} else {
		return ret;
	}
}

void
free(void *ptr) 
{
	if(ptr) {
		lock();
		total -= *((size_t*)ptr - 1);
		unlock();
		__libc_free((size_t*)ptr - 1);
	}
}

define realloc, calloc too.

then,

LD_PRELOAD=./my_shim.so program.exe

This way, you can get accurate counts of heap activity.  Or, you might
try to access the heap's internal data structures, if it has that
information.


If you only look at the kernel's numbers for size/rss/etc., these will
usually tend to always increase, because the kernel knows nothing of
your heap.  It only knows about brk() space (increasing) and mapped
memory and such.  The C library will manage the kernel's memory
allocation internally, usually by re-using space it previously allocated
instead of ever freeing it.  Thus, the upward trend.

/proc/pid/status and statm are accurate, it's just that they only tell
you what the kernel's view of the process is.  This may be very
different from the c library's view.

-J

On Wed, Jul 10, 2002 at 06:18:18PM -0500, Karthikeyan Nathillvar wrote:
> Hi,
> 
>   I want to find the memory usage of a particular process, to be precise
> the percentage memory utilization. I need to find it through a program
> other than "top".
> 
>  1) I tried using getrusage() system call. But it is returning zero for
> all values(like ru_maxrss, etc..) except ru_utime and ru_stime. I am using
> 2.2.18 kernel.
> 
>  2) I tried to read from /proc/<pid>/statm file. But, the process memory
> usage seems to be always in an increasing trend, even though lot of
> freeing is going on inside. All the values, size, resident, are always
> increasing.
> 
>    Can anyone suggest me any other ways through which memory utilization
> of a program can be obtained.
> 
> Thanking you in advance,
> ntk.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
