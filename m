Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288983AbSAUAbw>; Sun, 20 Jan 2002 19:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288982AbSAUAbc>; Sun, 20 Jan 2002 19:31:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64076 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288980AbSAUAbW>; Sun, 20 Jan 2002 19:31:22 -0500
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] new virtualization syscall to improve uml performance?
In-Reply-To: <200201182335.SAA05269@ccure.karaya.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jan 2002 17:28:15 -0700
In-Reply-To: <200201182335.SAA05269@ccure.karaya.com>
Message-ID: <m1lmesh7j4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It sounds like there are a couple of good ideas here.  Let me add my
refinements.

new_addr(); /* to get a secondary address space */
struct sandbox_params {
    int return_reason;
    int return_data;
    int eax;
    int ebx;
};
run_sandbox(int address_space, struct sandbox_params *params); /* to start a sandbox */

int fmmap(int address_space, void *start, size_t length, int prot, 
         int flags, int fd, off_t offset);
int fmunmap(int addresss_space, void *start, size_t length);


With the secondary address spaces being completely setup by uml.
And run_sandbox being the entry/exit point.  The nice thing here is
that because they would share the same kernel stack/process most
registers can be left in registers.  With run_sandbox putting as much
as possible on a fast path.

And then new_addr, fmmap, fmunmap would be all that you would really
need to manipulate those address spaces.

Usually processors only support a kernel/user space differentiation in
their page tables, and the sometimes support caching multiple address
spaces simultaneously cached in their tlbs.  So I have designed this
interface to take advantage of the common processor features, and
additionally look as much like normal process execution as possible.
Any other implementation would need someone manually modify the page
tables, either the kernel or uml calling mprotect.

Any trap taken in the sandboxed address space should fill the
appropriate fields in struct sandbox_params and switch address spaces
back to the master process.

This interface is as cheap as I can imagine making it.  And with
a little care can be really optimized on the kernel side if uml
becomes a common case.

Eric




