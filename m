Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUCVRHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUCVRHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:07:52 -0500
Received: from dkw.ci.uv.es ([147.156.1.46]:26519 "EHLO dkw.uv.es")
	by vger.kernel.org with ESMTP id S262121AbUCVRGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:06:39 -0500
Date: Mon, 22 Mar 2004 18:05:20 +0100
From: uaca@alumni.uv.es
To: linux-net@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: RFC/Doc/BUGs: CONFIG_PACKET_MMAP
Message-ID: <20040322170520.GA3685@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

Here is an updated and extended version of the 
CONFIG_PACKET_MMAP documentation I posted previously

Please read it and and send me your comments to

       uaca@alumni.uv.es


I have found two bugs

     + the first is a minor issue, it allows the
       user to waste some memory. It is marked as
       check (1) in the documentation.

     + another is a memory leakage when two or more calls
       to setsockopt with PACKET_RX_RING is done on the same
       socket. pg_vec and io_vec vectors are not deallocated.

Also, I have propossed a modification, which would allow to 
increase the number of the frames that can be used in the 
buffer, there is limit here and things are worse on 64 bit
architectures. I'm very interested on hear comments about 
it, I'm sending a CC: to Alexey Kuznetsov, I think he is the author 
of PACKET_MMAP. 

The propossed modification is to kill the io_vec vector, and just 
use pg_vec and infer page position by using pointer arithmetic. 



I would like to ask you about skb_buf.ip_summed. This field is also
used for both RX and TX checksum offloading and not only IP packets but
also for TCP/UDP (typhoon, ixgb). I think the ip_summed description 
is misleading and should be changed:

 *      @ip_summed: Driver fed us an IP checksum

And hence also my description of the TP_STATUS_CSUMNOTREADY flag on
PACKET_MMAP. 

IMHO, An updated description should also mention what this flag 
means with respect to upper layer protocols.



cheers

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

Humans are slow, innaccurate, and brilliant.
Computers are fast, acurrate, and dumb. 
Together they are unbeatable

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
--------------------------------------------------------------------------------
+ ABSTRACT
--------------------------------------------------------------------------------

This file documents the CONFIG_PACKET_MMAP option available with the PACKET
socket interface on 2.4 and 2.6 kernels. This type of sockets are used for 
capture network traffic with utilities like tcpdump or any other that uses 
the libpcap library. 

You can find the lastest version of this document at

    http://pusa.uv.es/~ulisses/packet_mmap/

Maybe this file is too much verbose, please send me your comments to

    Ulises Alonso Camaró <uaca@i.hate.spam.alumni.uv.es>

-------------------------------------------------------------------------------
+ Why use PACKET_MMAP
--------------------------------------------------------------------------------

In Linux 2.4/2.6 if PACKET_MMAP is not enabled, the capture process is very
inefficient. It uses very limited buffers and requires one system call
to capture each packet, it requires two if you want to get packet's 
timestamp (like libpcap always does).

In the other hand PACKET_MMAP is very efficient. PACKET_MMAP provides a size 
configurable circular buffer mapped in user space. This way reading packets just 
needs to wait for them, most of the time there is no need to issue a single 
system call. By using a shared buffer between the kernel and the user 
also has the benefit of minimizing packet copies.

It's fine to use PACKET_MMAP to improve the performance of the capture process, 
but it isn't everything. At least, if you are capturing at high speeds (this 
is relative to the cpu speed), you should check if the device driver of your 
network interface card supports some sort of interrupt load mitigation or 
(even better) if it supports NAPI, also make sure it is enabled.

--------------------------------------------------------------------------------
+ How to use CONFIG_PACKET_MMAP
--------------------------------------------------------------------------------

>From the user standpoint, you should use the higher level libpcap library, wich
is a de facto standard, portable across nearly all operating systems
including Win32. 

Said that, at time of this writing, official libpcap 0.8.1 is out and doesn't include
support for PACKET_MMAP, and also probably the libpcap included in your distribution. 

I'm aware of two implementations of PACKET_MMAP in libpcap:

    http://pusa.uv.es/~ulisses/packet_mmap/  (by Simon Patarin, based on libpcap 0.6.2)
    http://public.lanl.gov/cpw/              (by Phil Wood, based on lastest libpcap)

The rest of this document is intended for people who want to understand
the low level details or want to improve libpcap by including PACKET_MMAP
support.

--------------------------------------------------------------------------------
+ How to use CONFIG_PACKET_MMAP directly
--------------------------------------------------------------------------------

