Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275467AbTHNUL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275466AbTHNUL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:11:27 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:11906 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S275487AbTHNUJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:09:38 -0400
Message-ID: <3F3BED6F.1090407@pacbell.net>
Date: Thu, 14 Aug 2003 13:13:35 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3 oops in cfb_imgblt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oops happens within a few seconds of starting up a 2.6.0-test3
kernel using statically linked framebuffer console code.  Seemingly
the killer is when the output gets near the last line of the screen.
It happens consistently, making this unusable ... but for the few
moments before it oopses, I finally get a full screen text console!

It's elderly hardware that's been pretty happy with Linux from day one,
although this is the first time I've gotten the 2.6 console FB code to
work even this well with it -- so in that sense this is progress, though
it's a regression from 2.4 kernels.  (Where I didn't use FB_NEOMAGIC; but
then, FB_VESA never yet worked on 2.6 when I tried it, so I didn't even
try it this time.)  When the FB kicks in, dmesg reports this:

	neofb: mapped io at c5000000
	Autodetected internal display
	Panel is a 800x600 color TFT display
	neofb: mapped framebuffer at c5201000
	neofb v0.4.1: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
	fb0: MagicGraph 128XD frame buffer device
	Console: switching to colour frame buffer device 100x37

At that point the logo finally shows up and then most of the screen (below
the penguin) turns white; the white scrolls of as more messages appear.

When the login screen finally appears, there are display turds near the
bottom of the region where the logo filled the screen.  Then I log
in, use the (non-X11) console for a minute, and get the oops when the
display nears the bottom of the screen.  I include the oops and the
"drivers/video/cfbimgblt.lst" -- no C code here for some reason.

I think that counts as three bugs:  the white bits and display turds
can be ignored, the oops can't.

Known problems?  Suggestions?  Patches?

- Dave


Unable to handle kernel paging request at virtual address c54011c0
  printing eip:
c01c4e54
*pde = 011db067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01c4e54>]    Not tainted
EFLAGS: 00010246
EIP is at cfb_imageblit+0x2d4/0x6a0
eax: 00000000   ebx: c11cd7a4   ecx: c0254dc0   edx: 00000000
esi: 00000004   edi: 00000001   ebp: c54011c0   esp: c338ba18
ds: 007b   es: 007b   ss: 0068
Process tail (pid: 635, threadinfo=c338a000 task=c3f7c6c0)
Stack: c010a667 0000004b c3d42666 c11cd689 00000001 c0108f78 00000008 00000000
        c11ee87c c3d42666 c11cd689 00000001 00000001 0000007b 0000007b ffffff00
        c01bd94d 00000060 00000282 0000004c c0254dc0 c11cd7a4 07070707 0000000f
Call Trace:
  [<c010a667>] do_IRQ+0xe7/0x100
  [<c0108f78>] common_interrupt+0x18/0x20
  [<c01bd94d>] sys_outbuf+0xd/0x30
  [<c01b9c58>] putcs_aligned+0x188/0x1d0
  [<c01b9fa1>] accel_putcs+0x91/0xc0
  [<c012d188>] __alloc_pages+0x88/0x2f0
  [<c01bacf7>] fbcon_putcs+0x77/0x80
  [<c019c15b>] vt_console_print+0x28b/0x2f0
  [<c0116649>] __call_console_drivers+0x39/0x50
  [<c01167af>] call_console_drivers+0xdf/0xf0
  [<c01169ae>] release_console_sem+0x2e/0x90
  [<c0116933>] printk+0x103/0x110
  [<c01121ef>] do_page_fault+0x29f/0x477
  [<c010a667>] do_IRQ+0xe7/0x100
  [<c0108f78>] common_interrupt+0x18/0x20
  [<c01c4c3c>] cfb_imageblit+0xbc/0x6a0
  [<c0111f50>] do_page_fault+0x0/0x477
  [<c0108fbd>] error_code+0x2d/0x40
  [<c01c3b28>] bitfill32+0x68/0xf0
  [<c01c3ac0>] bitfill32+0x0/0xf0
  [<c01c40c5>] cfb_fillrect+0x1b5/0x2c0
  [<c01ba0c6>] accel_clear_margins+0xf6/0x100
  [<c01bb9f3>] fbcon_scroll+0x4c3/0xa30
  [<c0197e67>] scrup+0x77/0x150
  [<c019949f>] lf+0x2f/0x70
  [<c019a916>] do_con_trol+0x1a6/0xff0
  [<c019bd3b>] do_con_write+0x5db/0x6b0
  [<c019c3fc>] con_put_char+0x2c/0x40
  [<c018d565>] opost+0x1c5/0x1d0
  [<c018f69c>] write_chan+0x16c/0x220
  [<c0113800>] default_wake_function+0x0/0x20
  [<c0113800>] default_wake_function+0x0/0x20
  [<c018aa0d>] tty_write+0x19d/0x230
  [<c018f530>] write_chan+0x0/0x220
  [<c014103a>] vfs_write+0xaa/0xe0
  [<c0148f32>] sys_fstat64+0x22/0x30
  [<c014fb57>] sys_ioctl+0x207/0x220
  [<c01410ed>] sys_write+0x2d/0x50
  [<c0108d57>] syscall_call+0x7/0xb

Code: 89 45 00 83 c5 04 85 f6 75 06 be 08 00 00 00 43 8b 44 24 04

======================================================

