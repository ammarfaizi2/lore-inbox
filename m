Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVAFLLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVAFLLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVAFLLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:11:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:55787 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262810AbVAFLK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:10:56 -0500
Date: Thu, 6 Jan 2005 13:55:42 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@us.ibm.com>
Subject: Re: 2.6.10-mm1 panic in sysfs ?
Message-ID: <20050106082542.GA15246@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1104946602.4000.22.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104946602.4000.22.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 09:36:42AM -0800, Badari Pulavarty wrote:
> Hi Andrew,
> 
> I get a panic in sysfs_readdir() while booting 2.6.10-mm1
> kernel. Known fixes ?
> 
> Thanks,
> Badari
> 
> 

[....]
> Creating /var/log/boot.msg                                           done
> showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
> System Boot Control: The system has been                             set up
> Skipped features:                                  boot.cycle boot.sched
> System Boot Control: Running /etc/init.d/boot.local                  done
> INIT: Entering runlevel: 1
> Boot logging started on /dev/ttyS0(/dev/console) at Wed Jan  5 00:33:53 2005
> Master Resource Control: previous runlevel: N, switching to runlevel:1
> Hotplug is already active  (disable with  NOHOTPLUG=1 at the boot prodone
> coldplug scanning input: ***                                         done
>          scanning pci: ****.W*.*..*Unable to handle kernel NULL pointer dereference at virtual address 00000020
>  printing eip:
> c109c8ef
> *pde = 0191c001
> Oops: 0000 [#1]
> SMP
> Modules linked in:
> CPU:    2
> EIP:    0060:[<c109c8ef>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.10-mm1kexec)
> EIP is at sysfs_readdir+0xef/0x280
> eax: 00000000   ebx: c15e1160   ecx: 0000000c   edx: 00000020
> esi: c15e1164   edi: c15dd72d   ebp: c1a7df78   esp: c1a7df3c
> ds: 007b   es: 007b   ss: 0068
> Process getcfg (pid: 1927, threadinfo=c1a7c000 task=c2ba3040)


I think it crashed as the dentry->d_inode is NULL, which is surprising. Getting
some info on the file in process will certainly help. 

--------
static int sysfs_readdir(struct file * filp, void * dirent, filldir_t filldir)
{
        struct dentry *dentry = filp->f_dentry;
        struct sysfs_dirent * parent_sd = dentry->d_fsdata;
        struct sysfs_dirent *cursor = filp->private_data;
        struct list_head *p, *q = &cursor->s_sibling;
        ino_t ino;
        int i = filp->f_pos;
                                                                                
        switch (i) {
                case 0:
                        ino = dentry->d_inode->i_ino;
			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                        if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
                                break;
                        filp->f_pos++;
                        i++;

-------

BTW, is this a kexec boot or normal boot? I don't know if this has any 
effect or not but just trying to find reasons behind messages like 
entering runlevel 1 etc..

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
