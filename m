Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277545AbRJOPxn>; Mon, 15 Oct 2001 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277652AbRJOPxd>; Mon, 15 Oct 2001 11:53:33 -0400
Received: from linux.ee.tku.edu.tw ([163.13.132.68]:29705 "HELO
	linux.ee.tku.edu.tw") by vger.kernel.org with SMTP
	id <S277559AbRJOPxZ>; Mon, 15 Oct 2001 11:53:25 -0400
Date: Tue, 16 Oct 2001 08:12:03 +0800 (CST)
From: Gian-Yan Xu <kids@linux.ee.tku.edu.tw>
To: linux-kernel@vger.kernel.org
Subject: ptrace bug
Message-ID: <Pine.LNX.4.21.0110160805440.12289-100000@linux.ee.tku.edu.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Today I try to get register's value via ptrace(PTRACE_GETREGS, ...),
but only EBX, ECX, EDX, ESI, EDI, EBP, EAX registers are correct.
I notice that file /usr/src/linux/include/asm/ptrace.h:

#define FS 9
#define GS 10

but in the declare of struct pt_regs:
                                                                    
struct pt_regs {                                                
        long ebx;                                      
        long ecx;                    
        long edx;                                                             
        long esi;                                                             
        long edi;                    
        long ebp;                    
        long eax;
        int  xds;
        int  xes;
        long orig_eax;
        long eip;     
        int  xcs;     
        long eflags;  
        long esp;     
        int  xss;     
};                    
                                                                    
There is no xfs/xgs member in that struct, and the #define FRAME_SIZE 17
is not match the number of member in the pt_regs struct.                
                                                                        
                                                                              
In addition, in the ptrace.c:                                                 
                                                                        
   case PTRACE_GETREGS: { /* Get all gp regs from the child. */         
   if (!access_ok(VERIFY_WRITE, (unsigned *)data,
FRAME_SIZE*sizeo(long))) {
                        ret = -EIO;                                         
                        break;                                              
   }                                                                        
   for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {          
              __put_user(getreg(child, i),(unsigned long *) data);          
             data += sizeof(long);                                          
   }                                                                        
   ret = 0;                                                                 
                                                                            
FRAME_SIZE*sizeof(long) is larger than sizeof(struct pt_regs),              
the ptrace() will overwrite the data of parent process!                     
                                                                            
To fix the bug, try this patch:                                             
                                                                            
--- ptrace.h.orig       Mon Oct 15 21:00:48 2001                            
+++ ptrace.h    Mon Oct 15 21:05:56 2001                                    
@@ -33,6 +33,8 @@                                                           
        long eax;                                                           
        int  xds;                                                           
        int  xes;                                                           
+       int  xfs;                                                           
+       int  xgs;                                                           
        long orig_eax;                                                      
        long eip;                                                           
        int  xcs;                                                           
                                 
                                                              

-- 
Best regards,
Gian-Yain Xu. (kids@linux.ee.tku.edu.tw)