c01c4b80 <cfb_imageblit>:
c01c4b80:	55                   	push   %ebp
c01c4b81:	57                   	push   %edi
c01c4b82:	56                   	push   %esi
c01c4b83:	53                   	push   %ebx
c01c4b84:	81 ec 84 00 00 00    	sub    $0x84,%esp
c01c4b8a:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c4b91:	8b 94 24 9c 00 00 00 	mov    0x9c(%esp,1),%edx
c01c4b98:	8b 40 24             	mov    0x24(%eax),%eax
c01c4b9b:	89 44 24 74          	mov    %eax,0x74(%esp,1)
c01c4b9f:	8b 84 24 9c 00 00 00 	mov    0x9c(%esp,1),%eax
c01c4ba6:	8b 40 08             	mov    0x8(%eax),%eax
c01c4ba9:	89 44 24 70          	mov    %eax,0x70(%esp,1)
c01c4bad:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c4bb4:	8b 0a                	mov    (%edx),%ecx
c01c4bb6:	8b 5a 04             	mov    0x4(%edx),%ebx
c01c4bb9:	8b 78 14             	mov    0x14(%eax),%edi
c01c4bbc:	89 ca                	mov    %ecx,%edx
c01c4bbe:	8b 68 18             	mov    0x18(%eax),%ebp
c01c4bc1:	39 fa                	cmp    %edi,%edx
c01c4bc3:	0f 87 46 06 00 00    	ja     c01c520f <cfb_imageblit+0x68f>

c01c4bc9:	89 d8                	mov    %ebx,%eax
c01c4bcb:	39 e8                	cmp    %ebp,%eax
c01c4bcd:	0f 87 3c 06 00 00    	ja     c01c520f <cfb_imageblit+0x68f>

c01c4bd3:	8b 6c 24 70          	mov    0x70(%esp,1),%ebp
c01c4bd7:	89 f8                	mov    %edi,%eax
c01c4bd9:	01 ea                	add    %ebp,%edx
c01c4bdb:	39 d0                	cmp    %edx,%eax
c01c4bdd:	7e 02                	jle    c01c4be1 <cfb_imageblit+0x61>

c01c4bdf:	89 d0                	mov    %edx,%eax
c01c4be1:	89 c2                	mov    %eax,%edx
c01c4be3:	8b 7c 24 74          	mov    0x74(%esp,1),%edi
c01c4be7:	29 ca                	sub    %ecx,%edx
c01c4be9:	89 54 24 70          	mov    %edx,0x70(%esp,1)
c01c4bed:	8b 94 24 98 00 00 00 	mov    0x98(%esp,1),%edx
c01c4bf4:	0f af cf             	imul   %edi,%ecx
c01c4bf7:	8b 82 d8 00 00 00    	mov    0xd8(%edx),%eax
c01c4bfd:	0f af d8             	imul   %eax,%ebx
c01c4c00:	83 e0 03             	and    $0x3,%eax
c01c4c03:	c1 e0 03             	shl    $0x3,%eax
c01c4c06:	8d 14 d9             	lea    (%ecx,%ebx,8),%edx
c01c4c09:	8b 8c 24 98 00 00 00 	mov    0x98(%esp,1),%ecx
c01c4c10:	89 44 24 78          	mov    %eax,0x78(%esp,1)
c01c4c14:	89 d3                	mov    %edx,%ebx
c01c4c16:	89 d7                	mov    %edx,%edi
c01c4c18:	c1 eb 03             	shr    $0x3,%ebx
c01c4c1b:	8b 81 c8 01 00 00    	mov    0x1c8(%ecx),%eax
c01c4c21:	81 e3 fc ff ff 1f    	and    $0x1ffffffc,%ebx
c01c4c27:	8b b1 cc 01 00 00    	mov    0x1cc(%ecx),%esi
c01c4c2d:	8b 40 3c             	mov    0x3c(%eax),%eax
c01c4c30:	83 e7 1f             	and    $0x1f,%edi
c01c4c33:	01 f3                	add    %esi,%ebx
c01c4c35:	85 c0                	test   %eax,%eax
c01c4c37:	74 04                	je     c01c4c3d <cfb_imageblit+0xbd>

c01c4c39:	51                   	push   %ecx
c01c4c3a:	ff d0                	call   *%eax

c01c4c3c:	59                   	pop    %ecx
c01c4c3d:	8b 84 24 9c 00 00 00 	mov    0x9c(%esp,1),%eax
c01c4c44:	80 78 18 01          	cmpb   $0x1,0x18(%eax)
c01c4c48:	0f 85 22 04 00 00    	jne    c01c5070 <cfb_imageblit+0x4f0>

c01c4c4e:	8b 94 24 98 00 00 00 	mov    0x98(%esp,1),%edx
c01c4c55:	8b 82 cc 00 00 00    	mov    0xcc(%edx),%eax
c01c4c5b:	83 f8 02             	cmp    $0x2,%eax
c01c4c5e:	74 05                	je     c01c4c65 <cfb_imageblit+0xe5>

c01c4c60:	83 f8 04             	cmp    $0x4,%eax
c01c4c63:	75 30                	jne    c01c4c95 <cfb_imageblit+0x115>

c01c4c65:	8b 8c 24 9c 00 00 00 	mov    0x9c(%esp,1),%ecx
c01c4c6c:	8b 41 10             	mov    0x10(%ecx),%eax
c01c4c6f:	8b 8c 24 98 00 00 00 	mov    0x98(%esp,1),%ecx
c01c4c76:	8b 91 d8 01 00 00    	mov    0x1d8(%ecx),%edx
c01c4c7c:	8b 8c 24 9c 00 00 00 	mov    0x9c(%esp,1),%ecx
c01c4c83:	8b 04 82             	mov    (%edx,%eax,4),%eax
c01c4c86:	89 84 24 80 00 00 00 	mov    %eax,0x80(%esp,1)
c01c4c8d:	8b 41 14             	mov    0x14(%ecx),%eax
c01c4c90:	8b 04 82             	mov    (%edx,%eax,4),%eax
c01c4c93:	eb 1b                	jmp    c01c4cb0 <cfb_imageblit+0x130>

