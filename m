Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVBVWvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVBVWvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVBVWvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:51:07 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:3059 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261324AbVBVWtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:49:25 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6: USB Storage hangs machine on bootup for ~2 minutes
Date: Tue, 22 Feb 2005 17:49:13 -0500
User-Agent: KMail/1.7.92
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0502221525200.6861-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0502221525200.6861-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pb7GCC7EUTfR5hb"
Message-Id: <200502221749.13372.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pb7GCC7EUTfR5hb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 February 2005 03:41 pm, Alan Stern wrote:
> usb_device_read acquires a couple of locks, one for the USB bus list and
> one for the root hub of the bus it's looking at. =A0I don't know which one
> occurs at offset 229 on your system -- maybe you can tell. =A0Oddly enoug=
h,
> neither of those locks is for a USB device like the Maxtor drive. =A0So i=
t's
> not at all clear why plugging in the drive should mess up kudzu. =A0Or why
> the blockage should clear up after a couple of minutes.
>
> Perhaps we can find out by looking at other entries in the stack trace. =
=A0
> Of particular interest are the khubd, usb-storage, and scsi_eh processes.

Alan,
See below for stack traces and also note that the stack traces are after I=
=20
modified usb_device_read to do down_interruptible instead of down. (kudzu=20
gets stuck regardless though.) Let me know if you want me to revert the=20
down_interruptible change and repost the stack trace.

I wrongly related this to the 2 minute hang - this one is forever if I let=
=20
kudzu start during boot. If I run kudzu after boot is complete, it gets stu=
ck=20
and everything else on that drive (mount, unmount ..) also gets stuck. Sorr=
y=20
about the confusion.

Attached is the disassembly of usb_device_read from my machine.

Parag

SysRQ + T for relevant processes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
hald          D 00000020e12be31a     0  2558      1          3272  2545=20
(NOTLB)
ffff81002c76fb48 0000000000000082 ffff81002c76fb28 ffffffff88515044
       000000862c76fb08 ffff81002eb10800 0000000000000249 ffff810001c56030
       ffff81002c76fc08 0000000000000002
Call Trace:
<ffffffff88515044>{:scsi_mod:scsi_request_fn+2356}
       <ffffffff80385f0f>{io_schedule+15} <ffffffff801698d6>{sync_page+70}
       <ffffffff80386295>{__wait_on_bit_lock+69}=20
<ffffffff80169890>{sync_page+0}
       <ffffffff8016a1b7>{__lock_page+167}=20
<ffffffff8015c860>{wake_bit_function+0}
       <ffffffff8015c860>{wake_bit_function+0}=20
<ffffffff8016aed4>{do_generic_mapping_read+660}
       <ffffffff8016b1f0>{file_read_actor+0}=20
<ffffffff8016d1d4>{__generic_file_aio_read+420}
       <ffffffff8016d39b>{generic_file_read+187}=20
<ffffffff8015c820>{autoremove_wake_function+0}
       <ffffffff80186150>{do_brk+720} <ffffffff801998d1>{vfs_read+225}
       <ffffffff80199bd0>{sys_read+80} <ffffffff8010ed1e>{system_call+126}

 scsi_eh_2     D 00000000ffffffff     0  3581      1          3582  3277=20
(L-TLB)
 ffff81002bdc1d88 0000000000000046 00000000000001e3 ffff81002bed8800
        ffff81002bdc1d48 ffff81002c25a800 0000000000000812 ffffffff803df080
        ffff81002bdc1ed0 ffff81002c25a800
 Call Trace:
 <ffffffff803846d5>{wait_for_completion+437}=20
<ffffffff80133e30>{default_wake_function+0}
        <ffffffff80133e30>{default_wake_function+0}=20
<ffffffff88535be3>{:usb_storage:usb_stor_stop_transport+35}
        <ffffffff88534250>{:usb_storage:command_abort+256}
        <ffffffff88511f9c>{:scsi_mod:scsi_error_handler+2172}
        <ffffffff8010f7ef>{child_rip+8}=20
<ffffffff88511720>{:scsi_mod:scsi_error_handler+0}
        <ffffffff8010f7e7>{child_rip+0}
 usb-storage   D 00000000ffffffff     0  3582      1          3627  3581=20