>From the system calls stand point, the use of PACKET_MMAP involves
the following process:


[setup]     socket() -------> creation of the capture socket
            setsockopt() ---> allocation of the circular buffer (ring)
            mmap() ---------> maping of the allocated buffer to the
                              user process

[capture]   poll() ---------> to wait for incoming packets

[shutdown]  close() --------> destruction of the capture socket and
                              deallocation of all associated 
                              resources.


socket creation and destruction is straight forward, and is done 
the same way with or without PACKET_MMAP:

int fd;

fd= socket(PF_PACKET, mode, htons(ETH_P_ALL))

where mode is SOCK_RAW for the raw interface were link level
information can be captured or SOCK_DGRAM for the cooked
interface where link level information capture is not 
supported and a link level pseudo-header is provided 
by the kernel.

The destruction of the socket and all associated resources
is done by a simple call to close(fd).

Next I will describe PACKET_MMAP settings and it's constraints,
also the maping of the circular buffer in the user process and 
the use of this buffer.

--------------------------------------------------------------------------------
+ PACKET_MMAP settings
--------------------------------------------------------------------------------


To setup PACKET_MMAP from user level code is done with a call like

     setsockopt(fd, SOL_PACKET, PACKET_RX_RING, (void *) &req, sizeof(req))

The most significative in the previous call is the req parameter, this parameter 
must to have the following structure:

    struct tpacket_req
    {
        unsigned int    tp_block_size;  /* Minimal size of contiguous block */
        unsigned int    tp_block_nr;    /* Number of blocks */
        unsigned int    tp_frame_size;  /* Size of frame */
        unsigned int    tp_frame_nr;    /* Total number of frames */
    };

This structure is defined in include/linux/if_packet.h and establishes a 
circular buffer (ring) of unswapable memory mapped in the capture process. 
Being mapped in the capture process allows reading the captured frames and 
related meta-information like timestamps without requiring a system call.

Capured frames are grouped in blocks. Each block is a physically contiguous 
region of memory and holds tp_block_size/tp_frame_size frames. The total number 
of blocks is tp_block_nr. Note that tp_frame_nr is a redundant parameter because

    frames_per_block = tp_block_size/tp_frame_size

indeed, packet_set_ring checks that the following condition is true

    frames_per_block * tp_block_nr == tp_frame_nr


Lets see an example, with the following values:

     tp_block_size= 4096
     tp_frame_size= 2048
     tp_block_nr  = 4
     tp_frame_nr  = 8

we will get the following buffer structure:

        block #1                 block #2                 block #3                 block #4
+---------+---------+    +---------+---------+    +---------+---------+    +---------+---------+
| frame 1 | frame 2 |    | frame 3 | frame 4 |    | frame 5 | frame 6 |    | frame 7 | frame 8 |
+---------+---------+    +---------+---------+    +---------+---------+    +---------+---------+



--------------------------------------------------------------------------------
+ PACKET_MMAP setting constraints
--------------------------------------------------------------------------------

 Block size limit
------------------

As stated earlier, each block is a contiguous phisical region of memory. These 
memory regions are allocated with calls to the __get_free_pages() function. As 
the name indicates, this function allocates pages of memory, it allocates a power 
of two number of pages, that is 4096, 8192, 16384, etc. The maximum size of a 
region allocated by __get_free_pages is determined by the MAX_ORDER macro. More 
precisely the limit can be calculated as:

   PAGE_SIZE << MAX_ORDER

   In a i386 architecture PAGE_SIZE is 4096 bytes 
   In a 2.4/i386 kernel MAX_ORDER is 10
   In a 2.6/i386 kernel MAX_ORDER is 11

So get_free_pages can allocate as much as 4MB or 8MB in a 2.4/2.6 kernel 
respectively, with a i386 architecture.

 Block number limit
--------------------

To understand the constraints of PACKET_MMAP settings we have to see two 
aditional data structures used to support the ring. One of this structures 
limits the number of blocks as we will see next, the other structure limits 
the total number of frames.

There is a vector that mantains a pointer to each block, this vector is 
called pg_vec wich stands for page vector. The following figure represents 
the pg_vec that is used with the buffer shown before.

    +---+---+---+---+
    | x | x | x | x |
    +---+---+---+---+
      |   |   |   |
      |   |   |   v
      |   |   v  block #4
      |   v  block #3
      v  block #2
     block #1


