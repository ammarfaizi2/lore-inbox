Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264747AbSJ3RJf>; Wed, 30 Oct 2002 12:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSJ3RJf>; Wed, 30 Oct 2002 12:09:35 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:28349 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S264747AbSJ3RJd>; Wed, 30 Oct 2002 12:09:33 -0500
Message-ID: <025201c28037$f1ff9250$0200a8c0@cirilium.com>
From: "Mark Hamblin" <MarkHamblin@cox.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210291946260.1457-100000@blue1.dev.mcafeelabs.com>
Subject: Re: [patch] sys_epoll 0.14 ...
Date: Wed, 30 Oct 2002 10:15:24 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to understand these changes and I thought it might be nice
to share my notes with others.  This could be a good example for how to do
certain things in the kernel.  For example, from these changes,  I figured
out that to create a new system call, you have to:

1)  Add entry points into arch/i386/kernel/entry.S
2)  Define the new system calls, starting with sys_ and using asmlinkage in
the function definition.
3)  Add #defines for each into include/asm-i386/unistd.h
4)  Increase NR_syscalls in include/linux/sys.h

I have included some other high-level notes, including a kind of ad-hoc
cross reference for eventpoll.c.  I would appreciate any comments if anyone
thinks this kind of documentation would be useful.



diff -Nru linux-2.5.44.vanilla/arch/i386/kernel/entry.S
linux-2.5.44.epoll/arch/i386/kernel/entry.S
  // Add entry points for the three new system calls
diff -Nru linux-2.5.44.vanilla/drivers/char/Makefile
linux-2.5.44.epoll/drivers/char/Makefile
  // Add eventpoll
diff -Nru linux-2.5.44.vanilla/drivers/char/eventpoll.c
linux-2.5.44.epoll/drivers/char/eventpoll.c
  // New module
  // In cases where one entity is used by only one other entity, I indent
that entity under its user.
    // Define struct eventpoll (created by open_eventpoll and stored in
file->private_data field)
    // Define struct epitem, which is contained in a list by eventpoll.
    // You can identify the system calls because they all use asmlinkage:
    //   sys_epoll_create
    //     Uses ep_getfd();
    //       Uses get_eventpoll_inode();
    //   sys_epoll_ctl
    //   sys_epoll_wait
    // Additionally, you have these function pointer tables:
    //   eventpoll_fops
    //     Contains write_eventpoll
    //     Contains ioctl_eventpoll
    //     Contains mmap_eventpoll
    //     Contains open_eventpoll
    //     Contains close_eventpoll
    //       Uses ep_free();
    //     Contains poll_eventpoll
    //     Used by eventpoll_miscdev
    //       Used by eventpoll_init
    //       Used by eventpoll_exit
    //     Used by ep_getfd
    //     Used by get_eventpoll_inode
    //   eventpoll_mmap_ops
    //     Contains eventpoll_mm_open,
    //     Contains eventpoll_mm_close,
    //     Used by mmap_eventpoll (part of eventpoll_fops)
    //   eventpollfs_dentry_operations
    //     Contains eventpollfs_delete_dentry();
    //     Used by ep_getfd
    //   eventpoll_fs_type
    //     Uses eventpollfs_get_sb()
    //     Used by eventpoll_init
    //     Used by eventpoll_exit
    // And then you have the functions:
    //   ep_free_pages();
    //     Used by ep_free
    //     Used by ep_do_alloc_pages
    //     Used by ioctl_eventpoll
    //   ep_find_nl();
    //     Used by ep_find
    //     Used by ep_remove
    //     Used by ioctl_eventpoll
    //   ep_find();
    //     Used by sys_epoll_ctl
    //     Used by write_eventpoll
    //   ep_insert();
    //     Used by sys_epoll_ctl
    //     Used by write_eventpoll
    //     Uses ep_hashresize();
    //   ep_remove();
    //     Used by sys_epoll_ctl
    //     Used by write_eventpoll
    //   notify_proc()
    //     Used by ep_free   (as parm to file_notify_...)
    //     Used by ep_insert (as parm to file_notify_...)
    //     Used by ep_remove (as parm to file_notify_...)
    //   open_eventpoll();
    //     Used by eventpoll_fops
    //     Used by sys_epoll_create
    //     Uses ep_init();
    //   ep_poll();
    //     Used by  sys_epoll_wait
    //     Used by ioctl_eventpoll
    //   ep_do_alloc_pages();
    //     Used by sys_epoll_create
    //     Used by ioctl_eventpoll
    //     Uses ep_alloc_pages();
diff -Nru linux-2.5.44.vanilla/fs/Makefile linux-2.5.44.epoll/fs/Makefile
  // Add fcblist
diff -Nru linux-2.5.44.vanilla/fs/fcblist.c linux-2.5.44.epoll/fs/fcblist.c
  // New module
diff -Nru linux-2.5.44.vanilla/fs/file_table.c
linux-2.5.44.epoll/fs/file_table.c
  // Add calls to file_notify_init and file_notify_cleanup (defined in
fcblist)
diff -Nru linux-2.5.44.vanilla/fs/pipe.c linux-2.5.44.epoll/fs/pipe.c
  // Add call to file_send_notify when pipe ceases to be full/empty.
  // Add support for POLL_HUP to pipe_release
  // Add code to set up/initialize PIPE_READFILE/WRITEFILE
diff -Nru linux-2.5.44.vanilla/include/asm-i386/poll.h
linux-2.5.44.epoll/include/asm-i386/poll.h
  // Add POLLREMOVE (reference only by write_eventpoll, perhaps used by
user-code?)
diff -Nru linux-2.5.44.vanilla/include/asm-i386/unistd.h
linux-2.5.44.epoll/include/asm-i386/unistd.h
  // Create #defines for the three news system calls.
diff -Nru linux-2.5.44.vanilla/include/linux/eventpoll.h
linux-2.5.44.epoll/include/linux/eventpoll.h
  // New module
diff -Nru linux-2.5.44.vanilla/include/linux/fcblist.h
linux-2.5.44.epoll/include/linux/fcblist.h
  // New module
diff -Nru linux-2.5.44.vanilla/include/linux/fs.h
linux-2.5.44.epoll/include/linux/fs.h
  // Add file callback list and rw lock to ???.
diff -Nru linux-2.5.44.vanilla/include/linux/list.h
linux-2.5.44.epoll/include/linux/list.h
  // Added #defines for various generic list-access operations.
  // Only one used is list_first, by these functions:  ep_free,
ep_hashresize, file_notify_cleanup
diff -Nru linux-2.5.44.vanilla/include/linux/pipe_fs_i.h
linux-2.5.44.epoll/include/linux/pipe_fs_i.h
  // Add new fields for rdfile and wrfile
  // Add macros PIPE_READFILE and PIPE_WRITEFILE to access new fields.
diff -Nru linux-2.5.44.vanilla/include/linux/sys.h
linux-2.5.44.epoll/include/linux/sys.h
  // Increased NR_syscalls (by 4 instead of 3...why???)
diff -Nru linux-2.5.44.vanilla/include/net/sock.h
linux-2.5.44.epoll/include/net/sock.h
  // Added code to sk_wake_async to call file_send_notify.  This call given
priority over the older method.
  // My only question here is what was sk->socket->file being used for
before?  It's not a new field, and I see no other code
  //   that references it.
diff -Nru linux-2.5.44.vanilla/net/ipv4/tcp.c
linux-2.5.44.epoll/net/ipv4/tcp.c
  // Changes old call to sock_wake_async to now call sk_wake_async.  It
appears that sk_wake_async winds up calling
  //   sock_wake_async for the old case anyway.