c01c4c95:	8b 84 24 9c 00 00 00 	mov    0x9c(%esp,1),%eax
c01c4c9c:	8b 40 10             	mov    0x10(%eax),%eax
c01c4c9f:	89 84 24 80 00 00 00 	mov    %eax,0x80(%esp,1)
c01c4ca6:	8b 84 24 9c 00 00 00 	mov    0x9c(%esp,1),%eax
c01c4cad:	8b 40 14             	mov    0x14(%eax),%eax
c01c4cb0:	89 44 24 7c          	mov    %eax,0x7c(%esp,1)
c01c4cb4:	be 20 00 00 00       	mov    $0x20,%esi
c01c4cb9:	31 d2                	xor    %edx,%edx
c01c4cbb:	89 f0                	mov    %esi,%eax
c01c4cbd:	f7 74 24 74          	divl   0x74(%esp,1)
c01c4cc1:	85 d2                	test   %edx,%edx
c01c4cc3:	0f 85 df 01 00 00    	jne    c01c4ea8 <cfb_imageblit+0x328>

c01c4cc9:	85 ff                	test   %edi,%edi
c01c4ccb:	0f 85 d7 01 00 00    	jne    c01c4ea8 <cfb_imageblit+0x328>

c01c4cd1:	8b 54 24 78          	mov    0x78(%esp,1),%edx
c01c4cd5:	85 d2                	test   %edx,%edx
c01c4cd7:	0f 85 cb 01 00 00    	jne    c01c4ea8 <cfb_imageblit+0x328>

c01c4cdd:	48                   	dec    %eax
c01c4cde:	85 44 24 70          	test   %eax,0x70(%esp,1)
c01c4ce2:	0f 85 c0 01 00 00    	jne    c01c4ea8 <cfb_imageblit+0x328>

c01c4ce8:	83 7c 24 74 07       	cmpl   $0x7,0x74(%esp,1)
c01c4ced:	0f 86 b5 01 00 00    	jbe    c01c4ea8 <cfb_imageblit+0x328>

c01c4cf3:	83 7c 24 74 20       	cmpl   $0x20,0x74(%esp,1)
c01c4cf8:	0f 87 aa 01 00 00    	ja     c01c4ea8 <cfb_imageblit+0x328>

c01c4cfe:	8b 54 24 7c          	mov    0x7c(%esp,1),%edx
c01c4d02:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c4d09:	89 5c 24 6c          	mov    %ebx,0x6c(%esp,1)
c01c4d0d:	8b 9c 24 80 00 00 00 	mov    0x80(%esp,1),%ebx
c01c4d14:	89 54 24 68          	mov    %edx,0x68(%esp,1)
c01c4d18:	31 d2                	xor    %edx,%edx
c01c4d1a:	8b 48 24             	mov    0x24(%eax),%ecx
c01c4d1d:	89 f0                	mov    %esi,%eax
c01c4d1f:	f7 f1                	div    %ecx
c01c4d21:	8b 94 24 9c 00 00 00 	mov    0x9c(%esp,1),%edx
c01c4d28:	89 44 24 64          	mov    %eax,0x64(%esp,1)
c01c4d2c:	8b 72 08             	mov    0x8(%edx),%esi
c01c4d2f:	89 f2                	mov    %esi,%edx
c01c4d31:	8d 42 07             	lea    0x7(%edx),%eax
c01c4d34:	c1 e8 03             	shr    $0x3,%eax
c01c4d37:	83 f9 10             	cmp    $0x10,%ecx
c01c4d3a:	89 44 24 60          	mov    %eax,0x60(%esp,1)
c01c4d3e:	8b 84 24 9c 00 00 00 	mov    0x9c(%esp,1),%eax
c01c4d45:	8b 40 1c             	mov    0x1c(%eax),%eax
c01c4d48:	89 44 24 54          	mov    %eax,0x54(%esp,1)
c01c4d4c:	c7 44 24 50 00 00 00 	movl   $0x0,0x50(%esp,1)
c01c4d53:	00
c01c4d54:	74 2a                	je     c01c4d80 <cfb_imageblit+0x200>

c01c4d56:	83 f9 10             	cmp    $0x10,%ecx
c01c4d59:	77 07                	ja     c01c4d62 <cfb_imageblit+0x1e2>

c01c4d5b:	83 f9 08             	cmp    $0x8,%ecx
c01c4d5e:	74 10                	je     c01c4d70 <cfb_imageblit+0x1f0>

c01c4d60:	eb 36                	jmp    c01c4d98 <cfb_imageblit+0x218>

c01c4d62:	83 f9 20             	cmp    $0x20,%ecx
c01c4d65:	74 29                	je     c01c4d90 <cfb_imageblit+0x210>

c01c4d67:	eb 2f                	jmp    c01c4d98 <cfb_imageblit+0x218>

c01c4d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,1),%esi
c01c4d70:	c7 44 24 50 00 00 00 	movl   $0x0,0x50(%esp,1)
c01c4d77:	00
			c01c4d74: R_386_32	.data
c01c4d78:	eb 1e                	jmp    c01c4d98 <cfb_imageblit+0x218>

