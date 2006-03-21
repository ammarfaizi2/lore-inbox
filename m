Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWCUWUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWCUWUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWCUWUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:20:16 -0500
Received: from main.gmane.org ([80.91.229.2]:42374 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965138AbWCUWUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:20:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Possible CIFS regression in 2.6.16 (vs 2.6.14)
Date: Tue, 21 Mar 2006 22:15:10 +0000
Message-ID: <adam.20060321221510$2914@samael.haus>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: yggdrasl.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having just upgraded from 2.6.14 to 2.6.16, I've discovered that I can
no longer mount an SMB share on my network using cifs as the filesystem.
Mounting with smbfs, however, works happily.

I'm using Samba 3.0.21c.  The share is served by an Iomega Network
Hard Disk and does not require a password.  (Examining the responses
from this thing seems to suggest it's running Samba 2.2.7, which is
quite possibly in violation of the GPL...)  The mount options in use
are: defaults,guest,file_mode=0664,dir_mode=0775,gid=users

Turning on tracing in /proc/fs/cifs/cifsFYI gives the following
(slightly anonymised):

 fs/cifs/cifsfs.c: Devname: //hostname/NetHDD flags: 64 
 fs/cifs/connect.c: CIFS VFS: in cifs_mount as Xid: 30 with uid: 0
 fs/cifs/connect.c: Username: root 
 fs/cifs/connect.c: UNC: \\hostname\NetHDD ip: 192.168.x.x
 fs/cifs/connect.c: Socket created
 fs/cifs/connect.c: sndbuf 16384 rcvbuf 87380 rcvtimeo 0x7fffffff
 fs/cifs/transport.c: Sending smb of length 68
 fs/cifs/connect.c: Demultiplex PID: 2527
 fs/cifs/connect.c: Existing smb sess not found
 fs/cifs/transport.c: For smb_command 114
 fs/cifs/transport.c: Sending smb of length 47
 fs/cifs/connect.c: rfc1002 length 0x82000004)
 fs/cifs/connect.c: Good RFC 1002 session rsp
 fs/cifs/connect.c: rfc1002 length 0x5b)
 fs/cifs/cifssmb.c: share mode security
 fs/cifs/connect.c: Security Mode: 0x2 Capabilities: 0xe3f9 Time Zone: 0
 fs/cifs/connect.c: In sesssetup
 fs/cifs/transport.c: For smb_command 115
 fs/cifs/transport.c: Sending smb of length 162
 fs/cifs/connect.c: rfc1002 length 0x49)
 fs/cifs/connect.c:  Guest login
 fs/cifs/connect.c: UID = 0 
 fs/cifs/connect.c: CIFS Session Established successfully
 fs/cifs/connect.c: file mode: 0x1b4  dir mode: 0x1fd
 fs/cifs/transport.c: For smb_command 117
 fs/cifs/transport.c: Sending smb of length 91
 fs/cifs/connect.c: rfc1002 length 0x27)
Status code returned 0xc00000cc NT_STATUS_BAD_NETWORK_NAME
 fs/cifs/netmisc.c:  !!Mapping smb error code 67 to POSIX err -6 !!
 fs/cifs/connect.c: CIFS Tcon rc = -6
 fs/cifs/cifssmb.c: In SMBLogoff for session disconnect
 fs/cifs/transport.c: For smb_command 116
 fs/cifs/transport.c: Sending smb of length 39
 fs/cifs/connect.c: rfc1002 length 0x2b)
 fs/cifs/connect.c: CIFS VFS: leaving cifs_mount (xid = 30) rc = -6
 CIFS VFS: cifs_mount failed w/return code = -6

Tracing this back to fs/cifs/connect.c seems to suggest that the
relevant difference from 2.6.14 is that the kernel now sends a
hashed password at the start of the smb_command 117, whereas in
the older kernel (and using smbfs) only a null byte is sent for
the password.

I've tried mounting with the sec=none option to turn off password
hashing, but it doesn't seem to make any difference (the request
packet looks about the same in tcpdump as well).

Is there any way to restore the 2.6.14 behaviour, or is this a
bug (or an unimplemented feature) in CIFS?  I'm afraid I don't
know anything much about SMB, but I'm happy to provide any
information which might help in tracking this down.

Thanks in advance...
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("Shut up! I'm *trying* to concentrate!!!!!"                        )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

