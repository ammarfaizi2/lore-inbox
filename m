Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRIKSfb>; Tue, 11 Sep 2001 14:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272357AbRIKSfW>; Tue, 11 Sep 2001 14:35:22 -0400
Received: from [209.247.180.230] ([209.247.180.230]:47882 "HELO RAS-SERVER")
	by vger.kernel.org with SMTP id <S270774AbRIKSfK>;
	Tue, 11 Sep 2001 14:35:10 -0400
From: "Bao C. Ha" <baoha@sensoria.com>
To: "'Benjamin LaHaise'" <bcrl@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Different old_mmap behavior between  2.4.5 and 2.4.8
Date: Tue, 11 Sep 2001 11:31:22 -0700
Message-ID: <02b701c13aef$f59f0a00$456c020a@SENSORIA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <20010910214946.A16760@redhat.com>
Importance: Normal
X-GCMulti: 1
X-SMTP-Server: PostCast Server 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Sep 10, 2001 at 06:30:55PM -0700, Bao C. Ha wrote:
> > Is this supposed to be the correct behavior?  What changes 
> > make the newer kernels to return different pointers?  We
> > are running on the sh4 architecture but I think these calls
> > come from malloc() which should be arch-independent.
> 
> The result from earlier kernels is wrong.  If your code 
> requires that the same address is returned as was specified 
> then you need to pass in the MAP_FIXED flag.

Unfortunately, it is the linuxthreads code that is broken
on the sh4 platform.  It seems that the pointers are moved 
due to cache aliasing.  I am trying to raise awareness that
this is breaking pthreads applications on sh4-linux.

Following is the relevant segment of linuxthreads that is
broken:

In function pthread_allocate_stack(), file manager.c:
.......
#  ifdef _STACK_GROWS_DOWN
      new_thread = default_new_thread;
      new_thread_bottom = (char *) (new_thread + 1) - stacksize;
      map_addr = new_thread_bottom - guardsize;
      res_addr = mmap(map_addr, stacksize + guardsize,
                      PROT_READ | PROT_WRITE | PROT_EXEC,
                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      if (res_addr != map_addr)
        {
          /* Bad luck, this segment is already mapped. */
          if (res_addr != MAP_FAILED)
            munmap (res_addr, stacksize + guardsize);
          return -1;
        }
.......

We resort to patching the MAP_FIXED back to linuxthreads
until we get a resolution on this problem.

Thanks.
Bao