c01c4d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
c01c4d80:	c7 44 24 50 40 00 00 	movl   $0x40,0x50(%esp,1)
c01c4d87:	00
			c01c4d84: R_386_32	.data
c01c4d88:	eb 0e                	jmp    c01c4d98 <cfb_imageblit+0x218>

c01c4d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
c01c4d90:	c7 44 24 50 50 00 00 	movl   $0x50,0x50(%esp,1)
c01c4d97:	00
			c01c4d94: R_386_32	.data
c01c4d98:	8b 7c 24 64          	mov    0x64(%esp,1),%edi
c01c4d9c:	83 ef 02             	sub    $0x2,%edi
c01c4d9f:	83 ff ff             	cmp    $0xffffffff,%edi
c01c4da2:	74 23                	je     c01c4dc7 <cfb_imageblit+0x247>

c01c4da4:	d3 64 24 68          	shll   %cl,0x68(%esp,1)
c01c4da8:	8b 44 24 7c          	mov    0x7c(%esp,1),%eax
c01c4dac:	8b 74 24 68          	mov    0x68(%esp,1),%esi
c01c4db0:	d3 e3                	shl    %cl,%ebx
c01c4db2:	09 c6                	or     %eax,%esi
c01c4db4:	8b ac 24 80 00 00 00 	mov    0x80(%esp,1),%ebp
c01c4dbb:	4f                   	dec    %edi
c01c4dbc:	09 eb                	or     %ebp,%ebx
c01c4dbe:	89 74 24 68          	mov    %esi,0x68(%esp,1)
c01c4dc2:	83 ff ff             	cmp    $0xffffffff,%edi
c01c4dc5:	75 dd                	jne    c01c4da4 <cfb_imageblit+0x224>

c01c4dc7:	8a 4c 24 64          	mov    0x64(%esp,1),%cl
c01c4dcb:	b8 01 00 00 00       	mov    $0x1,%eax
c01c4dd0:	d3 e0                	shl    %cl,%eax
c01c4dd2:	48                   	dec    %eax
c01c4dd3:	89 44 24 5c          	mov    %eax,0x5c(%esp,1)
c01c4dd7:	8b 44 24 68          	mov    0x68(%esp,1),%eax
c01c4ddb:	89 44 24 58          	mov    %eax,0x58(%esp,1)
c01c4ddf:	89 d0                	mov    %edx,%eax
c01c4de1:	31 d2                	xor    %edx,%edx
c01c4de3:	8b 4c 24 58          	mov    0x58(%esp,1),%ecx
c01c4de7:	f7 74 24 64          	divl   0x64(%esp,1)
c01c4deb:	31 d9                	xor    %ebx,%ecx
c01c4ded:	8b 94 24 9c 00 00 00 	mov    0x9c(%esp,1),%edx
c01c4df4:	89 4c 24 58          	mov    %ecx,0x58(%esp,1)
c01c4df8:	89 44 24 4c          	mov    %eax,0x4c(%esp,1)
c01c4dfc:	8b 7a 0c             	mov    0xc(%edx),%edi
c01c4dff:	4f                   	dec    %edi
c01c4e00:	83 ff ff             	cmp    $0xffffffff,%edi
c01c4e03:	0f 84 06 04 00 00    	je     c01c520f <cfb_imageblit+0x68f>

c01c4e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,1),%esi
c01c4e10:	8b 4c 24 4c          	mov    0x4c(%esp,1),%ecx
c01c4e14:	8b 6c 24 6c          	mov    0x6c(%esp,1),%ebp
c01c4e18:	49                   	dec    %ecx
c01c4e19:	be 08 00 00 00       	mov    $0x8,%esi
c01c4e1e:	89 4c 24 04          	mov    %ecx,0x4(%esp,1)
c01c4e22:	41                   	inc    %ecx
c01c4e23:	8b 5c 24 54          	mov    0x54(%esp,1),%ebx
c01c4e27:	74 4b                	je     c01c4e74 <cfb_imageblit+0x2f4>

c01c4e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,1),%esi
c01c4e30:	8b 54 24 64          	mov    0x64(%esp,1),%edx
c01c4e34:	8b 44 24 5c          	mov    0x5c(%esp,1),%eax
c01c4e38:	29 d6                	sub    %edx,%esi
c01c4e3a:	89 f1                	mov    %esi,%ecx
c01c4e3c:	0f be 13             	movsbl (%ebx),%edx
c01c4e3f:	d3 fa                	sar    %cl,%edx
c01c4e41:	21 c2                	and    %eax,%edx
c01c4e43:	8b 44 24 58          	mov    0x58(%esp,1),%eax
c01c4e47:	8b 4c 24 50          	mov    0x50(%esp,1),%ecx
c01c4e4b:	23 04 91             	and    (%ecx,%edx,4),%eax
c01c4e4e:	8b 54 24 68          	mov    0x68(%esp,1),%edx
c01c4e52:	31 d0                	xor    %edx,%eax

// OOPS
c01c4e54:	89 45 00             	mov    %eax,0x0(%ebp)
c01c4e57:	83 c5 04             	add    $0x4,%ebp
c01c4e5a:	85 f6                	test   %esi,%esi
c01c4e5c:	75 06                	jne    c01c4e64 <cfb_imageblit+0x2e4>