The number of blocks that can be allocated is determined by the size of 
pg_vec. This vector is allocated with a call to the kmalloc function.

kmalloc allocates any number of bytes of phisically contiguous memory 
from a pool of pre-determined sizes. This pool of memory is mantained 
by the slab allocator wich is at the end the responsible of doing
the allocation and hence wich imposes the maximum memory 
that kmalloc can allocate. 

In a 2.4/2.6 kernel and the i386 architecture, the limit is 131072 bytes. This
limit can be checked in the "size-<bytes>" entries of /proc/slabinfo

In a 32 bit architecture, pointers are 4 bytes long, so the total number of 
pointers to blocks (and hence blocks) is

     131072/4 = 32768 blocks


 Total Frame number limit
--------------------------

There is another vector of pointers, wich hold references to each frame 
in the buffer, this vector is called io_vec. This vector is also allocated 
with kmalloc, so we the maximum number of frames is the same as for the block 
number. Indeed, the limit to the size of the buffer is impossed by the io_vec 
vector because we have at least the same number of frames than blocks.

If we continue with the previous example the resulting io_vec is:

    +---+---+---+---+---+---+---+---+
    | y | y | y | y | y | y | y | y |
    +---+---+---+---+---+---+---+---+
      |   |   |   |   |   |   |   |
      |   |   |   |   |   |   |   v
      |   |   |   |   |   |   v  frame #8 --- in block #4
      |   |   |   |   |   v  frame #7 ------- in block #4
      |   |   |   |   v  frame #6 ----------- in block #3  
      |   |   |   v  frame #5 --------------- in block #3
      |   |   v  frame #4 ------------------- in block #2
      |   v  frame #3 ----------------------- in block #2
      v  frame #2 --------------------------- in block #1
     frame #1 ------------------------------- in block #1


If you check the source code you will see that what I draw here as a frame
is not only the link level frame. At the begining of each frame there is a 
header called struct tpacket_hdr used in PACKET_MMAP to hold link level's frame
meta information like timestamp. So what we draw here a frame it's really 
the following (from include/linux/if_packet.h):

/*
   Frame structure:

   - Start. Frame must be aligned to TPACKET_ALIGNMENT=16
   - struct tpacket_hdr
   - pad to TPACKET_ALIGNMENT=16
   - struct sockaddr_ll
   - Gap, chosen so that packet data (Start+tp_net) alignes to TPACKET_ALIGNMENT=16
   - Start+tp_mac: [ Optional MAC header ]
   - Start+tp_net: Packet data, aligned to TPACKET_ALIGNMENT=16.
   - Pad to align to TPACKET_ALIGNMENT=16
 */
           
 Other constraints
-------------------
 
 The following are conditions that are checked in packet_set_ring

   tp_block_size must be a multiple of PAGE_SIZE (1)
   tp_frame_size must be greater than TPACKET_HDRLEN (obvious)
   tp_frame_size must be a multiple of TPACKET_ALIGNMENT
   tp_frame_nr   must be exactly frames_per_block*tp_block_nr

I believe that check (1) should be changed to check if 
tp_block_size is also a power of two.

I suposse that alignment to 16 bytes boundaries is to fit better 
in cache lines.


--------------------------------------------------------------------------------
+ Maping and use of the circular buffer (ring)
--------------------------------------------------------------------------------

