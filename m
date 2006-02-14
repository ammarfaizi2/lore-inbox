Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWBNTyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWBNTyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWBNTyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:54:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:22201 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422773AbWBNTyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:54:21 -0500
Subject: Re: Additional questions on your hang
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steve French <smfltc@us.ibm.com>,
       "linux-cifs-client@lists.samba.org" 
	<linux-cifs-client@lists.samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060214171713.GA3513@stusta.de>
References: <20050721115604.GB3160@stusta.de>
	 <OF31F3CBF1.99DB2B76-ON87257046.0068484B-86257046.0068A410@us.ibm.com>
	 <20050722191457.GL3160@stusta.de> <43F20EC0.8090305@us.ibm.com>
	 <20060214171713.GA3513@stusta.de>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 13:54:11 -0600
Message-Id: <1139946851.9961.28.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 18:17 +0100, Adrian Bunk wrote:
> On Tue, Feb 14, 2006 at 11:09:20AM -0600, Steve French wrote:
> 
> > Adrian,
> 
> Hi Steve,
> 
> > If your problem turns out to be serious - I do want to find a way to 
> > solve this before 2.6.16 goes out
> 
> :-)
> 
> > A couple of other datapoints that might be helpful ... Although we don't 
> > know for sure that the hang is related to
> > SMB read (despite the EAGAIN warning logged on a read) - it might be 
> > useful to know whether the problem
> > occurred when mount option "forcedirectio" is specified (since reads in 
> > that case will bypass the pagecache).,
> 
> With forcedirectio, it's still failing after some time (this time not 
> until nearly 1 GB was transferred), but instead of killing the machine 
> it's giving a useful error message ("Process mc" since I was copying 
> with GNU Midnight Commander):
> 
> Feb 14 18:03:16 r063144 kernel:  CIFS VFS: No response to cmd 46 mid 42374
> Feb 14 18:03:16 r063144 kernel:  CIFS VFS: Send error in read = -11
> Feb 14 18:03:19 r063144 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000031
> Feb 14 18:03:19 r063144 kernel:  printing eip:
> Feb 14 18:03:19 r063144 kernel: c0182caa
> Feb 14 18:03:19 r063144 kernel: *pde = 00000000
> Feb 14 18:03:19 r063144 kernel: Oops: 0000 [#1]
> Feb 14 18:03:19 r063144 kernel: Modules linked in:
> Feb 14 18:03:19 r063144 kernel: CPU:    0
> Feb 14 18:03:19 r063144 kernel: EIP:    0060:[cifs_user_read+319/539]    Not tainted VLI
> Feb 14 18:03:19 r063144 kernel: EFLAGS: 00210296   (2.6.16-rc3 #1) 
> Feb 14 18:03:19 r063144 kernel: EIP is at cifs_user_read+0x13f/0x21b
> Feb 14 18:03:19 r063144 kernel: eax: fffffff5   ebx: 0001b746   ecx: 00000000   edx: 00000000
> Feb 14 18:03:19 r063144 kernel: esi: 00002000   edi: fffffff5   ebp: d3be5b20   esp: c842ff38
> Feb 14 18:03:19 r063144 kernel: ds: 007b   es: 007b   ss: 0068
> Feb 14 18:03:19 r063144 kernel: Process mc (pid: 29402, threadinfo=c842e000 task=cdbfe030)
> Feb 14 18:03:19 r063144 kernel: Stack: <0>00002000 08dd2000 00000000 c842ff70 c842ff6c c842ff68 00002000 da1725e0 
> Feb 14 18:03:19 r063144 kernel:        00000000 c21f9920 c5224aa0 08184fb0 00000000 00000000 00000000 d3be5b20 
> Feb 14 18:03:19 r063144 kernel:        00002000 c0182b6b 08184fb0 c013d736 c842ffa4 d3be5b20 fffffff7 08184fb0 
> Feb 14 18:03:19 r063144 kernel: Call Trace:
> Feb 14 18:03:19 r063144 kernel:  [cifs_user_read+0/539] cifs_user_read+0x0/0x21b
> Feb 14 18:03:19 r063144 kernel:  [vfs_read+125/223] vfs_read+0x7d/0xdf
> Feb 14 18:03:19 r063144 kernel:  [sys_read+60/99] sys_read+0x3c/0x63
> Feb 14 18:03:19 r063144 kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
> Feb 14 18:03:19 r063144 kernel: Code: 18 50 8d 44 24 20 50 8d 44 24 28 50 8b 54 24 44 89 d8 ff 72 04 ff 32 56 8b 54 24 28 e8 4b 6d ff ff 8b 54 24 34 89 c7 8b 4c 24 38 <0f> b7 42 31 8d 54 02 04 8b 44 24 2c e8 ce 97 01 00 83 c4 18 85 
> Feb 14 18:03:19 r063144 kernel:  <3> CIFS VFS: Send error in Close = -9

I wasn't able to trace it to an exact line of code, but I think I see
what the problem is.

This patch moves the copy_to_user from smb_read_data after the test
whether smb_read_data is null.  It's good not to dereference a pointer
if you have a reason to test it for null afterward.

This patch has not been compiled or tested.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff -urp linux-2.6.16-rc3/fs/cifs/file.c linux/fs/cifs/file.c
--- linux-2.6.16-rc3/fs/cifs/file.c	2006-02-13 07:28:51.000000000 -0600
+++ linux/fs/cifs/file.c	2006-02-14 13:45:09.000000000 -0600
@@ -1441,14 +1441,16 @@ ssize_t cifs_user_read(struct file *file
 					 current_read_size, *poffset,
 					 &bytes_read, &smb_read_data,
 					 &buf_type);
-			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			if (copy_to_user(current_offset, 
-					 smb_read_data + 4 /* RFC1001 hdr */
-					 + le16_to_cpu(pSMBr->DataOffset), 
-					 bytes_read)) {
-				rc = -EFAULT;
-			}
 			if (smb_read_data) {
+				pSMBr = (struct smb_com_read_rsp *)
+					smb_read_data;
+				if (copy_to_user(current_offset, 
+						 smb_read_data +
+						 4 + /* RFC1001 hdr */
+						 le16_to_cpu(pSMBr->DataOffset),
+						 bytes_read)) {
+					rc = -EFAULT;
+				}
 				if(buf_type == CIFS_SMALL_BUFFER)
 					cifs_small_buf_release(smb_read_data);
 				else if(buf_type == CIFS_LARGE_BUFFER)

-- 
David Kleikamp
IBM Linux Technology Center

