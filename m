Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135172AbRDLPkt>; Thu, 12 Apr 2001 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRDLPkk>; Thu, 12 Apr 2001 11:40:40 -0400
Received: from conx.aracnet.com ([216.99.200.135]:41665 "HELO cj90.in.cjcj.com")
	by vger.kernel.org with SMTP id <S135172AbRDLPkZ>;
	Thu, 12 Apr 2001 11:40:25 -0400
Message-ID: <3AD5CC5F.69D3BAEC@cjcj.com>
Date: Thu, 12 Apr 2001 08:40:15 -0700
From: CJ <cj@cjcj.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Asynchronous io
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

//Linux really needs a clean basis for asynchronous and 
//unbuffered i/o libraries.  Something like the fork/thread
//clone(), but to replace select() and aio_* polling.  This 
//might be a start. And it is just a file and very like a
//pipe or socket.

//Suppose we add /dev/qio with 64 byte sectors as follows: 

struct qio{            //64 byte i/o request
    u16 flags;          //0.0 request block variant, SEEK_SET...
    u16 verb;           //0.2 open,close,read,mmap,sync,write,
                        //    ioctl
                        //    mallocIO&read,write&freeIO,
                        //    mallocIO,freeIO
                        //    autothread might be an ioctl()
    u16 errno;          //0.4 per request status
    u16 completehow;    //0.6 queue,AST,pipe,SIGIO,SIGIO||delete ok
    u64 offset;         //1 
    u32 length;         //2.0 bytes requested
    u32 timeout;        //2.4 im ms or us?
    u32 transferred;    //3.0 bytes
    u32 qiohandle;      //3.4 for cancell or polling
    void* handle;       //4 (open & close might write)
    void* buffer;       //5
    void* callback;     //6 optimize special cases w/ completehow
    void* callparam;    //7 
};                      //all fields are read xor write

//Writing to the device would schedule i/o, reading would reap
//completions.  Bad writes would give the byte offset to the 
//rejected sector field if detected synchronously.  Multiple 
//sector writes would be truncated on the first bad sector.
//Accepted writes would be buffered in the kernel.

//Each open creates a new queue, each write is read in the
//same queue.  Any number of threads can read or write a queue.

//some cases might be simplified by kernel processed completions, 
//such as VMS AST emulation, or putting results in a pipe. Hence
//completehow, which might use callback and callparam.

//timeout?  
//canceling i/o?  
//Sun aio emulation?  
//VMS qio emulation?  
//MS IOCP emulation?
//malloc()&free() safe across threads?
//Should O_DIRECT would error unless properly aligned etc.
