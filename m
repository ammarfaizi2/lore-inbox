Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313857AbSDIL42>; Tue, 9 Apr 2002 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313858AbSDIL41>; Tue, 9 Apr 2002 07:56:27 -0400
Received: from mail.ekh.no ([213.184.194.22]:57608 "EHLO romeo.skybert.no")
	by vger.kernel.org with ESMTP id <S313857AbSDIL41>;
	Tue, 9 Apr 2002 07:56:27 -0400
Date: Tue, 9 Apr 2002 13:56:23 +0200 (CEST)
From: =?iso-8859-1?Q?Erik_Inge_Bols=F8?= <erik@tms.no>
To: <linux-kernel@vger.kernel.org>
cc: <samba@samba.org>, <erik@tms.no>
Subject: 2.2.20 umount oops (probably smbfs related)
Message-ID: <Pine.LNX.4.30.0204091332380.12937-100000@romeo.skybert.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6-clm-rl-8 (http://amavis.org/)
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6-clm-rl-8 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an oops that appeared yesterday in umount, after 81 days of uptime
and much automated smbfs mount/umount activity:

Stock kernel 2.2.20. No charset= or other weird options to smbfs.

I seem to remember having seen this once on a 2.2.19pre series kernel as
well.

Ksymoops:

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
current->tss.cr3 = 08f1f000, %cr3 = 08f1f000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0126389>]
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: cb428000   edx: 0000003c
esi: cd8ef600   edi: 00000000   ebp: ce6a0004   esp: cb429f4c
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 30793, process nr: 116, stackpage=cb429000)
Stack: 00000000 cd8ef644 cd8ef644 cd8ef600 00000004 c012914e cd8ef600 00000004
       fffffffa c14f0004 ce6a8188 c01291f8 00000004 00000000 00000000 00000000
       08050004 c14f2a00 00000000 c01292ed 00000004 00000000 cb428000 08051ea9
Call Trace: [<c012914e>] [<c01291f8>] [<c01292ed>] [<c0129308>] [<c0109144>]
Code: 8b 43 1c 48 75 35 53 e8 9f 9b 00 00 53 e8 31 ee ff ff c7 43

>>EIP: c0126389 <fput+5/48>
Trace: c012914e <do_umount+ee/144>
Trace: c01291f8 <umount_dev+54/9c>
Trace: c01292ed <sys_umount+ad/bc>
Trace: c0129308 <sys_oldumount+c/10>
Trace: c0109144 <system_call+34/38>
Code:  c0126389 <fput+5/48>                    00000000 <_EIP>: <===
Code:  c0126389 <fput+5/48>                       0:	8b 43 1c             	movl   0x1c(%ebx),%eax <===
Code:  c012638c <fput+8/48>                       3:	48                   	decl   %eax
Code:  c012638d <fput+9/48>                       4:	75 35                	jne     c01263c4 <fput+40/48>
Code:  c012638f <fput+b/48>                       6:	53                   	pushl  %ebx
Code:  c0126390 <fput+c/48>                       7:	e8 9f 9b 00 00       	call    c012ff34 <locks_remove_flock+0/90>
Code:  c0126395 <fput+11/48>                      c:	53                   	pushl  %ebx
Code:  c0126396 <fput+12/48>                      d:	e8 31 ee ff ff       	call    c01251cc <__fput+0/48>
Code:  c012639b <fput+17/48>                     12:	c7 43 00 00 00 00 00 	movl   $0x0,0x0(%ebx)

3 warnings issued.  Results may not be reliable.

Right before the oops, I got these lines in dmesg:

ind //email.txt failed, error=-5
smb_lookup: find //email.txt failed, error=-5
smb_retry: signal failed, error=-3
smb_lookup: find //email.txt failed, error=-5
smb_get_length: recv error = 512
smb_request: result -512, setting invalid
smb_dont_catch_keepalive: did not get valid server!

Especially the last line - happened in the same second as the oops,
according to syslog.

Note that the smb share in question is mounted, alive and well as of this
moment, I can read files on it just fine - it's just the umount of it that
oopsed.

This is a production server in heavy use, so no _too_ experimental patches
please, can't reboot it very often :-/

Any fixes handy, anyone? Can't seem to find anything that would fix this
in the 2.2.21pre changelog...

Please CC: me, I'm not on either of the linux-kernel or samba lists.

-- 
Erik I. Bolsø, Triangel Maritech Software AS | Skybert AS
Tlf: 712 41 694		Mobil: 915 79 512

