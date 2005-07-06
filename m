Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVGFXxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVGFXxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVGFUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:47 -0400
Received: from mollusk.mweb.co.za ([196.2.24.27]:21009 "EHLO
	mollusk.mweb.co.za") by vger.kernel.org with ESMTP id S262206AbVGFSTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:19:46 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Tracking a bug in x86-64
Date: Wed, 6 Jul 2005 20:20:27 +0200
User-Agent: KMail/1.8.50
Cc: Andrew Morton <akpm@osdl.org>, rudsve@drewag.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       Little.Boss@physics.mcgill.ca
References: <200506132259.22151.bonganilinux@mweb.co.za> <20050705141234.3cab3328.akpm@osdl.org> <1120631696.3168.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1120631696.3168.5.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507062020.27480.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2005 08:34 am, Arjan van de Ven wrote:
> On Tue, 2005-07-05 at 14:12 -0700, Andrew Morton wrote:
> > Bongani Hlope <bonganilinux@mweb.co.za> wrote:
> > >
> > > I haven't tested 2.6.12.2 but the problem was introduced around 2.6.11-mm1 and
> > >  found its way to 2.6.12-rcX. First try to run the following command (this works for me)
> > >  echo 0 > /proc/sys/kernel/randomize_va_space
> > >  I got an email from Juan Gallego (cc'd), he says that command does not work for him though.
> > > 
> > >  Andrew,
> > >  Should I log this on the kernel's bugzilla?
> > 
> > Yes please.  This is a tough one, and having one place to go to for the
> > info would be useful.
> 
> key for this one is to make sure we separate the cases carefully, and
> not end up with one big bucket of "something broke" that has a gazilion
> different and unrelated causes. 
> For the cases where a vm layout thing is suspected of causing the
> breakage we also really need a /proc/<pid>/maps *at the time of the
> breakage* realistically for doing any kind of diagnostics.
> 

The problem is, it is hard to get the /proc/<pid>/maps file because the crashes are just random. 
If I set  /proc/sys/kernel/randomize_va_space back to 1, and do a make -j4 on the kernel source. 
gcc will start to segfault or cause protection errors. I added a printk in the randomize_stack_top function
just to print the pid and the random_variable (yes it is silly but...), the problem went away.

I tried to capture the /proc/<pid>/maps for the broken apps using the code below (it captures some, but it is brain dead),
but the problem goes away.  I'll try to write a bash script that does the same and test.

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <cstdio>
#include <iostream>
#include <fstream>

using namespace std;

int main(int argc, char** argv) {
        pid_t child;

        child = fork();

        if(child == 0) {
                execvp("/usr/bin/g++", argv);
        }
        else if (child > 0) {
                char* name = new char[256];
                sprintf(name,"/proc/%ld/maps", child);
                ifstream in(name);
                delete[] name;
                ofstream out("/home/bongani/log/procs.txt", ofstream::app);
                name = new char[4096];

                out<<"--------------------------------------------"<<"\n";
                out<<"g++("<<child<<")"<<"\n";

                while(!in.eof()) {
                        in.getline(name, 4096);
                        out<<child<<" "<<name<<"\n";
                }

                out<<"----------------------------------------------"<<endl;
                do {
                }
                while(child != wait(NULL));
                delete[] name;
        }
        else {
                printf("fork failed");
        }
        return 0;

}