c01c4e5e:	be 08 00 00 00       	mov    $0x8,%esi
c01c4e63:	43                   	inc    %ebx
c01c4e64:	8b 44 24 04          	mov    0x4(%esp,1),%eax
c01c4e68:	48                   	dec    %eax
c01c4e69:	89 44 24 04          	mov    %eax,0x4(%esp,1)
c01c4e6d:	83 7c 24 04 ff       	cmpl   $0xffffffff,0x4(%esp,1)
c01c4e72:	75 bc                	jne    c01c4e30 <cfb_imageblit+0x2b0>

c01c4e74:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c4e7b:	8b 74 24 6c          	mov    0x6c(%esp,1),%esi
c01c4e7f:	8b 5c 24 54          	mov    0x54(%esp,1),%ebx
c01c4e83:	8b 54 24 60          	mov    0x60(%esp,1),%edx
c01c4e87:	8b 80 d8 00 00 00    	mov    0xd8(%eax),%eax
c01c4e8d:	01 d3                	add    %edx,%ebx
c01c4e8f:	01 c6                	add    %eax,%esi
c01c4e91:	4f                   	dec    %edi
c01c4e92:	89 74 24 6c          	mov    %esi,0x6c(%esp,1)
c01c4e96:	89 5c 24 54          	mov    %ebx,0x54(%esp,1)
c01c4e9a:	83 ff ff             	cmp    $0xffffffff,%edi
c01c4e9d:	0f 85 6d ff ff ff    	jne    c01c4e10 <cfb_imageblit+0x290>

c01c4ea3:	e9 67 03 00 00       	jmp    c01c520f <cfb_imageblit+0x68f>

c01c4ea8:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c4eaf:	89 7c 24 48          	mov    %edi,0x48(%esp,1)
c01c4eb3:	89 dd                	mov    %ebx,%ebp
c01c4eb5:	8b 40 24             	mov    0x24(%eax),%eax
c01c4eb8:	89 44 24 44          	mov    %eax,0x44(%esp,1)
c01c4ebc:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c4ec3:	8b 54 24 44          	mov    0x44(%esp,1),%edx
c01c4ec7:	8b 80 d8 00 00 00    	mov    0xd8(%eax),%eax
c01c4ecd:	c7 44 24 38 20 00 00 	movl   $0x20,0x38(%esp,1)
c01c4ed4:	00
c01c4ed5:	8b 4c 24 38          	mov    0x38(%esp,1),%ecx
c01c4ed9:	89 44 24 3c          	mov    %eax,0x3c(%esp,1)
c01c4edd:	29 d1                	sub    %edx,%ecx
c01c4edf:	89 4c 24 38          	mov    %ecx,0x38(%esp,1)
c01c4ee3:	8b 8c 24 9c 00 00 00 	mov    0x9c(%esp,1),%ecx
c01c4eea:	8b 71 08             	mov    0x8(%ecx),%esi
c01c4eed:	8d 46 07             	lea    0x7(%esi),%eax
c01c4ef0:	c1 e8 03             	shr    $0x3,%eax
c01c4ef3:	89 44 24 34          	mov    %eax,0x34(%esp,1)
c01c4ef7:	8b 41 1c             	mov    0x1c(%ecx),%eax
c01c4efa:	89 6c 24 40          	mov    %ebp,0x40(%esp,1)
c01c4efe:	89 44 24 30          	mov    %eax,0x30(%esp,1)
c01c4f02:	8b 51 0c             	mov    0xc(%ecx),%edx
c01c4f05:	4a                   	dec    %edx
c01c4f06:	89 54 24 28          	mov    %edx,0x28(%esp,1)
c01c4f0a:	42                   	inc    %edx
c01c4f0b:	0f 84 fe 02 00 00    	je     c01c520f <cfb_imageblit+0x68f>

c01c4f11:	eb 0d                	jmp    c01c4f20 <cfb_imageblit+0x3a0>

c01c4f13:	8b 8c 24 9c 00 00 00 	mov    0x9c(%esp,1),%ecx
c01c4f1a:	8b 71 08             	mov    0x8(%ecx),%esi
c01c4f1d:	8d 76 00             	lea    0x0(%esi),%esi
c01c4f20:	8b 44 24 30          	mov    0x30(%esp,1),%eax
c01c4f24:	8b 54 24 48          	mov    0x48(%esp,1),%edx
c01c4f28:	31 db                	xor    %ebx,%ebx
c01c4f2a:	85 d2                	test   %edx,%edx
c01c4f2c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp,1)
c01c4f33:	00
c01c4f34:	c7 44 24 24 08 00 00 	movl   $0x8,0x24(%esp,1)
c01c4f3b:	00
c01c4f3c:	89 ef                	mov    %ebp,%edi
c01c4f3e:	89 44 24 2c          	mov    %eax,0x2c(%esp,1)
c01c4f42:	0f 84 a3 00 00 00    	je     c01c4feb <cfb_imageblit+0x46b>

c01c4f48:	83 cb ff             	or     $0xffffffff,%ebx
c01c4f4b:	8a 4c 24 48          	mov    0x48(%esp,1),%cl
c01c4f4f:	d3 e3                	shl    %cl,%ebx
c01c4f51:	83 f3 ff             	xor    $0xffffffff,%ebx
c01c4f54:	8b 45 00             	mov    0x0(%ebp),%eax
c01c4f57:	21 d8                	and    %ebx,%eax
c01c4f59:	8b 5c 24 48          	mov    0x48(%esp,1),%ebx
c01c4f5d:	89 44 24 04          	mov    %eax,0x4(%esp,1)
c01c4f61:	e9 85 00 00 00       	jmp    c01c4feb <cfb_imageblit+0x46b>

