Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318102AbSHIAtd>; Thu, 8 Aug 2002 20:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSHIAtd>; Thu, 8 Aug 2002 20:49:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53203 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318102AbSHIAtc>;
	Thu, 8 Aug 2002 20:49:32 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, davej@suse.de, lkml <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@austin.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OF9B5458C8.3B464ED3-ON85256C10.0004B20C-85256C10.0004E452@us.ibm.com>
From: Hubertus Franke <frankeh@us.ibm.com>
Date: Thu, 8 Aug 2002 20:53:25 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Build V60_M14_08012002 Release
 Candidate|August 01, 2002) at 08/08/2002 20:52:22
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


I package my stuff up that allows to pull this into user space and run much
more efficient
pid allocation test for performance....
I'll also include the comparision numbers.  Currently remote, so I don't
have access to
that info.
Based on that though it seems with random pid deletion (we surely could
argue about
that one) there still seems reasonable benefits to "consider" a twolevel
algo.
More tomorrow.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003




                                                                                                                                     
                      Linus Torvalds                                                                                                 
                      <torvalds@transme        To:       Hubertus Franke/Watson/IBM@IBMUS                                            
                      ta.com>                  cc:       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,    
                                                Andrew Morton <akpm@zip.com.au>, <andrea@suse.de>, <davej@suse.de>, lkml <linux-     
                      08/08/2002 06:26          kernel@vger.kernel.org>, Paul Larson <plars@austin.ibm.com>                          
                      PM                       Subject:  Re: [PATCH] Linux-2.5 fix/improve get_pid()                                 
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     




On Thu, 8 Aug 2002, Linus Torvalds wrote:
>
> So let's just try Andries approach, suggested patch as follows..

"ps" seems to do ok from a visual standpoint at least up to 99 million.
Maybe it won't look that good after that, I'm too lazy to test.

The following trivial program is useful for efficiently allocating pid
numbers without blowing chunks on the VM subsystem and spending all the
time on page table updates - for people who want to test (look out: I've
got dual 2.4GHz CPU's with HT, so getting up to 10+ million was easy, your
milage may wary and at some point you should just compile a kernel that
starts higher ;).

                         Linus

---
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main()
{
        int i;
        for (i = 1; i < 250000; i++) {
                if (!vfork())
                        exit(1);
                if (waitpid(-1, NULL, WNOHANG) < 0)
                        perror("waitpid");
        }
        return 0;
}





