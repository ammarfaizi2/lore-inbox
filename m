Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUDMBn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 21:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUDMBn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 21:43:29 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:48833 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263225AbUDMBnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 21:43:21 -0400
Date: Mon, 12 Apr 2004 16:47:38 -0400
From: Chris Shoemaker <chris.shoemaker@cox.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.4] Oops in filp_close (partial SOLUTION)
Message-ID: <20040412204737.GA1202@cox.net>
References: <20040401232734.GB8061@cox.net> <200404020838.09566.vda@port.imtp.ilyichevsk.odessa.ua> <20040403183551.GA1342@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403183551.GA1342@cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In summary, I'm still getting an oops almost every day, and none of the 
following have helped:
	- testing for flakiness w/ memtest and cpuburn (no faults)
	- reducing dma mode w/ hdparm nor BIOS
	- recompiling with conservative CONFIG_(ide_stuff) settings
	- decreasing number of loaded modules
[For background, you can refer to my last post of April 3rd.]

The oopses are consistently concurrent with IDE I/O, but I still 
don't know if that's symptom or cause.  Last week, I noticed the 
following oops with such a short call trace, so I disassembled to see 
what I could learn.  Here's what I found:

	The instruction at EIP (8b 50 2c) is mov 0x2c(%eax),%edx marked
below at address 1d3f.  It corresponds to the second part of the test
"if (filp->f_op && filp->f_op->flush)".  Now, %ebx (0xc36f7f5c) still
contains filp, which is probably valid, since filp->f_error was zero
(still in %esi).  %eax (0x46388060) is _supposed_ to contain filp->f_op, 
but it seems to actually be causing the page_fault instead.

	If I guess that this is a regular inode-backed filp (afterall,
the oops _was_ during disk activity) then f_op would have come from
ext3_{file|dir}_operations, and my ext3 is built-in, not a module.  So,
is it reasonable to find filp->f_op so "far" from filp (0x46388060 vs
0xc36f7f5c)?  I guessed not, and after poking around the code some more, 
I tried:

$ grep 388060 /boot/System.map
c0388060 D ext3_file_operations

	AHA!  So it _was_ a file, and %eax was supposed to be c0388060.  
So how does filp->f_op go from c0388060 to 46388060?  3 RAM bit-errors?  
That seems unlikely, especially since memtest86 runs for days with no 
problems.

	So now I'm looking for something that would corrupt the high 
byte of filp->f_op.  So far, this has taken me about one week (I'm 
slow ;)   I wanted to check back in with the list in case I'm on the 
wrong track.

	Any debugging advice?  If you were I, would you keep looking for
more info about this oops, or would you move to another oops?  My goal
is to eventually test (or submit) a patch that makes these oopses go
away.  Thanks!

 - Chris Shoemaker


