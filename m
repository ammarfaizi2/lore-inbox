Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTDWRpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTDWRpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:45:07 -0400
Received: from web8002.mail.in.yahoo.com ([203.199.70.20]:38978 "HELO
	web8005.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S264145AbTDWRpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:45:02 -0400
Message-ID: <20030423175333.7272.qmail@web8005.mail.in.yahoo.com>
Date: Wed, 23 Apr 2003 18:53:33 +0100 (BST)
From: =?iso-8859-1?q?Yours=20Lovingly?= <ylovingly@yahoo.co.in>
Subject: Re: Qn: Queer "Unable to handle kernel NULL pointer dereference at ..." error in kernel
To: Bryan Henderson <hbryan@us.ibm.com>, Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFAFB946CE.4BD085AE-ON87256D10.006801CE-88256D10.00683E0D@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am sorry for that useless information. i am
attaching  a ksymoops output of that problem (focus on
the register operation (that ksymoops identifies as
the fault triggering instruction) in the "code"
section at the end of the ksymoops output)

FIRST THE CHAOTIC CODE REVISITED:-

static void nfs_print_path(struct dentry *d) {
	struct dentry *parent;
	struct qstr *qs;
	char name[64];
	struct inode *inode_parent, *inode;
	void *p, *me;

	if(!d) { 
		return;
	}	
	parent = d->d_parent;
	qs = &d->d_name;
	
	if(parent)  {
		inode_parent = parent->d_inode;
		inode = d->d_inode;
		p = (void *)inode_parent;
		me = (void *)inode;
// Till here things work just fine. I am DEAD SURE of
that as i put printk()
// followed by return here and there and checked.

// My analysis with printk's and return's shows that
the next statement, or somewhere
// after that is the problem. ksymoops identifies the
fault triggering instrxn as
// 'cmp' (see output below) which (??) could be for
this statement.
		if( p - me != 0 ) {
			//nfs_print_path(parent);
			printk("return 3\n");
			return;
		}




KSYMOOPS output:

<1>Unable to handle kernel NULL pointer dereference at
virtual address 0000000f
c88b6956
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c88b6956>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000006   ebx: c6675024   ecx: 00000001   edx:
00000007
esi: 429d3663   edi: 0000005d   ebp: c6598cdc   esp:
c5b21f08
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 1996, stackpage=c5b21000)
Stack: 00000246 ffffffd2 c011b91b 0001ea92 0001ea96
00000282 0001ea96 0001ea8f 
       00000001 00000282 00000001 c033c964 00000000
00000004 c6598cdc c011bb41 
       c6675044 429d3663 c6675044 c88b80e2 c6675024
bffff930 c014f67e c71bf000 
Call Trace: [<c011b91b>] [<c011bb41>] [<c88b80e2>]
[<c014f67e>] [<c0151111>] 
   [<c014cd04>] [<c010775c>] [<c010766b>] 
Code: 39 42 08 74 0d 83 ec 0c 68 2c 81 8c c8 eb 0b 8d
76 00 83 ec 

>>EIP; c88b6956 <[nfs]nfs_print_path+2e/58> <=====
Trace; c011b91b <call_console_drivers+eb/100>
Trace; c011bb41 <printk+1a1/1f0>
Trace; c88b80e2 <[nfs]nfs_revalidate+116/1b0>
Trace; c014f67e <getname+5e/a0>
Trace; c0151111 <__user_walk+41/50>
Trace; c014cd04 <sys_lstat64+34/70>
Trace; c010775c <error_code+34/3c>
Trace; c010766b <system_call+33/38>
Code;  c88b6956 <[nfs]nfs_print_path+2e/58>
00000000 <_EIP>:
Code;  c88b6956 <[nfs]nfs_print_path+2e/58> <=====
   0:   39 42 08                  cmp   
%eax,0x8(%edx)   <=====
Code;  c88b6959 <[nfs]nfs_print_path+31/58>
3:   74 0d                     je     12 <_EIP+0x12>
c88b6968 <[nfs]nfs_print_path+40/58>
Code;  c88b695b <[nfs]nfs_print_path+33/58>
5:   83 ec 0c                  sub    $0xc,%esp
Code;  c88b695e <[nfs]nfs_print_path+36/58>
8:   68 2c 81 8c c8            push   $0xc88c812c
Code;  c88b6963 <[nfs]nfs_print_path+3b/58>
d:   eb 0b                     jmp    1a <_EIP+0x1a>
c88b6970 <[nfs]nfs_print_path+48/58>
Code;  c88b6965 <[nfs]nfs_print_path+3d/58>
f:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c88b6968 <[nfs]nfs_print_path+40/58>
12:   83 ec 00                  sub    $0x0,%esp


--- Jan Harkes <jaharkes@cs.cmu.edu> wrote: >
> > I guess your 'small' hack puts too much on the
stack
> resulting in a
> stackoverflow.
> > > More likely an error writing to 'p' and 'me'
> veriables on the stack.
> They are probably past the end of the stack,
> resulting in a pagefault
> which simply triggers the NULL ptr dereference
> message, because
> pagefaults should never occur in kernel space and
> typically indicate a
> bad pointer dereference.

--- Bryan Henderson <hbryan@us.ibm.com> wrote: > > I
agree that the statements in question can't cause
> that symptom.  (I don't
> even think the stack is being accessed -- looks like
> register operations to
> me).  I suspect your analysis is in error.  You may
> need to use a kernel
> debugger to figure this out.

so it does look like a plain register operation. so
whats so wrong ??
if u still think this info is really insufficient for
finding out whats
wrong can u suggest a nice kernel debugger(ksymoops i
all i use). note that this error is highly
reproducible  and not something that just went wrong
sometime.


regards
abhishek



________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
