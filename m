Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271212AbRH1Osh>; Tue, 28 Aug 2001 10:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271265AbRH1OsR>; Tue, 28 Aug 2001 10:48:17 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:23812 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S271212AbRH1OsJ>; Tue, 28 Aug 2001 10:48:09 -0400
Message-ID: <3B8BAF1C.EC336B17@cc.gatech.edu>
Date: Tue, 28 Aug 2001 10:47:56 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
Organization: CoC, GaTech
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: silly memory question ...
In-Reply-To: <Pine.LNX.3.95.1010828101642.13417A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

thanks to all of you for your suggestions... it turns out this
is an ARM-specific issue, and maybe some other platforms as well.
(or maybe just my specific ARM kernel/glibc combo. ;)

it turns out x86 ignores some "modes" for pages in memory.  or
maybe ld.so doesn't bother to set them.  anyway, the code snippet 
below "fixes" the pages i need fixed to become R/W/X.

on *my* ARM, you can't default execute data pages; you can't 
write text pages; etc, etc. (my kernel is 2.4.0 with glibc 2.1.2.)

i don't know what other platforms enforce this, but hopefully 
this is as educational for those suggesting solutions as it has 
been for me. if i had specified i was running on ARM originally, 
it may have made things clearer.

thanks again,

josh

   // fix permissions on __app_code - we need R/W/X, not just R/X ... 
   // ARM-specific problem, but this fix should work on ALL platform targets

   printf("Fixing TEXT segment permissions for R/W/X....\n");
   for (i=0; i<APP_CODE_K*1024/PAGESIZE; i++)
   {
      code = (ui32*) ((((ui32)__app_code + i*PAGESIZE) - 1) & ~(PAGESIZE-1));
      if (mprotect( code, PAGESIZE, PROT_READ|PROT_WRITE|PROT_EXEC) )
      {
         printf("mprotect() on 0x%08x failed!\nerrno (%d) indicates status: ", code, errno);
	 switch (errno) 
	 {
	    case EINVAL: printf("EINVAL: not valid ptr, or not multiple of PAGESIZE (%d)\n", PAGESIZE);  
                         break;
	    case EFAULT: printf("EFAULT: memory can not be accessed.\n"); 
                         break;
	    case EACCES: printf("EACCES: memory can not be given specified access modes.\n"); 
                         break;
	    case ENOMEM: printf("ENOMEM: internal kernel structures could not be allocated.\n"); 
                         break;
	    default:     printf("??????: unknown error result.\n");
	 }
         exit( CLNT_MPROT_FAIL );
      }
   }

note:
the dummy "nop" function "__app_code()" is APP_CODE_K in size of
KBs of NOPs.

note 2:
i hope the KiB/MiB/whatever standard suggestion is never adopted 
and revoked really soon now.
