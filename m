Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbULVFXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbULVFXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbULVFXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:23:38 -0500
Received: from web61205.mail.yahoo.com ([216.155.196.129]:54139 "HELO
	web61205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261360AbULVFXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:23:22 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=it9PI9Dka2n4EIA7VbwiF9SXg2vapRnNHD+6ADP+Vhn1zSR4VqXena7Q5uZ6XauFtshErKRv1kr26UnqeTDganBcjlM7qNMobuy3fHBW1OI90P7Wcl7/8J7ijmf3HpFwgC99Zhgpi2LnYS/Zy/ANZA1goBAOIP29uPVr5ZavAaQ=  ;
Message-ID: <20041222052322.39048.qmail@web61205.mail.yahoo.com>
Date: Tue, 21 Dec 2004 21:23:22 -0800 (PST)
From: John Wang <john_wang1969@yahoo.com>
Subject: help on driver's nopage mmap method
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have been struggling for a couple of days about
a problem of using nopage method to mmap memory from
driver to user application.

What I try to do is very simple - just to get the
simplest case to work, but I always get some junk in
user app (to be more specific, always 0xFF in the mmap
the memory area). I don't know what is wrong here - it
appears perfectly normal (compared to the examples in
the book Linux Device Driver). The kernel is 2.4.2
running on Intel x86 platform.

The program is very simple so I attached here (header
includes are ignored here to shorten the length).
Please CC me directly if anyone has answer since I am
not subscribed to the mailing list. Thanks in advance.

<test user app>
int
main(int argc, char *argv[])
{
        int     fd;
        char    *addr;
 
        fd = open("/dev/my_mmap", O_RDONLY);
        if(fd < 0) {
                perror("open");
                exit(1);
        }
 
        addr = mmap(NULL, 4096, PROT_READ, MAP_SHARED,
fd, 0);
        if(addr == MAP_FAILED) {
                perror("mmap");
                exit(1);
        }
        write(1, addr, 4096);
 
        return 0;
}

<end of test user app>

<kernel driver>
#define SOCK_MMAP_MAJOR         254
#define MY_NAME                 "mmap_sock"
 
void
mmap_sock_vma_open(struct vm_area_struct *vma)
{
        printk("<1>%s called\n", __FUNCTION__);
        return;
}
 
void
mmap_sock_vma_close(struct vm_area_struct *vma)
{
        printk("<1>%s called\n", __FUNCTION__);
        return;
}
 
void *k_vaddr;
 
struct page *
mmap_sock_vma_nopage(struct vm_area_struct *vma,
        unsigned long address, int write_access)
{
        struct page *pageptr;
 
        pageptr = virt_to_page(k_vaddr);
        get_page(pageptr);
        return pageptr;
}
 
static struct vm_operations_struct mmap_sock_vm_ops =
{
        open: mmap_sock_vma_open,
        close: mmap_sock_vma_close,
        nopage: mmap_sock_vma_nopage,
};
 
int
mmap_sock_mmap(struct file* fp, struct vm_area_struct
*vma)
{
        size_t  vma_size, pd_size;
 
        printk("<1>%s called\n", __FUNCTION__);
 
        if(vma->vm_pgoff != 0) {
                // this device has to be mapped from
offset 0
                return -EINVAL;
        }
 
        vma->vm_flags |= VM_RESERVED;
        vma->vm_ops = &mmap_sock_vm_ops;
        if(k_vaddr == NULL) {
                k_vaddr = __get_free_pages(GFP_KERNEL,
0);
                memset(k_vaddr, 0x30, PAGE_SIZE);
        }
        return 0;
}
 
int
mmap_sock_open(struct inode *inode, struct file *fp)
{
        if ( (fp->f_flags & O_ACCMODE) != O_RDONLY) {
                // only open for read
                return -EACCES;
        }
 
        return 0;
}
 
int
mmap_sock_release(struct inode *inode, struct file
*fp)
{
        return 0;
}
 
static struct file_operations mmap_sock_fops = {
        open:   mmap_sock_open,
        release: mmap_sock_release,
        mmap:   mmap_sock_mmap,
        owner:  THIS_MODULE,
};
 
int
init_module(void)
{
        int     ret = 0;
 
        ret = register_chrdev(SOCK_MMAP_MAJOR,
MY_NAME, &mmap_sock_fops);
        if (ret < 0) {
                printk("<1>%s: can't get major %d\n",
MY_NAME, SOCK_MMAP_MAJOR);                return ret;
        }
 
        return 0;
}
 
void
cleanup_module(void)
{
        int     ret;
 
        ret = unregister_chrdev(SOCK_MMAP_MAJOR,
MY_NAME);
        if(ret < 0) {
                printk("<1>%s: can't unregister dev,
err: %d\n", MY_NAME,
                        ret);
        }
}


		
__________________________________ 
Do you Yahoo!? 
Dress up your holiday email, Hollywood style. Learn more. 
http://celebrity.mail.yahoo.com
