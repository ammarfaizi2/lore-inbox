Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290028AbSAQQvy>; Thu, 17 Jan 2002 11:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290034AbSAQQvs>; Thu, 17 Jan 2002 11:51:48 -0500
Received: from rpapar1.cgey.com ([194.3.224.25]:31422 "EHLO door.cgey.com")
	by vger.kernel.org with ESMTP id <S290060AbSAQQvj>;
	Thu, 17 Jan 2002 11:51:39 -0500
Message-ID: <3C470105.ED9DDCE@cgey.com>
Date: Thu, 17 Jan 2002 16:51:17 +0000
From: Fabien Ribes <fabien.ribes@cgey.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Oops in sock_poll
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a kernel Oops on ppc kernel 2.4.5 with an application listenning
to a high throughput of incoming messages on a netlink socket. The
application is running select() on the netlink socket file descriptor
followed with  recvmsg() call (in a forever loop).

The Oops (not saved, and hard to reproduce) showed a crash in the
sock_poll function (kernel/net/socket.c); after investigations, crash is
due to a NULL pointer in f_dentry member of the file structure. This
pointer is set to NULL in the fput (kernel/fs/file_table.c) function.
The backtraces show that the calling function is the sys_recvmsg
(kernel/net/socket.c).

My understanding of the problem is the following:

- When everything goes right:

A/ When netlink socket is opened, its associated file structure is
initialised with f_count to 1, and a dentry;

B/ When select is executed, f_count is increased to 2;

C/ When select ends, f_count is decreased to 1;

D/ When recvmsg is executed, f_count is increased to 2;

E/ When recvmsg ends, f_count is decreased to 1;

F/ Loop forever to B/

- When the problem occurs:

A/ When netlink socket is opened, its associated file structure is
initialised with f_count to 1, and a dentry;

B/ When select is executed, f_count is increased to 2;

C/ When select ends, f_count is decreased to 1;

D/ When recvmsg is executed, f_count is increased to 2;

????/ SOMETHING decreases f_count to 1;

E/ When recvmsg ends, f_count is decreased to 0, AND THEREFORE f_dentry
member of file is set to NULL (since file is considered as not used) ;

F/ When select is executed, f_count is incremented to 1, but f_dentry is
NULL and therefore following code crashes in sock_poll function:
 sock = socki_lookup(file->f_dentry->d_inode);

Do you have an idea of the event that could have decreased the f_count
member between D/ and E/ ?
Could you give me elements to continue my investigation ?

Thanks a lot for you help,
Fabien
