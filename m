Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135218AbRDLQXh>; Thu, 12 Apr 2001 12:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135219AbRDLQX0>; Thu, 12 Apr 2001 12:23:26 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:34823 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S135218AbRDLQXL>;
	Thu, 12 Apr 2001 12:23:11 -0400
Date: Thu, 12 Apr 2001 12:22:52 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: CJ <cj@cjcj.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Asynchronous io
In-Reply-To: <3AD5CC5F.69D3BAEC@cjcj.com>
Message-ID: <Pine.LNX.4.30.0104121212500.2332-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CJ,
  you should really read the thread titled "Linux's implementation of
poll() not scalable?" in the LKML archives, here is a link:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.3/0003.html
There are many problems with the /dev/something interface for events and
all is described in that thread.

  I have worked on a way suggested by Linus to get rid of the hit in
performance when using select() and poll().  I have a working model for
TCP sockets (as that is what I wanted to speed up - a TCP based proxy).
My implementation is still in alpha but is available here:
  http://www.jukie.net/~bart/kernel/fdevent/

  Now, before anyone gets to excited... I spoke with Linus about this and
he suggested that I speak with Ben LaHaise who is working on async io
using some modifications to the wail queue.  I have send him mail but have
not heard from Ben - I guess he must be as busy as the rest of us with a
full mailbox of messages that he has no time to reply to. :)

  My implementation introduces two new system calls: bind_event and
get_events (as descibed in Linus' email above).  The project is still in
an alpha stage so I don't have any benchmarks.  I am working on this at my
own time so progress is moving at a slow pace... unfortunately.

Regards,
Bart.

On Thu, 12 Apr 2001, CJ wrote:

> //Linux really needs a clean basis for asynchronous and
> //unbuffered i/o libraries.  Something like the fork/thread
> //clone(), but to replace select() and aio_* polling.  This
> //might be a start. And it is just a file and very like a
> //pipe or socket.
>
> //Suppose we add /dev/qio with 64 byte sectors as follows:
>
> struct qio{            //64 byte i/o request
>     u16 flags;          //0.0 request block variant, SEEK_SET...
>     u16 verb;           //0.2 open,close,read,mmap,sync,write,
>                         //    ioctl
>                         //    mallocIO&read,write&freeIO,
>                         //    mallocIO,freeIO
>                         //    autothread might be an ioctl()
>     u16 errno;          //0.4 per request status
>     u16 completehow;    //0.6 queue,AST,pipe,SIGIO,SIGIO||delete ok
>     u64 offset;         //1
>     u32 length;         //2.0 bytes requested
>     u32 timeout;        //2.4 im ms or us?
>     u32 transferred;    //3.0 bytes
>     u32 qiohandle;      //3.4 for cancell or polling
>     void* handle;       //4 (open & close might write)
>     void* buffer;       //5
>     void* callback;     //6 optimize special cases w/ completehow
>     void* callparam;    //7
> };                      //all fields are read xor write
>
> //Writing to the device would schedule i/o, reading would reap
> //completions.  Bad writes would give the byte offset to the
> //rejected sector field if detected synchronously.  Multiple
> //sector writes would be truncated on the first bad sector.
> //Accepted writes would be buffered in the kernel.
>
> //Each open creates a new queue, each write is read in the
> //same queue.  Any number of threads can read or write a queue.
>
> //some cases might be simplified by kernel processed completions,
> //such as VMS AST emulation, or putting results in a pipe. Hence
> //completehow, which might use callback and callparam.
>
> //timeout?
> //canceling i/o?
> //Sun aio emulation?
> //VMS qio emulation?
> //MS IOCP emulation?
> //malloc()&free() safe across threads?
> //Should O_DIRECT would error unless properly aligned etc.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/