Here's the oops:
Apr  4 17:16:12 peace kernel: Unable to handle kernel paging request at virtual address 4638808c
Apr  4 17:16:12 peace kernel:  printing eip:
Apr  4 17:16:12 peace kernel: c017c46f
Apr  4 17:16:12 peace kernel: *pde = 00000000
Apr  4 17:16:12 peace kernel: Oops: 0000 [#1]
Apr  4 17:16:12 peace kernel: PREEMPT DEBUG_PAGEALLOC
Apr  4 17:16:12 peace kernel: CPU:    0
Apr  4 17:16:12 peace kernel: EIP:    0060:[filp_close+47/128]    Not tainted
Apr  4 17:16:12 peace kernel: EFLAGS: 00013206
Apr  4 17:16:12 peace kernel: EIP is at filp_close+0x2f/0x80
Apr  4 17:16:12 peace kernel: eax: 46388060   ebx: c36f7f5c   ecx: 089a1950   edx: c5e4ee44
Apr  4 17:16:12 peace kernel: esi: 00000000   edi: c5e4ee44   ebp: c5e31fbc   esp: c5e31fac
Apr  4 17:16:12 peace kernel: ds: 007b   es: 007b   ss: 0068
Apr  4 17:16:12 peace kernel: Process XFree86 (pid: 1124, threadinfo=c5e30000 task=c5e4f9e0)
Apr  4 17:16:12 peace kernel: Stack: c0381664 00000026 089a1950 40187c40 c5e30000 c010a00b 00000026 089a1950
Apr  4 17:16:12 peace kernel:        4018f110 089a1950 40187c40 00000000 00000006 0000007b 0000007b 00000006
Apr  4 17:16:12 peace kernel:        401262f7 00000073 00003286 bffff4b4 0000007b
Apr  4 17:16:12 peace kernel: Call Trace:
Apr  4 17:16:12 peace kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr  4 17:16:12 peace kernel:
Apr  4 17:16:12 peace kernel: Code: 8b 50 2c 85 d2 75 2a 89 fa 89 d8 e8 41 bb 02 00 89 d8 89 fa


Here's the output of ksymoops:
ksymoops 2.4.9 on i686 2.6.4.  Options used
     -v /usr/src/linux-2.6.4/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.4/ (default)
     -m /boot/System.map-2.6.4 (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr  4 17:16:12 peace kernel: Unable to handle kernel paging request at virtual address 4638808c
Apr  4 17:16:12 peace kernel: c017c46f
Apr  4 17:16:12 peace kernel: *pde = 00000000
Apr  4 17:16:12 peace kernel: Oops: 0000 [#1]
Apr  4 17:16:12 peace kernel: CPU:    0
Apr  4 17:16:12 peace kernel: EIP:    0060:[filp_close+47/128]    Not tainted
Apr  4 17:16:12 peace kernel: EFLAGS: 00013206
Apr  4 17:16:12 peace kernel: eax: 46388060   ebx: c36f7f5c   ecx: 089a1950   edx: c5e4ee44
Apr  4 17:16:12 peace kernel: esi: 00000000   edi: c5e4ee44   ebp: c5e31fbc   esp: c5e31fac
Apr  4 17:16:12 peace kernel: ds: 007b   es: 007b   ss: 0068
Apr  4 17:16:12 peace kernel: Stack: c0381664 00000026 089a1950 40187c40 c5e30000 c010a00b 00000026 089a1950
Apr  4 17:16:12 peace kernel:        4018f110 089a1950 40187c40 00000000 00000006 0000007b 0000007b 00000006
Apr  4 17:16:12 peace kernel:        401262f7 00000073 00003286 bffff4b4 0000007b
Apr  4 17:16:12 peace kernel: Call Trace:
Apr  4 17:16:12 peace kernel: Code: 8b 50 2c 85 d2 75 2a 89 fa 89 d8 e8 41 bb 02 00 89 d8 89 fa
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 46388060 <__crc_skb_ip_make_writable+92257/186203>
>>ebx; c36f7f5c <__crc_filp_close+1e1a27/317acd>
>>ecx; 089a1950 <__crc_vlan_ioctl_set+3efe4f/56407d>
>>edx; c5e4ee44 <__crc_xfrm_policy_get_afinfo+fedcb/2d3b6a>
>>edi; c5e4ee44 <__crc_xfrm_policy_get_afinfo+fedcb/2d3b6a>
>>ebp; c5e31fbc <__crc_xfrm_policy_get_afinfo+e1f43/2d3b6a>
>>esp; c5e31fac <__crc_xfrm_policy_get_afinfo+e1f33/2d3b6a>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 50 2c                  mov    0x2c(%eax),%edx
Code;  00000003 Before first symbol
   3:   85 d2                     test   %edx,%edx
Code;  00000005 Before first symbol
   5:   75 2a                     jne    31 <_EIP+0x31>
Code;  00000007 Before first symbol
   7:   89 fa                     mov    %edi,%edx
Code;  00000009 Before first symbol
   9:   89 d8                     mov    %ebx,%eax
Code;  0000000b Before first symbol
   b:   e8 41 bb 02 00            call   2bb51 <_EIP+0x2bb51>
Code;  00000010 Before first symbol
  10:   89 d8                     mov    %ebx,%eax
Code;  00000012 Before first symbol
  12:   89 fa                     mov    %edi,%edx


Here's the source code of filp_close() in fs/open.c:
/*
 * "id" is the POSIX thread ID. We use the
 * files pointer for this..
 */
int filp_close(struct file *filp, fl_owner_t id)
{
	int retval;

	/* Report and clear outstanding errors */
	retval = filp->f_error;
	if (retval)
		filp->f_error = 0;

	if (!file_count(filp)) {
		printk(KERN_ERR "VFS: Close: file count is 0\n");
		return retval;
	}

	if (filp->f_op && filp->f_op->flush) {
		int err = filp->f_op->flush(filp);
		if (!retval)
			retval = err;
	}

	dnotify_flush(filp, id);
	locks_remove_posix(filp, id);
	fput(filp);
	return retval;
}

EXPORT_SYMBOL(filp_close);


and here's the objdump output for filp_close:

1d10 <filp_close>:
    1d10:	55                   	push   %ebp
    1d11:	89 e5                	mov    %esp,%ebp
    1d13:	83 ec 10             	sub    $0x10,%esp
    1d16:	89 5d f4             	mov    %ebx,0xfffffff4(%ebp)
    1d19:	89 c3                	mov    %eax,%ebx
    1d1b:	89 7d fc             	mov    %edi,0xfffffffc(%ebp)
    1d1e:	89 d7                	mov    %edx,%edi
    1d20:	89 75 f8             	mov    %esi,0xfffffff8(%ebp)
    1d23:	8b 70 44             	mov    0x44(%eax),%esi
    1d26:	85 f6                	test   %esi,%esi
    1d28:	74 07                	je     1d31 <filp_close+0x21>
    1d2a:	c7 40 44 00 00 00 00 	movl   $0x0,0x44(%eax)
    1d31:	8b 43 14             	mov    0x14(%ebx),%eax
    1d34:	85 c0                	test   %eax,%eax
    1d36:	74 48                	je     1d80 <filp_close+0x70>
    1d38:	8b 43 10             	mov    0x10(%ebx),%eax
    1d3b:	85 c0                	test   %eax,%eax
    1d3d:	74 07                	je     1d46 <filp_close+0x36>
    1d3f:	8b 50 2c             	mov    0x2c(%eax),%edx
    1d42:	85 d2                	test   %edx,%edx
    1d44:	75 2a                	jne    1d70 <filp_close+0x60>
    1d46:	89 fa                	mov    %edi,%edx
    1d48:	89 d8                	mov    %ebx,%eax
    1d4a:	e8 fc ff ff ff       	call   1d4b <filp_close+0x3b>
    1d4f:	89 d8                	mov    %ebx,%eax
    1d51:	89 fa                	mov    %edi,%edx
    1d53:	e8 fc ff ff ff       	call   1d54 <filp_close+0x44>
    1d58:	89 d8                	mov    %ebx,%eax
    1d5a:	e8 fc ff ff ff       	call   1d5b <filp_close+0x4b>
    1d5f:	89 f0                	mov    %esi,%eax
    1d61:	8b 5d f4             	mov    0xfffffff4(%ebp),%ebx
    1d64:	8b 75 f8             	mov    0xfffffff8(%ebp),%esi
    1d67:	8b 7d fc             	mov    0xfffffffc(%ebp),%edi
    1d6a:	89 ec                	mov    %ebp,%esp
    1d6c:	5d                   	pop    %ebp
    1d6d:	c3                   	ret    
    1d6e:	89 f6                	mov    %esi,%esi
    1d70:	89 d8                	mov    %ebx,%eax
    1d72:	ff d2                	call   *%edx
    1d74:	85 f6                	test   %esi,%esi
    1d76:	0f 44 f0             	cmove  %eax,%esi
    1d79:	eb cb                	jmp    1d46 <filp_close+0x36>
    1d7b:	90                   	nop    
    1d7c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
    1d80:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp,1)
    1d87:	e8 fc ff ff ff       	call   1d88 <filp_close+0x78>
    1d8c:	eb d1                	jmp    1d5f <filp_close+0x4f>
    1d8e:	89 f6                	mov    %esi,%esi


