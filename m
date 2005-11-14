Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVKNRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKNRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVKNRP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:15:26 -0500
Received: from rtr.ca ([64.26.128.89]:37853 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751199AbVKNRPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:15:25 -0500
Message-ID: <4378C626.4030107@rtr.ca>
Date: Mon, 14 Nov 2005 12:15:18 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
References: <4378ADB2.7040905@rtr.ca>	 <1131982550.2821.41.camel@laptopd505.fenrus.org>  <4378B1FB.1060201@rtr.ca> <1131987398.24066.7.camel@localhost.localdomain>
In-Reply-To: <1131987398.24066.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
>
> Interesting. Since you have a very easy to reproduce case -
> can you write a program to do posix_fadvise(POSIX_FADV_DONTNEED)
> on those files in directory "t" and see what happens ?

Sure.  It appears to cause an immediate "sync" of the file data
to disk (lots of drive activity for a few seconds), and the Dirty
count from /proc/meminfo reduces correspondingly.

Oddly enough, the Dirty count didn't go all the way down, though.
Doing a "sync" or a second run of the program afterwards does
get the count down to zero immediately, without any significant I/O.

Strange.

#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main (int argc, char *argv[])
{
         while (--argc > 0) {
                 int fd = open(*++argv, O_RDWR);
                 if (fd == -1) {
                         perror(*argv);
                 } else {
                         int posix_fadvise(int, off_t, off_t, int);
                         const int POSIX_FADV_DONTNEED = 4;
                         int rc = posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
                         if (rc == -1)
                                 perror(*argv);
                         close(fd);
                 }
         }
         return 0;
}
