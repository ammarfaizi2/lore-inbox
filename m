Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbRCGIOq>; Wed, 7 Mar 2001 03:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130434AbRCGIOg>; Wed, 7 Mar 2001 03:14:36 -0500
Received: from servo.isi.edu ([128.9.160.111]:59911 "EHLO servo.isi.edu")
	by vger.kernel.org with ESMTP id <S130433AbRCGIOV>;
	Wed, 7 Mar 2001 03:14:21 -0500
Message-Id: <200103070813.f278DUw06475@servo.isi.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another? 
In-Reply-To: Message from Marcelo Tosatti <marcelo@conectiva.com.br> 
   of "Wed, 07 Mar 2001 03:02:14 -0300." <Pine.LNX.4.21.0103070301310.1548-100000@freak.distro.conectiva> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6472.983952810.1@servo.isi.edu>
Date: Wed, 07 Mar 2001 00:13:30 -0800
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
>On Wed, 7 Mar 2001, Alexander Viro wrote:
>> You are reinventing the wheel.
>> man ptrace (see PTRACE_{PEEK,POKE}{TEXT,DATA} and PTRACE_{ATTACH,CONT,DETACH})
>
>With ptrace data will be copied twice. As far as I understood, Jeremy
>wants to avoid that. 

Yes - I've been looking at the sys_ptrace code and it seems that it
does two copies through the kernel (but, using access_process_vm
instead of copy_from_user -- I'm not sure how they differ).  I'm
trying to reduce the number of copies by giving one process a pointer
into another process's address space.

Right now, my code looks something like this: (it might make more
sense if you know that I've written a framework for writing user-space
device drivers... I'm going to be releasing it soon, hopefully after I
resolve this performance problem.  Or maybe before, if it's hard.)

   Process X: (any arbitrary process)
        read(fd, my_local_buffer);
   Kernel:
        [notifies process Y that X needs data]
   Process Y: (the userspace device driver)
        memcpy(my_local_buffer, data_destined_for_process_x);
        write(fd, my_local_buffer);
   Kernel (in sys_write:)
        copy_from_user(kernel_buffer, Y's my_local_buffer);
        copy_to_user(X's my_local_buffer, kernel_buffer);     

Now, this all works fine, but it's slower than I'd like.  I used SGI's
kernprof (oss.sgi.com/projects/kernprof) and found that the kernel was
spending most of its time (like 70%) in copy_to_user and
copy_from_user.  So, I am hoping to make this all go faster, while
hopefully preserving correctness, by changing to something like this:

   Process X:
        read(fd, my_local_buffer);
   Kernel:
        [maps X's my_local_buffer to Y's address space]
        [notifies process Y that X needs data, and sends along a
	 pointer to write data to, or a handle usable by shmat,
         or something]
   Process Y:
         memcpy(X's my_local_buffer, data_destined_for_process_x);

If I'm lucky we can avoid both copy_to_user and copy_from_user.

This would be easy if X was a "cooperative" process because we could
just set up a shared memory segment between the two processes.  The
problem is that X is not cooperative -- it can be any existing
program.

Regards,
Jeremy
