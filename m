Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbQLFALv>; Tue, 5 Dec 2000 19:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbQLFALl>; Tue, 5 Dec 2000 19:11:41 -0500
Received: from magic.adaptec.com ([208.236.45.80]:27844 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S129183AbQLFAL0>; Tue, 5 Dec 2000 19:11:26 -0500
Message-ID: <E9EF680C48EAD311BDF400C04FA07B612D4D77@ntcexc02.ntc.adaptec.com>
From: "Boerner, Brian" <Brian_Boerner@adaptec.com>
To: "'Keith Owens'" <kaos@ocs.com.au>, "'ak@suse.de'" <ak@suse.de>,
        "'rmk@arm.linux.org.uk'" <rmk@arm.linux.org.uk>,
        "'Andrew Morton'" <morton@nortelnetworks.com>
Cc: "Boerner, Brian" <Brian_Boerner@adaptec.com>,
        "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: aacraid for 2.4.0 revisitied
Date: Tue, 5 Dec 2000 18:40:00 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You folks seem to be interested in this, so I thought I might bother for a
bit of follow up.

I would like to start off by thanking each of you for responding. I guess I
got into the 2.4 game a bit late and haven't been on linux-kernel in quite a
while. If anyone has any ideas on what I'm doing wrong, I would appreciate
it.

Both Russell and Keith seemed to think it was modutils. While this was
grossly out of date, it didn't solve the problem.

Andrew mentioned the __devinit and __devinitdata declarations. I'm not using
any of those, so I don't see a problem there. At least I'm not declaring
them.

Andi seems to think it's jumping before the detect function. Wouldn't that
get called first by the OS to "detect" the hardware?

I've seen two different issues now. One when I get an interrupt which
reports the error bug in sched.c:698.

Trying to get past this and figure out if it's a problem with my isr or with
the scheduler I've disabled I/O in the driver. No I/Os No Interrupts...

I get another oops. I'm not very efficient at reading these messages. To bad
the oops-tracing.txt file isn't in a little more detail. It seems you have
to be quite knowledgeable of the inner workings of the Linux kernel to
understand them, but I digress.

Looks like it's dying trying to make the procfs entry. However comparing
what the aic7xxx driver is doing and what I am doing produced no fruitful
output. 

If I enable interrupts and the opps I mentioned above it produced, it is
worthwhile to mention that the kernel just keeps looping oops messages over
and over until it runs out of memory, each time reporting a bug in
sched.c:698.

Some things I have verified needed to be done have been done:
dev->base_address[foo] has been changed to dev->resource[foo].start

I'm using pci_enable_device (though I'm not sure I'm using it in the correct
location)

not using cli/sti

It's been mentioned that the scsi proc has changed, but I don't see how it
effects me.

I've always allocated my irq using SA_SHIRQ and have never passed in a null
field for dev_id.

ksymoops 2.3.5 on i686 2.4.0-test11-dbg.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11-dbg/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0147b8b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0147b8b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: 00000000
esi: c882f7a0   edi: 00000000   ebp: c882f7a0   esp: c43e9e4c
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 866, stackpage=c43e9000)
Stack: c01d9ef8 00001011 00000046 00000000 00000000 c882f7a0 c7f905c0
c882f7a0 
       c01ab17a 00000000 c7f905c0 c4420234 c0120802 0000003f 000000e0
00000038 
       00000046 00000001 00000009 c882f669 00000009 90051364 c8822000
c8822000 
Call Trace: [<c01d9ef8>] [<c882f7a0>] [<c882f7a0>] [<c01ab17a>] [<c0120802>]
[<c882f669>] [<c8822000>] 
       [<c8822000>] [<c882f7a0>] [<c01a8c74>] [<c882f7a0>] [<c012a857>]
[<c8822000>] [<c8822bd9>] [<c882f7a0>] 
       [<c882f7a0>] [<c8822000>] [<c0118c65>] [<c8822060>] [<c0108f77>] 
Code: f2 ae f7 d1 49 6a 07 89 cd 8d 45 4d 50 e8 83 fc fd ff 89 c3 

>>EIP; c0147b8b <proc_mkdir+3b/c0>   <=====
Trace; c01d9ef8 <pci_find_device+18/20>
Trace; c882f7a0 <END_OF_CODE+8531cec/???
Trace; c882f7a0 <END_OF_CODE+8531cec/???
Trace; c01ab17a <build_proc_dir_entries+1a/b0>
Trace; c0120802 <do_anonymous_page+32/80>
Trace; c882f669 <END_OF_CODE+8531bb5/???
Trace; c8822000 <END_OF_CODE+852454c/???
Trace; c8822000 <END_OF_CODE+852454c/???
Trace; c882f7a0 <END_OF_CODE+8531cec/???
Trace; c01a8c74 <scsi_register_host+c4/2d0>
Trace; c882f7a0 <END_OF_CODE+8531cec/???
Trace; c012a857 <__alloc_pages_limit+87/b0>
Trace; c8822000 <END_OF_CODE+852454c/???
Trace; c8822bd9 <END_OF_CODE+8525125/???
Trace; c882f7a0 <END_OF_CODE+8531cec/???
Trace; c882f7a0 <END_OF_CODE+8531cec/???
Trace; c8822000 <END_OF_CODE+852454c/???
Trace; c0118c65 <sys_init_module+515/5d0>
Trace; c8822060 <END_OF_CODE+85245ac/???
Trace; c0108f77 <system_call+33/38>
Code;  c0147b8b <proc_mkdir+3b/c0>
00000000 <_EIP>:
Code;  c0147b8b <proc_mkdir+3b/c0>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c0147b8d <proc_mkdir+3d/c0>
   2:   f7 d1                     not    %ecx
Code;  c0147b8f <proc_mkdir+3f/c0>
   4:   49                        dec    %ecx
Code;  c0147b90 <proc_mkdir+40/c0>
   5:   6a 07                     push   $0x7
Code;  c0147b92 <proc_mkdir+42/c0>
   7:   89 cd                     mov    %ecx,%ebp
Code;  c0147b94 <proc_mkdir+44/c0>
   9:   8d 45 4d                  lea    0x4d(%ebp),%eax
Code;  c0147b97 <proc_mkdir+47/c0>
   c:   50                        push   %eax
Code;  c0147b98 <proc_mkdir+48/c0>
   d:   e8 83 fc fd ff            call   fffdfc95 <_EIP+0xfffdfc95> c0127820
<kmalloc+0/b0>
Code;  c0147b9d <proc_mkdir+4d/c0>
  12:   89 c3                     mov    %eax,%ebx


1 warning issued.  Results may not be reliable.

Brian M. Boerner
System Software Developer
Adaptec, Inc.
Nashua, NH 03060
(603) 579-4625


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
