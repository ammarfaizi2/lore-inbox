Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRIJPef>; Mon, 10 Sep 2001 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271320AbRIJPe0>; Mon, 10 Sep 2001 11:34:26 -0400
Received: from ns.ithnet.com ([217.64.64.10]:27909 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271278AbRIJPeQ>;
	Mon, 10 Sep 2001 11:34:16 -0400
Date: Mon, 10 Sep 2001 17:34:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Erik DeBill <erik@www.creditminders.com>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: nfs client oops, all 2.4 kernels
Message-Id: <20010910173420.11d2fa71.skraw@ithnet.com>
In-Reply-To: <20010910100202.A14106@www.creditminders.com>
In-Reply-To: <20010910100202.A14106@www.creditminders.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001 10:02:02 -0500 Erik DeBill <erik@www.creditminders.com>
wrote:

> I've been running into a repeatable oops in the NFS client code,
> apparently related to file locking.
> Sep 10 08:49:10 jerry kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
> Sep 10 08:49:10 jerry kernel: c0146cab
> Sep 10 08:49:10 jerry kernel: *pde = 00000000
> Sep 10 08:49:10 jerry kernel: Oops: 0000
> Sep 10 08:49:10 jerry kernel: CPU:    0
> Sep 10 08:49:10 jerry kernel: EIP:    0010:[fcntl_setlease+171/640]
> Sep 10 08:49:10 jerry kernel: EIP:    0010:[<c0146cab>]
> Sep 10 08:49:10 jerry kernel: EFLAGS: 00010286
> Sep 10 08:49:10 jerry kernel: eax: 00000000   ebx: 00000000   ecx: c7302b60  
edx: c7926b88
> Sep 10 08:49:10 jerry kernel: esi: c4275240   edi: 00000000   ebp: bfffba10  
esp: c5d8df60
> Sep 10 08:49:10 jerry kernel: ds: 0018   es: 0018   ss: 0018
> Sep 10 08:49:10 jerry kernel: Process db2sysc (pid: 774, stackpage=c5d8d000)
> Sep 10 08:49:10 jerry kernel: Stack: c7926b2c c7926b88 c4275240 00000000
c7926b88 c4275240 c01488f6 c7926b88 
> Sep 10 08:49:11 jerry kernel:        00000000 c5d8c000 c71e30c0 c013512d
c71e30c0 c4275240 00000000 c71e30c0 
> Sep 10 08:49:11 jerry kernel:        00000000 c71e30c0 00000030 00000000
c013519b c71e30c0 c4275240 c5d8c000 
> Sep 10 08:49:11 jerry kernel: Call Trace: [d_validate+54/224]
[sys_chdir+253/256] [sys_fchdir+107/208] [system_call+19/56] 
> Sep 10 08:49:11 jerry kernel: Call Trace: [<c01488f6>] [<c013512d>]
[<c013519b>] [<c0106edb>] 
> Sep 10 08:49:11 jerry kernel: Code: 8b 03 8d 73 04 89 02 8b 43 04 c7 03 00 00
00 00 8b 56 04 89 
> 
> >>EIP; c0146cab <locks_delete_lock+b/d0>   <=====
> Trace; c01488f6 <locks_remove_posix+86/e0>
> Trace; c013512d <filp_close+9d/b0>
> Trace; c013519b <sys_close+5b/70>
> Trace; c0106edb <system_call+33/38>
> Code;  c0146cab <locks_delete_lock+b/d0>
> 00000000 <_EIP>:
> Code;  c0146cab <locks_delete_lock+b/d0>   <=====
>    0:   8b 03                     mov    (%ebx),%eax   <=====
> Code;  c0146cad <locks_delete_lock+d/d0>
>    2:   8d 73 04                  lea    0x4(%ebx),%esi
> Code;  c0146cb0 <locks_delete_lock+10/d0>
>    5:   89 02                     mov    %eax,(%edx)
> Code;  c0146cb2 <locks_delete_lock+12/d0>
>    7:   8b 43 04                  mov    0x4(%ebx),%eax
> Code;  c0146cb5 <locks_delete_lock+15/d0>
>    a:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
> Code;  c0146cbb <locks_delete_lock+1b/d0>
>   10:   8b 56 04                  mov    0x4(%esi),%edx
> Code;  c0146cbe <locks_delete_lock+1e/d0>
>   13:   89 00                     mov    %eax,(%eax)
> 

Hm, I am sure no nfs or fs guru, but looking at

static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
{
        struct file_lock *fl = *thisfl_p;

        *thisfl_p = fl->fl_next;
        fl->fl_next = NULL;

        list_del(&fl->fl_link);
        INIT_LIST_HEAD(&fl->fl_link);

        fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
        if (fl->fl_fasync != NULL){
                printk(KERN_ERR "locks_delete_lock: fasync == %p\n",
fl->fl_fasync);
                fl->fl_fasync = NULL;
        }

        if (fl->fl_remove)
                fl->fl_remove(fl);

        locks_wake_up_blocks(fl, wait);
        locks_free_lock(fl);
}

in linux/fs/locks.c I would say it fails either because thisfl_p is NULL or
*thisfl_p is NULL. Try securing it via:


static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
{
        struct file_lock *fl;
	
	if (thisfl_p == NULL || *thisfl_p == NULL)
		return;

	fl = *thisfl_p;

        *thisfl_p = fl->fl_next;
        fl->fl_next = NULL;

...
}

This is for sure not the cure, but may help your setup.

Regards,
Stephan


