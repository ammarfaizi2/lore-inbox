Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265317AbSJRUzI>; Fri, 18 Oct 2002 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265323AbSJRUzI>; Fri, 18 Oct 2002 16:55:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265317AbSJRUzF>;
	Fri, 18 Oct 2002 16:55:05 -0400
Subject: Linux 2.5 and Zsh bug
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 14:01:07 -0700
Message-Id: <1034974867.5475.26.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running zsh on a Linux 2.5 kernel, the prompt always has a hash
sign '#' rather than the normal user '$'.  This probably happens because
the shell function privasserted() is returning true for all users.  I
know nothing about Posix capabilities but the zsh code for this looks
suspicious.

Code in question:
------------------------------------------------------------
/* isolate zsh bug */
#include <stdio.h>
#include <sys/capability.h>

int
privasserted(void)
{
   if(!geteuid()) {
       printf("geteuid() is root\n");
       return 1;
   }
   else  {
       cap_t caps = cap_get_proc();
       if(caps) {
           printf("caps = %p\n", caps);
           /* POSIX doesn't define a way to test whether a capability
set *
            * is empty or not.  Typical.  I hope this is
conforming...    */
           cap_flag_value_t val;
           cap_value_t n;

           for(n = 0; !cap_get_flag(caps, n, CAP_EFFECTIVE, &val); n++)
{
               if(val) {
                   printf("capability %#x is %d\n", n, val);
                   cap_free(caps); /* missing in original zsh code
memory leak */
                   return 1;
               }
           }
           printf("last capability %#x\n", n);

           cap_free(caps);
       }
   }
   return 0;
}

int main(int argc, const char **argv) {
   printf("%s privledged\n", privasserted() ?  "Is" : "Not");
}

------------------------------------------------
On 2.4.18
caps = 0x8049844
last capability 0x1d
Not privledged

On 2.5.43
caps = 0x804a00c
capability 0 is 1
Is privledged