(L-TLB)
 ffff81002b8e1c08 0000000000000046 ffff81002b9e1000 0000000000000010
        000000762b8e1c98 ffff81002bed8800 00000000000003dd ffff81002eb10800
        00000000c0040280 000000000000001f
 Call Trace:
 <ffffffff803846d5>{wait_for_completion+437}=20
<ffffffff803843e1>{thread_return+253}
        <ffffffff80133e30>{default_wake_function+0}=20
<ffffffff80133e30>{default_wake_function+0}
        <ffffffff88535166>{:usb_storage:usb_stor_msg_common+550}
        <ffffffff80120426>{dma_unmap_sg+134}=20
<ffffffff8853570f>{:usb_storage:usb_stor_bulk_transfer_buf+143}
        <ffffffff88535f8b>{:usb_storage:usb_stor_Bulk_transport+203}
        <ffffffff885358eb>{:usb_storage:usb_stor_invoke_transport+59}
        <ffffffff88534dfb>{:usb_storage:usb_stor_transparent_scsi_command+2=
7}
        <ffffffff88536974>{:usb_storage:usb_stor_control_thread+756}
        <ffffffff801337c3>{finish_task_switch+195}=20
<ffffffff8010f7ef>{child_rip+8}
        <ffffffff88536680>{:usb_storage:usb_stor_control_thread+0}
        <ffffffff8010f7e7>{child_rip+0}

 scsi_eh_3     S 00000000ffffffff     0  3627      1          3634  3582=20
(L-TLB)
 ffff81002bd47d68 0000000000000046 ffff81002bd47d28 ffffffff80219b32
        000000742bc387c0 ffff81002bc387c0 0000000000000226 ffff81002b9fc030
        ffff81002bd47d48 ffffffff80147ab1
 Call Trace:
 <ffffffff80219b32>{_atomic_dec_and_lock+290} <ffffffff80147ab1>{free_uid+3=
3}
        <ffffffff80383bd6>{__down_interruptible+486}=20
<ffffffff80133e30>{default_wake_function+0}
        <ffffffff80386928>{__down_failed_interruptible+53}
        <ffffffff88512a75>{:scsi_mod:.text.lock.scsi_error+45}
        <ffffffff8010f7ef>{child_rip+8}=20
<ffffffff88511720>{:scsi_mod:scsi_error_handler+0}
        <ffffffff8010f7e7>{child_rip+0}
 usb-storage   S 00000020f04e3d81     0  3634      1                3627=20
(L-TLB)
 ffff81002bc53df8 0000000000000046 ffff81002bc53d80 0000000000001000
        000000732b9eba7c ffff81002b9fc030 00000000000005ad ffff81002ebc9800
        ffff81002bc53de8 ffffffff8853570f
 Call Trace:
 <ffffffff8853570f>{:usb_storage:usb_stor_bulk_transfer_buf+143}
        <ffffffff80383bd6>{__down_interruptible+486}=20
<ffffffff80133e30>{default_wake_function+0}
        <ffffffff80386928>{__down_failed_interruptible+53}
        <ffffffff88537bb8>{:usb_storage:.text.lock.usb+5}=20
<ffffffff801337c3>{finish_task_switch+195}
        <ffffffff8010f7ef>{child_rip+8}=20
<ffffffff88536680>{:usb_storage:usb_stor_control_thread+0}
       <ffffffff8010f7e7>{child_rip+0}

khubd         S 0000001ddd381da1     0   125      1           182     9=20
(L-TLB)
ffff810001ecbe18 0000000000000046 0000000000000246 ffff81002ba2c400
       0000007401ecbdd8 ffff810001e9a800 0000000000003023 ffff81002bed8070
       ffff810001ecbe18 ffffffff8015c4c9
Call Trace:
<ffffffff8015c4c9>{prepare_to_wait+345} <ffffffff802e0216>{hub_thread+4118}
       <ffffffff8016f0cf>{free_pages_bulk+1007}=20
<ffffffff8015c820>{autoremove_wake_function+0}
       <ffffffff8015c820>{autoremove_wake_function+0}=20
