Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312899AbSDKUVj>; Thu, 11 Apr 2002 16:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312901AbSDKUVi>; Thu, 11 Apr 2002 16:21:38 -0400
Received: from fungus.teststation.com ([212.32.186.211]:12548 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S312899AbSDKUVg>; Thu, 11 Apr 2002 16:21:36 -0400
Date: Thu, 11 Apr 2002 22:21:04 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: =?iso-8859-1?Q?Erik_Inge_Bols=F8?= <erik@tms.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.20 umount oops (probably smbfs related)
In-Reply-To: <Pine.LNX.4.30.0204091332380.12937-100000@romeo.skybert.no>
Message-ID: <Pine.LNX.4.33.0204112117400.21322-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Erik Inge Bolsø wrote:

> Process umount (pid: 30793, process nr: 116, stackpage=cb429000)
> Stack: 00000000 cd8ef644 cd8ef644 cd8ef600 00000004 c012914e cd8ef600 00000004
>        fffffffa c14f0004 ce6a8188 c01291f8 00000004 00000000 00000000 00000000
>        08050004 c14f2a00 00000000 c01292ed 00000004 00000000 cb428000 08051ea9
> Call Trace: [<c012914e>] [<c01291f8>] [<c01292ed>] [<c0129308>] [<c0109144>]
> Code: 8b 43 1c 48 75 35 53 e8 9f 9b 00 00 53 e8 31 ee ff ff c7 43
> 
> >>EIP: c0126389 <fput+5/48>
> Trace: c012914e <do_umount+ee/144>
> Trace: c01291f8 <umount_dev+54/9c>
> Trace: c01292ed <sys_umount+ad/bc>
> Trace: c0129308 <sys_oldumount+c/10>
> Trace: c0109144 <system_call+34/38>
> Code:  c0126389 <fput+5/48>                    00000000 <_EIP>: <===
> Code:  c0126389 <fput+5/48>                       0:	8b 43 1c             	movl   0x1c(%ebx),%eax <===

Your trace doesn't include any smb_ references, but I suppose the cd8ef644
ones might be. I don't see where do_umount calls fput so ...

> Right before the oops, I got these lines in dmesg:
> 
> ind //email.txt failed, error=-5
> smb_lookup: find //email.txt failed, error=-5
> smb_retry: signal failed, error=-3

"signal failed, error=-3" means that smbmount is no longer with us. When
that happens smbfs can't get a new connection when the connection is lost
(which is a normal event).

This is usually bad and you may want to investigate why it died/upgrade
your samba version regardless of the patch below. Recent smbmounts can log
to file and with a suitable debuglevel you may find out what happened
(debug=4 or so).

> smb_lookup: find //email.txt failed, error=-5
> smb_get_length: recv error = 512
> smb_request: result -512, setting invalid
> smb_dont_catch_keepalive: did not get valid server!

smbfs unmount code "put_super" does:
	if (server->sock_file) {
		smb_proc_disconnect(server);
		smb_dont_catch_keepalive(server);
		fput(server->sock_file);
	}

I think what happened is that there was a server->sock_file, but that the
tcp connection behind it was actually dead. -5 is an indication of that.

When it tries to send the disconnect message in smb_proc_disconnect it
detects this, closes sock_file and sets it to NULL.

smb_dont_catch_keepalive prints that error message on a NULL sock_file.

Then when the fput is run the put_super code assumes there is a 
sock_file, because it was one in the if ...

If that is what happened the patch below should help. It simply changes
smbfs not to try and send a disconnect message if it isn't connected. 
Which makes sense anyway, no need to connect just to say goodbye. Even if
that may the polite thing to do :)


> Note that the smb share in question is mounted, alive and well as of this
> moment, I can read files on it just fine - it's just the umount of it that
> oopsed.

Sounds strange. Could that be some automounter that mounted another one
for you?

If the patch below doesn't work, try just removing the smb_proc_disconnect
line from put_super. Closing the file disconnects anyway.

/Urban


diff -urN -X exclude linux-2.2.20-orig/fs/smbfs/proc.c linux-2.2.20-smbfs/fs/smbfs/proc.c
--- linux-2.2.20-orig/fs/smbfs/proc.c	Thu Apr 11 21:25:09 2002
+++ linux-2.2.20-smbfs/fs/smbfs/proc.c	Thu Apr 11 22:01:48 2002
@@ -2152,10 +2152,16 @@
 int
 smb_proc_disconnect(struct smb_sb_info *server)
 {
-	int result;
+	int result = -EIO;
+
 	smb_lock_server(server);
+        if (server->state != CONN_VALID)
+                goto out;
+
 	smb_setup_header(server, SMBtdis, 0, 0);
 	result = smb_request_ok(server, SMBtdis, 0, 0);
+
+out:
 	smb_unlock_server(server);
 	return result;
 }

