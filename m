Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270422AbTGMWRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270423AbTGMWRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:17:09 -0400
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:34689 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP id S270422AbTGMWRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:17:04 -0400
Date: Sun, 13 Jul 2003 15:31:54 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200307132231.h6DMVs916407@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/fs/file-max broken in 2.4.22-pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Setting /proc/sys/fs/file-max to 60000 results in a max of 1024 file
handles. In 2.4.21-rc7-ac1 and random earlier kernels this works as expected.

---------------------------------------------------------------------------

root@athlon:/root # cat file-max.c
#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

main() {
        int i = 0;
        struct rlimit r;
        getrlimit(RLIMIT_NOFILE, &r);
        r.rlim_cur = 50000;
        setrlimit(RLIMIT_NOFILE, &r);
        while(1) {
          if(fopen("/tmp/file-max-test", "w") == 0) {
            perror("");
            break;
          }
          i++;
        }
        printf("opened %d files\n", i);
}

root@athlon:/root # echo 60000 > /proc/sys/fs/file-max
root@athlon:/root # cc file-max.c 
root@athlon:/root # a.out
Too many open files
opened 1021 files
root@athlon:/root # uname -a
Linux athlon 2.4.22-pre5 #2 SMP Sun Jul 13 12:38:04 PDT 2003 i686 unknown