c01c4f66:	8b 44 24 24          	mov    0x24(%esp,1),%eax
c01c4f6a:	8b 54 24 2c          	mov    0x2c(%esp,1),%edx
c01c4f6e:	48                   	dec    %eax
c01c4f6f:	89 44 24 24          	mov    %eax,0x24(%esp,1)
c01c4f73:	31 c0                	xor    %eax,%eax
c01c4f75:	8a 4c 24 24          	mov    0x24(%esp,1),%cl
c01c4f79:	8a 02                	mov    (%edx),%al
c01c4f7b:	d3 f8                	sar    %cl,%eax
c01c4f7d:	83 e0 01             	and    $0x1,%eax
c01c4f80:	8b 94 24 80 00 00 00 	mov    0x80(%esp,1),%edx
c01c4f87:	75 04                	jne    c01c4f8d <cfb_imageblit+0x40d>

c01c4f89:	8b 54 24 7c          	mov    0x7c(%esp,1),%edx
c01c4f8d:	88 d9                	mov    %bl,%cl
c01c4f8f:	89 d0                	mov    %edx,%eax
c01c4f91:	d3 e0                	shl    %cl,%eax
c01c4f93:	8b 4c 24 04          	mov    0x4(%esp,1),%ecx
c01c4f97:	09 c1                	or     %eax,%ecx
c01c4f99:	3b 5c 24 38          	cmp    0x38(%esp,1),%ebx
c01c4f9d:	89 4c 24 04          	mov    %ecx,0x4(%esp,1)
c01c4fa1:	72 26                	jb     c01c4fc9 <cfb_imageblit+0x449>

c01c4fa3:	8b 44 24 04          	mov    0x4(%esp,1),%eax
c01c4fa7:	89 07                	mov    %eax,(%edi)
c01c4fa9:	83 c7 04             	add    $0x4,%edi
c01c4fac:	3b 5c 24 38          	cmp    0x38(%esp,1),%ebx
c01c4fb0:	74 0f                	je     c01c4fc1 <cfb_imageblit+0x441>

c01c4fb2:	b9 20 00 00 00       	mov    $0x20,%ecx
c01c4fb7:	29 d9                	sub    %ebx,%ecx
c01c4fb9:	d3 ea                	shr    %cl,%edx
c01c4fbb:	89 54 24 04          	mov    %edx,0x4(%esp,1)
c01c4fbf:	eb 08                	jmp    c01c4fc9 <cfb_imageblit+0x449>

c01c4fc1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp,1)
c01c4fc8:	00
c01c4fc9:	8b 4c 24 44          	mov    0x44(%esp,1),%ecx
c01c4fcd:	8b 54 24 24          	mov    0x24(%esp,1),%edx
c01c4fd1:	01 cb                	add    %ecx,%ebx
c01c4fd3:	83 e3 1f             	and    $0x1f,%ebx
c01c4fd6:	85 d2                	test   %edx,%edx
c01c4fd8:	75 11                	jne    c01c4feb <cfb_imageblit+0x46b>

c01c4fda:	8b 44 24 2c          	mov    0x2c(%esp,1),%eax
c01c4fde:	40                   	inc    %eax
c01c4fdf:	c7 44 24 24 08 00 00 	movl   $0x8,0x24(%esp,1)
c01c4fe6:	00
c01c4fe7:	89 44 24 2c          	mov    %eax,0x2c(%esp,1)
c01c4feb:	4e                   	dec    %esi
c01c4fec:	83 fe ff             	cmp    $0xffffffff,%esi
c01c4fef:	0f 85 71 ff ff ff    	jne    c01c4f66 <cfb_imageblit+0x3e6>

c01c4ff5:	85 db                	test   %ebx,%ebx
c01c4ff7:	74 13                	je     c01c500c <cfb_imageblit+0x48c>

c01c4ff9:	88 d9                	mov    %bl,%cl
c01c4ffb:	8b 5c 24 04          	mov    0x4(%esp,1),%ebx
c01c4fff:	83 ca ff             	or     $0xffffffff,%edx
c01c5002:	8b 07                	mov    (%edi),%eax
c01c5004:	d3 e2                	shl    %cl,%edx
c01c5006:	21 d0                	and    %edx,%eax
c01c5008:	09 d8                	or     %ebx,%eax
c01c500a:	89 07                	mov    %eax,(%edi)
c01c500c:	8b 44 24 34          	mov    0x34(%esp,1),%eax
c01c5010:	8b 54 24 30          	mov    0x30(%esp,1),%edx
c01c5014:	01 c2                	add    %eax,%edx
c01c5016:	8b 44 24 78          	mov    0x78(%esp,1),%eax
c01c501a:	8b 4c 24 3c          	mov    0x3c(%esp,1),%ecx
c01c501e:	89 54 24 30          	mov    %edx,0x30(%esp,1)
c01c5022:	01 cd                	add    %ecx,%ebp
c01c5024:	85 c0                	test   %eax,%eax
c01c5026:	74 2d                	je     c01c5055 <cfb_imageblit+0x4d5>

