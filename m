Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbUKLRg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbUKLRg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUKLRg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:36:28 -0500
Received: from blackhole.sk ([212.89.236.103]:9444 "EHLO
	blackhole.websupport.sk") by vger.kernel.org with ESMTP
	id S262582AbUKLRbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 12:31:20 -0500
Date: Fri, 12 Nov 2004 18:31:18 +0100
From: stanojr@blackhole.websupport.sk
To: linux-kernel@vger.kernel.org
Subject: quota deadlock
Message-ID: <20041112173118.GC17928@blackhole.websupport.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear developers,
                                  
my english sucks, so i'll be brief.                        
heavy write access to partition with quota enabled causes deadlock. if
processes try to access the deadlocked partition they                    
simply have no response and cannot be killed with SIGKILL. i've been
testing with reiserfs and ext2 on 2.6.9 kernel.
                                                
i made this little code to reproduce the problem:
--                   
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>  
#include <unistd.h>
                            
int main(int ac,char *av[]) {
        int procs,size,i;
                         
        procs=atoi(av[1]);
        size=atoi(av[2]);
                             
        for(i=0;i<procs;i++) { 
                if (fork()==0) {
                        int fd;        
                        char buf[65535];
                                 
                        setuid(i);                   
                        snprintf(buf,65535,"tmp/%d",i);
                        fd=open(buf,O_RDWR|O_CREAT|O_TRUNC|O_APPEND,S_IRWXU);
                        while (1) {               
                                write(fd,buf,size);
                        }
                }
        }
}
--
 
use:                              
mkdir tmp;chmod 777 tmp;./a 20 4096                        
this creates 20 processes and every one has setuid to 0..20 trying to
write to tmp/0..20 4096k of crap in loop. after writing some MBs, all
processes just lock.
                                              
here is my task list dumped via sysrq and .config file from kernel
2.6.9
http://blackhole.websupport.sk/~stanojr/quotadeadlock/

stanojr
