Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290987AbSBGAPc>; Wed, 6 Feb 2002 19:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290984AbSBGAPJ>; Wed, 6 Feb 2002 19:15:09 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:17164 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S290981AbSBGAOt>; Wed, 6 Feb 2002 19:14:49 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org, davem@redhat.com, alan@redhat.com
cc: pmenage@ensim.com
Subject: [PATCH][BUG] Race in unix_dgram_sendmsg
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Feb 2002 16:14:42 -0800
Message-Id: <E16YcD4-0001UT-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's an oopsable race in unix_dgram_sendmsg() in 2.2.20 (that appears
to have been fixed in 2.4 as part of the threading of the network
stack).

At the start of unix_dgram_sendmsg() we check that we either have a peer
socket, or that we have a remote socket address in sunaddr. Later, we
release the kernel lock while copying data from user space. After
reacquiring the lock, we check that we have a peer, and if not we try to
find the peer specified by sunaddr.

While the lock was released, (or if we slept while copying into memory
on UP) another user of the socket may have broken the connection,
resulting in calling unix_find_other() with a NULL sunaddr, and an Oops.

Below are the obvious patch to fix the problem, a sample Oops and a test
program to demonstrate the bug.

--- linux/net/unix/af_unix.c~	Tue Jan 29 00:05:14 2002
+++ linux/net/unix/af_unix.c	Wed Feb  6 15:41:52 2002
@@ -1017,6 +1017,9 @@
 	}
 	if (!other)
 	{
+		err = -ECONNRESET;
+		if(sunaddr==NULL)
+			goto out_free;
 		other = unix_find_other(sunaddr, namelen, sk->type, hash, &err);
 		if (other==NULL)
 			goto out_free;






Feb  6 14:59:12 qa06 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000002
Feb  6 14:59:12 qa06 kernel: current->tss.cr3 = 19835000, %%cr3 = 19835000
Feb  6 14:59:12 qa06 kernel: *pde = 00000000
Feb  6 14:59:12 qa06 kernel: Oops: 0000
Feb  6 14:59:12 qa06 kernel: CPU:    3
Feb  6 14:59:12 qa06 kernel: EIP:    0010:[unix_find_other+16/156]
Feb  6 14:59:12 qa06 kernel: EIP:    0010:[<80189184>]
Feb  6 14:59:12 qa06 kernel: EFLAGS: 00010246
Feb  6 14:59:12 qa06 kernel: eax: 00000002   ebx: 00000000   ecx: 00000000   edx: 00000000
Feb  6 14:59:12 qa06 kernel: esi: 00000000   edi: 9936fe54   ebp: 00000002   esp: 9936fe10
Feb  6 14:59:12 qa06 kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 14:59:12 qa06 kernel: Process testoops (pid: 21019, process nr: 73, stackpage=9936f000)
Feb  6 14:59:12 qa06 kernel: Stack: bece7da0 9936fe5c 80189d2f 00000000 00000000 00000002 00000000 9936fe54 
Feb  6 14:59:12 qa06 kernel:        00000003 9936fed4 80189b30 00000000 9b2060c0 9936fe54 9936e000 00000000 
Feb  6 14:59:12 qa06 kernel:        00000000 00000000 00000000 9a3483b0 801537bc 9a3483b0 9936fed4 00000006 
Feb  6 14:59:12 qa06 kernel: Call Trace: [unix_dgram_sendmsg+511/800] [unix_dgram_sendmsg+0/800] [sock_sendmsg+136/172] [unix_dgram_sendmsg+0/800] [sys_sendto+230/284] [<c009ed6a>] [<c0144930>] 
Feb  6 14:59:12 qa06 kernel: Call Trace: [<80189d2f>] [<80189b30>] [<801537bc>] [<80189b30>] [<80154422>] [<c009ed6a>] [<c0144930>] 
Feb  6 14:59:12 qa06 kernel:        [free_pages+36/40] [do_wp_page+264/512] [handle_mm_fault+405/480] [sys_send+30/36] [sys_socketcall+269/480] [system_call+52/56] 
Feb  6 14:59:12 qa06 kernel:        [<80128f38>] [<80121500>] [<80121b8d>] [<80154476>] [<80154ce5>] [<8010a7b0>] 
Feb  6 14:59:12 qa06 kernel: Code: 80 7a 02 00 74 56 68 00 c0 00 00 6a 02 8d 42 02 50 e8 c2 ab 




#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

int main(void) {

    int fd = socket(AF_UNIX, SOCK_DGRAM, 0);
    if(fork()) {
	struct sockaddr_un sun = { AF_UNIX, "/dev/log" };
	struct sockaddr unspec = { AF_UNSPEC };

	while(1) {
	    connect(fd, (struct sockaddr *)&sun, sizeof(sun));
	    connect(fd, &unspec, sizeof(unspec));
	}
    } else {
	while(1) {
	    send(fd, "xxxxx", 6, 0);
	}

    }
}