c01c5028:	8b 7c 24 48          	mov    0x48(%esp,1),%edi
c01c502c:	8b 44 24 78          	mov    0x78(%esp,1),%eax
c01c5030:	8b 4c 24 40          	mov    0x40(%esp,1),%ecx
c01c5034:	8b 54 24 3c          	mov    0x3c(%esp,1),%edx
c01c5038:	01 c7                	add    %eax,%edi
c01c503a:	89 7c 24 48          	mov    %edi,0x48(%esp,1)
c01c503e:	8d 0c 91             	lea    (%ecx,%edx,4),%ecx
c01c5041:	8b 74 24 48          	mov    0x48(%esp,1),%esi
c01c5045:	89 cd                	mov    %ecx,%ebp
c01c5047:	83 e6 1f             	and    $0x1f,%esi
c01c504a:	89 4c 24 40          	mov    %ecx,0x40(%esp,1)
c01c504e:	83 e5 fc             	and    $0xfffffffc,%ebp
c01c5051:	89 74 24 48          	mov    %esi,0x48(%esp,1)
c01c5055:	8b 5c 24 28          	mov    0x28(%esp,1),%ebx
c01c5059:	4b                   	dec    %ebx
c01c505a:	89 5c 24 28          	mov    %ebx,0x28(%esp,1)
c01c505e:	83 7c 24 28 ff       	cmpl   $0xffffffff,0x28(%esp,1)
c01c5063:	0f 85 aa fe ff ff    	jne    c01c4f13 <cfb_imageblit+0x393>

c01c5069:	e9 a1 01 00 00       	jmp    c01c520f <cfb_imageblit+0x68f>

c01c506e:	89 f6                	mov    %esi,%esi
c01c5070:	8b 94 24 9c 00 00 00 	mov    0x9c(%esp,1),%edx
c01c5077:	31 c0                	xor    %eax,%eax
c01c5079:	8a 42 18             	mov    0x18(%edx),%al
c01c507c:	3b 44 24 74          	cmp    0x74(%esp,1),%eax
c01c5080:	0f 87 89 01 00 00    	ja     c01c520f <cfb_imageblit+0x68f>

c01c5086:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c508d:	89 7c 24 20          	mov    %edi,0x20(%esp,1)
c01c5091:	89 dd                	mov    %ebx,%ebp
c01c5093:	8b 40 24             	mov    0x24(%eax),%eax
c01c5096:	c7 44 24 10 20 00 00 	movl   $0x20,0x10(%esp,1)
c01c509d:	00
c01c509e:	8b 4c 24 10          	mov    0x10(%esp,1),%ecx
c01c50a2:	89 44 24 14          	mov    %eax,0x14(%esp,1)
c01c50a6:	29 c1                	sub    %eax,%ecx
c01c50a8:	8b 84 24 98 00 00 00 	mov    0x98(%esp,1),%eax
c01c50af:	89 4c 24 10          	mov    %ecx,0x10(%esp,1)
c01c50b3:	8b 80 d8 01 00 00    	mov    0x1d8(%eax),%eax
c01c50b9:	89 44 24 0c          	mov    %eax,0xc(%esp,1)
c01c50bd:	8b 42 1c             	mov    0x1c(%edx),%eax
c01c50c0:	89 6c 24 1c          	mov    %ebp,0x1c(%esp,1)
c01c50c4:	89 44 24 08          	mov    %eax,0x8(%esp,1)
c01c50c8:	8b 4a 0c             	mov    0xc(%edx),%ecx
c01c50cb:	49                   	dec    %ecx
c01c50cc:	89 4c 24 18          	mov    %ecx,0x18(%esp,1)
c01c50d0:	41                   	inc    %ecx
c01c50d1:	0f 84 38 01 00 00    	je     c01c520f <cfb_imageblit+0x68f>

c01c50d7:	8b 84 24 9c 00 00 00 	mov    0x9c(%esp,1),%eax
c01c50de:	31 db                	xor    %ebx,%ebx
c01c50e0:	89 ef                	mov    %ebp,%edi
c01c50e2:	8b 70 08             	mov    0x8(%eax),%esi
c01c50e5:	8b 44 24 20          	mov    0x20(%esp,1),%eax
c01c50e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp,1)
c01c50f0:	00
c01c50f1:	85 c0                	test   %eax,%eax
c01c50f3:	74 19                	je     c01c510e <cfb_imageblit+0x58e>

c01c50f5:	83 ca ff             	or     $0xffffffff,%edx
c01c50f8:	8a 4c 24 20          	mov    0x20(%esp,1),%cl
c01c50fc:	d3 e2                	shl    %cl,%edx
c01c50fe:	8b 45 00             	mov    0x0(%ebp),%eax
c01c5101:	83 f2 ff             	xor    $0xffffffff,%edx
c01c5104:	21 d0                	and    %edx,%eax
c01c5106:	8b 5c 24 20          	mov    0x20(%esp,1),%ebx
c01c510a:	89 44 24 04          	mov    %eax,0x4(%esp,1)
c01c510e:	4e                   	dec    %esi
c01c510f:	83 fe ff             	cmp    $0xffffffff,%esi
c01c5112:	0f 84 8c 00 00 00    	je     c01c51a4 <cfb_imageblit+0x624>

c01c5118:	8b 94 24 98 00 00 00 	mov    0x98(%esp,1),%edx
c01c511f:	8b 82 cc 00 00 00    	mov    0xcc(%edx),%eax
c01c5125:	83 f8 02             	cmp    $0x2,%eax
c01c5128:	74 05                	je     c01c512f <cfb_imageblit+0x5af>

c01c512a:	83 f8 04             	cmp    $0x4,%eax
c01c512d:	75 11                	jne    c01c5140 <cfb_imageblit+0x5c0>

c01c512f:	8b 44 24 08          	mov    0x8(%esp,1),%eax
c01c5133:	31 c9                	xor    %ecx,%ecx
c01c5135:	8a 08                	mov    (%eax),%cl
c01c5137:	8b 44 24 0c          	mov    0xc(%esp,1),%eax
c01c513b:	8b 14 88             	mov    (%eax,%ecx,4),%edx
c01c513e:	eb 08                	jmp    c01c5148 <cfb_imageblit+0x5c8>

