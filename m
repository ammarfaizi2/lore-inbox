Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135455AbRDRWx0>; Wed, 18 Apr 2001 18:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135456AbRDRWxQ>; Wed, 18 Apr 2001 18:53:16 -0400
Received: from mail.ettnet.se ([212.109.4.7]:60172 "HELO mail.ettnet.se")
	by vger.kernel.org with SMTP id <S135455AbRDRWxJ>;
	Wed, 18 Apr 2001 18:53:09 -0400
Date: Thu, 19 Apr 2001 03:03:15 +0200
From: Joel Eriksson <jen@ettnet.se>
To: linux-kernel@vger.kernel.org
Subject: Re: Socket hack question.
Message-ID: <20010419030315.A7923@seth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Phone: +46-736-256517
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 11:31:00PM +0200, Andi Kleen wrote:
> On Thu, Apr 19, 2001 at 12:28:52AM +0200, Joel Eriksson wrote:
> > Hello,
> > 
> > I am a kernel hacking newbie and am struggling to understand the
> > networking subsystem. I would like to be able to add a systemcall,
> > preferably asynchronous, that connects a socket with a filedescriptor
> > (proxy(srcsd, dstfd)) so that everything received on srcsd is directly
> > written to dstfd. The proxy should close when srcsd is closed or when
> > a zero-size packet is sent (or something like that..).
> 
> That syscall already exists -- it's called sendfile. 

Actually, I realised the similarities with sendfile() after I made the
post. :-) But I thought sendfile() could only be used for sending data
from a "regular" file descriptor to another file- or socket descriptor..?

The syscall I would like to implement is kind of the reverse to sendfile()
since it should be used to copy data _from_ a socket descriptor to a
file descriptor.

Hmm, I made a small test program and from what I can understand it seems
to verify what I thought:

---
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>

int main(void)
{
        pid_t pid;
        int fdarr[2];

        if (socketpair(AF_UNIX, SOCK_STREAM, 0, fdarr) ÿ-1) {
                perror("socketpair");
                return 1;
        }

        if ((pid ÿork()) ÿ-1) {
                perror("fork");
                return 1;
        } else if (pid) {
                close(fdarr[0]);
                if (sendfile(1, fdarr[1], NULL, 5) ÿ-1) {
                        perror("sendfile");
                        return 1;
                }
        } else {
                close(fdarr[1]);
                write(fdarr[0], "Test\n", 5);
        }

        return 0;
}
---

The output from the program is "sendfile: Invalid argument"..

> -Andi

-- 
Joel Eriksson
