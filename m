Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSFXHCQ>; Mon, 24 Jun 2002 03:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSFXHCQ>; Mon, 24 Jun 2002 03:02:16 -0400
Received: from mercury.physics.adelaide.edu.au ([129.127.102.44]:14208 "EHLO
	mercury.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S317426AbSFXHCO>; Mon, 24 Jun 2002 03:02:14 -0400
From: Jonathan Woithe <jwoithe@mercury.physics.adelaide.edu.au>
Message-Id: <200206240653.g5O6rpp02613@mercury.physics.adelaide.edu.au>
Subject: NFS lockd oops under 2.4.18
To: trond.myklebust@fys.uio.no
Date: Mon, 24 Jun 2002 16:23:51 +0930 (CST)
Cc: jwoithe@mercury.physics.adelaide.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond and others

I would like to report an NFS oops on one of our machines, possibly
involving lockd.  It is a stock Redhat 7.3 installation running 2.4.18-2 out
of the box.  The machine is exporting user home directories for between 50
to 100 unix clients.  The clients are a mix of Digital unix boxes (v4.0d or
later) and various Linux versions (Redhat 6.1/7.1/7.2/7.3, Slackware 8.0).

Initially things work fine, but after some time (or perhaps after a certain
number of connections and/or NFS operations) the following oops occurs:

Jun 24 15:22:02 mercury kernel: Unable to handle kernel paging request at virtual address 938e38a4
Jun 24 15:22:02 mercury kernel:  printing eip:
Jun 24 15:22:02 mercury kernel: d8911bf2
Jun 24 15:22:02 mercury kernel: *pde = 00000000
Jun 24 15:22:02 mercury kernel: Oops: 0002
Jun 24 15:22:02 mercury kernel: via82cxxx_audio uart401 ac97_codec sound soundcore binfmt_misc autofs nfs nfsd
Jun 24 15:22:02 mercury kernel: CPU:    0
Jun 24 15:22:02 mercury kernel: EIP:    0010:[<d8911bf2>]    Not tainted
Jun 24 15:22:02 mercury kernel: EFLAGS: 00010212
Jun 24 15:22:02 mercury kernel: 
Jun 24 15:22:02 mercury kernel: EIP is at xdr_encode_netobj_R29c6f164 [sunrpc] 0x12 (2.4.18-3)
Jun 24 15:22:02 mercury kernel: eax: 306db20d   ebx: d4e8306c   ecx: d1d77070   edx: d4e83064
Jun 24 15:22:02 mercury kernel: esi: d4e83008   edi: d4e83008   ebp: d1d77070   esp: d790fda8
Jun 24 15:22:02 mercury kernel: ds: 0018   es: 0018   ss: 0018
Jun 24 15:22:02 mercury kernel: Process lockd (pid: 667, stackpage=d790f000)
Jun 24 15:22:02 mercury kernel: Stack: d4e83008 d4e83008 d8922f7b d1d77070 d4e83064 d1d7701c c6a740c0 d4e8306c 
Jun 24 15:22:02 mercury kernel:        c6a740c0 d8923920 c6a74cc0 d890e879 c89d805c c4fc2280 d8923920 c6a74cc0 
Jun 24 15:22:02 mercury kernel:        d8923934 d1d7705c d4e83008 c89d805c d89098e0 c89d805c d1d7705c d4e83008 
Jun 24 15:22:02 mercury kernel: Call Trace: [<d8922f7b>] nlm4_encode_testres [lockd] 0x8b 
Jun 24 15:22:02 mercury kernel: [<d8923920>] nlm4clt_encode_testres [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: [<d890e879>] rpcauth_marshcred [sunrpc] 0x49 
Jun 24 15:22:02 mercury kernel: [<d8923920>] nlm4clt_encode_testres [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: [<d8923934>] nlm4clt_encode_testres [lockd] 0x14 
Jun 24 15:22:02 mercury kernel: [<d89098e0>] call_encode [sunrpc] 0xd0 
Jun 24 15:22:02 mercury kernel: [<d890cf79>] __rpc_execute [sunrpc] 0xa9 
Jun 24 15:22:02 mercury kernel: [<d8909566>] rpc_call_setup_R0816cf16 [sunrpc] 0x46 
Jun 24 15:22:02 mercury kernel: [<d89094f7>] rpc_call_async_Rf292dde9 [sunrpc] 0x77 
Jun 24 15:22:02 mercury kernel: [<d891db9a>] nlmsvc_async_call [lockd] 0x7a 
Jun 24 15:22:02 mercury kernel: [<d8924330>] nlm4svc_callback_exit [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: [<d8924303>] nlm4svc_callback [lockd] 0x73 
Jun 24 15:22:02 mercury kernel: [<d8924330>] nlm4svc_callback_exit [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: [<d8923e44>] nlm4svc_proc_test_msg [lockd] 0x44 
Jun 24 15:22:02 mercury kernel: [<c014a5c1>] posix_lock_file [kernel] 0x551 
Jun 24 15:22:02 mercury kernel: [<c014a5c1>] posix_lock_file [kernel] 0x551 
Jun 24 15:22:02 mercury kernel: [<c01c86ac>] skb_checksum [kernel] 0x4c 
Jun 24 15:22:02 mercury kernel: [<d8922ca7>] nlm4_decode_lock [lockd] 0x47 
Jun 24 15:22:02 mercury kernel: [<d8922cbc>] nlm4_decode_lock [lockd] 0x5c 
Jun 24 15:22:02 mercury kernel: [<d892318f>] nlm4svc_decode_testargs [lockd] 0x2f 
Jun 24 15:22:02 mercury kernel: [<d892a494>] nlmsvc_procedures4 [lockd] 0xc0 
Jun 24 15:22:02 mercury kernel: [<d890f606>] svc_process_Re3483a09 [sunrpc] 0x2c6 
Jun 24 15:22:02 mercury kernel: [<d8929bc0>] nlmsvc_version4 [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: [<d8929be4>] nlmsvc_program [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: [<d891eccd>] lockd [lockd] 0x19d 
Jun 24 15:22:02 mercury kernel: [<c0107136>] kernel_thread [kernel] 0x26 
Jun 24 15:22:02 mercury kernel: [<d891eb30>] lockd [lockd] 0x0 
Jun 24 15:22:02 mercury kernel: 
Jun 24 15:22:02 mercury kernel: 
Jun 24 15:22:02 mercury kernel: Code: c7 04 81 00 00 00 00 8b 4c 24 0c 83 44 24 0c 04 8b 02 0f c8 

The output from lsmod is:

Module                  Size  Used by    Not tainted
via82cxxx_audio        20480   0 (autoclean)
uart401                 7936   0 (autoclean) [via82cxxx_audio]
ac97_codec             11936   0 (autoclean) [via82cxxx_audio]
sound                  71916   0 (autoclean) [via82cxxx_audio uart401]
soundcore               6692   4 (autoclean) [via82cxxx_audio sound]
binfmt_misc             7556   1
autofs                 12132   1 (autoclean)
nfs                    86172   3 (autoclean)
nfsd                   76192   8 (autoclean)
lockd                  56768   1 (autoclean) [nfs nfsd]
sunrpc                 75764   1 (autoclean) [nfs nfsd lockd]
dmfe                   15420   1
ide-cd                 30272   0 (autoclean)
cdrom                  32224   0 (autoclean) [ide-cd]
st                     29140   0 (unused)
usb-uhci               24452   0 (unused)
usbcore                73216   1 [usb-uhci]
qlogicisp              44512   0 (unused)
sd_mod                 12864   0 (unused)
scsi_mod              108576   3 [st qlogicisp sd_mod]

A few weeks ago there was a similar report on linux-kernel which used xfs as
the filesystem.  We are not using xfs - just ext2.

The oops appears to crash lockd (it doesn't appear in the process table
after the oops has occured) and all nfsd processes are locked in the D state
indefinitely.  The machine needs to be rebooted to restore operation.  It
goes without saying that in this state, all clients hang up until the server
has been rebooted.

If you have any further questions I'm happy to attempt to answer them.  This
was going to be our new production server, but until this problem is
rectified we're going to have to fall back to our original DEC - we can't
afford to have 100 people unable to work for days on end.

Please CC me any replies since I do not subscribe to either list (nfs or
linux-kernel).

Best regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