c01c5140:	8b 4c 24 08          	mov    0x8(%esp,1),%ecx
c01c5144:	31 d2                	xor    %edx,%edx
c01c5146:	8a 11                	mov    (%ecx),%dl
c01c5148:	88 d9                	mov    %bl,%cl
c01c514a:	89 d0                	mov    %edx,%eax
c01c514c:	d3 e0                	shl    %cl,%eax
c01c514e:	8b 4c 24 04          	mov    0x4(%esp,1),%ecx
c01c5152:	09 c1                	or     %eax,%ecx
c01c5154:	3b 5c 24 10          	cmp    0x10(%esp,1),%ebx
c01c5158:	89 4c 24 04          	mov    %ecx,0x4(%esp,1)
c01c515c:	72 2a                	jb     c01c5188 <cfb_imageblit+0x608>

c01c515e:	8b 44 24 04          	mov    0x4(%esp,1),%eax
c01c5162:	89 07                	mov    %eax,(%edi)
c01c5164:	83 c7 04             	add    $0x4,%edi
c01c5167:	3b 5c 24 10          	cmp    0x10(%esp,1),%ebx
c01c516b:	74 13                	je     c01c5180 <cfb_imageblit+0x600>

c01c516d:	b9 20 00 00 00       	mov    $0x20,%ecx
c01c5172:	29 d9                	sub    %ebx,%ecx
c01c5174:	d3 ea                	shr    %cl,%edx
c01c5176:	89 54 24 04          	mov    %edx,0x4(%esp,1)
c01c517a:	eb 0c                	jmp    c01c5188 <cfb_imageblit+0x608>

c01c517c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
c01c5180:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp,1)
c01c5187:	00
c01c5188:	8b 44 24 08          	mov    0x8(%esp,1),%eax
c01c518c:	8b 54 24 14          	mov    0x14(%esp,1),%edx
c01c5190:	01 d3                	add    %edx,%ebx
c01c5192:	40                   	inc    %eax
c01c5193:	4e                   	dec    %esi
c01c5194:	83 e3 1f             	and    $0x1f,%ebx
c01c5197:	89 44 24 08          	mov    %eax,0x8(%esp,1)
c01c519b:	83 fe ff             	cmp    $0xffffffff,%esi
c01c519e:	0f 85 74 ff ff ff    	jne    c01c5118 <cfb_imageblit+0x598>

c01c51a4:	85 db                	test   %ebx,%ebx
c01c51a6:	74 13                	je     c01c51bb <cfb_imageblit+0x63b>

c01c51a8:	83 ca ff             	or     $0xffffffff,%edx
c01c51ab:	88 d9                	mov    %bl,%cl
c01c51ad:	8b 07                	mov    (%edi),%eax
c01c51af:	8b 74 24 04          	mov    0x4(%esp,1),%esi
c01c51b3:	d3 e2                	shl    %cl,%edx
c01c51b5:	21 d0                	and    %edx,%eax
c01c51b7:	09 f0                	or     %esi,%eax
c01c51b9:	89 07                	mov    %eax,(%edi)
c01c51bb:	8b 94 24 98 00 00 00 	mov    0x98(%esp,1),%edx
c01c51c2:	8b 5c 24 78          	mov    0x78(%esp,1),%ebx
c01c51c6:	8b 82 d8 00 00 00    	mov    0xd8(%edx),%eax
c01c51cc:	01 c5                	add    %eax,%ebp
c01c51ce:	85 db                	test   %ebx,%ebx
c01c51d0:	74 29                	je     c01c51fb <cfb_imageblit+0x67b>

c01c51d2:	8b 4c 24 1c          	mov    0x1c(%esp,1),%ecx
c01c51d6:	8d 0c 81             	lea    (%ecx,%eax,4),%ecx
c01c51d9:	8b 44 24 78          	mov    0x78(%esp,1),%eax
c01c51dd:	89 cd                	mov    %ecx,%ebp
c01c51df:	89 4c 24 1c          	mov    %ecx,0x1c(%esp,1)
c01c51e3:	8b 4c 24 20          	mov    0x20(%esp,1),%ecx
c01c51e7:	83 e5 fc             	and    $0xfffffffc,%ebp
c01c51ea:	01 c1                	add    %eax,%ecx
c01c51ec:	89 4c 24 20          	mov    %ecx,0x20(%esp,1)
c01c51f0:	8b 54 24 20          	mov    0x20(%esp,1),%edx
c01c51f4:	83 e2 1f             	and    $0x1f,%edx
c01c51f7:	89 54 24 20          	mov    %edx,0x20(%esp,1)
c01c51fb:	8b 44 24 18          	mov    0x18(%esp,1),%eax
c01c51ff:	48                   	dec    %eax
c01c5200:	89 44 24 18          	mov    %eax,0x18(%esp,1)
c01c5204:	83 7c 24 18 ff       	cmpl   $0xffffffff,0x18(%esp,1)
c01c5209:	0f 85 c8 fe ff ff    	jne    c01c50d7 <cfb_imageblit+0x557>

c01c520f:	81 c4 84 00 00 00    	add    $0x84,%esp
c01c5215:	5b                   	pop    %ebx
c01c5216:	5e                   	pop    %esi
c01c5217:	5f                   	pop    %edi
c01c5218:	5d                   	pop    %ebp
c01c5219:	c3                   	ret
c01c521a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

