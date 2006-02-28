Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWB1D13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWB1D13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWB1D13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:27:29 -0500
Received: from fmr17.intel.com ([134.134.136.16]:41641 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932209AbWB1D12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:27:28 -0500
Subject: Re: [PATCH] Enable mprotect on huge pages
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: david@gibson.dropbear.id.au,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>, davem@davemloft.net,
       paulus@samba.org, benh@kernel.crashing.org, wli@holomorphy.com,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       "tony.luck@intel.com" <tony.luck@intel.com>
In-Reply-To: <20060227173449.26c79a44.akpm@osdl.org>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
	 <20060224142844.77cbd484.akpm@osdl.org>
	 <20060226230903.GA24422@localhost.localdomain>
	 <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
	 <1141022034.1256.44.camel@ymzhang-perf.sh.intel.com>
	 <20060227173449.26c79a44.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-xT5BrnIf0bUySs9m124g"
Message-Id: <1141097034.3898.10.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 28 Feb 2006 11:23:54 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xT5BrnIf0bUySs9m124g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-02-28 at 09:34, Andrew Morton wrote:
> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> >
> > > > > > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> >  > > > > mprotect. My patch against 2.6.16-rc3 enables this capability.
> > 
> >  Based on David's comments, I worked out a new patch against 2.6.16-rc4.
> >  Thank David.
> > 
> 
> Please always send an updated changelog when sending an updated patch. 
> Otherwise I have to go trolling back through the email thread to find it,
> then work out what needs to be changed.
Thanks for your kind reminder. I would do so next time.

> 
> > 
> >  I tested it on i386/x86_64/ia64. Who could help test it on other
> >  platforms, such like PPC64?
> 
> I can do that - please send me your test app?
I attach a test case. It will create directory /mnt/hugepages and delete it
after testing automatically.

To run it by user root:
#gcc -o mprotect_testcase mprotect_testcase.c
#echo "5">/proc/sys/vm/nr_hugepages
#./mprotect_testcase

You could use gdb to step it to see the changing of the process vma maps.

Thanks.



--=-xT5BrnIf0bUySs9m124g
Content-Disposition: attachment; filename=mprotect_testcase.c
Content-Type: text/x-c; name=mprotect_testcase.c; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <setjmp.h>

#define WORK_DIR "/mnt/hugepages"
#define MMAP_DIR "/mnt/hugepages/mmap"
#define MMAP_FILE "/mnt/hugepages/mmap/mmap_file"

char buff[2000];

int get_htlb_mem_stat(int *total_pages, int *free_pages, long *page_size)
{
        int fd=0;
        int size1=0;
        char *start=0;

        buff[0] = '\0';
        if((fd=open("/proc/meminfo", O_RDONLY)) < 0)
        {
                printf("Current kernel does not support Huge TLB!\n");
                exit(-1);
        }

        size1 = pread(fd, buff, sizeof(buff), 0);
        if(size1>=sizeof(buff))
        {
                size1 = sizeof(buff)-1;
        }
        if(size1<0)
                size1 = 0;

        buff[size1] = '\0';
	start = buff;
	while(*start) {
		if(isupper(*start))
			*start = tolower(*start);
		start ++;
	}

	start = strstr(buff, "hugepagesize:");
	if(start==NULL)
	{
                printf("Current kernel does not support Huge TLB!\n");
                exit(-1);
        }
        start += sizeof("hugepagesize:");
        if(sscanf(start,"%ld", page_size) != 1)
        {
                printf("Current kernel does not support Huge TLB!\n");
                exit(-1);
        }
        *page_size *= 1024; /*Convert to BYTE from KB*/

        close(fd);

        return 0;
}


int mmap_open_mmap(int *fd, void **addr, size_t length, int prot, int flags)
{
	*fd = open(MMAP_FILE, O_CREAT|O_RDWR, 0755);
	if (*fd < 0) {
		/*perror("Open failed");*/
		exit(errno);
	}
	*addr = mmap(NULL, length, prot, flags, *fd, 0);
	if( *addr == (void *)-1 ) {
		/*perror("mmap failed");*/
		close(*fd);
		*fd = -1;
		return -1;
	}

	return 0;
}

int mmap_unmap(void *start, size_t length)
{
	int     result=0;

	result = munmap(start, length);
	if(result == -1 ) {
		/*perror("mmap_unmap failed");*/
		return -1;
	}

	return 0;
}

int test_mmap_mprotect()
{
	int result = -1;
	void *addr=0;
	long tt001;
	int	fd=-1;

	int	total_pages;
	int	free_pages;
	long	LPAGE_SIZE;

	printf("Test mmap mprotect ...");
	get_htlb_mem_stat(&total_pages, &free_pages, &LPAGE_SIZE);
	result = mount("none", MMAP_DIR, "hugetlbfs", 0, NULL);
	if(result != 0) {
		perror("Mount fail:");
		goto out1;
	}

	result = mmap_open_mmap(&fd, &addr, LPAGE_SIZE*3, PROT_READ|PROT_WRITE, MAP_SHARED);
	if(result < 0)
		goto out2;

	munmap(addr, LPAGE_SIZE*3);
	close(fd);

	result = mmap_open_mmap(&fd, &addr, LPAGE_SIZE*3, PROT_NONE, MAP_SHARED);
	if(result < 0)
		goto out2;

	if(mprotect(addr, LPAGE_SIZE*3, PROT_READ)) {
		printf("fail!\n");
		goto out2;
	}

	tt001 = ((long *)addr)[0];

	if(mprotect(addr+LPAGE_SIZE, LPAGE_SIZE, PROT_READ|PROT_WRITE)) {
		printf("fail!\n");
		goto out2;
	}
	((char *)addr)[LPAGE_SIZE+100] = tt001;

	if(mprotect(addr+LPAGE_SIZE, LPAGE_SIZE, PROT_READ)) {
		printf("fail!\n");
		goto out2;
	}

	printf("pass!\n");

out3:
	if(result < 0)
		mmap_unmap(addr, LPAGE_SIZE*3);
	else
		result = mmap_unmap(addr, LPAGE_SIZE*3);
out2:
	close(fd);
	if(result < 0)
		umount(MMAP_DIR);
	else
		result = umount(MMAP_DIR);
out1:
	return result;
}

void init()
{
	mkdir(WORK_DIR, 0777);
	mkdir(MMAP_DIR, 0755);
}

void uninit()
{
	rmdir(MMAP_DIR);
	rmdir(WORK_DIR);
}

int main(int argc, char * argv)
{
	int	total_pages=0;
	int	free_pages=0;
	int	result=0;

	init();

	test_mmap_mprotect();

	uninit();
	return 0;
}



--=-xT5BrnIf0bUySs9m124g--

