Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVAaIBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVAaIBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVAaH54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:57:56 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:23520 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261968AbVAaH4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:56:08 -0500
Message-ID: <41FDE497.6040308@candelatech.com>
Date: Sun, 30 Jan 2005 23:56:07 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: close-exec flag not working in 2.6.9?
Content-Type: multipart/mixed;
 boundary="------------030804020201040303080000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030804020201040303080000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As far as I can tell, close-exec is not working correctly in 2.6.9
or 2.6.10-1.741_FC3smp.

The attached program generates a file /tmp/cl_foo.output
which has this data:


[greear@grok ~]$ more /tmp/cl_foo.output
total 5
lrwx------  1 greear greear 64 Jan 30 23:49 0 -> /dev/pts/3
l-wx------  1 greear greear 64 Jan 30 23:49 1 -> /tmp/cl_foo.output
l-wx------  1 greear greear 64 Jan 30 23:49 2 -> /tmp/cl_foo.output
lr-x------  1 greear greear 64 Jan 30 23:49 3 -> /etc/passwd
lr-x------  1 greear greear 64 Jan 30 23:49 4 -> /proc/7020/fd


I would not expect to see the /etc/passwd entry since I marked
it close-exec in the parent process before forking and running
the system() command.

Am I confused about things, or is this a real bug?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


--------------030804020201040303080000
Content-Type: text/plain;
 name="close_exec.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="close_exec.cc"



#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <errno.h>

using namespace std;

void close_exec(int s) {
   int  flags;

   flags = fcntl(s, F_GETFL);
   flags |= (FD_CLOEXEC);
   if (fcntl(s, F_SETFL, flags) < 0) {
      cerr << "ERROR:  fcntl, executing close_exec:  " << strerror(errno)
           << endl;
   }
}//close_exec

int main() {
   ofstream script("/tmp/cl_foo.bash");
   script << "#!/bin/bash\nls -l /proc/self/fd > /tmp/cl_foo.output 2>&1\n";
   script.close();
   
   if (chmod("/tmp/cl_foo.bash",
             S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH) < 0) {
      cerr << "ERROR:  Failed to chmod /tmp/cl_foo.bash, error: "
           << strerror(errno) << endl;
      exit(7);
   }

   int fd = open("/etc/passwd", O_RDONLY);
   if (fd < 0) {
      cerr << "ERROR:  Failed to open /etc/passwd: " << strerror(errno) << endl;
   }
   else {
      close_exec(fd);
   }

   int rv = fork();
   if (rv < 0) {
      cerr << "ERROR from fork: " << strerror(errno) << endl;
   }
   else if (rv == 0) {
      // Child
      system("/tmp/cl_foo.bash");
      exit(7);
   }
   else {
      // parent, done
      sleep(5);
   }
   return 0;
}//main

--------------030804020201040303080000--