The maping of the buffer in the user process is done with the conventional 
mmap function. Even the circular buffer is compound of several phisically
discontiguous blocks of memory, they are contiguous to the user space, hence
just one call to mmap is needed:

    mmap(0, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

Once mapped, each frame (as detailed earlier) will be spaced tp_frame_size bytes
as spected. At the begining of each frame there is an status field (see 
struct tpacket_hdr). If this field is 0 means that the frame is ready
to be used for the kernel, If not, there is a frame the user can read 
and the following flags apply:

     from include/linux/if_packet.h

     #define TP_STATUS_COPY          2 
     #define TP_STATUS_LOSING        4 
     #define TP_STATUS_CSUMNOTREADY  8 


TP_STATUS_COPY        : This flag indicates that the frame (and associated
                        meta information) has been truncated because it's 
                        larger than tp_frame_size. This packet can be read enterily 
                        wich recvfrom().
                        
                        In order to make this work it must to be
                        enabled previously with setsockopt() and 
                        the PACKET_COPY_THRESH option. 

                        The number of frames than can be buffered to 
                        be read with recvfrom is limited like a normal socket.
                        See the SO_RCVBUF option in the socket (7) man page.

TP_STATUS_LOSING      : indicates there were packet drops from last time 
                        statistics where checked with getsockopt() and
                        the PACKET_STATISTICS option.

TP_STATUS_CSUMNOTREADY: currently it's used for outgoing IP packets wich it's checksum
                        will be done in hardware. So while reading the packet we should
                        not try to check the checksum. 

for convenience there is also the following defines

     #define TP_STATUS_KERNEL        0
     #define TP_STATUS_USER          1

The kernel initializes all frames to TP_STATUS_KERNEL, when the kernel
receives a packet it puts in the buffer and updates the status with
at least the TP_STATUS_USER flag. Then the user can read the packet,
once the packet is read the user must zero the status field, so the kernel 
can use again that frame buffer.

The user can use poll (any other variant should apply too) to check if new
packets are in the ring. It doesn't incur in a race condition to first
check the status value and then poll for frames, eg:

    struct pollfd pfd;

    pfd.fd = fd;
    pfd.revents = 0;
    pfd.events = POLLIN|POLLRDNORM|POLLERR;

    if (status == TP_STATUS_KERNEL)
        retval = poll(&pfd, 1, timeout);

--------------------------------------------------------------------------------
+ Details and discusion
--------------------------------------------------------------------------------

All memory allocations done in packet_set_ring are not freed until the socket
is closed. The memory allocations are done with GFP_KERNEL priority, this 
basically means that the allocation can wait and swap other process' memory 
in order to allocate the nececessary memory, so normally limits can be reached.

While reading packet_set_ring I asked myself some questions:

   + Why pointers for both blocks and frames?

   io_vec and pg_vec pointers are asigned to a struct packet_op
   wich is held in the packet socket, not freed until socket close. In 
   struct packet_opt io_vec renames to iovec.

   By having frame pointers there is a fast access to each frame when 
   needed, and this is fine because this will happen very often. Block pointers 
   are used only in the setup/shutdown of the PACKET_MMAP infraestructure, 
   mostly in packet_set_ring and packet_mmap. It is possible to infer block 
   position by taking into acount the number of frames each block has. 
   PACKET_MMAP's designers seems that tought it is worth having pg_vec 
   to make code more readable. More in this later.


   + The maximum number of frames, is really a limitating factor?

   Next I will consider the following scenario:

   In the Internet, packet average size, including the link layer, 
   is around 575 bytes. 

   In a i386 architecture PACKET_MMAP can hold up to 32768 frames.

   If we want to monitor a link at a rate of 1 Gb/s, PACKET_MMAP
   will only buffer as much as 0.15 seconds ((575*8*32768)/10^9).
   
   With multi-Gigabit interfaces going to mainstream, this limit will
   have to go away.

   Please note that a 64 bit machine makes things worst with respect to
   pg_vec and io_vec because they can handle half of the pointers than a 
   32 bit machine, pointers are double size and the kmalloc limit 
   doesn't increase.

   kmalloc limits (128 KiB by default) are defined in 
   include/linux/kmalloc_sizes.h, and is raised in case the CPU doesn't 
   have an MMU (CONFIG_MMU undefined) and can be raised further with 
   CONFIG_LARGE_ALLOCS. It's straight forward modifying 
   kmalloc_sizes.h to increase the limits, but you also have to 
   modify MAX_OBJ_ORDER and MAX_GFP_ORDER in slab.c.

   Another possibility would be to change the allocation of io_vec
   to use vmalloc instead of kmalloc. 

   These two options are hacks and should be avoided, A different
   approach could be to convert pg_vec and io_vec in a two folded 
   structure.
 
   +---+---+---+---+
   | x | x | x | x |
   +---+---+---+---+
     |   |   |   |
     |   |   |   |   +---+---+---+---+
     |   |   |   |-> | y | y | y | y | 
     |   |   |       +---+---+---+---+
     |   |   |   +---+---+---+---+
     |   |   |-> | y | y | y | y |
     |   |       +---+---+---+---+
     |   |   +---+---+---+---+
     |   |-> | y | y | y | y |
     |       +---+---+---+---+
     |   +---+---+---+---+
     |-> | y | y | y | y |
         +---+---+---+---+


   In this case the setup parameters should minimize the number of blocks.

   Another option, would be to just use pg_vec and avoid the use of io_vec, 
   and infer page position by using pointer arithmetic. IMHO this is 
   preferable.
   


>>> EOF