<ffffffff8010f7ef>{child_rip+8}
       <ffffffff802df200>{hub_thread+0} <ffffffff8010f7e7>{child_rip+0}



--Boundary-00=_pb7GCC7EUTfR5hb
Content-Type: text/plain;
  charset="iso-8859-1";
  name="usb_dv_rd.dis"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb_dv_rd.dis"

0000000000000970 <usb_device_read>:
 970:	55                   	push   %rbp
 971:	48 89 e5             	mov    %rsp,%rbp
 974:	48 83 ec 60          	sub    $0x60,%rsp
 978:	4c 89 75 f0          	mov    %r14,0xfffffffffffffff0(%rbp)
 97c:	4c 89 7d f8          	mov    %r15,0xfffffffffffffff8(%rbp)
 980:	45 31 ff             	xor    %r15d,%r15d
 983:	48 89 55 d0          	mov    %rdx,0xffffffffffffffd0(%rbp)
 987:	48 89 5d d8          	mov    %rbx,0xffffffffffffffd8(%rbp)
 98b:	49 89 ce             	mov    %rcx,%r14
 98e:	4c 89 65 e0          	mov    %r12,0xffffffffffffffe0(%rbp)
 992:	4c 89 6d e8          	mov    %r13,0xffffffffffffffe8(%rbp)
 996:	48 c7 c2 ea ff ff ff 	mov    $0xffffffffffffffea,%rdx
 99d:	48 89 75 c0          	mov    %rsi,0xffffffffffffffc0(%rbp)
 9a1:	48 8b 01             	mov    (%rcx),%rax
 9a4:	48 85 c0             	test   %rax,%rax
 9a7:	48 89 45 c8          	mov    %rax,0xffffffffffffffc8(%rbp)
 9ab:	0f 88 63 01 00 00    	js     b14 <usb_device_read+0x1a4>
 9b1:	31 d2                	xor    %edx,%edx
 9b3:	48 83 7d d0 00       	cmpq   $0x0,0xffffffffffffffd0(%rbp)
 9b8:	0f 84 56 01 00 00    	je     b14 <usb_device_read+0x1a4>
 9be:	48 89 f2             	mov    %rsi,%rdx
 9c1:	65 48 8b 04 25 18 00 	mov    %gs:0x18,%rax
 9c8:	00 00 
 9ca:	48 03 55 d0          	add    0xffffffffffffffd0(%rbp),%rdx
 9ce:	48 19 c9             	sbb    %rcx,%rcx
 9d1:	48 39 90 48 e0 ff ff 	cmp    %rdx,0xffffffffffffe048(%rax)
 9d8:	48 83 d9 00          	sbb    $0x0,%rcx
 9dc:	48 85 c9             	test   %rcx,%rcx
 9df:	48 89 c8             	mov    %rcx,%rax
 9e2:	48 c7 c2 f2 ff ff ff 	mov    $0xfffffffffffffff2,%rdx
 9e9:	0f 85 25 01 00 00    	jne    b14 <usb_device_read+0x1a4>
 9ef:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 9f6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 9fd:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13
 a04:	e8 00 00 00 00       	callq  a09 <usb_device_read+0x99>
 a09:	be 84 00 00 00       	mov    $0x84,%esi
 a0e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 a15:	e8 00 00 00 00       	callq  a1a <usb_device_read+0xaa>
 a1a:	4c 89 ef             	mov    %r13,%rdi
 a1d:	ff 0d 00 00 00 00    	decl   0(%rip)        # a23 <usb_device_read+0xb3>
 a23:	0f 88 c8 02 00 00    	js     cf1 <.text.lock.devices+0x14>
 a29:	31 c0                	xor    %eax,%eax
 a2b:	4c 63 e0             	movslq %eax,%r12
 a2e:	4d 85 e4             	test   %r12,%r12
 a31:	4c 89 e2             	mov    %r12,%rdx
 a34:	0f 85 da 00 00 00    	jne    b14 <usb_device_read+0x1a4>
 a3a:	eb 17                	jmp    a53 <usb_device_read+0xe3>
 a3c:	4c 89 ef             	mov    %r13,%rdi
 a3f:	ff 05 00 00 00 00    	incl   0(%rip)        # a45 <usb_device_read+0xd5>
 a45:	0f 8e b0 02 00 00    	jle    cfb <.text.lock.devices+0x1e>
 a4b:	4c 89 e2             	mov    %r12,%rdx
 a4e:	e9 c1 00 00 00       	jmpq   b14 <usb_device_read+0x1a4>
 a53:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 a5a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 a61:	31 c0                	xor    %eax,%eax
 a63:	e8 00 00 00 00       	callq  a68 <usb_device_read+0xf8>
 a68:	48 8b 15 00 00 00 00 	mov    0(%rip),%rdx        # a6f <usb_device_read+0xff>
 a6f:	48 8d 5a c0          	lea    0xffffffffffffffc0(%rdx),%rbx
 a73:	48 8b 43 40          	mov    0x40(%rbx),%rax
 a77:	0f 18 08             	prefetcht0 (%rax)
 a7a:	48 81 fa 00 00 00 00 	cmp    $0x0,%rdx
 a81:	74 6a                	je     aed <usb_device_read+0x17d>
 a83:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
 a87:	48 85 ff             	test   %rdi,%rdi
 a8a:	74 54                	je     ae0 <usb_device_read+0x170>
 a8c:	e8 00 00 00 00       	callq  a91 <usb_device_read+0x121>
 a91:	4c 8b 43 38          	mov    0x38(%rbx),%r8
 a95:	48 8d 55 c8          	lea    0xffffffffffffffc8(%rbp),%rdx
 a99:	48 8d 75 d0          	lea    0xffffffffffffffd0(%rbp),%rsi
 a9d:	48 8d 7d c0          	lea    0xffffffffffffffc0(%rbp),%rdi
 aa1:	49 89 d9             	mov    %rbx,%r9
 aa4:	4c 89 f1             	mov    %r14,%rcx
 aa7:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%rsp)
 aae:	00 
 aaf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%rsp)
 ab6:	00 
 ab7:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
 abe:	e8 bd f5 ff ff       	callq  80 <usb_device_dump>
 ac3:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
 ac7:	49 89 c4             	mov    %rax,%r12
 aca:	e8 00 00 00 00       	callq  acf <usb_device_read+0x15f>
 acf:	4d 85 e4             	test   %r12,%r12
 ad2:	0f 88 64 ff ff ff    	js     a3c <usb_device_read+0xcc>
 ad8:	4d 01 e7             	add    %r12,%r15
 adb:	66                   	data16
 adc:	66                   	data16
 add:	90                   	nop    
 ade:	66                   	data16
 adf:	90                   	nop    
 ae0:	48 8b 53 40          	mov    0x40(%rbx),%rdx
 ae4:	48 8d 42 c0          	lea    0xffffffffffffffc0(%rdx),%rax
 ae8:	48 89 c3             	mov    %rax,%rbx
 aeb:	eb 86                	jmp    a73 <usb_device_read+0x103>
 aed:	4c 89 ef             	mov    %r13,%rdi
 af0:	ff 05 00 00 00 00    	incl   0(%rip)        # af6 <usb_device_read+0x186>
 af6:	0f 8e 09 02 00 00    	jle    d05 <.text.lock.devices+0x28>
 afc:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 b03:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 b0a:	31 c0                	xor    %eax,%eax
 b0c:	e8 00 00 00 00       	callq  b11 <usb_device_read+0x1a1>
 b11:	4c 89 fa             	mov    %r15,%rdx
 b14:	48 8b 5d d8          	mov    0xffffffffffffffd8(%rbp),%rbx
 b18:	4c 8b 65 e0          	mov    0xffffffffffffffe0(%rbp),%r12
 b1c:	48 89 d0             	mov    %rdx,%rax
 b1f:	4c 8b 6d e8          	mov    0xffffffffffffffe8(%rbp),%r13
 b23:	4c 8b 75 f0          	mov    0xfffffffffffffff0(%rbp),%r14
 b27:	4c 8b 7d f8          	mov    0xfffffffffffffff8(%rbp),%r15
 b2b:	c9                   	leaveq 
 b2c:	c3                   	retq   
 b2d:	66                   	data16
 b2e:	66                   	data16
 b2f:	90                   	nop    


--Boundary-00=_pb7GCC7EUTfR5hb--
