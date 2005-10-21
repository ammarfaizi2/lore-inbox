Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVJUSxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVJUSxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVJUSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:53:48 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:61582 "EHLO
	churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S965084AbVJUSxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:53:47 -0400
Message-ID: <43593943.8070901@churchillrandoms.co.uk>
Date: Fri, 21 Oct 2005 11:53:55 -0700
From: Stefan Jones <stefan.jones@churchillrandoms.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051003)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.13.4] Memoryleak - idr_layer_cache slab - inotify?
References: <43593240.9020806@churchillrandoms.co.uk>
In-Reply-To: <43593240.9020806@churchillrandoms.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jones wrote:

> I noticed this a while back when gam_server (new fam replacement)
> started playing up and the idr_layer_cache slab used up 300Mb of RAM.
>
> To reproduce:
>
> Run gnome and make sure it is using gam_server for fam.
>
> In one console do:
>
> while true ;do sleep 0.1 ; killall -w gam_server; done
>
> In another try slabtop and see the idr_layer_cache slab climb, eating
> memory (abit slowly).
> ( Gnome restarts gam_server after each kill for you and gets it doing
> stuff )
>
> I looked though the source and inotify does use the idr_layer_cache slab
> and gam_server also uses inotify.

Made a standalone testcase, run this and the kernel will eat up your 
memory (seen via slabtop):

( this should compile everywhere )

#include <sys/wait.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/select.h>
#include <asm/unistd.h>
#include <errno.h>


#define __NR_inotify_init    291
#define __NR_inotify_add_watch    292
#define __NR_inotify_rm_watch    293


_syscall0(int, inotify_init);
_syscall3(int, inotify_add_watch, int, fd, const char *, name, unsigned 
int, mask);
_syscall2(int, inotify_rm_watch, int, fd, unsigned int, wd);

int main() {
    pid_t pid;
    int fd;
    int wd;
    const char *dirname=".";
    unsigned int mask = 0xffffffff;
    int stat;
   
    for(;;) {
        if(!(pid = fork())) {
            fd = inotify_init ();

            wd = inotify_add_watch (fd, dirname, mask);
            if (wd < 0)
                perror ("inotify_add_watch");

            kill(getpid(),SIGTERM);
        }
        waitpid(pid,&stat,0);
    }
   
    return 0;
}
